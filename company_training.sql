-- =============================================================
-- MYSQL PRACTICE PROJECT
-- Beginner to Advanced SQL Queries
-- =============================================================

DROP DATABASE IF EXISTS company_training;
CREATE DATABASE company_training;
USE company_training;

-- =============================================================
-- 1. CREATE TABLES
-- =============================================================

CREATE TABLE IF NOT EXISTS departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) DEFAULT 'HQ'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    position VARCHAR(100),
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE,
    manager_id INT DEFAULT NULL,
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2) DEFAULT 0.00,
    status VARCHAR(30) DEFAULT 'Planned'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS project_assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(100),
    assigned_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    hours_worked DECIMAL(4,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Present',
    FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS salary_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    change_date DATE NOT NULL,
    reason VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    is_available TINYINT(1) DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(100),
    country VARCHAR(100),
    signup_date DATE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB;

-- =============================================================
-- 2. INSERT DATA
-- =============================================================

INSERT INTO departments (id, name, location) VALUES
(1, 'Engineering', 'New York'),
(2, 'Sales', 'Chicago'),
(3, 'Marketing', 'Boston'),
(4, 'HR', 'Seattle'),
(5, 'Finance', 'Austin');

INSERT INTO employees (id, first_name, last_name, email, department_id, position, salary, hire_date, manager_id, is_active) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 1, 'Software Engineer', 95000.00, '2020-01-15', NULL, 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 1, 'Senior Developer', 110000.00, '2018-06-01', 1, 1),
(3, 'Emily', 'Johnson', 'emily.johnson@example.com', 2, 'Sales Manager', 78000.00, '2019-03-12', NULL, 1),
(4, 'Michael', 'Brown', 'michael.brown@example.com', 3, 'Marketing Specialist', 68000.00, '2021-02-10', 3, 1),
(5, 'Sarah', 'Davis', 'sarah.davis@example.com', 4, 'HR Specialist', 62000.00, '2022-04-05', NULL, 1),
(6, 'David', 'Wilson', 'david.wilson@example.com', 5, 'Accountant', 71000.00, '2017-09-20', NULL, 1),
(7, 'Anna', 'Taylor', 'anna.taylor@example.com', 1, 'QA Engineer', 76000.00, '2021-07-18', 2, 1),
(8, 'Chris', 'Anderson', 'chris.anderson@example.com', 2, 'Sales Representative', 59000.00, '2023-01-22', 3, 1),
(9, 'Laura', 'Martinez', 'laura.martinez@example.com', 3, 'Content Strategist', 64000.00, '2020-11-11', 4, 1),
(10, 'Robert', 'Lee', 'robert.lee@example.com', 1, 'DevOps Engineer', 88000.00, '2019-10-05', 2, 1);

INSERT INTO projects (id, name, start_date, end_date, budget, status) VALUES
(1, 'CRM Upgrade', '2024-01-01', '2024-06-30', 150000.00, 'Completed'),
(2, 'Mobile App', '2024-02-15', '2024-08-15', 220000.00, 'In Progress'),
(3, 'Website Redesign', '2024-03-01', '2024-07-01', 90000.00, 'Completed'),
(4, 'Data Migration', '2024-04-01', '2024-09-01', 180000.00, 'Planned'),
(5, 'AI Dashboard', '2024-05-01', '2024-10-01', 250000.00, 'In Progress'),
(6, 'Inventory System', '2024-06-01', '2024-12-01', 140000.00, 'Planned');

INSERT INTO project_assignments (id, employee_id, project_id, role, assigned_date) VALUES
(1, 1, 1, 'Lead Developer', '2024-01-01'),
(2, 2, 1, 'Architect', '2024-01-02'),
(3, 7, 2, 'QA Lead', '2024-02-15'),
(4, 10, 2, 'DevOps', '2024-02-16'),
(5, 4, 3, 'Marketing Lead', '2024-03-01'),
(6, 9, 3, 'Content Lead', '2024-03-03'),
(7, 6, 4, 'Finance Reviewer', '2024-04-01'),
(8, 3, 5, 'Product Sponsor', '2024-05-01');

INSERT INTO attendance (id, employee_id, attendance_date, hours_worked, status) VALUES
(1, 1, '2024-07-01', 8.00, 'Present'),
(2, 2, '2024-07-01', 8.50, 'Present'),
(3, 3, '2024-07-01', 7.50, 'Present'),
(4, 4, '2024-07-01', 8.00, 'Present'),
(5, 5, '2024-07-01', 6.00, 'Late'),
(6, 6, '2024-07-01', 8.00, 'Present'),
(7, 7, '2024-07-02', 8.00, 'Present'),
(8, 8, '2024-07-02', 5.00, 'Absent');

INSERT INTO salary_history (id, employee_id, salary, change_date, reason) VALUES
(1, 1, 90000.00, '2023-01-01', 'Annual Review'),
(2, 1, 95000.00, '2024-01-01', 'Promotion'),
(3, 2, 100000.00, '2023-05-01', 'Performance Bonus'),
(4, 2, 110000.00, '2024-06-01', 'Promotion'),
(5, 3, 75000.00, '2023-02-01', 'Salary Adjustment'),
(6, 4, 65000.00, '2023-03-01', 'Annual Review'),
(7, 7, 72000.00, '2023-07-01', 'Adjustment'),
(8, 10, 85000.00, '2023-09-01', 'Market Adjustment');

INSERT INTO categories (id, name) VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Clothing'),
(4, 'Books'),
(5, 'Home Goods');

INSERT INTO products (id, name, category_id, price, stock_quantity, is_available) VALUES
(1, 'Laptop', 1, 999.99, 15, 1),
(2, 'Smartphone', 1, 699.99, 25, 1),
(3, 'Office Chair', 2, 199.99, 10, 1),
(4, 'Desk', 2, 349.99, 8, 1),
(5, 'T-Shirt', 3, 19.99, 50, 1),
(6, 'Jeans', 3, 49.99, 40, 1),
(7, 'SQL Basics', 4, 29.99, 20, 1),
(8, 'Python for Data', 4, 39.99, 15, 1),
(9, 'Coffee Maker', 5, 89.99, 12, 1),
(10, 'Blender', 5, 59.99, 18, 1);

INSERT INTO customers (id, first_name, last_name, email, city, country, signup_date) VALUES
(1, 'Alice', 'Green', 'alice.green@example.com', 'New York', 'USA', '2023-01-01'),
(2, 'Bob', 'White', 'bob.white@example.com', 'London', 'UK', '2023-02-15'),
(3, 'Mina', 'Lopez', 'mina.lopez@example.com', 'Madrid', 'Spain', '2023-03-10'),
(4, 'David', 'Kim', 'david.kim@example.com', 'Seoul', 'South Korea', '2023-04-05'),
(5, 'Nora', 'Patel', 'nora.patel@example.com', 'Mumbai', 'India', '2023-05-20'),
(6, 'Omar', 'Hassan', 'omar.hassan@example.com', 'Cairo', 'Egypt', '2023-06-12'),
(7, 'Lina', 'Chen', 'lina.chen@example.com', 'Toronto', 'Canada', '2023-07-01'),
(8, 'Sam', 'Turner', 'sam.turner@example.com', 'Sydney', 'Australia', '2023-08-08');

INSERT INTO orders (id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2024-01-10', 1299.98, 'Completed'),
(2, 2, '2024-01-12', 199.99, 'Completed'),
(3, 3, '2024-01-18', 349.99, 'Pending'),
(4, 4, '2024-02-01', 699.99, 'Completed'),
(5, 5, '2024-02-05', 89.99, 'Completed'),
(6, 6, '2024-02-12', 39.99, 'Pending'),
(7, 7, '2024-02-20', 1099.98, 'Completed'),
(8, 8, '2024-03-02', 59.99, 'Completed'),
(9, 1, '2024-03-05', 449.97, 'Pending'),
(10, 3, '2024-03-10', 999.99, 'Completed');

INSERT INTO order_items (id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 999.99),
(2, 1, 2, 1, 699.99),
(3, 2, 3, 1, 199.99),
(4, 3, 4, 1, 349.99),
(5, 4, 2, 1, 699.99),
(6, 5, 9, 1, 89.99),
(7, 6, 8, 1, 39.99),
(8, 7, 1, 1, 999.99),
(9, 7, 5, 1, 19.99),
(10, 8, 10, 1, 59.99),
(11, 9, 6, 3, 49.99),
(12, 9, 7, 1, 29.99),
(13, 10, 1, 1, 999.99),
(14, 10, 3, 1, 199.99),
(15, 10, 5, 2, 19.99);

INSERT INTO payments (id, order_id, payment_date, amount, payment_method) VALUES
(1, 1, '2024-01-10', 1299.98, 'Credit Card'),
(2, 2, '2024-01-12', 199.99, 'PayPal'),
(3, 4, '2024-02-01', 699.99, 'Credit Card'),
(4, 5, '2024-02-05', 89.99, 'Debit Card'),
(5, 7, '2024-02-20', 1099.98, 'Bank Transfer'),
(6, 8, '2024-03-02', 59.99, 'PayPal'),
(7, 10, '2024-03-10', 999.99, 'Credit Card'),
(8, 3, '2024-03-11', 349.99, 'Cash');

-- =============================================================
-- 3. BEGINNER PRACTICE QUERIES
-- =============================================================

-- 1. Select all employees
SELECT * FROM employees;

-- 2. Select only names and salaries
SELECT first_name, last_name, salary FROM employees;

-- 3. Filter employees by salary
SELECT first_name, last_name, salary FROM employees WHERE salary > 70000;

-- 4. Filter by department id
SELECT first_name, last_name FROM employees WHERE department_id = 1;

-- 5. Use ORDER BY ascending
SELECT first_name, last_name, salary FROM employees ORDER BY salary ASC;

-- 6. Use ORDER BY descending
SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC;

-- 7. Limit results
SELECT first_name, last_name FROM employees ORDER BY salary DESC LIMIT 5;

-- 8. Select distinct departments
SELECT DISTINCT department_id FROM employees;

-- 9. Search with LIKE
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'J%';

-- 10. Search with wildcard suffix
SELECT first_name, last_name FROM employees WHERE last_name LIKE '%son';

-- 11. Use IN operator
SELECT first_name, last_name FROM employees WHERE department_id IN (1, 2, 3);

-- 12. Use BETWEEN operator
SELECT first_name, last_name, salary FROM employees WHERE salary BETWEEN 60000 AND 80000;

-- 13. Check for NULL values
SELECT first_name, last_name, manager_id FROM employees WHERE manager_id IS NULL;

-- 14. Check for non-null values
SELECT first_name, last_name, manager_id FROM employees WHERE manager_id IS NOT NULL;

-- 15. Combine conditions with AND
SELECT first_name, last_name, salary FROM employees WHERE department_id = 1 AND salary > 80000;

-- 16. Combine conditions with OR
SELECT first_name, last_name, salary FROM employees WHERE department_id = 2 OR department_id = 3;

-- 17. Use aliases
SELECT first_name AS fn, last_name AS ln, salary AS monthly_salary FROM employees;

-- 18. Use concatenation
SELECT CONCAT(first_name, ' ', last_name) AS full_name, position FROM employees;

-- 19. Use mathematical expressions
SELECT first_name, salary, salary * 12 AS annual_salary FROM employees;

-- 20. Use ROUND function
SELECT first_name, ROUND(salary / 12, 2) AS monthly_average FROM employees;

-- 21. Sort by multiple columns
SELECT first_name, last_name, department_id, salary FROM employees ORDER BY department_id, salary DESC;

-- 22. Filter using NOT
SELECT first_name, last_name FROM employees WHERE NOT department_id = 4;

-- 23. Retrieve employees hired after 2020
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date > '2020-01-01';

-- 24. Retrieve active employees
SELECT first_name, last_name FROM employees WHERE is_active = 1;

-- 25. Retrieve inactive employees
SELECT first_name, last_name FROM employees WHERE is_active = 0;

-- 26. Get salary summary by department
SELECT department_id, COUNT(*) AS total_employees, AVG(salary) AS avg_salary FROM employees GROUP BY department_id;

-- 27. Count total employees
SELECT COUNT(*) AS total_employees FROM employees;

-- 28. Sum salaries
SELECT SUM(salary) AS total_salary FROM employees;

-- 29. Find highest salary
SELECT MAX(salary) AS highest_salary FROM employees;

-- 30. Find lowest salary
SELECT MIN(salary) AS lowest_salary FROM employees;

-- 31. Average salary
SELECT AVG(salary) AS average_salary FROM employees;

-- 32. Group by department and count
SELECT department_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id;

-- 33. Group by department with average salary
SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary FROM employees GROUP BY department_id;

-- 34. Use HAVING to filter groups
SELECT department_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id HAVING COUNT(*) >= 2;

-- 35. Use HAVING with average salary
SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) > 70000;

-- 36. Find names that start with A or J
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'A%' OR first_name LIKE 'J%';

-- 37. Find names with exactly 4 letters
SELECT first_name FROM employees WHERE first_name LIKE '____';

-- 38. Use CASE for salary banding
SELECT first_name, last_name, salary,
       CASE
           WHEN salary >= 90000 THEN 'High'
           WHEN salary >= 70000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_band
FROM employees;

-- 39. Use CASE for active status
SELECT first_name, last_name,
       CASE is_active
           WHEN 1 THEN 'Active'
           ELSE 'Inactive'
       END AS employee_status
FROM employees;

-- 40. Show employees without email
SELECT first_name, last_name FROM employees WHERE email IS NULL;

-- =============================================================
-- 4. INTERMEDIATE PRACTICE QUERIES
-- =============================================================

-- 41. Inner join employees and departments
SELECT e.first_name, e.last_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- 42. Left join employees and departments
SELECT e.first_name, e.last_name, d.name AS department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- 43. Right join example
SELECT e.first_name, e.last_name, d.name AS department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- 44. Join employees to their managers
SELECT e.first_name AS employee_name, m.first_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- 45. Join employees with projects
SELECT e.first_name, e.last_name, p.name AS project_name, pa.role
FROM employees e
JOIN project_assignments pa ON e.id = pa.employee_id
JOIN projects p ON pa.project_id = p.id;

-- 46. Aggregate employees by department name
SELECT d.name AS department_name, COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.name;

-- 47. Find total budget by project status
SELECT status, SUM(budget) AS total_budget
FROM projects
GROUP BY status;

-- 48. Find average project budget
SELECT AVG(budget) AS average_project_budget FROM projects;

-- 49. Filter employees with salary above average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 50. Find employees in Engineering using subquery
SELECT first_name, last_name
FROM employees
WHERE department_id = (SELECT id FROM departments WHERE name = 'Engineering');

-- 51. Find employees who work on project CRM Upgrade
SELECT e.first_name, e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM project_assignments pa
    JOIN projects p ON pa.project_id = p.id
    WHERE pa.employee_id = e.id AND p.name = 'CRM Upgrade'
);

-- 52. Find employees not assigned to any project
SELECT e.first_name, e.last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM project_assignments pa WHERE pa.employee_id = e.id
);

-- 53. Get employees with salary above 80000 and department Engineering
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 80000 AND department_id = (
    SELECT id FROM departments WHERE name = 'Engineering'
);

-- 54. Correlated subquery example
SELECT first_name, last_name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);

-- 55. Use UNION
SELECT first_name AS person_name FROM employees
UNION
SELECT name FROM departments;

-- 56. Use UNION ALL
SELECT first_name AS person_name FROM employees
UNION ALL
SELECT name FROM departments;

-- 57. Join orders with customers
SELECT c.first_name, c.last_name, o.id AS order_id, o.total_amount, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.id;

-- 58. Join orders with order items and products
SELECT o.id AS order_id, p.name AS product_name, oi.quantity, oi.unit_price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

-- 59. Find revenue per product
SELECT p.name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.name;

-- 60. Find top spending customers
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 61. Find orders without payment
SELECT o.id, o.order_date, o.total_amount
FROM orders o
LEFT JOIN payments p ON o.id = p.order_id
WHERE p.id IS NULL;

-- 62. Find payment methods used
SELECT payment_method, COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method;

-- 63. Use CASE with order status
SELECT id, status,
       CASE status
           WHEN 'Completed' THEN 'Closed'
           WHEN 'Pending' THEN 'Open'
           ELSE 'Other'
       END AS order_stage
FROM orders;

-- 64. Use multiple joins with customers, orders, payments
SELECT c.first_name, c.last_name, o.id AS order_id, p.amount, p.payment_method
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN payments p ON o.id = p.order_id;

-- 65. Find average attendance hours
SELECT employee_id, AVG(hours_worked) AS avg_hours
FROM attendance
GROUP BY employee_id;

-- 66. Find late attendance count
SELECT employee_id, COUNT(*) AS late_days
FROM attendance
WHERE status = 'Late'
GROUP BY employee_id;

-- 67. Find salary change history per employee
SELECT e.first_name, e.last_name, sh.salary, sh.change_date, sh.reason
FROM salary_history sh
JOIN employees e ON sh.employee_id = e.id;

-- 68. Create a view for employee summary
CREATE VIEW employee_summary AS
SELECT e.id, e.first_name, e.last_name, d.name AS department_name, e.salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- 69. Query the view
SELECT * FROM employee_summary;

-- 70. Create a view for sales summary
CREATE VIEW sales_summary AS
SELECT c.first_name, c.last_name, o.id AS order_id, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;

-- 71. Query the sales view
SELECT * FROM sales_summary;

-- =============================================================
-- 5. ADVANCED PRACTICE QUERIES
-- =============================================================

-- 72. Common Table Expression example
WITH high_salary_employees AS (
    SELECT id, first_name, last_name, salary
    FROM employees
    WHERE salary > 80000
)
SELECT * FROM high_salary_employees ORDER BY salary DESC;

-- 73. CTE with department totals
WITH dept_totals AS (
    SELECT department_id, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
)
SELECT d.name AS department_name, dt.total_salary
FROM dept_totals dt
JOIN departments d ON dt.department_id = d.id;

-- 74. Recursive CTE example
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 10
)
SELECT * FROM seq;

-- 75. Ranking employees by salary
SELECT first_name, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 76. Dense ranking
SELECT first_name, last_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_dense_rank
FROM employees;

-- 77. Row number example
SELECT first_name, last_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- 78. LEAD and LAG example
SELECT first_name, last_name, salary,
       LAG(salary, 1, 0) OVER (ORDER BY salary) AS previous_salary,
       LEAD(salary, 1, 0) OVER (ORDER BY salary) AS next_salary
FROM employees;

-- 79. Running total of employee salaries
SELECT first_name, last_name, salary,
       SUM(salary) OVER (ORDER BY salary) AS running_total
FROM employees;

-- 80. Running total by department
SELECT e.first_name, e.last_name, e.department_id, e.salary,
       SUM(e.salary) OVER (PARTITION BY e.department_id ORDER BY e.salary) AS dept_running_total
FROM employees e;

-- 81. Window function for average salary
SELECT first_name, last_name, salary,
       AVG(salary) OVER () AS overall_avg_salary
FROM employees;

-- 82. Find employees above department average
SELECT first_name, last_name, department_id, salary
FROM (
    SELECT e.first_name, e.last_name, e.department_id, e.salary,
           AVG(e.salary) OVER (PARTITION BY e.department_id) AS dept_avg
    FROM employees e
) x
WHERE salary > dept_avg;

-- 83. Find top 3 highest salary employees
SELECT first_name, last_name, salary
FROM (
    SELECT first_name, last_name, salary,
           RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk <= 3;

-- 84. Find highest paid employee in each department
SELECT first_name, last_name, department_id, salary
FROM (
    SELECT e.first_name, e.last_name, e.department_id, e.salary,
           RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
    FROM employees e
) ranked
WHERE rnk = 1;

-- 85. Use EXPLAIN for performance check
EXPLAIN SELECT * FROM employees WHERE department_id = 1;

-- 86. Add index example
CREATE INDEX idx_employees_department_id ON employees(department_id);

-- 87. Use index after creation
EXPLAIN SELECT * FROM employees WHERE department_id = 1;

-- 88. Transaction example
START TRANSACTION;
UPDATE employees SET salary = salary + 5000 WHERE id = 1;
SELECT salary FROM employees WHERE id = 1;
ROLLBACK;

-- 89. Transaction with commit
START TRANSACTION;
UPDATE employees SET salary = salary + 3000 WHERE id = 2;
COMMIT;

-- 90. Show latest salary after commit
SELECT first_name, last_name, salary FROM employees WHERE id = 2;

-- 91. Find total sales per month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- 92. Find customers with more than one order
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 93. Show order totals with payment status
SELECT o.id, o.total_amount,
       CASE
           WHEN EXISTS (SELECT 1 FROM payments p WHERE p.order_id = o.id) THEN 'Paid'
           ELSE 'Unpaid'
       END AS payment_status
FROM orders o;

-- 94. Find products with low stock
SELECT id, name, stock_quantity FROM products WHERE stock_quantity < 20;

-- 95. Find out-of-stock products
SELECT id, name FROM products WHERE stock_quantity = 0;

-- 96. Find product categories with inventory value
SELECT c.name AS category_name, SUM(p.price * p.stock_quantity) AS inventory_value
FROM categories c
JOIN products p ON c.id = p.category_id
GROUP BY c.name;

-- 97. Find all completed orders
SELECT * FROM orders WHERE status = 'Completed';

-- 98. Find pending orders
SELECT * FROM orders WHERE status = 'Pending';

-- 99. Compare order amount with payment amount
SELECT o.id, o.total_amount, p.amount, (o.total_amount - p.amount) AS difference
FROM orders o
JOIN payments p ON o.id = p.order_id;

-- 100. Find top 3 products by revenue
SELECT p.name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 3;

-- 101. Find orders by city
SELECT c.city, COUNT(o.id) AS order_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.city;

-- 102. Find customers from USA
SELECT first_name, last_name, city, country FROM customers WHERE country = 'USA';

-- 103. Find products in electronics category
SELECT p.name, c.name AS category_name
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE c.name = 'Electronics';

-- 104. Show department names alongside employee counts
SELECT d.name AS department_name, COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.name;

-- 105. Show all employees and their current projects
SELECT e.first_name, e.last_name, p.name AS project_name
FROM employees e
LEFT JOIN project_assignments pa ON e.id = pa.employee_id
LEFT JOIN projects p ON pa.project_id = p.id;

-- 106. Show employees with no manager
SELECT first_name, last_name FROM employees WHERE manager_id IS NULL;

-- 107. Show employees with managers
SELECT e.first_name, e.last_name, m.first_name AS manager_first_name
FROM employees e
JOIN employees m ON e.manager_id = m.id;

-- 108. Find salaries greater than 100000
SELECT first_name, last_name, salary FROM employees WHERE salary > 100000;

-- 109. Find salary changes for John Doe
SELECT e.first_name, e.last_name, sh.salary, sh.change_date, sh.reason
FROM salary_history sh
JOIN employees e ON sh.employee_id = e.id
WHERE e.first_name = 'John';

-- 110. Use DISTINCT with country values
SELECT DISTINCT country FROM customers;

-- 111. Use DISTINCT with payment methods
SELECT DISTINCT payment_method FROM payments;

-- 112. Use LIMIT with offset
SELECT first_name, last_name FROM employees ORDER BY salary DESC LIMIT 3 OFFSET 2;

-- 113. Use NOT IN
SELECT first_name, last_name FROM employees WHERE department_id NOT IN (4, 5);

-- 114. Use LIKE for middle pattern
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%a%';

-- 115. Use BETWEEN dates
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date BETWEEN '2020-01-01' AND '2022-12-31';

-- 116. Use DATE_FORMAT for hire month
SELECT first_name, last_name, DATE_FORMAT(hire_date, '%M %Y') AS hire_month_year FROM employees;

-- 117. Use YEAR function
SELECT first_name, last_name, YEAR(hire_date) AS hire_year FROM employees;

-- 118. Get month name from order dates
SELECT id, DATE_FORMAT(order_date, '%M') AS month_name FROM orders;

-- 119. Find recent orders
SELECT * FROM orders WHERE order_date >= '2024-02-01';

-- 120. Find oldest employees by hire date
SELECT first_name, last_name, hire_date FROM employees ORDER BY hire_date ASC LIMIT 5;

-- 121. Find newest employees by hire date
SELECT first_name, last_name, hire_date FROM employees ORDER BY hire_date DESC LIMIT 5;

-- 122. Use subquery in SELECT
SELECT first_name, last_name, salary,
       (SELECT MAX(salary) FROM employees) AS max_salary
FROM employees;

-- 123. Use subquery in FROM (derived table)
SELECT dept_name, avg_salary
FROM (
    SELECT d.name AS dept_name, AVG(e.salary) AS avg_salary
    FROM departments d
    JOIN employees e ON d.id = e.department_id
    GROUP BY d.name
) AS dept_stats;

-- 124. Use subquery in WHERE with IN
SELECT first_name, last_name
FROM employees
WHERE id IN (SELECT employee_id FROM project_assignments);

-- 125. Use subquery in WHERE with NOT IN
SELECT first_name, last_name
FROM employees
WHERE id NOT IN (SELECT employee_id FROM project_assignments);

-- 126. Return top 3 departments by employee count
SELECT d.name, COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.name
ORDER BY employee_count DESC
LIMIT 3;

-- 127. Add a new sample record
INSERT INTO employees (first_name, last_name, email, department_id, position, salary, hire_date, manager_id) VALUES
('Megan', 'Brooks', 'megan.brooks@example.com', 2, 'Account Executive', 74000.00, '2024-01-20', 3);

-- 128. Update a salary
UPDATE employees SET salary = 77000.00 WHERE id = 11;

-- 129. Delete a test record if present
DELETE FROM employees WHERE email = 'megan.brooks@example.com' AND id = 11;

-- 130. Final select to verify data
SELECT id, first_name, last_name, salary FROM employees ORDER BY id; 

-- =============================================================
-- 6. PRACTICE PROBLEMS
-- =============================================================

-- Practice 1: Find the highest-paid employee in each department.
SELECT department_id, first_name, last_name, salary
FROM (
    SELECT e.department_id, e.first_name, e.last_name, e.salary,
           RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rnk
    FROM employees e
) ranked
WHERE rnk = 1;

-- Practice 2: Find total revenue by customer.
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_revenue DESC;

-- Practice 3: Find employees who are assigned to a project but have no attendance record.
SELECT e.first_name, e.last_name
FROM employees e
JOIN project_assignments pa ON e.id = pa.employee_id
LEFT JOIN attendance a ON e.id = a.employee_id
WHERE a.id IS NULL;

-- Practice 4: Find departments with no employees.
SELECT d.name
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
WHERE e.id IS NULL;

-- Practice 5: Find products sold in more than one order.
SELECT p.name, COUNT(DISTINCT oi.order_id) AS order_count
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.name
HAVING COUNT(DISTINCT oi.order_id) > 1;

-- Practice 6: Find average salary by position.
SELECT position, AVG(salary) AS avg_salary
FROM employees
GROUP BY position;

-- Practice 7: List customers who paid by Credit Card.
SELECT c.first_name, c.last_name, p.payment_method
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN payments p ON o.id = p.order_id
WHERE p.payment_method = 'Credit Card';

-- Practice 8: List employees with above-average attendance hours.
SELECT e.first_name, e.last_name, AVG(a.hours_worked) AS avg_hours
FROM employees e
JOIN attendance a ON e.id = a.employee_id
GROUP BY e.id, e.first_name, e.last_name
HAVING AVG(a.hours_worked) > 7.5;

-- Practice 9: Show the total of all completed orders.
SELECT SUM(total_amount) AS completed_order_total
FROM orders
WHERE status = 'Completed';

-- Practice 10: Show employee names and department names using a view.
SELECT * FROM employee_summary;

