Exercise 2

#CREATE DATABASE 

CREATE DATABASE Company1;

#USE DATABASE

USE Company1;

# 1.CREATE TABLE: Salary1

CREATE TABLE Salary1(
SalaryID INT PRIMARY KEY NOT NULL,
Salary DECIMAL(10,2) NOT NULL,
PayFrequency VARCHAR(15)
);

DESC Salary1;

+--------------+---------------+------+-----+---------+-------+
| Field        | Type          | Null | Key | Default | Extra |
+--------------+---------------+------+-----+---------+-------+
| SalaryID     | int           | NO   | PRI | NULL    |       |
| Salary       | decimal(10,2) | NO   |     | NULL    |       |
| PayFrequency | varchar(20)   | YES  |     | NULL    |       |
+--------------+---------------+------+-----+---------+-------+

#CREATE TABLE: Department1

CREATE TABLE Department1(
DepartmentID INT PRIMARY KEY NOT NULL,
DepartmentName VARCHAR(25) NOT NULL,
Location VARCHAR(30)
);

DESC Department1;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| DepartmentID   | int         | NO   | PRI | NULL    |       |
| DepartmentName | varchar(25) | NO   |     | NULL    |       |
| Location       | varchar(30) | YES  |     | NULL    |       |
+----------------+-------------+------+-----+---------+-------+


#CREATE TABLE: Employee1

CREATE TABLE Employee1(
EmployeeID INT PRIMARY KEY NOT NULL,
EmployeeName VARCHAR(25) NOT NULL,
PhoneNumber VARCHAR(15),
HireDate DATE,
SalaryID INT,
DepartmentID INT,
FOREIGN KEY (DepartmentID) REFERENCES Department1(DepartmentID),
FOREIGN KEY (SalaryID) REFERENCES Salary1(SalaryID)
);

DESC Employee1;
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| EmployeeID   | int         | NO   | PRI | NULL    |       |
| EmployeeName | varchar(25) | NO   |     | NULL    |       |
| PhoneNumber  | varchar(15) | YES  |     | NULL    |       |
| HireDate     | date        | YES  |     | NULL    |       |
| SalaryID     | int         | YES  | MUL | NULL    |       |
| DepartmentID | int         | YES  | MUL | NULL    |       |
+--------------+-------------+------+-----+---------+-------+


# 2. Insert the records into SALARY1 
INSERT INTO Salary1 (SalaryID, Salary, PayFrequency) VALUES
    -> (1111,75000.00,'Monthly'),
    -> (2222,80000.00,'Monthly'),
    -> (3333,85000.00,'Monthly'),
    -> (4444,90000.00,'Monthly'),
    -> (5555,1100000.00,'Annual');

# Insert the records into DEPARTMENT1 
INSERT INTO Department1 (DepartmentID, DepartmentName,Location) VALUES
    -> (100,'Sales','Bengaluru'),
    -> (101,'System','Tumkur'),
    -> (102,'Marketing','Hyderabad'),
    -> (103,'Finance','Cochin'),
    -> (104,'Human Resources','Chennai');

# Insert the records into EMPLOYEE1
INSERT INTO Employee1 (EmployeeID,EmployeeName,PhoneNumber,HireDate,SalaryID, DepartmentID) VALUES
    -> (10000,'Herbert','555-123-4567','2010-08-12',1111,100),
    -> (10001,'Dhamodhar','9876543210','2008-07-14',2222,101),
    -> (10002,'Bharani','9876543211','2008-06-15',3333,102),
    -> (10003,'Mozhi','9876543212','2009-05-10',1111,103),
    -> (10004,'Emilkumar','555-789-1234','2010-02-07',3333,101);

SELECT * FROM Employee1;
+------------+--------------+--------------+------------+----------+--------------+
| EmployeeID | EmployeeName | PhoneNumber  | HireDate   | SalaryID | DepartmentID |
+------------+--------------+--------------+------------+----------+--------------+
|      10000 | Herbert      | 555-123-4567 | 2010-08-12 |     1111 |          100 |
|      10001 | Dhamodhar    | 9876543210   | 2008-07-14 |     2222 |          101 |
|      10002 | Bharani      | 9876543211   | 2008-06-15 |     3333 |          102 |
|      10003 | Mozhi        | 9876543212   | 2009-05-10 |     1111 |          103 |
|      10004 | Emilkumar    | 555-789-1234 | 2010-02-07 |     3333 |          101 |
+------------+--------------+--------------+------------+----------+--------------+

SELECT * FROM Department1;
+--------------+-----------------+-----------+
| DepartmentID | DepartmentName  | Location  |
+--------------+-----------------+-----------+
|          100 | Sales           | Bengaluru |
|          101 | System          | Tumkur    |
|          102 | Marketing       | Hyderabad |
|          103 | Finance         | Cochin    |
|          104 | Human Resources | Chennai   |
+--------------+-----------------+-----------+

SELECT * FROM Salary1;
+----------+------------+--------------+
| SalaryID | Salary     | PayFrequency |
+----------+------------+--------------+
|     1111 |   75000.00 | Monthly      |
|     2222 |   80000.00 | Monthly      |
|     3333 |   85000.00 | Monthly      |
|     4444 |   90000.00 | Monthly      |
|     5555 | 1100000.00 | Annual       |
+----------+------------+--------------+

# 3. Display list of employees working in a specific department using JOIN

SELECT E.EmployeeName,D.DepartmentName
    -> FROM Employee1 E
    -> JOIN Department1 D ON E.DepartmentID = D.DepartmentID
    -> WHERE D.DepartmentName='Sales';

+--------------+----------------+
| EmployeeName | DepartmentName |
+--------------+----------------+
| Herbert      | Sales          |
+--------------+----------------+

# 4.Display total salary paid per department using GROUP BY and aggregate function

SELECT D.DepartmentName,SUM(S.Salary) AS TotalSalary
    -> FROM Employee1 E
    -> JOIN Department1 D ON E.DepartmentID = D.DepartmentID
    -> JOIN Salary1 S ON E.SalaryID = S.SalaryID
    -> GROUP BY D.DepartmentName;

+----------------+-------------+
| DepartmentName | TotalSalary |
+----------------+-------------+
| Sales          |    75000.00 |
| System         |   165000.00 |
| Marketing      |    85000.00 |
| Finance        |    75000.00 |
+----------------+-------------+

# 5. Create a View that displays employee name, department and salary
CREATE VIEW EmployeeDetails AS
    -> SELECT E.EmployeeName,D.DepartmentName,S.Salary
    -> FROM Employee1 E
    -> JOIN Department1 D ON E.DepartmentID = D.DepartmentID
    -> JOIN Salary1 S ON E.SalaryID = S.SalaryID;

SELECT * FROM EmployeeDetails;
+--------------+----------------+----------+
| EmployeeName | DepartmentName | Salary   |
+--------------+----------------+----------+
| Herbert      | Sales          | 75000.00 |
| Dhamodhar    | System         | 80000.00 |
| Bharani      | Marketing      | 85000.00 |
| Mozhi        | Finance        | 75000.00 |
| Emilkumar    | System         | 85000.00 |
+--------------+----------------+----------+





