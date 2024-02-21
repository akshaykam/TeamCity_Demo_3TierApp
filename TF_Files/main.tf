#Demo file added for IAC scan on Snyk

provider "aws" {
  region = "us-east-1" # or your desired region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.*.id
  }
}

resource "aws_nat_gateway" "public" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "availability_zone" = var.availability_zones[i] } }
  subnet_id = aws_subnet.public.*.id[each.key]
  allocation_id = aws_eip.public.*.id[each.key]
}

resource "aws_eip" "public" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "availability_zone" = var.availability_zones[i] } }

  vpc = true
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "cidr_block" = var.public_subnet_cidr_block + "/" + format("%02d", i + 1), "availability_zone" = var.availability_zones[i] } }
  vpc_id = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-" + each.key
  }
}

resource "aws_subnet" "private" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "cidr_block" = var.private_subnet_cidr_block + "/" + format("%02d", i + 1), "availability_zone" = var.availability_zones[i] } }
  vpc_id = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block = each.value.cidr_block

  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-" + each.key
  }
}

resource "aws_route_table_association" "public_subnet" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "subnet_id" = aws_subnet.public.*.id[i] } }
  subnet_id = each.value.subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet" {
  for_each = { for i in range(length(var.availability_zones)) : i => { "subnet_id" = aws_subnet.private.*
