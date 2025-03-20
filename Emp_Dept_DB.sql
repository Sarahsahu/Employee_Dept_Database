create database DeptDB;
use DeptDB;

 CREATE TABLE DEPT (
    DEPTNO INT(2) PRIMARY KEY, 
    DNAME VARCHAR(14), 
    LOC VARCHAR(13)
);
DESC TABLE DEPT;

Insert into DEPT  values (10,'ACCOUNTING','NEW YORK');
Insert into DEPT  values (20,'RESEARCH','DALLAS');
Insert into DEPT  values (30,'SALES','CHICAGO');
Insert into DEPT values (40,'OPERATIONS','BOSTON');
Insert into DEPT  values (50,'IT','HYDERABAD');

select * from DEPT;

CREATE TABLE EMP
   (
    EMPNO INT (2) PRIMARY KEY, 
	ENAME VARCHAR(10), 
	JOB VARCHAR(9), 
	MGR INT(4), 
	HIREDATE DATE, 
	SAL INT (7), 
	DEPTNO INT (2) REFERENCES DEPT(DEPTNO)
   ) ;
   
   DESC table EMP;
   
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, 10);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, 10);
INSERT INTO EMP VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, 20);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, 20);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, 20);
INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 50, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 30);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 30);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 8005, 30);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, 40);
INSERT INTO EMP VALUES (8001, 'ANABELLE', 'CLERK', 7698, '1981-12-03', 5500, 20);
INSERT INTO EMP VALUES (8002, 'OLIVE', 'CLERK', 7698, '1981-12-03', 5800, 20);
INSERT INTO EMP VALUES (8003, 'OLIVE', 'CLERK', 7698, '1981-12-03', 5800, 20);
INSERT INTO EMP VALUES (8004, 'KINGS', 'CLERK', 7698, '1981-12-03', 5800, 20);
INSERT INTO EMP VALUES (8005, 'KINE', 'CLERK', 7698, '1981-12-03', 5800, 20);
INSERT INTO EMP VALUES (8006, 'KILLEY', 'SALESMAN', 7788, '1990-06-12', 7500, NULL);
INSERT INTO EMP VALUES (8007, 'JASON', 'DEVELOPER', 7788, '1990-06-12', 7500, NULL);
INSERT INTO EMP VALUES (8008, 'BIPLAB', 'CLERK', 7788, '1989-07-12', 8999, 20);
INSERT INTO EMP VALUES (8009, 'BIPLAB', 'SALESMAN', 7698, '2022-03-12', 9000, 30);
INSERT INTO EMP VALUES (8010, 'JASON', 'SALESMAN', 7698, '2022-03-12', 9000, 30);
select * from EMP;

SHOW tables;

/*QUERIES*/
#1 Select all employee and salary who are earning more than employee 7839.
select ENAME , SAL 
from EMP
where SAL > (select SAL from EMP where EMPNO = 7839); 

#2. Select employee name, salary, employee 7499 's salary for employees earning more than employee 7499.

select ENAME, SAL, 
(select SAL from EMP where EMPNO = 7499) as SAL_7499 
from EMP where SAL > (select SAL from EMP where EMPNO = 7499);

#3. Select all details of employees who belong to the same department as employee 7839.

select * from EMP 
where EMPNO =(select DEPTNO from DEPT where DEPTNO = 7839);

/* 4. Select all employee names, their salary, and the total average salary of all employees who are earning 
more than the average salary.*/

select ENAME, SAL, (select AVG(SAL) from EMP) as AVG_SAL 
from EMP 
where SAL > (select AVG(SAL) from EMP);

/* 5.Select all employee details who were hired before BLAKE.*/

select *
from EMP
where HIREDATE < (select HIREDATE from EMP where ENAME ='BLAKE');
 
/*6. Select all employee names and salaries who are earning more than BLAKE but less than KING.*/

select ENAME,SAL
from EMP
where SAL> (select SAL from EMP where ENAME ='BLAKE') and SAL< (select SAL from EMP where ENAME ='KING');

#7. Select all department numbers which have more employees than department 10.

select DEPTNO 
from EMP 
group by DEPTNO 
having  COUNT(*) > (select COUNT(*) from EMP where DEPTNO = 10);

#8.Select all department names which have more employees working than the 'ACCOUNTING' department.
select DNAME  
from DEPT  
where DEPTNO in (  
    select DEPTNO  
    from EMP  
    group by DEPTNO  
    having count(EMPNO) > (select count(EMPNO) from EMP where DEPTNO =  
                           (select DEPTNO from DEPT where DNAME = 'ACCOUNTING')));  
                           
#9. Select the 3rd highest salary.  
      
select distinct SAL
from EMP
order by SAL desc
limit 1 offset 2;
                   
/* 10. Retrieve the employee names and their department names from the EMP and DEPT tables.*/
 
select E.ENAME, D.DNAME
from EMP E
inner join DEPT D on E.DEPTNO = D.DEPTNO;

/*11 . Retrieve all employees and their respective department names. 
Also, include employees who do not have a matching department.*/

select E.ENAME, D.DNAME
from EMP E
left join  DEPT D on E.DEPTNO = D.DEPTNO;

/* 12. Retrieve all departments and the employees working in them. 
Also, include departments with no employees."*/

select E.ENAME, D.DNAME
from EMP E
right join DEPT D on E.DEPTNO = D.DEPTNO;

