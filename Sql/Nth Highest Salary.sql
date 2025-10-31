CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Salary DECIMAL(10, 2)
);


INSERT INTO Employees (EmployeeID, EmployeeName, Salary)
VALUES
(1, 'Alice Smith', 70000.00),
(2, 'Bob Johnson', 85000.00),
(3, 'Carol White', 95000.00),
(4, 'David Brown', 60000.00),
(5, 'Eve Davis', 75000.00),
(6, 'Frank Miller', 90000.00),
(7, 'Grace Lee', 80000.00),
(8, 'Hannah Clark', 62000.00),
(9, 'Ivy Harris', 74000.00),
(10, 'Jack Lewis', 98000.00);

select * from Employees

--2nd Highest Salary
select max(salary) [2nd Highest Salary] from employees
where Salary < (select max(Salary) from Employees)

--3rd Highest Salary
select max(salary) [3rd Highest Salary] from Employees
where Salary < (select max(salary) [2nd Highest Salary] from employees
where Salary < (select max(Salary) from Employees))


--CTE
with cte as (
Select *,DENSE_RANK() over(order by Salary desc)[DR] from Employees
)

Select salary[2nd Highest Salary] from cte where DR = 2

--3rd Highest Salary
with cte as (
Select *,DENSE_RANK() over(order by Salary desc)[DR] from Employees
)
Select salary[3rd Highest Salary] from cte where [DR] = 3

-- Sub Query along with Dense Function
Select Salary as [2nd Highest Salary] from 
(select *, DENSE_RANK() over(order by  Salary desc)[DR] from Employees) x
Where DR = 2

-- 3rd highest salary
Select salary as [3rd Highest Salary] from
(Select *, DENSE_RANK() over(order by salary desc)[DR] from Employees) x
where DR = 3

-- Only using sub query
select top 1 salary [2nd Highest Salary] from
(Select distinct top 2 Salary from Employees order by Salary desc) x
Order by Salary asc

--3rd Highest Salary
Select top 1 salary [3rd Highest Salary] from
(Select distinct top 3 Salary from Employees order by salary desc) x
Order by  salary asc