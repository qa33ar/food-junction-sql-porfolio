# Food Junction SQL Portfolio Project

## Project Overview
This project demonstrates an end-to-end SQL data analysis workflow using a fictional Pakistani restaurant chain, Food Junction.
Raw data consists of csv files which are uploaded in MySQL to perform explorations, cleaning, preparing and finding key-points to improve business performance. Main focus was to use express SQL utility.

## Business Scenario
Food Junction wants insights into operations during 2024–2025, including branch performance, customer behavior, menu performance, employee distribution, and customer satisfaction.

## Dataset
- branches
- employees
- customers
- menu_items
- orders
- order_details
- reviews
  
## Database Schema
![EER Diagram](Images/eer-diagram.png)

## Skills Demonstrated
- Database Design (EER)
- Data Cleaning
- Data Quality Assessment
- Exploratory Data Analysis
- SQL Joins
- Views
- Aggregate Functions
- Business Analysis

## Data Quality Checks
- Primary key uniqueness
- Foreign key integrity
- Duplicate detection
- Date range validation
- Numeric range validation

## Business Questions
- Business performance
- Top branches
- Profitable menu items
- Customer purchasing behaviour
- Employee distribution
- Customer satisfaction
- Operational issues

## Key findings / Conclusions
-Based on the SQL analysis, the business maintained an estimated profit margin of approximately 90% during both 2024  and 2025. While overall performance appears strong, several opportunities for improvement were identified.

-Order patterns show that demand varies significantly by day and hour. Management may consider aligning staffing levels with peak and off-peak periods to optimize labor costs without affecting service quality.

-Several menu items received relatively few orders. Their performance should be reviewed to determine whether they should be promoted, revised, or removed from the menu.

-Customer ratings suggest that repeat customers generally provide positive feedback, although this relationship is not consistent across all customers. Encouraging more customers to leave reviews, for example through a loyalty or rewards program, could provide more reliable customer satisfaction data.

-Approximately 5% of orders were cancelled or refunded. Investigating the underlying causes, particularly in branches with higher cancellation rates, may help improve operational efficiency and customer satisfaction.


## Technologies
- MySQL
- MySQL Workbench
- SQL

## Repository Structure
```
Dataset/
SQL/
Documentation/
Images/
README.md
```

## Author
Qammar Dean
