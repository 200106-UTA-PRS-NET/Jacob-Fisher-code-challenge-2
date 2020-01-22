create database employee;
use employee;

create table Department(
	id int primary key identity,
	name varchar(max),
	location varchar(max),
)

create table Employee(
	id int primary key identity,
	firstname varchar(max)not null,
	lastname varchar(max) not null,
	ssn char(9) not null unique,
	deptid int foreign key references department(id)
)

create table EmpDetails(
	id int primary key identity,
	employeeID int foreign key references employee(id),
	salary money not null,
	address_1 varchar(max) not null,
	address_2 varchar(max),
	city varchar(max) not null,
	state varchar(max) not null,
	country varchar(max)
)

insert into Department(name, location) values ('HR', 'Building 1, Floor 2'), ('Business', 'Building 1, Floor 3'), ('Engineering', 'Building 2');
insert into Employee(firstname, lastname, ssn, deptid) values ('John', 'Smith', '123456789', 2), ('Emily', 'Smith', '987654321', 1), ('Bob', 'Builder', '234567890', 3);
insert into EmpDetails(employeeID, salary, address_1, address_2, city, state, country) values (1, 23000, '1234 2nd Street', 'Apt 512', 'Texas City', 'Texas', 'USA'), (2, 54000, '1234 2nd Street', 'Apt 512', 'Texas City', 'Texas', 'USA'), (3, 50000, '532 Main Street', null, 'Texas City', 'Texas', 'USA');

insert into Department(name, location) values ('Marketing', 'Building 1, Floor 1');
insert into Employee(firstname, lastname, ssn, deptid) values ('Tina', 'Smith', '321654987', 4);
insert into EmpDetails(employeeID, salary, address_1, address_2, city, state, country) values (4, 33000, '1234 2nd Street', 'Apt 512', 'Texas City', 'Texas', 'USA');

select firstname as 'First Name', lastname as 'Last Name'
from employee where employee.deptid in
	(select id from Department where Department.name = 'Marketing');

select sum(salary) as 'Summed Salary' from EmpDetails
where employeeID in (select id from employee where deptid in
	(select id from Department where Department.name = 'Marketing'));

select department.name as 'Department', count(employee.id) as 'Num. Employees'
from department join employee on Department.id = employee.deptid
group by department.name;

update EmpDetails set salary = 90000
where employeeID in (select id from employee where firstname = 'Tina' and lastname = 'Smith');