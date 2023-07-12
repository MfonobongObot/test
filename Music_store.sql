
---Who is the senior most employee based on job title?
SELECT TOP 1*
FROM dbo.employee
ORDER BY levels desc;

---Which countries have the most Invoices?
SELECT COUNT (*),billing_country
FROM dbo.invoice
GROUP BY billing_country
ORDER BY billing_country desc;

---What are top 3 values of total invoice?
SELECT DISTINCT top 3 total as Total_Spending,billing_country
FROM invoice
ORDER BY total desc;

---What is the total sales amount per track
SELECT  track.name as Track_Name, Album.title as Album_Name, sum(invoice_line.quantity * invoice_line.unit_price) as Total_Sales
FROM invoice_line
JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY track.name,Album.title
ORDER BY Total_Sales DESC;

---Which city has the best customers? We would like to throw a promotional Music 
---Festival in the city we made the most money. Write a query that returns one city that
---has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT TOP 1 SUM(total) as Total_spending,billing_city
FROM invoice
GROUP BY billing_city;

---Who is the best customer? The customer who has spent the most money will be
---declared the best customer. Write a query that returns the person who has spent the
---most money

SELECT TOP 1 customer.customer_id, customer.first_name, customer.last_name, invoice.total as Total_Spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
ORDER BY total desc

---write a query to return the top 10 customers and their country
---customers who spend the most money be considered among the 10 ten customers 
SELECT TOP 10 customer.customer_id, customer.first_name, customer.last_name, customer.country ,invoice.total
from customer
JOIN invoice ON invoice.customer_id = customer.customer_id
ORDER BY total DESC

---Write query to return the email, first name, last name, & Genre of all Rock Music
---listeners. Return your list ordered alphabetically by email starting with A

SELECT  DISTINCT customer.first_name,customer.last_name,customer.email, genre.name as name
FROM customer
JOIN Invoice ON invoice.customer_id = customer.customer_id
JOIN Invoice_line ON invoice.invoice_id = invoice_line.invoice_id 
JOIN track ON track.track_id = invoice_line.invoice_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name like 'Rock'
ORDER BY email;

---Let's invite the artists who have written the most rock music in our dataset. Write a
---query that returns the Artist name and total track count of the top 10 rock band
SELECT TOP 10 artist.artist_id, artist.name, genre.name, COUNT(track.track_id) as Number_of_Rock_Songs
FROM artist
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id,artist.name,genre.name
ORDER BY Number_of_Rock_Songs DESC;

---Return all the track names that have a song length longer than the average song length. 
---Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. 

SELECT name,milliseconds
FROM track
WHERE milliseconds > (select AVG(milliseconds) as Average_Song_Lenght
                      FROM track)
ORDER BY milliseconds

