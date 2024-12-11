WITH orders AS (
  SELECT
    id,
    customer,
    ordered_at,
    store_id,
    subtotal,
    tax_paid,
    order_total
  FROM {{ source('jaffle_shop', 'orders') }}
), formula_1 AS (
  SELECT
    *,
    id AS order_id,
    store_id AS location_id,
    customer AS customer_id2,
    (
      order_total / 100.0
    ) AS order_total,
    (
      tax_paid / 100.0
    ) AS tax_paid,
    DATE_TRUNC('DAY', ordered_at) AS ordered_at
  FROM orders
)
SELECT
  *
FROM formula_1