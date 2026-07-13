
-- Identify issues
/*
1. Data types needed to be corrected. Date and DateTime are in text format.
2. Primary keys are not defined in tables.
*/


/* testing if there any existing relationshilps between tables
 
 Query given below was applied to find if there are any relationships between tables. Upon testing no relationships were found between tables.
	*/
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME IS NOT NULL
AND TABLE_SCHEMA = 'food_junction';

-- no relationships at this point

-- Finding data types and column names in all the tables
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'food_junction'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT 
    a.TABLE_NAME AS table_1,
    a.COLUMN_NAME,
    b.TABLE_NAME AS table_2
FROM information_schema.COLUMNS a
JOIN information_schema.COLUMNS b
    ON a.COLUMN_NAME = b.COLUMN_NAME
    AND a.TABLE_NAME != b.TABLE_NAME
WHERE a.TABLE_SCHEMA = 'food_junction'
AND b.TABLE_SCHEMA = 'food_junction'
AND a.TABLE_NAME < b.TABLE_NAME;


-- Building relationships between tables

-- testing data first
SHOW KEYS FROM branches WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM customers WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM orders WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM menu_items WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM order_details WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM employees WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM reviews WHERE Key_name = 'PRIMARY';

-- Data type correction
ALTER TABLE orders ADD COLUMN Order_DateTime_new DATETIME;
UPDATE orders 
SET Order_DateTime_new = STR_TO_DATE(Order_DateTime, '%d/%m/%Y %H:%i')
where Order_ID > 0;

alter table employees ADD column hire_date_new date;

Alter table orders drop column Order_DateTime;
Alter table orders change column Order_DateTime_new Order_DateTime datetime;


UPDATE employees 
SET hire_date_new = STR_TO_DATE(Hire_Date, '%Y-%m-%d')
where Employee_ID > 0;

alter table employees drop Hire_Date;
alter table employees change column hire_date_new Hire_Date Date;

-- DATA TYPE ISSUE RESOLVED: text to date and datetime conversion above

-- Another Issue is undefined Primary and foreign keys

-- Defining Primary and foreign keys

ALTER TABLE branches
ADD PRIMARY KEY (Branch_ID);
ALTER TABLE employees
ADD PRIMARY KEY (Employee_ID);

-- employees → branches
ALTER TABLE employees
ADD CONSTRAINT fk_employees_branch
FOREIGN KEY (Branch_ID) REFERENCES branches(Branch_ID);

-- orders → customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

-- orders → branches
ALTER TABLE orders
ADD CONSTRAINT fk_orders_branch
FOREIGN KEY (Branch_ID) REFERENCES branches(Branch_ID);

-- order_details → orders
ALTER TABLE order_details
ADD CONSTRAINT fk_orderdetails_order
FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID);

-- order_details → menu_items
ALTER TABLE order_details
ADD CONSTRAINT fk_orderdetails_menuitem
FOREIGN KEY (Menu_Item_ID) REFERENCES menu_items(Menu_Item_ID);

-- reviews → orders
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_order
FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID);

-- check primary key in table
SHOW KEYS FROM orders WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM menu_items WHERE Key_name = 'PRIMARY';

-- without where clause
SHOW KEYS FROM orders;
show keys from menu_items;
-- Adding / confirming primary keys in each table
ALTER TABLE orders
ADD PRIMARY KEY (Order_ID);
	
ALTER TABLE menu_items
ADD PRIMARY KEY (Menu_Item_ID);

ALTER TABLE customers
ADD PRIMARY KEY (Customer_ID);

ALTER TABLE orders
ADD PRIMARY KEY (Order_ID);

ALTER TABLE order_details
ADD PRIMARY KEY (Order_Detail_ID);

ALTER TABLE reviews
ADD PRIMARY KEY (Review_ID);


-- Running foreign keys constraints again
ALTER TABLE order_details
ADD CONSTRAINT fk_orderdetails_order
FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID);

ALTER TABLE order_details
ADD CONSTRAINT fk_orderdetails_menuitem
FOREIGN KEY (Menu_Item_ID) REFERENCES menu_items(Menu_Item_ID);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID);

-- checking again if all PK and fk exists
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME IS NOT NULL
AND TABLE_SCHEMA = 'food_junction';
