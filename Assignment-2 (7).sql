/*********************************************

**File: Assignment2.sql

**Desc: Assignment 2

**Author:

**Date:

*********************************************/


################################################## QUESTION 1 #################################################

#a) Show list of databases
SHOW DATABASES;


#b) Select sakila database
CREATE DATABASE IF NOT EXISTS sakila;

USE sakila;


#c) Show all tables in the sakila database.
SHOW TABLES;


#d) Show each of the columns along with their data types for the actor table
DESCRIBE actor;


#e) Show the total number of records in the actor table
SELECT 
	COUNT(*) AS Total_No_Of_Records 
FROM 
	actor;


#f)what is the first name and last name of all the actors in the actor table?
SELECT
	first_name,
    last_name
FROM
	actor;
	

#g) Insert your first name and middle initial (in the last column) in to the actors table.
INSERT INTO `actor`
		(`actor_id`,`first_name`,`last_name`,`last_update`)
VALUES
	('201','JaiSai','Manikanta','2019-08-26 11:17:56');
    
## just for checking purpose whether my name inserted or not ##
SELECT * FROM actor
WHERE
	actor_id=201;



#h) Update your middle initial with your last name in the actor table
UPDATE actor
SET
	last_name='Visarapu'
WHERE
	last_name='Manikanta';
    
## just for checking puprose whether my name is updated or not ##
SELECT * FROM actor
WHERE
	actor_id=201;
    


#i)Delete the record from the actor table where the first name matches your first name
DELETE FROM actor
WHERE
	first_name='JaiSai';

## checking whether the record was deleted or not ##
SELECT * FROM actor;
SELECT COUNT(*) FROM actor;    ## count of records again 200 so the record deleted from actor table successfully##



#j) Create a table payment_type with the following specifications
# Table Name : “Payment_type”
# Primary Key: "payment_type_id”
# Column: “Type” 

CREATE TABLE `Payment_type` (
		`payment_type_id` INT(11) NOT NULL,
        `Type` VARCHAR(50) NOT NULL,
        PRIMARY KEY (`payment_type_id`));
        
INSERT INTO `Payment_type`
		(`payment_type_id`,`Type`)
VALUES
	('1','Credit Card'),
    ('2','Cash'),
    ('3','Paypal'),
    ('4','Cheque');
	
## checking whether the values are inserted or not ##
SELECT * FROM Payment_type;



#k) Rename table payment_type to payment_types
RENAME TABLE Payment_type TO Payment_types;

## checking whether table name is changed or not ##
SHOW TABLES;



#l) Drop the table payment_types
DROP TABLE Payment_types;

## checking ##
SHOW TABLES;



##################################################### QUESTION 2 #################################################

#a) List all the movies (title & description) that are rated PG-13
SELECT
	title,
    description
FROM
	film
WHERE
	rating='PG-13';
    

#b) List all the movies that are either PG OR PG-13 using IN operator
SELECT * FROM film
WHERE
	rating IN ('PG','PG-13');
    
    
#c) Report all payments greater than and equal to 2$ and less than equal to 7$
## CONDITIONAL OPERATOR ##
SELECT
	payment_id,
    amount
FROM
	payment
WHERE
	amount>=2 AND
    amount<=7;

## BETWEEN KEYWORD ##
SELECT
	payment_id,
    amount
FROM
	payment
WHERE
	amount BETWEEN 2 AND 7;
    
    

#d) List all addresses that have phone number that contain digits 589,start with 140 or end with 589
SELECT
	address,
    phone
FROM
	address
WHERE
	phone LIKE '%589%' OR  phone LIKE '140%'  OR  phone LIKE '%589';
    

    
#e) list all staff members(first name,last name,email) who have no password
SELECT
	first_name,
    last_name,
    email
FROM
	staff
WHERE
	password IS NULL;
    
    
#f) Select all films that have title names like ZOO and rental duration greater than or equal to 4
SELECT
	film_id,
    title,
    description,
    rental_duration
FROM
	film
WHERE
	title LIKE '%ZOO%' 
    AND rental_duration>=4;
    


#g) what is the cost of renting the movie ACADEMY DINOSAUR for 2 weeks?
SELECT
	film_id,
    title,
    description,
    (rental_rate * 14) AS Rental_rate_for_2weeks
FROM
	film
WHERE
	title='ACADEMY DINOSAUR' ;
    
    

#h) List all unique districts where the customers,staff,and stores are located
SELECT distinct
	district
FROM
	address
WHERE
	district IS NOT NULL;
    
    

#i) list the top 10 newest customers across all stores 
SELECT
	customer_id,
    first_name,
    last_name,
    email,
    create_date
FROM
	customer
LIMIT 10;

## based on the create_date ##
SELECT
	customer_id,
    first_name,
    last_name,
    email,
    create_date
FROM
	customer
ORDER BY create_date DESC
LIMIT 10;


################################################## QUESTION 3 #################################################

#a) Show total number of movies
SELECT 
	COUNT(film_id) AS Total_No_Of_movies
FROM
	film;
    

#b)what is the minimum payment received and max payment received across all transactions?
SELECT
	MIN(amount) AS min_payment_received,
    MAX(amount) AS max_payment_received
FROM
	payment;
    

#c) Number of customers that rented movies between Feb-2005 and May-2005(based on payment date)
SELECT
	COUNT(payment_id) AS Total_Number_Of_customers
FROM
	payment
WHERE
	payment_date BETWEEN '2005-02-01' AND '2005-05-01';
    


#d) List all movies where replacement_cost is greater than 15$ or rental_duration is between 6 and 10 days
SELECT
	film_id,
    title,
    replacement_cost,
    rental_duration
FROM
	film
WHERE
	replacement_cost > 15 
    OR rental_duration BETWEEN 6 AND 10;
    
    

#e) what is the total amount spent by customers for movies in the year 2005?
SELECT
	COUNT(DISTINCT(payment_id)) AS Total_Number_of_customers,
    SUM(amount) AS Total_amount_spent
FROM
	payment
WHERE
	payment_date BETWEEN CAST('2005-01-01' AS DATE) AND CAST('2005-12-31' AS DATE);
    
    

#f) what is the average replacement cost across all movies?
SELECT
	AVG(replacement_cost) AS Avg_Replacement_Cost
FROM
	film;
    
    

#g) what is the standard deviation of rental rate across all movies?
SELECT
	STD(rental_rate) AS Standard_deviation_of_rental_rate
FROM
	film;
    
    

#h) what is the midrange of the rental duration for all movies
SELECT
	(MAX(rental_duration) + MIN(rental_duration)) / 2   AS Mid_range_of_rental_duration
FROM
	film;

    
###################################################### QUESTION 4 #################################################

#a) List all customers that live in Nepal
SELECT
	c.customer_id,
    concat(c.first_name,' ',c.last_name) AS customer_name,
    cntry.Country
FROM
	country cntry
		INNER JOIN
	city cty  ON  cty.country_id=cntry.country_id
		INNER JOIN
	address a  ON  a.city_id=cty.city_id
		INNER JOIN
	customer c  ON  c.address_id=a.address_id
WHERE
	Country='Nepal';
    

    
#b) List all actors that appears in the movie titled Academy Dinosaur
SELECT
	a.actor_id,
    concat(a.first_name,' ',a.last_name) AS actor_name,
    f.title AS  movie_title
FROM
	film f
		INNER JOIN
	film_actor fa  ON  f.film_id = fa.film_id
		INNER JOIN
	actor a  ON  a.actor_id = fa.actor_id
WHERE
	title = 'ACADEMY DINOSAUR';
	


#c) what is the revenue generated by each customer?
SELECT
	customer_id,
    SUM(amount) AS total_revenue
FROM
	payment
GROUP BY customer_id;



#d) List top 10 customers that rented the most movies.
SELECT
	c.customer_id,
    concat(c.first_name,' ',c.last_name) AS Customer_name,
    COUNT(rental_id) AS total_count_of_Rented_movies
FROM
	rental r
		INNER JOIN
	customer c ON r.customer_id=c.customer_id
GROUP BY customer_id
 ORDER BY total_count_of_Rented_movies DESC
 LIMIT 10;



#e) list the inventory available in store to rent for each of the movies
SELECT
	film_id,
    COUNT(inventory_id) AS inventory_available
FROM
	inventory
GROUP BY film_id;

## order by inventory available in store to rent for each of the movies in desc order ##
SELECT
	film_id,
    COUNT(inventory_id) AS inventory_available
FROM
	inventory
GROUP BY film_id
ORDER BY inventory_available DESC;



#f ) list the top zipcodes that have the highest rental activity
SELECT
	c.city_id,
    c.city,
    a.postal_code AS zipcode,
    SUM(amount) AS rental_activity
FROM
	city c
		INNER JOIN
	address a on c.city_id=a.city_id
		INNER JOIN
	customer cust on cust.address_id=a.address_id
		INNER JOIN
	payment p ON p.customer_id=cust.customer_id
GROUP BY postal_code
ORDER BY rental_activity DESC
LIMIT 5;
	
 
######################################################### QUESTION 5 #######################################################

#a) list actors and customers whose first name is the same as the first name of the actor with ID 8
### list of actors using sub-query##
SELECT 
    actor_id,
    concat(first_name,' ',last_name) AS list_of_actors
FROM
    actor 
WHERE
    first_name = (SELECT 
					first_name
				FROM
					actor 
				where
					actor_id=8);
                
				
## list of customers using sub-query ##    
SELECT 
    customer_id,
    concat(first_name,' ',last_name) AS list_of_customers
FROM
    customer
WHERE
    first_name = (SELECT 
					first_name
				FROM
					actor
				WHERE
					actor_id=8);
                    
                    
## list of actors and customers using join and sub-query ##
SELECT 
    a.actor_id,
    concat(a.first_name,' ',a.last_name) AS list_of_actors,
    c.customer_id,
    concat(c.first_name,' ',c.last_name) AS list_of_customers
FROM
    actor a
		INNER JOIN
	customer c on c.first_name=a.first_name
WHERE
    c.first_name = (SELECT 
					a.first_name
				FROM
					 actor a
				WHERE
					a.actor_id=8);




#b) list customers and payment amounts, with payments greater than average payment amount
SELECT
    payment_id,
    customer_id,
    amount
FROM
	payment
WHERE
	amount > (SELECT
					AVG(amount)
				FROM
					payment);
                    



#c) List customers who have rented movies atleast once
SELECT 
    customer_id,
    concat(first_name,' ',last_name) as Customer_name,
    email
FROM
    customer
WHERE
    customer_id  IN  (SELECT 
            customer_id
        FROM
            rental);
            
            

#d) Find the floor of the maximum,minimum, and average payment amount
SELECT
	floor(MAX(amount)) AS Max_payment_amount,
    floor(MIN(amount)) AS Min_payment_amount,
    floor(AVG(amount)) AS Avg_payment_amount
FROM
	payment;
								

########################################################### QUESTION 6  #######################################################

#a) create a view called actors_portfolio which contains information about actors and films(including titles and category)
CREATE VIEW actors_portfolio AS
	SELECT
		a.actor_id,
		concat(a.first_name,' ',a.last_name) AS actor_name,
		f.title AS film_title,
		c.name AS film_category,
		f.description AS film_description
	FROM
		film f
			INNER JOIN
		film_actor fa ON f.film_id=fa.film_id
			INNER JOIN
		actor a ON fa.actor_id=a.actor_id
			INNER JOIN
		film_category fc ON fc.film_id=f.film_id
			INNER JOIN
		category c ON c.category_id=fc.category_id
	GROUP BY film_title
	ORDER BY film_category;




#b) describe the structure of the view and query the view to get information on the actor ADAM GRANT
DESCRIBE  actors_portfolio;

SELECT
	*
FROM	
	actors_portfolio
WHERE
	actor_name='ADAM GRANT';
    
    

#c) insert a new movie titled Data Hero in sci-fi category starring ADAM GRANT
INSERT INTO actors_portfolio(actor_id,actor_name,film_title,film_category,film_description)
VALUES (300,'ADAM GRANT','DATA HERO','Sci_Fi','Hero is a stunt man falls from flight');
   
### it is showing an error because of the 'WITH CHECK OPTION' and it is not allowing the
#  'INSERT' option on the target table 'actors_portfolio' to insert any values 
# I tried to insert in different ways due to 'WITH CHECK OPTION' it is not allowing to 
# any values ###


########################################################### QUESTION 7 (Optional Practice Questions) ###############################################

#a) customers sorted by first name and last name in ascending order.
SELECT
	*
FROM
	customer
ORDER BY first_name ASC, last_name ASC;



#b) Group distinct addresses by district
SELECT 
	DISTINCT(address) AS Address,
    district AS District
FROM
	address
GROUP BY District
ORDER BY District;



#c) count of movies that are either G/NC-17/PG-13/PG/R grouped by rating
SELECT
	rating,
	COUNT(film_id) AS Count_Of_Movies
FROM
	film
WHERE
	rating IN ('G','NC-17','PG-13','PG','R')
GROUP BY rating
ORDER BY Count_Of_Movies DESC;
 
 

#d) Number of addresses in each district
SELECT
	district AS District,
	COUNT(DISTINCT(address)) AS Number_Of_Addresses
FROM
	address
GROUP BY District
ORDER BY Number_Of_Addresses desc;



#e) Find the movies where rental rate is greater than 1$ and order result set by descending order
SELECT
	film_id,
    title AS Movies,
    rental_rate
FROM
	film
WHERE
	rental_rate>1
ORDER BY rental_rate DESC;



#f) Top 2 movies that are rated R with the highest replacement cost
SELECT
	film_id,
    title AS Movies,
    rating,
    replacement_cost
FROM
	film
WHERE
	rating='R'
ORDER BY replacement_cost DESC
LIMIT 2;



#g) Find the most frequently occuring(mode) rental rate across products
SELECT
	rental_rate,
    COUNT(rental_rate) as Mode_Of_rental_rate
FROM
	film
GROUP BY rental_rate
ORDER BY Mode_Of_rental_Rate DESC
LIMIT 1;



#h) Find the top 2 movies with movie length greater than 50mins and which has commentaries as a special features.
SELECT
	film_id,
    title AS Movies,
    length AS Movie_length,
    special_features
FROM
	film
WHERE
	special_features LIKE '%Commentaries%'
HAVING  length > 50
ORDER BY length DESC
LIMIT 2;
	
    

#i) List the years with more than 2 movies released
SELECT
    release_year,
    COUNT(film_id) AS No_Of_Movies_Released 
FROM
	film
HAVING COUNT(release_year) > 2;


##################################################### QUESTION 8 (Optional Practice Questions ############################################

#a) Extract the street number(characters 1 through 4) from customer addressLine1
SELECT
	address_id,
	address,
    SUBSTRING(address,1,4) AS Street_Number
FROM
	address;
    


#b) Find out actors whose last name starts with character A,B,or c
SELECT
	actor_id,
    first_name,
    last_name
FROM
	actor
WHERE
	last_name LIKE 'A%'  OR  last_name LIKE 'B%'  OR  last_name LIKE 'C%';
    
    

#c) Find film titles that contains exactly 10 characters
SELECT
	film_id,
    title
FROM
	film
WHERE
	length(title)=10;
	
 

#d) Format a payment_date using the following format e.g "22/1/2016"
SELECT
	payment_date AS 'default',
    date_format(payment_date,'%d/%m/%Y') AS '%d/%m/%Y'
FROM
	payment;



#e) Find the number of days between two date values rental_date & return_date
SELECT 
    rental_date,
    return_date,
    DATEDIFF(return_date,rental_date) AS numberOfDays
FROM
    rental
ORDER BY numberOfDays DESC;

























