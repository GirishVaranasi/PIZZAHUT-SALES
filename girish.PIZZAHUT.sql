CREATE DATABASE PIZZAHUT;
USE PIZZAHUT;
select * FROM pizza_types;
-- Retrieve total no of order placed
SELECT COUNT(order_id) FROM orders;
-- calculate total sales generated from pizza sales

SELECT 
    SUM(orderdetails.quantity * pizzas.price) AS TOTAL_SALES
FROM
    orderdetails
        JOIN
    pizzas ON orderdetails.pizza_id = pizzas.pizza_id;
    
    --  Identify the highest-priced pizza.
   SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 2; 
-- Identify the most common pizza size ordered.
SELECT 
    pizzas.pizza_type_id,
    pizzas.size,
    COUNT(orderdetails.quantity) AS quantity
FROM
    pizzas
        JOIN
    orderdetails ON pizzas.pizza_id = orderdetails.pizza_id
GROUP BY pizzas.size , pizzas.pizza_type_id
ORDER BY quantity DESC limit 3;
-- list the  5 most ordered pizza types along with quantities
SELECT 
    pizza_types.name, SUM(orderdetails.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orderdetails ON pizzas.pizza_id = orderdetails.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- MEDIUM TYPE QUESTIONS
-- INTERMEDIATE TYPES OF QUESTIONS
-- JOIN THE NECESSARY TABLES TO FIND THE TOTAL QUANTITY OF EACH PIZZAS CATEGORY ORDERED
SELECT 
    pizza_types.category, SUM(orderdetails.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orderdetails ON orderdetails.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;
	
-- determine the distribution of orders by hours the day

select hour(time) as times ,count(order_id)as orders 
from orders
group by times order by orders asc ;

-- join the relavent tables to find the category wise distrubation of pizzas.

select category, count(name) from pizza_types 
group by category; 

-- group the orders by date and calculate the avg no of pizzas ordered per day

SELECT 
    AVG(qunatity)
FROM
    (SELECT 
        orders.date, SUM(orderdetails.quantity) AS qunatity
    FROM
        orders
    JOIN orderdetails ON orders.order_id = orderdetails.order_id
    GROUP BY orders.date) as tables; 

-- determine the top 3 most ordered pizzas types based on revenue.

select pizza_types.name,sum(orderdetails.quantity*pizzas.price)as revenue from pizza_types
join 
pizzas on
pizzas.pizza_type_id=pizza_types.pizza_type_id
join  
orderdetails on
orderdetails.pizza_id= pizzas.pizza_id
group by
pizza_types.name order by revenue desc limit 3;
