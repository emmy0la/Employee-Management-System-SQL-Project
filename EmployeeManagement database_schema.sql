CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

CREATE TABLE Departments (
DeptID INT PRIMARY KEY AUTO_INCREMENT,
DeptName VARCHAR(50) UNIQUE NOT NULL,
Location VARCHAR(50)
);

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY AUTO_INCREMENT,
    JobTitle VARCHAR(50) UNIQUE NOT NULL,
    MinSalary DECIMAL(15 , 2 ),
    MaxSalary DECIMAL(15 , 2 )
);

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
DateOfBirth DATE NOT NULL,
Gender VARCHAR(10),
Email VARCHAR(100) UNIQUE NOT NULL,
PhoneNumber VARCHAR(20) UNIQUE,
HireDate DATE NOT NULL,
JobID INT,
DepartmentID INT,
ManagerID INT,
Status VARCHAR(20),
FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
FOREIGN KEY (DepartmentID) REFERENCES Departments(DeptID),
FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Salaries (
SalaryID INT PRIMARY KEY AUTO_INCREMENT,
EmployeeID INT NOT NULL,
SalaryAmount DECIMAL(15,2) NOT NULL,
FromDate DATE NOT NULL,
ToDate DATE,
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Attendance (
AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
EmployeeID INT NOT NULL,
AttendanceDate DATE NOT NULL,
Status VARCHAR(20),
CheckInTime TIME,
CheckOutTime TIME,
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Performance (
PerformanceID INT PRIMARY KEY AUTO_INCREMENT,
EmployeeID INT NOT NULL,
ReviewDate DATE NOT NULL,
Rating INT,
Comments TEXT,
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

SHOW TABLES;

DESCRIBE Departments;
DESCRIBE Jobs;
DESCRIBE Employees;
DESCRIBE Salaries;
DESCRIBE Attendance;
DESCRIBE Performance;

-- Show full names and email;
SELECT 
    FirstName, LastName, Email
FROM
    Employees;
    
    SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName, Email
FROM
    Employees;
    
-- Active employees;
    SELECT 
    *
FROM
    Employees
WHERE
    Status = 'Active';
    
    SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Status
FROM
    Employees
WHERE
    Status = 'Active';

-- Employees absent;
    SELECT 
    *
FROM
    Attendance
WHERE
    Status = 'Absent';

SELECT 
    a.AttendanceID,
    e.FirstName,
    e.LastName,
    a.AttendanceDate,
    a.Status
FROM
    Attendance a
        JOIN
    Employees e ON a.EmployeeID = e.EmployeeID
WHERE
    a.Status = 'Absent';

-- Finance department and active;
SELECT 
    e.FirstName, e.LastName
FROM
    Employees e
        JOIN
    Departments d ON e.DepartmentID = d.DeptID
WHERE
    d.DeptName = 'Finance'
        AND e.Status = 'Active';

SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DeptName,
    e.Status
FROM
    Employees e
        JOIN
    Departments d ON e.DepartmentID = d.DeptID
WHERE
    d.DeptName = 'Finance'
        AND e.Status = 'Active';       -- Second filter: status

-- High Salary Employees (>100,000);
SELECT 
    e.FirstName, s.SalaryAmount
FROM
    Employees e
        JOIN
    Salaries s ON e.EmployeeID = s.EmployeeID
WHERE
    s.SalaryAmount > 100000;
    
    SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    s.SalaryAmount,
    s.FromDate
FROM
    Employees e
        JOIN
    Salaries s ON e.EmployeeID = s.EmployeeID
WHERE
    s.ToDate IS NULL
        AND s.SalaryAmount > 100000
ORDER BY s.SalaryAmount DESC;

-- Employees in HR or Finance
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DeptName,
    e.Status
FROM
    Employees e
        JOIN
    Departments d ON e.DepartmentID = d.DeptID
WHERE
    d.DeptName IN ('Human Resources' , 'Finance')
ORDER BY d.DeptName , e.LastName;

-- Inactive Employees (NOT operator)
SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Status,
    Email
FROM
    Employees
WHERE
    Status != 'Active';  -- != means "not equal to";

-- Attendance in January 2026
SELECT 
    a.AttendanceID,
    e.FirstName,
    e.LastName,
    a.AttendanceDate,
    a.Status,
    a.CheckInTime,
    a.CheckOutTime
FROM
    Attendance a
        JOIN
    Employees e ON a.EmployeeID = e.EmployeeID
WHERE
    a.AttendanceDate BETWEEN '2026-01-01' AND '2026-01-31'
        AND a.Status = 'Present'
ORDER BY a.AttendanceDate , e.LastName;

-- Order by Last Name
SELECT 
    EmployeeID, FirstName, LastName, Email
FROM
    Employees
ORDER BY LastName , FirstName;  -- Sort by Last, then by First;

-- Highest Salaries First
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    s.SalaryAmount,
    j.JobTitle
FROM
    Employees e
        JOIN
    Salaries s ON e.EmployeeID = s.EmployeeID
        JOIN
    Jobs j ON e.JobID = j.JobID
WHERE
    s.ToDate IS NULL
ORDER BY s.SalaryAmount DESC;  -- Highest first

-- Unique Departments
SELECT DISTINCT
    d.DeptName, d.Location
FROM
    Departments d
ORDER BY d.DeptName;

-- Top 5 Performers (by salary)
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    s.SalaryAmount,
    j.JobTitle
FROM
    Employees e
        JOIN
    Salaries s ON e.EmployeeID = s.EmployeeID
        JOIN
    Jobs j ON e.JobID = j.JobID
WHERE
    s.ToDate IS NULL
ORDER BY s.SalaryAmount DESC
LIMIT 5;  -- Only return first 5 rows

-- Pagination (Next 5 employees)
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    j.JobTitle,
    d.DeptName
FROM
    Employees e
        JOIN
    Jobs j ON e.JobID = j.JobID
        JOIN
    Departments d ON e.DepartmentID = d.DeptID
ORDER BY e.EmployeeID
LIMIT 5 OFFSET 5;  -- Skip 5 rows, then show next 5

-- INNER JOIN (most common)
SELECT 
    e.FirstName, d.DeptName
FROM
    Employees e
        INNER JOIN
    Departments d ON e.DepartmentID = d.DeptID;
-- Only shows employees with valid departments

-- LEFT JOIN (show all employees, even without departments)
SELECT 
    e.FirstName, d.DeptName
FROM
    Employees e
        LEFT JOIN
    Departments d ON e.DepartmentID = d.DeptID;
-- Shows all employees, DeptName will be NULL if no department

