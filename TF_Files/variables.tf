#file added for IAC snyk scan demo
  
variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  type = string
  default = "10.0.2.0/24"
}
