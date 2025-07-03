/*
Find departments with above-average salaries.

case=1
output=
+---------------+--------------+
| department_id | avg_salary   |
+---------------+--------------+
|             3 | 73500.000000 |
|             4 | 63500.000000 |
+---------------+--------------+
*/

use fsa1;
select department_id,avg(salary)  from employees
group by department_id having avg(salary)>(select avg(salary) from employees);



/*
Departments with more than 1 employees

case=1
output=
+-----------------+                                                                                                                                   
| department_name |                                                                                                                                   
+-----------------+                                                                                                                                   
| HR              |                                                                                                                                   
| Finance         |                                                                                                                                   
| IT              |                                                                                                                                   
| Marketing       |                                                                                                                                   
+-----------------+

*/
use fsa1;
select department_name from departments d having
(select count(employee_id)>1 from employees e where e.department_id=d.department_id )



/*
Employees not assigned to any project

case=1
output=
+----------------+                                                                                                                                    
| employee_name  |                                                                                                                                    
+----------------+                                                                                                                                    
| David Williams |                                                                                                                                    
| Frank White    |                                                                                                                                    
| Grace Hall     |                                                                                                                                    
| Henry Clark    |                                                                                                                                    
| Jack Miller    |                                                                                                                                    
+----------------+
*/
use fsa1;
select employee_name from employees  where employee_id not in (select employee_id from projects)



/*
Employees hired before 2020

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
| Eva Davis     |                                                                                                                                     
| Grace Hall    |                                                                                                                                     
| Ivy Lewis     |                                                                                                                                     
+---------------+

*/
use fsa1;
select employee_name from employees  where hire_date<'2020-01-01';



/*
Departments with average salary above 60000

case=1
output=
+-----------------+                                                                                                                                   
| department_name |                                                                                                                                   
+-----------------+                                                                                                                                   
| IT              |                                                                                                                                   
| Marketing       |                                                                                                                                   
+-----------------+  
*/
use fsa1;
select department_name from departments d having
(select avg(salary)>60000 from employees e
where e.department_id=d.department_id)


/*
Managers with more than 2 subordinates

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Alice Johnson |                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
+---------------+
*/
use fsa1;
select employee_name from employees e 
having(select count(employee_id)>=2
from employees e2 where e.employee_id=e2.manager_id)


/*
Employees who are also managers

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Alice Johnson |                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
| Eva Davis     |                                                                                                                                     
+---------------+
*/
use fsa1;
select e.employee_name from employees e 
join employees e2 on 
e.employee_id=e2.manager_id
group by e2.manager_id




/*
Employee with the second highest salary

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Grace Hall    |                                                                                                                                     
+---------------+
*/
use fsa1;
select employee_name from employees order by salary desc limit 1 offset 1;


/*
Departments where the max salary is less than 70000

case=1
output=
+-----------------+                                                                                                                                   
| department_name |                                                                                                                                   
+-----------------+                                                                                                                                   
| HR              |                                                                                                                                   
| Finance         |                                                                                                                                   
| Marketing       |                                                                                                                                   
| Operations      |                                                                                                                                   
+-----------------+
*/
use fsa1;
select department_name from departments d where department_id in
(select department_id from employees where salary<70000);



/*
Employees working in the same department as 'Bob Smith'

case=1
output=
+----------------+                                                                                                                                    
| employee_name  |                                                                                                                                    
+----------------+                                                                                                                                    
| Bob Smith      |                                                                                                                                    
| David Williams |                                                                                                                                    
+----------------+
*/
use fsa1;
select employee_name from employees where department_id =
(select department_id from employees where employee_name="Bob Smith");



/*
Projects handled by employees who earn more than average

case=1
output=
+-----------------------+                                                                                                                             
| project_name          |                                                                                                                             
+-----------------------+                                                                                                                             
| Financial Audit       |                                                                                                                             
| Cybersecurity Upgrade |                                                                                                                             
| Marketing Strategy    |                                                                                                                             
+-----------------------+
*/
use fsa1;
select project_name from projects where employee_id in
(select employee_id from employees  where salary>(select avg(salary) from employees));


/*
Employees who earn more than their manager

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
| Eva Davis     |                                                                                                                                     
+---------------+
*/
use fsa1;
select employee_name from employees e 
join employees e2  on e.employee_id=e2.manager_id
where e.salary> (select salary from employees e2 )


/*
Employees hired before their manager

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
| Eva Davis     |                                                                                                                                     
| Grace Hall    |                                                                                                                                     
+---------------+
*/
use fsa1;
-- select e.employee_name from employees e where hire_date <
-- (select hire_date from employees  where employee_id=e.manager_id)
select e.employee_name from employees e 
Join employees m on e.manager_id=m.employee_id
where e.hire_date<m.hire_date



/*
Employees working in departments where max salary is below 90000

case=1
output=
+----------------+                                                                                                                                    
| employee_name  |                                                                                                                                    
+----------------+                                                                                                                                    
| Alice Johnson  |                                                                                                                                    
| Bob Smith      |                                                                                                                                    
| Charlie Brown  |                                                                                                                                    
| David Williams |                                                                                                                                    
| Eva Davis      |                                                                                                                                    
| Grace Hall     |                                                                                                                                    
| Henry Clark    |                                                                                                                                    
| Ivy Lewis      |                                                                                                                                    
| Jack Miller    |                                                                                                                                    
+----------------+
*/

use fsa1;
select employee_name from employees e where department_id in
(select department_id from employees e2
group by department_id
having max(salary)<90000);


/*
Employees with salary greater than all others in their department

case=1
output=
+---------------+                                                                                                                                     
| employee_name |                                                                                                                                     
+---------------+                                                                                                                                     
| Alice Johnson |                                                                                                                                     
| Bob Smith     |                                                                                                                                     
| Charlie Brown |                                                                                                                                     
| Eva Davis     |                                                                                                                                     
| Frank White   |                                                                                                                                     
| Ivy Lewis     |                                                                                                                                     
+---------------+
*/
use fsa1;
select employee_name from employees e where salary in
(select max(salary) from employees  group by department_id );
-- where e2.employee_id=e.department_id)


/*
Employees with salary less than any other in their department

case=1
output=
+----------------+                                                                                                                                    
| employee_name  |                                                                                                                                    
+----------------+                                                                                                                                    
| David Williams |                                                                                                                                    
| Grace Hall     |                                                                                                                                    
| Henry Clark    |                                                                                                                                    
| Jack Miller    |                                                                                                                                    
+----------------+
*/
use fsa1;
select employee_name from employees where salary in(
select min(salary) from employees group by department_id)









