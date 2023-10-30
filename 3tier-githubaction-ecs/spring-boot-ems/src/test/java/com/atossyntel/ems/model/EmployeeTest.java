package com.atossyntel.ems.model;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class EmployeeTest {

	Employee employee = new Employee(1, "Astha", "Gangwar", "asthag@cybage.com", 120, "7418529630", "");
	Employee emp = new Employee();

	@Test
	public void getEmployeeFname() {

		String result = employee.getFname();
		assertEquals("Astha", result);
	}

	@Test
	public void getEmployeeLname() {
		String result = employee.getLname();
		assertEquals("Gangwar", result);
	}

	@Test
	public void getEmployeeEmail() {
		String result = employee.getEmail();
		assertEquals("asthag@cybage.com", result);
	}

	@Test
	public void getEmployeeSalary() {
		double result = employee.getSalary();
		assertEquals(120, result);
	}

	@Test
	public void getMobileNumber() {
		String result = employee.getMobile();
		assertEquals("7418529630", result);
	}

	
	 @Test 
	 public void getPanDetails() 
	 { String result = employee.getPan();
	  assertEquals("",result); }
	 
	/*
	 * @Test public void getIdEmployee() { int result = emp.getEmployeeId();
	 * assertEquals(1, result); }
	 */
	 
	 
}