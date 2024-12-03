# MUSIC-STORE DATABASE ANALYSIS #

create database music_store;
use music_store;

#1. Who is the senior most employee based on job title?

select * 
from employee
order by levels desc
limit 1;

#2. Which countries have the most Invoices?

select count(*) as Number_of_Invoice, billing_country 
from invoice
group by billing_country
order by Number_of_Invoice desc;

#3. What are top 3 values of total invoice?

select total 
from invoice
order by total desc
limit 3;

#4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
# Write a query that returns one city that has the highest sum of invoice totals. Return both the city name and sum of all invoice totals. 

select round(sum(total), 2) as invoice_total, billing_city 
from invoice
group by billing_city
order by invoice_total desc;

#5. Who is the best customer? The customer who has spent the most money will be declared the best customer.
# Write a query that returns the person who has spent the most money.

select c.customer_id, c.first_name, c.last_name, round(sum(i.total), 2) as total_amount
from customer c
join invoice i
on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_amount desc
limit 1;

#6. Write query to return the email, first name, last name and genre of all rock music listeners.
# Return your list ordered alphabetically by email starting with A

select distinct email, first_name, last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in ( 
	select track_id 
	from track
	join genre
	on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
order by email;

#7. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album2 on album2.album_id = track.album_id
join artist on artist.artist_id = album2.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id, artist.name
order by number_of_songs desc
limit 10;

#8. Return all the track names that have a song length longer than the average song length. Return the Name and Miliseconds for each track. Order by the song length with the longest songs listed first.

select name, milliseconds
from track
where milliseconds >
(
	select avg(milliseconds) as avg_track_length
	from track
)
order by milliseconds desc;

#9. Find how much amount spent by each customer on artists? 
# Write a query to return customer name, artist name and total spent.

with best_selling_artist as (
	select artist.artist_id as artist_id, artist.name as artist_name,
		sum(invoice_line.unit_price * invoice_line.quantity) as total_sales
    from invoice_line
    join track on track.track_id = invoice_line.track_id
    join album2 on album2.album_id = track.album_id
    join artist on artist.artist_id = album2.artist_id
    group by artist_id, artist_name
    order by total_sales
)
select c.customer_id, c.first_name, c.last_name, bsa.artist_name, 
	round(sum(il.unit_price * il.quantity), 2) as amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album2 alb on alb.album_id = t.album_id
join best_selling_artist bsa on bsa.artist_id = alb.artist_id
group by c.customer_id, c.first_name, c.last_name, bsa.artist_name
order by amount_spent desc;

#10. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases.
# Write a query that returns each country along with the top genre. For countries where the maximum number of purchases is shared return all genres.

with popular_genre as (
	select count(invoice_line.quantity) as purchases, customer.country, genre.name, genre.genre_id,
    row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo
    from invoice_line
    join invoice on invoice.invoice_id = invoice_line.invoice_id
    join customer on customer.customer_id = invoice.customer_id
    join track on track.track_id = invoice_line.track_id
    join genre on genre.genre_id = track.genre_id
    group by customer.country, genre.name, genre.genre_id
    order by customer.country asc, purchases desc
)
select * from popular_genre where RowNo <= 1;

#11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared provide all customers who spent this amount. 
 
WITH recursive 
customer_with_country AS (
    SELECT customer.customer_id, customer.first_name, customer.last_name, 
           invoice.billing_country, SUM(invoice.total) AS total_spending
    FROM invoice
    JOIN customer ON invoice.customer_id = customer.customer_id
    GROUP BY customer.customer_id, customer.first_name, customer.last_name, invoice.billing_country
),
country_max_spending AS (
    SELECT billing_country, MAX(total_spending) AS max_spending
    FROM customer_with_country
    GROUP BY billing_country
)
SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customer_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY cc.billing_country;












