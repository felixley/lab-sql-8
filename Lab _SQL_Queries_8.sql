
-- Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
select title, length, dense_rank() over(order by length desc) as 'Rank'
from sakila.film;


-- Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select rating, title, length, dense_rank() over(partition by rating order by length desc) as 'Rank'
from sakila.film;

-- How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query
select a.name,  count(a.category_id) as 'Number'
from sakila.category as a
inner join sakila.film_category as b
on a.category_id = b.category_id
inner join sakila.film as c
on b.film_id = c.film_id
group by a.name
order by Number desc;


-- Which actor has appeared in the most films?
select a.first_name, a.last_name, a.actor_id, count(b.film_id) as Number
from sakila.actor as a
join sakila.film_actor as b
on a.actor_id = b.actor_id
group by a.actor_id, a.first_name, a.last_name
order by Number desc
limit 1;

-- Most active customer (the customer that has rented the most number of films)
select a.customer_id, a.first_name, a.last_name, count(b.rental_id) Rentals
from sakila.customer as a
join sakila.rental as b
on a.customer_id = b.customer_id
group by a.last_name, a.first_name, a.customer_id
order by Rentals desc
limit 1;
