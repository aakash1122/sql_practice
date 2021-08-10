--@block drop table
DROP TABLE Departments;
DROP TABLE Employees;

--@Block create table
CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);

CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);

--@BLOCK INSERT DATA
INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

--@block Select the last name of all employees.
SELECT lastname FROM employees;

--@BLOCK Select the last name of all employees, without duplicates.
SELECT DISTINCT lastname FROM employees;

--@BLOCK Select all the data of employees whose last name is "Smith".
SELECT * FROM employees WHERE lastname = 'Smith';

--@BLOCK Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees WHERE lastname IN ( 'Smith','Doe');

--@BLOCK Select all the data of employees that work in department 14
SELECT * FROM employees where department = 14;

--@BLOCK Select all the data of employees that work in department 37 or department 77.
select * from employees where department in (37, 77);

--@BLOCK Select all the data of employees whose last name begins with an "S".
select * from employees where lastname like 'S%';
--@BLOCK  Select the sum of all the departments' budgets.
select sum(Budget) as total_budget from departments;

--@BLOCK Select the number of employees in each department (you only need to show the department code and the number of employees)
SELECT Department, COUNT(*)
  FROM Employees
  GROUP BY Department;

--@BLOCK Select all the data of employees, including each employee's department's data.
select * from employees, departments where employees.department = departments.code;

--@BLOCK Select the name and last name of each employee, along with the name and budget of the employee's department.
select employees.name,employees.lastname,departments.budget,departments.name  
from employees 
LEFT join departments
on employees.department = departments.code


--@BLOCK Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT employees.name, employees.lastname 
from employees , departments 
where departments.code = employees.department and departments.budget > 60000

--@block  Select the departments with a budget larger than the average budget of all the departments.
select name from departments where budget > (
  select avg(budget) from departments
)

--@BLOCK  Select the names of departments with more than two employees.
select departments.name, count(employees.name) AS counter
from departments, employees
group by department.code
where  counter >= 2

--@BLOCK Select the name and last name of employees working for departments with second lowest budget.
select name, lastname from employees 
where department = (
select code from departments 
order by budget offset 1 limit 1
) 
--@BLOCK  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into departments (code,name,budget) 
values (11,'Quality Assurance',40000)

insert into employees (ssn,name,lastname,department)
values (847219811,'Mary','Moore',11)

--@BLOCK  Reduce the budget of all departments by 10%.
select budget * 0.9 from departments

--@BLOCKReassign all employees from the Research department (code 77) to the IT department (code 14).
update employees set department = 14 where department = 77