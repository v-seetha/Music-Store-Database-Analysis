
-- Top Selling Artists by Revenue
-- This query identifies the highest-grossing artists in the database
SELECT 
	TOP 10
    a.artist_id,
    a.name AS artist_name,
    COUNT(DISTINCT i.invoice_id) AS number_of_invoices,
    COUNT(il.track_id) AS tracks_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM dbo.artist a
JOIN dbo.album al ON a.artist_id = al.artist_id
JOIN dbo.track t ON t.album_id = al.album_id
JOIN dbo.invoice_line il ON il.track_id = t.track_id
JOIN dbo.invoice i ON i.invoice_id = il.invoice_id
GROUP BY a.artist_id, a.name
ORDER BY total_revenue DESC;

-- Sales Trends Over Time
-- This query analyzes sales patterns over time by grouping by month and year
SELECT 
    DATEPART(YEAR, i.invoice_date) AS year,
    DATEPART(MONTH, i.invoice_date) AS month,
    COUNT(DISTINCT i.invoice_id) AS invoice_count,
    COUNT(il.invoice_line_id) AS items_sold,
    ROUND(SUM(i.total), 2) AS total_revenue
FROM dbo.invoice i
JOIN dbo.invoice_line il ON i.invoice_id = il.invoice_id
GROUP BY DATEPART(YEAR, i.invoice_date), DATEPART(MONTH, i.invoice_date)
ORDER BY year, month;

--Customer Spending Analysis
-- This query analyzes spending patterns by customers
SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    c.country,
    COUNT(DISTINCT i.invoice_id) AS purchase_count,
    ROUND(SUM(i.total), 2) AS total_spent,
    ROUND(AVG(i.total), 2) AS avg_invoice_value,
    MAX(i.invoice_date) AS last_purchase_date
FROM dbo.customer c
JOIN dbo.invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC;

-- Geographic Sales Distribution
-- This query analyzes sales by country
SELECT 
    i.billing_country AS country,
    COUNT(DISTINCT i.invoice_id) AS invoice_count,
    COUNT(DISTINCT i.customer_id) AS customer_count,
    ROUND(SUM(i.total), 2) AS total_revenue,
    ROUND(SUM(i.total) / COUNT(DISTINCT i.customer_id), 2) AS revenue_per_customer
FROM dbo.invoice i
GROUP BY i.billing_country
ORDER BY total_revenue DESC;

-- Employee Sales Performance
-- This query evaluates the performance of sales support representatives
SELECT 
    e.employee_id,
    e.first_name + ' ' + e.last_name AS employee_name,
    e.title,
    COUNT(DISTINCT c.customer_id) AS customers_supported,
    COUNT(DISTINCT i.invoice_id) AS invoices_generated,
    ROUND(SUM(i.total), 2) AS total_revenue_generated
FROM dbo.employee e
JOIN dbo.customer c ON e.employee_id = c.support_rep_id
JOIN dbo.invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.title
ORDER BY total_revenue_generated DESC;

-- Genre Performance Analysis 
-- This query identifies the most lucrative music genres
SELECT 
    g.genre_id,
    g.name AS genre,
    COUNT(il.invoice_line_id) AS tracks_sold,
    COUNT(DISTINCT t.album_id) AS albums_represented,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue,
    ROUND(SUM(il.unit_price * il.quantity) / COUNT(il.invoice_line_id), 2) AS avg_revenue_per_track
FROM dbo.genre g
JOIN dbo.track t ON g.genre_id = t.genre_id
JOIN dbo.invoice_line il ON t.track_id = il.track_id
GROUP BY g.genre_id, g.name
ORDER BY total_revenue DESC;

-- Media Type Popularity and Revenue Analysis
-- This query analyzes which media types generate the most revenue
SELECT 
    mt.media_type_id,
    mt.name AS media_type,
    COUNT(il.invoice_line_id) AS items_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue,
    ROUND(AVG(il.unit_price), 2) AS avg_price
FROM dbo.media_type mt
JOIN dbo.track t ON mt.media_type_id = t.media_type_id
JOIN dbo.invoice_line il ON t.track_id = il.track_id
GROUP BY mt.media_type_id, mt.name
ORDER BY total_revenue DESC;

--Track Length Analysis by Genre
-- This query analyzes track length patterns across different genres
SELECT 
    g.name AS genre,
    AVG(t.milliseconds)/1000 AS avg_length_seconds,
    MIN(t.milliseconds)/1000 AS min_length_seconds,
    MAX(t.milliseconds)/1000 AS max_length_seconds,
    COUNT(t.track_id) AS number_of_tracks
FROM dbo.track t
JOIN dbo.genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY avg_length_seconds DESC;

--  Popular Tracks Analysis
-- This query identifies the top-selling tracks
SELECT 
	TOP 20
    t.track_id,
    t.name AS track_name,
    a.name AS artist_name,
    al.title AS album_title,
    g.name AS genre,
    COUNT(il.invoice_line_id) AS times_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM dbo.track t
JOIN dbo.album al ON t.album_id = al.album_id
JOIN dbo.artist a ON al.artist_id = a.artist_id
JOIN dbo.genre g ON t.genre_id = g.genre_id
JOIN dbo.invoice_line il ON t.track_id = il.track_id
GROUP BY t.track_id, t.name, a.name, al.title, g.name
ORDER BY times_sold DESC;

-- Customer Lifetime Value (CLV) Analysis
-- This query calculates the total value and engagement metrics for each customer
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    c.country,
    MIN(i.invoice_date) AS first_purchase_date,
    MAX(i.invoice_date) AS last_purchase_date,
    DATEDIFF(day, MIN(i.invoice_date), MAX(i.invoice_date)) AS days_as_customer,
    COUNT(DISTINCT i.invoice_id) AS total_purchases,
    ROUND(COUNT(DISTINCT i.invoice_id) * 30.0 / 
        (CASE 
            WHEN DATEDIFF(day, MIN(i.invoice_date), MAX(i.invoice_date)) = 0 THEN 1 
            ELSE DATEDIFF(day, MIN(i.invoice_date), MAX(i.invoice_date))
        END), 2) AS monthly_purchase_frequency,
    ROUND(SUM(i.total), 2) AS total_spent,
    ROUND(SUM(i.total) / COUNT(DISTINCT i.invoice_id), 2) AS avg_purchase_value
FROM dbo.customer c
JOIN dbo.invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC;

-- Customer Genre Preferences
-- This query analyzes each customer's preferred music genres
SELECT
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    g.name AS genre,
    COUNT(il.invoice_line_id) AS tracks_purchased,
    ROUND(COUNT(il.invoice_line_id) * 100.0 / SUM(COUNT(il.invoice_line_id)) OVER (PARTITION BY c.customer_id), 2) AS percentage_of_purchases
FROM dbo.customer c
JOIN dbo.invoice i ON c.customer_id = i.customer_id
JOIN dbo.invoice_line il ON i.invoice_id = il.invoice_id
JOIN dbo.track t ON il.track_id = t.track_id
JOIN dbo.genre g ON t.genre_id = g.genre_id
GROUP BY c.customer_id, c.first_name, c.last_name, g.name
ORDER BY c.customer_id, tracks_purchased DESC;

-- Customer Segmentation by Purchase Behavior
-- This query segments customers based on recency, frequency, and monetary value
WITH customer_rfm AS (
    SELECT
        c.customer_id,
        c.first_name + ' ' + c.last_name AS customer_name,
        MAX(i.invoice_date) AS last_purchase_date,
        DATEDIFF(day, MAX(i.invoice_date), GETDATE()) AS recency_days,
        COUNT(DISTINCT i.invoice_id) AS frequency,
        ROUND(SUM(i.total), 2) AS monetary
    FROM dbo.customer c
    JOIN dbo.invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
    *,
    CASE 
        WHEN recency_days <= 90 AND frequency >= 10 AND monetary >= 100 THEN 'High-Value Active'
        WHEN recency_days <= 90 AND frequency >= 5 THEN 'Active'
        WHEN recency_days <= 180 THEN 'Recent'
        WHEN recency_days <= 365 THEN 'Lapsed'
        ELSE 'Inactive'
    END AS customer_segment
FROM customer_rfm
ORDER BY monetary DESC;

--Album Performance Analysis
-- This query evaluates the commercial performance of albums
SELECT
    al.album_id,
    al.title AS album_title,
    ar.name AS artist_name,
    COUNT(DISTINCT t.track_id) AS total_tracks,
    COUNT(il.invoice_line_id) AS tracks_sold,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue,
    ROUND(AVG(il.unit_price), 2) AS avg_track_price,
    ROUND(SUM(il.unit_price * il.quantity) / COUNT(DISTINCT t.track_id), 2) AS revenue_per_track
FROM dbo.album al
JOIN dbo.artist ar ON al.artist_id = ar.artist_id
JOIN dbo.track t ON t.album_id = al.album_id
JOIN dbo.invoice_line il ON il.track_id = t.track_id
GROUP BY al.album_id, al.title, ar.name
ORDER BY total_revenue DESC;

-- Playlist Popularity and Composition Analysis
-- This query analyzes the composition and popularity of playlists
SELECT
    p.playlist_id,
    p.name AS playlist_name,
    COUNT(DISTINCT pt.track_id) AS track_count,
    COUNT(DISTINCT g.genre_id) AS genre_count,
    STRING_AGG(DISTINCT g.name, ', ') AS genres_included,
    AVG(t.milliseconds)/1000/60 AS avg_track_length_minutes
FROM dbo.playlist p
JOIN dbo.playlist_track pt ON p.playlist_id = pt.playlist_id
JOIN dbo.track t ON pt.track_id = t.track_id
JOIN dbo.genre g ON t.genre_id = g.genre_id
GROUP BY p.playlist_id, p.name
ORDER BY track_count DESC;

-- Advanced Cohort Analysis by Customer Sign-up Date
-- This query analyzes customer spending patterns based on when they made their first purchase
WITH customer_first_purchase AS (
    SELECT
        customer_id,
        MIN(invoice_date) AS first_purchase_date,
        DATEPART(YEAR, MIN(invoice_date)) AS cohort_year,
        DATEPART(MONTH, MIN(invoice_date)) AS cohort_month
    FROM dbo.invoice
    GROUP BY customer_id
),
customer_monthly_activity AS (
    SELECT
        i.customer_id,
        DATEPART(YEAR, i.invoice_date) AS activity_year,
        DATEPART(MONTH, i.invoice_date) AS activity_month,
        cfp.cohort_year,
        cfp.cohort_month,
        ROUND(SUM(i.total), 2) AS monthly_spend
    FROM dbo.invoice i
    JOIN customer_first_purchase cfp ON i.customer_id = cfp.customer_id
    GROUP BY i.customer_id, DATEPART(YEAR, i.invoice_date), DATEPART(MONTH, i.invoice_date), 
             cfp.cohort_year, cfp.cohort_month
)
SELECT
    cohort_year,
    cohort_month,
    COUNT(DISTINCT customer_id) AS cohort_size,
    SUM(CASE WHEN activity_year = cohort_year AND activity_month = cohort_month THEN monthly_spend ELSE 0 END) AS month_0_revenue,
    SUM(CASE WHEN (activity_year = cohort_year AND activity_month = cohort_month + 1) OR 
                  (activity_year = cohort_year + 1 AND activity_month = 1 AND cohort_month = 12) 
             THEN monthly_spend ELSE 0 END) AS month_1_revenue,
    SUM(CASE WHEN (activity_year = cohort_year AND activity_month = cohort_month + 2) OR 
                  (activity_year = cohort_year + 1 AND activity_month = (cohort_month + 2) - 12) 
             THEN monthly_spend ELSE 0 END) AS month_2_revenue
FROM customer_monthly_activity
GROUP BY cohort_year, cohort_month
ORDER BY cohort_year, cohort_month;

-- Cross-selling Analysis - Identifying Album Pairs Often Purchased Together
-- This query finds which albums are commonly purchased together
WITH album_purchases AS (
    SELECT 
        i.invoice_id,
        t.album_id
    FROM dbo.invoice i
    JOIN dbo.invoice_line il ON i.invoice_id = il.invoice_id
    JOIN dbo.track t ON il.track_id = t.track_id
)
SELECT 
	TOP 20
    a1.title AS album_1,
    a2.title AS album_2,
    COUNT(*) AS times_purchased_together
FROM album_purchases ap1
JOIN album_purchases ap2 ON ap1.invoice_id = ap2.invoice_id AND ap1.album_id < ap2.album_id
JOIN dbo.album a1 ON ap1.album_id = a1.album_id
JOIN dbo.album a2 ON ap2.album_id = a2.album_id
GROUP BY a1.title, a2.title
ORDER BY times_purchased_together DESC;

-- Customer Purchase Pattern Over Time With Artist Preference
-- This query analyzes how customer preferences evolve over time
WITH customer_artist_purchases AS (
    SELECT
        c.customer_id,
        c.first_name + ' ' + c.last_name AS customer_name,
        DATEPART(YEAR, i.invoice_date) AS purchase_year,
        DATEPART(QUARTER, i.invoice_date) AS purchase_quarter,
        ar.artist_id,
        ar.name AS artist_name,
        COUNT(il.invoice_line_id) AS tracks_purchased,
        SUM(il.unit_price * il.quantity) AS amount_spent
    FROM dbo.customer c
    JOIN dbo.invoice i ON c.customer_id = i.customer_id
    JOIN dbo.invoice_line il ON i.invoice_id = il.invoice_id
    JOIN dbo.track t ON il.track_id = t.track_id
    JOIN dbo.album al ON t.album_id = al.album_id
    JOIN dbo.artist ar ON al.artist_id = ar.artist_id
    GROUP BY c.customer_id, c.first_name, c.last_name, 
             DATEPART(YEAR, i.invoice_date), DATEPART(QUARTER, i.invoice_date),
             ar.artist_id, ar.name
)
SELECT
    customer_id,
    customer_name,
    purchase_year,
    purchase_quarter,
    artist_name AS top_artist,
    tracks_purchased,
    amount_spent,
    ROUND(amount_spent / SUM(amount_spent) OVER (
        PARTITION BY customer_id, purchase_year, purchase_quarter
    ) * 100, 2) AS percentage_of_quarterly_spend
FROM customer_artist_purchases cap1
WHERE tracks_purchased = (
    SELECT MAX(tracks_purchased)
    FROM customer_artist_purchases cap2
    WHERE cap2.customer_id = cap1.customer_id
    AND cap2.purchase_year = cap1.purchase_year
    AND cap2.purchase_quarter = cap1.purchase_quarter
)
ORDER BY customer_id, purchase_year, purchase_quarter;

-- Price Elasticity Analysis
-- This query examines how sales volume varies with price
SELECT
    ROUND(il.unit_price, 2) AS price_point,
    COUNT(il.invoice_line_id) AS units_sold,
    COUNT(DISTINCT il.invoice_id) AS invoices,
    COUNT(DISTINCT t.track_id) AS unique_tracks,
    ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM dbo.invoice_line il
JOIN dbo.track t ON il.track_id = t.track_id
GROUP BY ROUND(il.unit_price, 2)
ORDER BY price_point;


--  Predictive Next Purchase Analysis
-- This query provides insights for recommendation systems based on purchase history
WITH customer_genre_history AS (
    SELECT
        c.customer_id,
        g.genre_id,
        g.name AS genre_name,
        COUNT(il.track_id) AS tracks_purchased,
        MAX(i.invoice_date) AS last_purchase_date
    FROM dbo.customer c
    JOIN dbo.invoice i ON c.customer_id = i.customer_id
    JOIN dbo.invoice_line il ON i.invoice_id = il.invoice_id
    JOIN dbo.track t ON il.track_id = t.track_id
    JOIN dbo.genre g ON t.genre_id = g.genre_id
    GROUP BY c.customer_id, g.genre_id, g.name
)
SELECT
    cgh1.customer_id,
    cgh1.genre_name AS favorite_genre,
    g.name AS recommended_genre,
    COUNT(DISTINCT c2.customer_id) AS similar_customers_count
FROM customer_genre_history cgh1
JOIN dbo.customer c1 ON cgh1.customer_id = c1.customer_id
JOIN dbo.customer c2 ON c1.country = c2.country AND c1.customer_id != c2.customer_id
JOIN customer_genre_history cgh2 ON c2.customer_id = cgh2.customer_id AND cgh1.genre_id = cgh2.genre_id
JOIN customer_genre_history cgh3 ON c2.customer_id = cgh3.customer_id AND cgh1.genre_id != cgh3.genre_id
JOIN dbo.genre g ON cgh3.genre_id = g.genre_id
WHERE cgh1.tracks_purchased = (
    SELECT MAX(tracks_purchased)
    FROM customer_genre_history
    WHERE customer_id = cgh1.customer_id
) AND cgh1.customer_id NOT IN (
    SELECT customer_id 
    FROM customer_genre_history
    WHERE genre_id = cgh3.genre_id
)
GROUP BY cgh1.customer_id, cgh1.genre_name, g.name
ORDER BY cgh1.customer_id, similar_customers_count DESC;
