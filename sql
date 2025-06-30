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





