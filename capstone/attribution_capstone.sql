SELECT DISTINCT utm_campaign AS campaign 
FROM page_visits
ORDER BY 1;

SELECT DISTINCT utm_source AS source
FROM page_visits
ORDER BY 1;

SELECT DISTINCT utm_campaign AS campaign, 
                utm_source AS source 
FROM page_visits
ORDER BY 1;

SELECT DISTINCT page_name 
FROM page_visits
ORDER BY 1;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS source,
       ft_attr.utm_campaign AS campaign,
       COUNT(*) AS first_touch
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;


WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS source,
       lt_attr.utm_campaign AS campaign,
       COUNT(*) AS last_touch_count 
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT COUNT(DISTINCT(user_id)) AS visitors_who_made_purchase 
FROM page_visits 
WHERE page_name = '4 - purchase'; 

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    pv.page_name
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS source,
       lt_attr.utm_campaign AS campaign,
       COUNT(*) AS last_touch_as_purchase_count
FROM lt_attr
WHERE page_name = '4 - purchase'
GROUP BY 1, 2
ORDER BY 3 DESC;         

