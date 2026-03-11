# Employee-Management-System-SQL-Project

Project Overview

This project demonstrates the design and analysis of an employee management database using SQL. The system stores and organizes employee records, departments, job roles, salary history, attendance records, and performance reviews.

The project focuses on relational database design, data normalization, and analytical querying to answer business questions commonly faced by HR and management teams.

The database was implemented using MySQL Workbench and populated using CSV datasets.


Technologies Used

SQL
MySQL Workbench
CSV Data Files
GitHub


Database Architecture

The database follows a relational design where multiple tables interact through primary and foreign keys.


Tables in the database

Employees
Stores personal and employment details of staff members.

Departments
Stores department names and their locations.

Jobs
Defines job roles and salary ranges.

Salaries
Stores employee salary records and salary history.

Attendance
Tracks employee daily attendance including check-in and check-out times.

Performance
Stores employee performance reviews and ratings.


Table Relationships

Employees → Departments using DepartmentID
Employees → Jobs using JobID
Employees → ManagerID referencing Employees (self relationship)
Salaries → Employees using EmployeeID
Attendance → Employees using EmployeeID
Performance → Employees using EmployeeID

This relational structure supports scalable HR data management.


SQL Skills Demonstrated

Database creation
Table design and normalization
Primary and foreign key implementation
Self referencing relationships
Data filtering using WHERE
Logical operators including AND, OR, NOT
Pattern filtering and conditional logic
Sorting using ORDER BY
Aggregation and filtering
Data pagination using LIMIT and OFFSET
Data joins including INNER JOIN and LEFT JOIN


Business Questions Answered

List all active employees in the organization

Identify employees who belong to a specific department such as Finance

Find employees with salaries above a specific threshold

Identify employees who were absent on certain days

Retrieve employee attendance records for a specific period

Identify departments and their locations

List employees and their job roles

Identify the highest earning employees

Retrieve employees across multiple departments such as HR or Finance


Example SQL Queries

Active Employees

SELECT *
FROM Employees
WHERE Status = 'Active';

Employees in Finance Department

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
d.DeptName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DeptID
WHERE d.DeptName = 'Finance'
AND e.Status = 'Active';

High Salary Employees

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
s.SalaryAmount
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.ToDate IS NULL
AND s.SalaryAmount > 100000
ORDER BY s.SalaryAmount DESC;

Attendance Analysis

SELECT
a.AttendanceID,
e.FirstName,
e.LastName,
a.AttendanceDate,
a.Status
FROM Attendance a
JOIN Employees e ON a.EmployeeID = e.EmployeeID
WHERE a.AttendanceDate BETWEEN '2026-01-01' AND '2026-01-31'
AND a.Status = 'Present';

Top 5 Highest Paid Employees

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
s.SalaryAmount,
j.JobTitle
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
JOIN Jobs j ON e.JobID = j.JobID
WHERE s.ToDate IS NULL
ORDER BY s.SalaryAmount DESC
LIMIT 5;


Example Insights

Employees in Finance and Human Resources departments represent key operational units.

Salary records reveal the distribution of compensation across job roles.

Attendance data helps track employee presence and identify absentee patterns.

Salary ranking queries help identify top earning employees.

Pagination queries allow analysts to work efficiently with large employee datasets.


Project Structure

Employee-Management-System-SQL

README.md
database_schema.sql
analysis_queries.sql

datasets
departments.csv
employees.csv
jobs.csv
salaries.csv
attendance.csv
performance.csv

screenshots
query_results.png
salary_analysis.png
attendance_query.png


Learning Outcomes

Design a normalized relational database structure

Implement primary keys and foreign keys

Write SQL queries for business analysis

Use JOIN operations to combine multiple tables

Filter and analyze HR data using SQL

Present data insights using structured queries


Future Improvements

Add analytical SQL functions such as GROUP BY and window functions

Create HR dashboards using Power BI or Tableau

Build automated reports for employee performance and attendance tracking

Expand the dataset to simulate real enterprise scale HR systems


Author

Emmanuel Olawumi

Data Analyst | SQL | Data Analytics | Digital Strategy
