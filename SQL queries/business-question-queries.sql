
-- Customer Satisfaction. Calculating average Ratings out of 5
select * from reviews; 
select AVG(Rating) from reviews
Where Rating is NOT null;

-- finding ratings versus customer repitition 
SELECT 
    c.Customer_ID,
    AVG(r.Rating) AS avg_rating,
    COUNT(DISTINCT o.Order_ID) AS total_orders
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN reviews r ON o.Order_ID = r.Order_ID
GROUP BY c.Customer_ID
ORDER BY total_orders desc; 
--  Generally we can say more orders, higher ratings but it is not the case all the time.
-- because many times, customers with fewer orders giving higher ratings than customers with lower ratings


-- Employee Distribution
-- how many employees in each branch
select Branch_ID, Count(Employee_ID) as No_of_employees from employees
group by Branch_ID;
-- Proportional distribution of employees per branch

-- operational issues -- Orders COMPLETION
-- checking if all orders completed
Select * from orders where status NOT LIKE 'Completed'; -- Not all order completed

-- how many were cancelled from each branch
Select Branch_ID, Count(Order_ID) as Cancel_Refunded
from orders where Status NOT LIKE 'Completed'
group by Branch_ID; -- roughly the same

-- Max orders from each branch
select Branch_ID, count(Status) as comp_orders
from orders
where status like 'Completed'
group by Branch_ID, Status
;

-- Opertational issues affectings orders
-- Find low-margin menu items
SELECT 
    Item_Name, Selling_Price_PKR, Cost_PKR,
    (Selling_Price_PKR - Cost_PKR) AS unit_profit,
    ROUND((Selling_Price_PKR - Cost_PKR) / Selling_Price_PKR * 100, 2) AS margin_pct
FROM menu_items
ORDER BY margin_pct ASC
LIMIT 10; -- so mutton karahi gives out least profit

-- checking if all orders completed
Select * from orders where status NOT LIKE 'Completed'; -- Not all order completed

-- how many were cancelled from each branch
Select Branch_ID, Count(Order_ID) as Cancel_Refunded
from orders where Status NOT LIKE 'Completed'
group by Branch_ID
order by Cancel_Refunded DESC; -- branches 6, 8 and 4 have least no. of cancelled orders


SELECT 
    b.Branch_Name,
    SUM(pv.total_profit) AS branch_profit,
    (SELECT SUM(Salary_PKR) FROM employees e WHERE e.Branch_ID = b.Branch_ID) AS branch_salaries
FROM profit_view pv
JOIN branches b ON pv.Branch_ID = b.Branch_ID
GROUP BY b.Branch_ID
ORDER BY (branch_profit - branch_salaries) ASC; -- Staffing is proportionate in each branch

-- least ordered menu item
SELECT mi.Item_Name, COUNT(od.Order_Detail_ID) AS times_ordered
FROM menu_items mi
LEFT JOIN order_details od ON mi.Menu_Item_ID = od.Menu_Item_ID
GROUP BY mi.Menu_Item_ID
ORDER BY times_ordered ASC
LIMIT 10;


-- customer purchasing behavior
-- finding repeating customers
SELECT COUNT(Customer_ID) AS occurrs
FROM orders
group by  Customer_ID
having COUNT(*) >1;
select * from orders;
SELECT 
    Customer_ID, 
    COUNT(Order_ID) AS total_orders
FROM orders
GROUP BY Customer_ID
HAVING total_orders > 1
ORDER BY total_orders DESC;

-- selective Most repeating customers descending order
SELECT 
    c.Customer_ID, c.First_Name, c.Last_Name,
    COUNT(o.Order_ID) AS total_orders,
    MIN(o.Order_DateTime) AS first_order,
    MAX(o.Order_DateTime) AS last_order
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID
having total_orders > 9  
ORDER BY total_orders DESC;

-- most revenue generating customers
SELECT 
    c.Customer_ID, c.First_Name,
    SUM(od.Quantity * mi.Selling_Price_PKR) AS total_spent,
    ROUND(AVG(od.Quantity * mi.Selling_Price_PKR), 2) AS avg_per_order
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
JOIN order_details od ON o.Order_ID = od.Order_ID
JOIN menu_items mi ON od.Menu_Item_ID = mi.Menu_Item_ID
GROUP BY c.Customer_ID
having avg_per_order > 4000
ORDER BY avg_per_order DESC;

-- Most ordered item
SELECT 
    c.Customer_ID, mi.Category, COUNT(*) AS times_ordered
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
JOIN order_details od ON o.Order_ID = od.Order_ID
JOIN menu_items mi ON od.Menu_Item_ID = mi.Menu_Item_ID
GROUP BY c.Customer_ID, mi.Category
having times_ordered > 8
ORDER BY c.Customer_ID, times_ordered DESC;

-- busy hours, most orders Timing
SELECT 
    HOUR(Order_DateTime) AS order_hour, -- hour() is built-in
    COUNT(*) AS order_count
FROM orders
GROUP BY order_hour
having order_count > 2000
ORDER BY order_count DESC;

-- busy Days of week
SELECT 
    dayname(Order_DateTime) AS order_day,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_day
ORDER BY order_count DESC;