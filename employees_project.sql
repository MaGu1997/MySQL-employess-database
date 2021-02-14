USE employees;
# SEQUENCE OF SELECT CLAUSE
# SELECT col_names,FROM tab_name,WHERE cond,GROUP conditions,BY col_name,HAVING conditions,ORDER BY col_name,LIMIT number,
-- SELECT first_name, last_name from employees;
-- SELECT 
--     *
-- FROM
--     employees
-- WHERE
    -- first_name = 'Denis' AND gender = 'M';
    -- first_name = 'Denis' OR first_name = 'Elvis';#both 
    -- last_name='Denis' AND (gender='M' OR gender='F');#precedence
    -- first_name = 'Cathie' OR 'Mark' OR 'Nathan';
    -- first_name IN ('Cathie', 'Mark', 'Nathan');#includes only cathie, etc
    -- first_name NOT IN ('Cathie', 'Mark', 'Nathan');#excludes names
    -- first_name LIKE('ar%');#starts with ar
    -- first_name LIKE('%ar%'); #has ar somewhere in betn
    -- first_name LIKE('%ar');#ends with ar
    -- first_name LIKE('Mar_');# starts with Mar but only 1 alphabet left. 4 letters
	-- hire_date BETWEEN'1990-01-01' AND '2000-01-01';
    -- first_name IS NOT NULL;
	-- first_name IS NULL;
    -- first_name = 'Mark';
    -- first_name > '2000-01-01'; 
    -- first_name >= '2000-01-01'; # val included
    -- first_name < '2000-01-01';
    -- first_name <= '2000-01-01';
    -- first_name <> 'Mark'; #Not equal to
    -- first_name != 'Mark'; #Not equal to

# SELECT DISTINCT
-- SELECT DISTINCT gender FROM    employees; 
#COUNT()
-- SELECT COUNT(emp_no) FROM employees; // IGNORES NULL VALUES
-- SELECT COUNT(DISTINCT first_name) FROM employees;
#ORDER BY
-- SELECT * FROM employees ORDER BY first_name ASC
-- SELECT * FROM employees ORDER BY first_name DESC
-- SELECT * FROM employees ORDER BY first_name,last_name ASC

#GROUP BY
# SELECT FROM WHERE GROUP BY ORDER BY
-- SELECT first_name , COUNT(first_name) FROM employees GROUP BY first_name ORDER BY first_name DESC;

#ALIASES (AS)
-- SELECT first_name, COUNT(first_name) AS names_count FROM employees GROUP BY first_name ORDER BY first_name DESC;

#HAVING (Same as where) --Can use aggregate function unlike WHERE
# cannot use aggregated and no-aggregated together in HAVING
-- SELECT first_name, COUNT(first_name) AS names_count FROM employees GROUP BY first_name HAVING COUNT(first_name) > 250 ORDER BY first_name DESC;

# Q. ETRACT a list of all names with hre date >jan 1990 01, and count <200.
-- SELECT first_name, COUNT(first_name) AS names_count FROM employees WHERE hire_date > '1999-01-01' GROUP BY first_name HAVING COUNT(first_name) < 200 RDER BY first_name ASC;

# LIMIT
#Q. Top 10 paid employees
-- SELECT * FROM salaries GROUP BY emp_no ORDER BY salary DESC LIMIT 10;

-- -------------------------------------- ----------------------
#INSERT CLAUSE 
-- --------------------------------------------------
 /*INSERT INTO employees
 (
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
) VALUES
(
	999000,
    '1997-01-01',
    'John',
    'Smith',
    'M',
    '1990-01-01'
);*/
    
-- select * from employees order by emp_no DESC LIMIT 10;
/*CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);*/

/*INSERT INTO departments_dup
(
	dept_no,
    dept_name
)	SELECT * FROM departments;*/

 -- -------------------------------------- ----------------------
#UPDATE,COMMIT. ROLLBACK CLAUSE 
-- --------------------------------------------------

/*UPDATE employees
SET  
	first_name='Stella',
    last_name='Parkinson',
    birth_date='1990-01-01',
    gender='F'
WHERE
	emp_no='999001'
    */
/*    
COMMIT;
    
UPDATE departments_dup
SET
	dept_no='d011',
	dept_name='Quality control';
        
SELECT * from departments_dup;
ROLLBACK;
COMMIT;
*/
 -- -------------------------------------- ----------------------
#DELETE 
-- --------------------------------------------------
# always commit first before making major changes so that it can be rollback
-- SELECT * from employees where emp_no=999003;
-- DELETE FROM employees where emp_no=999003;

-- ROLLBACK;
#UNSAFE WAY TO USE DELETE WITHOUT WHERE CLAUSE ATTACHED
/*
COMMIT;
select * from departments_dup;
DELETE from departments_dup;
ROLLBACK;
*/
 -- -------------------------------------------------
#	COUNT() SUM() MIN() MAX() AVG() -- AGGREGATE FUNCTIONS
-- --------------------------------------------------

-- select count(*)
-- from salaries;

-- select sum(salary)
-- from salaries;

-- select max(salary) from salaries;
-- select min(salary) from salaries;
-- select avg(salary) from salaries;
-- select round(avg(salary)) from salaries;
-- select round(avg(salary), 2) from salaries;

 -- -------------------------------------------------
#	IFNULL() and COALESCE()
-- --------------------------------------------------
-- SELECT 
--     dept_no, 
--     IFNULL(dept_name, 'Department name not provided')
-- FROM
--     departments_dup;
-- SELECT 
--     dept_no, 
--     COALESCE(dept_name,dept_manager 'Department name not provided') AS dept_manager
-- FROM
--     departments_dup;

/*
create table dept_manager_dup
(
	`emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL
);

Insert into dept_manager_dup
(
	`emp_no`,
  `dept_no`,
  `from_date`,
  `to_date` 
) select * from dept_manager;

select * from dept_manager_dup */

-- drop table depart_manager_dup;

 -- -------------------------------------------------
#	JOIN
-- --------------------------------------------------
/*
SELECT m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m 
inner join
departments_dup d on m.dept_no = d.dept_no
order by m.dept_no;
*/

 -- -------------------------------------------------
#	DUPLICATE rows in join
-- --------------------------------------------------

/* use the group by clause and apply to the most unique field in the databse
eg: group by emp_id will eliminate the duplicatevalues */

 -- -------------------------------------------------
#	LEFT JOIN()
-- --------------------------------------------------



 -- -------------------------------------------------
#	Problem: Select first name and last from employees where salary >145000 from salaries table
-- --------------------------------------------------
/*
Select e.emp_no, e.first_name, e.last_name, s.salary
from employees e
join salaries s on e.emp_no = s.emp_no
where s.salary>145000;
*/
 -- -------------------------------------------------
#	Multiple tables JOIN()
-- --------------------------------------------------
/*
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
;

*/

 -- -------------------------------------------------
#	sub qeuries use IN and () for subquery
-- --------------------------------------------------
/*
SElect e.first_name, e.last_name
from employees e
where e.emp_no IN (select dm.emp_no
from dept_manager dm);
*/

 -- -------------------------------------------------
-- EXISTS and NOT EXISTS() nested inside WHERE 
--------------------------------------------------
/*
SElect e.first_name, e.last_name
from employees e
where exists(Select * from dept_manager dm where dm.emp_no = e.emp_no);
*/

-- EXISTS VS IN 
-- EXISTS is fast as it only checks the rows for true or false

-- Select A.* from (select e.emp_no AS employee_id, MIN(de.dept_no) as department_code,(selectemp_no from dept_manager where emp_no=110022) as manager_ID from employees e join dept_emp de on e.emp_no=de.emp_no where e.emp_no<=10020 group by e.emp_no order by e.emp_no) as A union select A.* from (select e.emp_no AS employee_id, min(de.dept_no) as department_code,(selectemp_no from dept_manager where emp_no=110039) as manager_ID from employees e join dept_emp de on e.emp_no=de.emp_no where e.emp_no>10020 group by e.emp_no order by e.emp_no limit 20) as B;

 -- -------------------------------------------------
-- VIEWS = used to store coe and rerun every time a request for query is created
--------------------------------------------------
/*
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no ;

*/