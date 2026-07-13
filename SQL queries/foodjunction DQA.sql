USE food_junction;

-- 0 Checking for Data Quality

select * from customers;
select * from orders;
select * from employees;
select * from menu_items;
select * from order_details;
select * from orders;

select Order_id, Branch_ID , Order_DateTime from orders;

-- After having a general glance at data, data profiing is proceeded with checking out 
-- missing values, nulls and duplicates

-- 1.a applying CASE queries
SELECT * from customers;
SELECT
	SUM(CASE WHEN customers.first_name IS NULL OR customers.first_name = '' THEN 1 ELSE 0 END) AS cust_null,
    SUM(CASE WHEN customers.Gender IS NULL OR customers.Gender ='' THEN 1 ELSE 0 END) AS gender_null,
	SUM(CASE WHEN customers.city IS NULL OR customers.city = '' THEN 1 ELSE 0 END) AS city_null,
    SUM(CASE WHEN customers.Join_Date IS NULL OR customers.Join_Date ='' THEN 1 ELSE 0 END) AS date_null
from customers;

-- 1.b
SELECT * from employees;
SELECT
	SUM(CASE WHEN employees.Branch_id IS NULL OR employees.Branch_id = '' THEN 1 ELSE 0 END) AS branch_null,
    SUM(CASE WHEN employees.first_name IS NULL OR employees.first_name = '' THEN 1 ELSE 0 END) AS name_null,
    SUM(CASE WHEN employees.Role IS NULL OR employees.Role = '' THEN 1 ELSE 0 END) AS role_null,
    SUM(CASE WHEN employees.Hire_Date IS NULL OR employees.Hire_Date = '' THEN 1 ELSE 0 END) AS hired_null,
	SUM(CASE WHEN employees.Salary_PKR IS NULL OR employees.Salary_PKR = '' THEN 1 ELSE 0 END) AS salary_null
    from employees;
    
    -- 1.c
SELECT * from menu_items;
SELECT
	SUM(CASE WHEN menu_items.Item_Name IS NULL OR menu_items.Item_Name = '' THEN 1 ELSE 0 END) AS item_name_null,
	SUM(CASE WHEN menu_items.Category IS NULL OR menu_items.Category = '' THEN 1 ELSE 0 END) AS category_null,
   	SUM(CASE WHEN menu_items.Selling_Price_PKR IS NULL OR menu_items.Selling_Price_PKR = '' THEN 1 ELSE 0 END) AS selling_price_null,
  	SUM(CASE WHEN menu_items.Cost_PKR IS NULL OR menu_items.Cost_PKR = '' THEN 1 ELSE 0 END) AS cost_null,
   	SUM(CASE WHEN menu_items.Is_Active IS NULL OR menu_items.Is_Active = '' THEN 1 ELSE 0 END) AS active_null
    from menu_items;
    
    -- 1.d 
SELECT * from order_details;
SELECT
    SUM(CASE WHEN order_details.Order_ID IS NULL OR order_details.Order_ID = '' THEN 1 ELSE 0 END) AS order_null,
    SUM(CASE WHEN order_details.Menu_item_ID IS NULL OR order_details.Menu_item_ID = '' THEN 1 ELSE 0 END) AS ordetail_null,
    SUM(CASE WHEN order_details.quantity IS NULL OR order_details.quantity = '' THEN 1 ELSE 0 END) AS quantity_null
from order_details;

-- 1.e 
SELECT * from orders;
SELECT
    SUM(CASE WHEN orders.Order_ID IS NULL OR orders.Order_ID = '' THEN 1 ELSE 0 END) AS id_null,
    SUM(CASE WHEN orders.Customer_ID IS NULL OR orders.Customer_ID = '' THEN 1 ELSE 0 END) AS ordetail_null,
    SUM(CASE WHEN orders.Branch_ID IS NULL OR orders.Branch_ID = '' THEN 1 ELSE 0 END) AS branch_null,
	SUM(CASE WHEN orders.Order_DateTime IS NULL OR orders.Order_DateTime = '' THEN 1 ELSE 0 END) AS datatime_null,
    SUM(CASE WHEN orders.status IS NULL OR orders.status = '' THEN 1 ELSE 0 END) AS status_null
from orders;



-- 2 DUPLICATE DETECTION 
-- Full-row duplicates for customers

-- 2.a 
SELECT *, COUNT(*) AS occurrs
FROM branches
GROUP BY Branch_ID, Branch_Name, City  -- list all/most columns
HAVING COUNT(*) > 1;

-- 2.b 
SELECT *, COUNT(*) AS occurrs
FROM customers
GROUP BY Customer_ID, First_Name, Last_Name, Gender, City, Join_Date  -- list all/most columns
HAVING COUNT(*) > 1;

-- same for the rest duplicate detections
-- 2.c 
SELECT *, COUNT(*) AS occurrs
FROM employees
GROUP BY Employee_ID, Branch_ID, First_Name, Last_Name, Role, Hire_Date, Salary_PKR  -- list all/most columns
HAVING COUNT(*) > 1;

-- 2.d 
SELECT *, COUNT(*) AS occurrs
FROM menu_items
GROUP BY Menu_Item_ID, Item_Name, Category, Selling_Price_PKR, Cost_PKR, Is_Active  -- list all/most columns
Having COUNT(*) > 1;

-- 2.e 
SELECT *, COUNT(*) AS occurrs
FROM order_details
GROUP BY Order_Detail_ID, Order_ID, Menu_Item_ID, Quantity  -- list all/most columns
Having COUNT(*) > 1;

-- 2.f  
SELECT *, COUNT(*) AS occurrs
FROM orders
GROUP BY Order_ID, Customer_ID, Branch_ID, Order_DateTime, Status  -- list all/most columns
Having COUNT(*) > 1;

-- 2.g 
SELECT *, COUNT(*) AS occurrs
FROM reviews
GROUP BY Review_ID, Order_ID, Rating  -- list all/most columns
Having COUNT(*) > 1;

-- 3.a  CHECKING encoding replacement characters, common in csv 
SELECT * FROM branches
WHERE Branch_ID LIKE '%Ã,â€%,?%' OR Branch_Name LIKE '%Ã,â€%,?%' OR City LIKE '%Ã,â€%,?%';

-- 3.b 
SELECT * FROM customers
WHERE Customer_ID LIKE '%Ã,â€%,?%' OR First_Name LIKE '%Ã,â€%,?%' OR Last_Name LIKE  '%Ã,â€%,?%' OR Gender LIKE '%Ã,â€%,?%' OR City LIKE '%Ã,â€%,?%' OR Join_Date LIKE '%Ã,â€%,?%';
-- similar encoding check queries for rest of the tables
-- 3.c 
SELECT * FROM employees
WHERE Employee_ID LIKE '%Ã,â€%,?%' OR Branch_ID LIKE '%Ã,â€%,?%' OR First_Name LIKE '%Ã,â€%,?%' OR Last_Name LIKE '%Ã,â€%,?%' OR Role LIKE '%Ã,â€%,?%' OR Hire_Date LIKE '%Ã,â€%,?%' OR Salary_PKR LIKE '%Ã,â€%,?%';

-- 3.d  
SELECT * FROM menu_items
WHERE Menu_Item_ID LIKE '%Ã,â€%,?%' OR Item_Name LIKE '%Ã,â€%,?%' OR Category LIKE '%Ã,â€%,?%' OR Selling_Price_PKR LIKE '%Ã,â€%,?%' OR Cost_PKR LIKE '%Ã,â€%,?%' OR Cost_PKR LIKE '%Ã,â€%,?%' OR Is_Active LIKE '%Ã,â€%,?%';

-- 3.e 
SELECT * FROM order_details
WHERE Order_Detail_ID LIKE '%Ã,â€%,?%' OR Order_ID LIKE '%Ã,â€%,?%' OR Menu_Item_ID LIKE '%Ã,â€%,?%' OR Quantity LIKE '%Ã,â€%,?%';

-- 3.f 
SELECT * FROM orders
WHERE Order_ID LIKE '%Ã,â€%,?%' OR Customer_ID LIKE '%Ã,â€%,?%' OR Branch_ID LIKE '%Ã,â€%,?%' OR Order_DateTime LIKE '%Ã,â€%,?%' OR Status LIKE '%Ã,â€%,?%';

SELECT * FROM reviews
WHERE Review_ID LIKE '%Ã,â€%,?%' OR Order_ID LIKE '%Ã,â€%,?%' OR Rating LIKE '%Ã,â€%,?%';


-- 4.a  Inconsistent casing/spelling 
SELECT DISTINCT City FROM customers
ORDER BY City;

-- 4.b 
SELECT DISTINCT Role from employees
order by Role
;

-- 4.c 
SELECT DISTINCT Item_Name from menu_items
order by Item_Name
;

-- 4.d 
SELECT DISTINCT Category from menu_items
order by Category
;

-- 4.e  
SELECT DISTINCT Selling_Price_PKR from menu_items
order by Selling_Price_PKR
;




