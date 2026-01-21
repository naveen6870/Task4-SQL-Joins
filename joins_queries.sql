-- INNER JOIN: Customer + Invoice
SELECT c.first_name, c.last_name, i.invoice_id, i.invoice_date, i.total
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id;

-- INNER JOIN: Invoice + Invoice Line
SELECT i.invoice_id, il.track_id, il.unit_price, il.quantity
FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id;

-- Full transaction join
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       i.invoice_id,
       t.name AS track_name,
       il.unit_price,
       il.quantity
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id;

-- LEFT JOIN: Customers with no purchases
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
WHERE i.invoice_id IS NULL;

-- Revenue by artist
SELECT ar.name AS artist_name,
       SUM(il.unit_price * il.quantity) AS total_revenue
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY ar.name
ORDER BY total_revenue DESC;

-- Revenue by genre
SELECT g.name AS genre,
       SUM(il.unit_price * il.quantity) AS total_revenue
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY g.name
ORDER BY total_revenue DESC;

-- Customer lifetime value
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       SUM(i.total) AS lifetime_value
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY customer_name
ORDER BY lifetime_value DESC;
