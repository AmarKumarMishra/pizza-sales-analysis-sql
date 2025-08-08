create database pizzahut;
-- ✅ Create Database
CREATE DATABASE pizzahut;
USE pizzahut;

-- ✅ Create Orders Table
CREATE TABLE orders (
  order_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_time TIME NOT NULL,
  PRIMARY KEY(order_id)
);

-- ✅ Create Order Details Table
CREATE TABLE order_details (
  order_details_id INT NOT NULL,
  order_id INT NOT NULL,
  pizza_id TEXT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY(order_details_id)
);

-- ✅ Show all tables in database
SHOW TABLES;

-- ✅ Sample Query to check database selected properly
SELECT * FROM orders;

-- ✅ Most Popular Pizza Size
SELECT `pizzas[1]`.size,
       COUNT(order_details.order_details_id) AS order_count
FROM `pizzas[1]`
JOIN order_details ON `pizzas[1]`.pizza_id = order_details.pizza_id
GROUP BY `pizzas[1]`.size
ORDER BY order_count DESC;

-- ✅ Total Quantity Sold for Each Pizza Type
SELECT `pizza_types[1]`.name,
       SUM(order_details.quantity) AS quantity
FROM `pizza_types[1]`
JOIN `pizzas[1]` ON `pizza_types[1]`.pizza_type_id = `pizzas[1]`.pizza_type_id
JOIN order_details ON order_details.pizza_id = `pizzas[1]`.pizza_id
GROUP BY `pizza_types[1]`.name
ORDER BY quantity DESC;

-- ✅ Total Number of Orders
SELECT COUNT(*) AS total_orders FROM orders;

-- ✅ Total Revenue Generated
SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM order_details
JOIN `pizzas[1]` AS pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- ✅ Top 5 Most Ordered Pizza Types
SELECT `pizza_types[1]`.name, SUM(order_details.quantity) AS total_ordered
FROM order_details
JOIN `pizzas[1]` ON order_details.pizza_id = `pizzas[1]`.pizza_id
JOIN `pizza_types[1]` ON `pizzas[1]`.pizza_type_id = `pizza_types[1]`.pizza_type_id
GROUP BY `pizza_types[1]`.name
ORDER BY total_ordered DESC
LIMIT 5;

-- ✅ Total Pizzas Ordered per Pizza Type
SELECT `pizza_types[1]`.name,
       SUM(order_details.quantity) AS quantity
FROM `pizza_types[1]`
JOIN `pizzas[1]` ON `pizza_types[1]`.pizza_type_id = `pizzas[1]`.pizza_type_id
JOIN order_details ON order_details.pizza_id = `pizzas[1]`.pizza_id
GROUP BY `pizza_types[1]`.name
ORDER BY quantity DESC;

-- ✅ Average Pizza Price by Category
SELECT `pizza_types[1]`.category,
       ROUND(AVG(`pizzas[1]`.price), 2) AS avg_price
FROM `pizza_types[1]`
JOIN `pizzas[1]` ON `pizza_types[1]`.pizza_type_id = `pizzas[1]`.pizza_type_id
GROUP BY `pizza_types[1]`.category;

-- ✅ Daily Order Distribution
SELECT DATE(order_date) AS date, COUNT(*) AS total_orders
FROM orders
GROUP BY DATE(order_date)
ORDER BY date;

-- ✅ Busiest Order Days (Top 5)
SELECT DATE(order_date) AS date,
       COUNT(*) AS total_orders
FROM orders
GROUP BY DATE(order_date)
ORDER BY total_orders DESC
LIMIT 5;

-- ✅ Hourly Order Distribution
SELECT HOUR(order_time) AS hour,
       COUNT(*) AS total_orders
FROM orders
GROUP BY hour
ORDER BY hour;

-- ✅ Top 3 Pizza Categories by Revenue
SELECT `pizza_types[1]`.category,
       ROUND(SUM(order_details.quantity * `pizzas[1]`.price), 2) AS revenue
FROM order_details
JOIN `pizzas[1]` ON order_details.pizza_id = `pizzas[1]`.pizza_id
JOIN `pizza_types[1]` ON `pizzas[1]`.pizza_type_id = `pizza_types[1]`.pizza_type_id
GROUP BY `pizza_types[1]`.category
ORDER BY revenue DESC
LIMIT 3;
