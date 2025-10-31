-- Create the table with EmployeeID and Email
CREATE TABLE EmployeeRecords_1 (
    EmployeeID INT,
    Email VARCHAR(100)
);


-- Insert data into the table, including duplicates
INSERT INTO EmployeeRecords_1 (EmployeeID, Email) VALUES
(1, 'alice@example.com'),
(2, 'bob@example.com'),
(3, 'carol@example.com'),
(4, 'david@example.com'),
(2, 'bob@example.com'),        -- Duplicate entry (same EmployeeID and Email)
(4, 'david@example.com'),      -- Duplicate entry (same EmployeeID and Email)
(5, 'shared@example.com'),     -- Valid case: Same email, different EmployeeID
(6, 'shared@example.com');     -- Valid case: Same email, different EmployeeID


select * from EmployeeRecords_1
order by EmployeeID

select distinct * into #1 from EmployeeRecords_1

truncate table EmployeeRecords_1

insert into EmployeeRecords_1 select *from #1
select * from EmployeeRecords_1 order by email

--Records with lower employeeid shoul remain if duplicate is present
with cte as (select *,DENSE_RANK() over(partition by email order by employeeid)[DR]from
EmployeeRecords_1)

delete from cte where dr = 2

select * into employeerecords_2 from #1

select * from employeerecords_2 order by email

--Retail the record with higher Employee id
with cte as (
select *, DENSE_RANK() over(partition by email order by employeeid desc) [DR] from employeerecords_2
)
--select * from cte
delete from cte where DR = 2


