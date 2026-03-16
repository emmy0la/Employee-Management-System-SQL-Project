# Employee Management System SQL Project

## Project Note

This project was completed as part of a collaborative assignment by Team D of the SQL Study Group. Each member independently implemented the Employee Management System database and SQL analysis, while the final presentation and knowledge sharing were conducted as a team exercise.

## Problem Statement

Organizations need structured systems to manage employee information such as department assignments, job roles, salary history, attendance records, and performance reviews. When employee data is stored in scattered spreadsheets or disconnected systems, it becomes difficult for HR teams and management to analyze workforce information and make informed decisions.

This project simulates a real world Employee Management System using SQL. The goal is to design a relational database that stores employee information and allows analysts to run queries that support HR reporting and workforce analysis.

The project demonstrates how SQL can be used to organize organizational data, enforce relationships between tables, and answer important business questions related to employee management.

## Project Objectives

Design a normalized relational database for managing employee data.

Implement tables with primary keys and foreign key relationships.

Store employee records, departments, jobs, salaries, attendance, and performance reviews.

Write SQL queries to retrieve, filter, and analyze employee data.

Generate insights that HR teams and managers can use for decision making.

Demonstrate practical SQL skills used in real workplace data analysis.

## Dataset Description

The project uses structured sample datasets stored as CSV files. These files simulate organizational HR data.

Employees
Contains employee personal information, employment details, department assignments, and job roles.

Departments
Stores department names and office locations within the organization.

Jobs
Defines job titles and salary ranges for each role.

Salaries
Stores employee salary records and salary history across time periods.

Attendance
Tracks daily attendance records including attendance status, check in time, and check out time.

Performance
Stores employee performance review scores and feedback.

The datasets were imported into the SQL database to populate the tables and simulate a functioning employee management system.

## Database Schema

The database follows a relational structure where tables are connected through primary and foreign key relationships.

Main relationships in the system

Employees linked to Departments through DepartmentID
Employees linked to Jobs through JobID
Employees linked to Managers through ManagerID referencing Employees
Salaries linked to Employees through EmployeeID
Attendance linked to Employees through EmployeeID
Performance linked to Employees through EmployeeID

An Entity Relationship Diagram illustrates the database structure and relationships between tables.

ER Diagram

[ER_Diagram.png
](https://github.com/emmy0la/Employee-Management-System-SQL-Project/blob/main/ER_Diagram.png)

## SQL Analysis

Several SQL queries were written to explore and analyze the employee database.

Examples of SQL queries used in the analysis include:

Retrieve all active employees

SELECT *
FROM Employees
WHERE Status = 'Active';

Identify employees working in the Finance department

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
d.DeptName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DeptID
WHERE d.DeptName = 'Finance'
AND e.Status = 'Active';

Identify employees earning above a specific salary threshold

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
s.SalaryAmount
FROM Employees e
JOIN Salaries s
ON e.EmployeeID = s.EmployeeID
WHERE s.ToDate IS NULL
AND s.SalaryAmount > 100000
ORDER BY s.SalaryAmount DESC;

Analyze attendance records within a specific date range

SELECT
a.AttendanceID,
e.FirstName,
e.LastName,
a.AttendanceDate,
a.Status
FROM Attendance a
JOIN Employees e
ON a.EmployeeID = e.EmployeeID
WHERE a.AttendanceDate BETWEEN '2026-01-01' AND '2026-01-31'
AND a.Status = 'Present';

Retrieve the top 5 highest paid employees

SELECT
e.EmployeeID,
CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
s.SalaryAmount,
j.JobTitle
FROM Employees e
JOIN Salaries s
ON e.EmployeeID = s.EmployeeID
JOIN Jobs j
ON e.JobID = j.JobID
WHERE s.ToDate IS NULL
ORDER BY s.SalaryAmount DESC
LIMIT 5;

Screenshots of query outputs are available in the screenshots folder.

## Key Insights

Employee salary data allows identification of the highest earning employees within the organization.

Attendance records help track employee presence and identify absence patterns.

Department level filtering allows HR teams to review workforce distribution across departments.

Joining employee, salary, and job tables helps analyze compensation patterns across roles.

Structured relational databases improve data accessibility and reporting efficiency.

## Project Structure

Employee-Management-System-SQL-Project

README.md
database_schema.sql
analysis_queries.sql

datasets
employees.csv
departments.csv
jobs.csv
salaries.csv
attendance.csv
performance.csv

images
ER_Diagram.png

screenshots
active_employees.png
top_salary.png
attendance_query.png

## Tools Used

SQL
MySQL Workbench
CSV datasets
GitHub

## Future Improvements

Apply advanced SQL analytics using GROUP BY and aggregation functions.

Introduce window functions for deeper salary and performance analysis.

Build interactive HR dashboards using Power BI or Tableau.

Expand the dataset to simulate a larger enterprise level HR database.

## Author

Emmanuel Olawumi

Data Analyst
SQL | Data Analytics | Digital Strategy
