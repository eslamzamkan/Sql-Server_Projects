---1----
----Display the Department id, name and id and the name of its manager.---
select d.Dname,d.DNum,e.Superssn,e.Fname+e.Lname as manger
from  Department d 
inner join Employee e
on d.DNum=e.Dno ;
-----2----
-------Display the name of the departments and the name of the projects under its control----
select d.Dname ,p.Pname
from Department d inner join project p
on d.DNum=p.Dnum;
-----3----
----Display the full data about all the dependence associated with the name of the employee they depend on him/her.---
select  d.ESSN,d.Dependent_name,d.Sex,d.Bdate,e.Fname+e.Lname as employee
from Dependent d inner join Employee e
on e.SSN=d.ESSN;
-----4------
----using union---
----a-------
--The name and the gender of the dependence that's gender is Female and depending on Female Employee.--
select Dependent_name,Sex from Dependent 
where sex='F'
union
select Fname+Lname,sex as employee FROM Employee
WHERE Sex='F';
----b-------
----the male dependence that depends on Male Employee---
select Dependent_name,Sex from Dependent 
where sex='M'
union
select Fname+Lname,sex as employee FROM Employee
WHERE Sex='M';
-----5-----
---Display the Id, name and location of the projects in Cairo or Alex city----
select Pname,Pnumber,City from project where City='Alex' or City='Cairo';
-----6------
---Display the Projects full data of the projects with a name starts with "a" letter.----
select * from project where Pname like 'a%';
-----7--------
-----display all the employees in department 30 whose salary from 1000 to 2000 LE monthly-----
select * from Employee where Dno =30 and Salary between 1000 and 2000;
--------8---------
--Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project----
select DISTINCT  e.Fname+e.Lname as name,w.Hours from Employee e 
, [Works for] w,Project p
where e.SSN=w.ESSN  and e.Dno=10 and w.Pno=(select Pnumber from Project where Pname='AL Rabwah') ;

------9-------
----Find the names of the employees who directly supervised with Kamel Mohamed.----
select fname+lname as employee from Employee where Superssn=223344; 
-----------10--------
----For each project, list the project name and the total hours per week (for all employees) spent on that project----
select p.Pname, sum(w.hours) as hours 
from Project p
inner join [Works for]w on p.Pnumber = w.Pno
group by p.Pname;--
-----11--------
----Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name------
select DISTINCT Employee.fname, Project.Pname from 
Employee
inner join [Works for] w 
on w.ESSN =Employee.SSN
inner join Project 
 on Project.Pnumber=w.Pno
order by Project.Pname
;
------12--------
----Display the data of the department which has the smallest employee ID over all employees ID-----
select Department.Dname,Department.DNum,Department.[MGRSSN],Department.[MGRStart date],min(SSN) as min_id
from Department,Employee
where Department.MGRSSN=Employee.Superssn
group by Dname,DNum,MGRSSN,[MGRStart date]
having min(SSN)= (select min(SSN) from Employee);
--SELECT NAME, ID FROM Q.STAFF WHERE DEPT = ANY(SELECT DEPTNUMB FROM Q.ORG WHERE DIVISION='EASTERN')
-------13--------
------For each department, retrieve the department name and the maximum, minimum and average salary of its employees.------
select Department.Dname,min(Salary) as mini,max(Salary) as maxi
from Department,Employee
where Department.DNum=Employee.Dno
group by Dname;
--having min(Salary)= (select min(Salary) from Employee) and max(Salary)=(select max(Salary) from Employee);
-------14----------
----List the last name of all managers who have no dependents----
SELECT c1.Lname,c2.SSN 
FROM  Employee c1
INNER JOIN Employee c2 ON c1.SSN = c2.Superssn
ORDER BY Lname;
------15-----------
-----For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.-----
select Dno,DNum,avg(Salary) as average,count(*) as count from Employee e,Department d
where e.Dno=d.DNum
group by dno,DNum
having avg(Salary)<(select AVG(Salary) from Employee)
;
-------16---------
----Retrieve a list of employees and the projects they are working on ordered by department and within each department, ordered alphabetically by last name, first name.---
select Fname+Lname as name,p.Pname,Dnum from Employee e,Project p
where e.Dno=p.Dnum
order by name,Dno
;
-------17---------
----For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate----
select Pnumber,p.Dnum,City,[MGRStart date],Addresss  
from Department d
inner join Employee e
on d.MGRSSN=e.SSN 
inner join Project p
on p.Dnum=d.DNum
where City in (select city from Project where City='Cairo');
;





