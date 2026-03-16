-- Monthly order volume and late delivery rate

SELECT
  FORMAT_DATE('%Y-%m', DATE(order_purchase_timestamp)) AS month,
  COUNT(order_id) AS total_orders,

  SUM(
    CASE
      WHEN order_delivered_customer_date > order_estimated_delivery_date
      THEN 1 ELSE 0
    END
  ) AS late_orders,

  SAFE_DIVIDE(
    SUM(
      CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date
        THEN 1 ELSE 0
      END
    ),
    COUNT(order_id)
  ) AS late_delivery_rate

FROM `olist-analysis-490016.olist.orders`

WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL

GROUP BY month
ORDER BY month;

-- Monthly revenue trend

SELECT
  FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS month,
  SUM(oi.price) AS revenue

FROM `olist-analysis-490016.olist.orders` o

JOIN `olist-analysis-490016.olist.order_items` oi
ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY month
ORDER BY month;

-- Categories with the longest average delivery time

SELECT
  p.product_category_name,

  AVG(
    DATE_DIFF(
      DATE(o.order_delivered_customer_date),
      DATE(o.order_purchase_timestamp),
      DAY
    )
  ) AS avg_delivery_days

FROM `olist-analysis-490016.olist.orders` o

JOIN `olist-analysis-490016.olist.order_items` oi
ON o.order_id = oi.order_id

JOIN `olist-analysis-490016.olist.products` p
ON oi.product_id = p.product_id

WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL

GROUP BY p.product_category_name

ORDER BY avg_delivery_days DESC

LIMIT 5;

-- Average freight cost by customer state

SELECT
  c.customer_state,
  AVG(oi.freight_value) AS avg_freight

FROM `olist-analysis-490016.olist.orders` o

JOIN `olist-analysis-490016.olist.order_items` oi
ON o.order_id = oi.order_id

JOIN `olist-analysis-490016.olist.customers` c
ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered'

GROUP BY c.customer_state

ORDER BY avg_freight DESC;

-- Top sellers by total revenue

SELECT
  s.seller_id,
  SUM(oi.price) AS revenue

FROM `olist-analysis-490016.olist.order_items` oi

JOIN `olist-analysis-490016.olist.sellers` s
ON oi.seller_id = s.seller_id

GROUP BY s.seller_id

ORDER BY revenue DESC

LIMIT 10;

-- Average delivery time across all orders

SELECT
  AVG(
    DATE_DIFF(
      DATE(order_delivered_customer_date),
      DATE(order_purchase_timestamp),
      DAY
    )
  ) AS avg_delivery_days

FROM `olist-analysis-490016.olist.orders`

WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL;
