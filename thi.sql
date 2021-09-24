-- CREATE TABLE orders1
-- ( order_id number(5),
--   quantity number(4),
--   cost_per_item number(6,2),
--   total_cost number(8,2),
--   create_date date,
--   created_by varchar2(10)
-- );
-- CREATE OR REPLACE TRIGGER orders_before_insert
-- BEFORE INSERT
--    ON orders1
--    FOR EACH ROW

-- DECLARE
--    v_username varchar2(10);

-- BEGIN

--    -- Find username of person performing INSERT into table
--    SELECT user INTO v_username
--    FROM dual;

--    -- Update create_date field to current system date
--    :new.create_date := sysdate;

--    -- Update created_by field to the username of the person performing the INSERT
--    :new.created_by := v_username;

-- END;

-- CREATE TABLE orders2
-- ( order_id number(5),
--   quantity number(4),
--   cost_per_item number(6,2),
--   total_cost number(8,2)
-- );

-- Create table orders_audit
-- ( order_id number(5),
--   quantity number(4),
--   cost_per_item number(6,2),
--   total_cost number(8,2),
--   username varchar(20)
-- );

-- CREATE OR REPLACE TRIGGER orders_after_insert
-- AFTER INSERT
--    ON orders2
--    FOR EACH ROW

-- DECLARE
--    v_username varchar2(10);

-- BEGIN

--    -- Find username of person performing the INSERT into the table
--    SELECT user INTO v_username
--    FROM dual;

--    -- Insert record into audit table
--    INSERT INTO orders_audit
--    ( order_id,
--      quantity,
--      cost_per_item,
--      total_cost,
--      username )
--    VALUES
--    ( :new.order_id,
--      :new.quantity,
--      :new.cost_per_item,
--      :new.total_cost,
--      v_username );

-- END;

-- CREATE TABLE orders3
-- ( order_id number(5),
--   quantity number(4),
--   cost_per_item number(6,2),
--   total_cost number(8,2),
--   updated_date date,
--   updated_by varchar2(10)
-- );

-- CREATE OR REPLACE TRIGGER orders_before_update
-- BEFORE UPDATE
--    ON orders3
--    FOR EACH ROW

-- DECLARE
--    v_username varchar2(10);

-- BEGIN

--    -- Find username of person performing UPDATE on the table
--    SELECT user INTO v_username
--    FROM dual;

--    -- Update updated_date field to current system date
--    :new.updated_date := sysdate;

--    -- Update updated_by field to the username of the person performing the UPDATE
--    :new.updated_by := v_username;

-- END;

-- CREATE TABLE employee_salary
-- (
--     EMP_ID number(10),
--     SALARY number(10),
--     EMP_NAME varchar2(50)
-- );

-- CREATE TABLE employee_salary_hike_log
-- (
--     EMP_ID number(10),
--     NEW_SALARY number(10),
--     HIKE number(10),
--     UPDATED_DATE date,
--     UPDATED_BY varchar2(20)
-- );

-- CREATE OR REPLACE TRIGGER trg_log_salary_hike
-- AFTER UPDATE 
--   OF SALARY 
--     ON employee_salary 
-- FOR EACH ROW
-- WHEN ((NEW.SALARY - OLD.SALARY) > 50000)
 
-- DECLARE
-- username varchar2(20);
 
-- BEGIN
 
--     SELECT USER INTO username FROM dual;
    
--     -- Insert new values into log table.
--     INSERT INTO employee_salary_hike_log VALUES (:NEW.EMP_ID, :NEW.SALARY, :NEW.SALARY - :OLD.SALARY ,sysdate, username);
-- END;
 
-- Insert few values in employee_salary
 
-- INSERT INTO employee_salary VALUES (101,15000,'Pranav');
 
-- INSERT INTO employee_salary VALUES (201,40000,'Vikram');
 
-- INSERT INTO employee_salary VALUES (301,35000,'Nikhil');

-- UPDATE employee_salary SET SALARY = '70000' WHERE emp_id = 101;
 
-- UPDATE employee_salary SET SALARY = '100000' WHERE emp_id = 301;
 
-- -- Update salary of emp_id 201 with hike less than 50000
-- UPDATE employee_salary SET SALARY = '45000' WHERE emp_id = 201;

-- CREATE TABLE job_openings
-- (
--     APPLICATION_ID number(10) primary key,
--     FIRST_NAME varchar2(50),
--     LAST_NAME varchar2(50),
--     JOB_EXPERIENCE number(2),
--     LAST_APPLIED_DATE date
-- );

-- Creating TRIGGER

-- CREATE OR REPLACE TRIGGER trg_before_emp_update
-- BEFORE UPDATE OF JOB_EXPERIENCE,LAST_APPLIED_DATE
--   on job_openings
--   FOR EACH ROW 

-- DECLARE

-- years_since_last_applied number(5);

-- BEGIN
-- years_since_last_applied := -1;

--   IF(:NEW.LAST_APPLIED_DATE IS NOT NULL) THEN

--     SELECT MONTHS_BETWEEN(TO_DATE(sysdate,'DD-MON-YYYY'), TO_DATE(:NEW.LAST_APPLIED_DATE,'DD-MON-YYYY'))/12
--       INTO years_since_last_applied FROM dual;

--    -- Check whether years_since_last_applied is greater than 2 years or not
--     IF (years_since_last_applied <= 2) THEN
--       RAISE_APPLICATION_ERROR(-20000,'Previous application attempt must not be done in last 2 years.');
--     END IF;
--   END IF;
  
--     -- Job experience must be more than or equal to 3 years.
--     IF(:new.JOB_EXPERIENCE < 3) THEN
--       RAISE_APPLICATION_ERROR(-20000,'Job experience must be more than or equal to 3 years.');
--     END IF;          
    
-- END;

-- setting date format to to 'DD-MON-YYYY'

-- alter session set nls_date_format = 'DD-MON-YYYY';

-- INSERT INTO job_openings VALUES (1,'Mark','Sharma',10,'01-JAN-2012');

-- INSERT INTO job_openings VALUES (2,'Praveen','Kumar',4,'01-DEC-2010');

-- INSERT INTO job_openings VALUES (3,'Rahul','Kohli',6,null);

-- UPDATE job_openings SET JOB_EXPERIENCE = 2 where APPLICATION_ID = 1;

--Creating person_records table.

-- CREATE TABLE person_records
-- (
--     PERSON_ID number(10) primary key,
--     FIRST_NAME varchar2(50),
--     LAST_NAME varchar2(50),
--     HIRE_DATE date,
--     UPDATED_BY varchar2(20),
--     UPDATED_DATE date
-- );

-- CREATE OR REPLACE TRIGGER trg_before_person_update
-- BEFORE UPDATE
--   on person_records
--   FOR EACH ROW 

-- DECLARE
-- username varchar2(20);

-- BEGIN

--   SELECT USER INTO username FROM dual;
  
--   -- Setting updated_by and updated_Date values.
--   :NEW.UPDATED_BY := username;
--   :NEW.UPDATED_DATE := sysdate;

-- END;

-- alter session set nls_date_format = 'DD-MON-YYYY';

-- INSERT INTO person_records VALUES (101,'Devil','Khedut',sysdate,null,null);
-- INSERT INTO person_records VALUES (102,'Kanji','Yadav',sysdate,null,null);

-- CREATE TABLE customer_details
-- (
-- 	customer_id number(10) primary key,
-- 	customer_name varchar2(20),
-- 	country varchar2(20)
-- );

-- CREATE TABLE projects_details
-- (
-- 	project_id number(10) primary key,
-- 	project_name varchar2(30),
-- 	project_start_Date date,
-- 	customer_id number(10) references customer_details(customer_id)
-- );

-- CREATE OR REPLACE VIEW customer_projects_view AS
--    SELECT cust.customer_id, cust.customer_name, cust.country,
--           projectdtls.project_id, projectdtls.project_name, 
-- 		  projectdtls.project_start_Date
--    FROM customer_details cust, projects_details projectdtls
--    WHERE cust.customer_id = projectdtls.customer_id;

-- INSERT INTO customer_projects_view VALUES (1,'XYZ Enterprise','Japan',101,'Library management',sysdate);


-- CREATE OR REPLACE TRIGGER trg_cust_proj_view_insert
--    INSTEAD OF INSERT ON customer_projects_view
--    DECLARE
--      duplicate_info EXCEPTION;
--      PRAGMA EXCEPTION_INIT (duplicate_info, -00001);
--    BEGIN
     
--    INSERT INTO customer_details
--        (customer_id,customer_name,country)
--      VALUES (:new.customer_id, :new.customer_name, :new.country);
     
--    INSERT INTO projects_details (project_id, project_name, project_start_Date, customer_id)
--    VALUES (
--      :new.project_id,
--      :new.project_name,
--      :new.project_start_Date,
--      :new.customer_id);
  
--    EXCEPTION
--      WHEN duplicate_info THEN
--        RAISE_APPLICATION_ERROR (
--          num=> -20107,
--          msg=> 'Duplicate customer or project id');
--    END trg_cust_proj_view_insert;


INSERT INTO customer_projects_view VALUES (1,'XYZ Enterprise','Japan',101,'Library management',sysdate);

INSERT INTO customer_projects_view VALUES (2,'ABC Infotech','India',202,'HR management',sysdate);
