WITH

stg_email_activity AS (
    SELECT * FROM {{ ref('stg_email_activity') }}
),

stg_customer_profiles AS (
    SELECT * FROM {{ ref('stg_customer_profiles') }}
),

/*
Join the country and allow_email_tracking columns
Filter out any rows where allow_email_tracking is false
*/
joined_email_activity AS (
    SELECT
        ea.*,
        cp.country,
        cp.allow_email_tracking
    FROM stg_email_activity ea
    LEFT JOIN stg_customer_profiles cp
        ON ea.email = cp.email
    WHERE cp.allow_email_tracking = TRUE
),

/*
I have assumed that region = country as this is the given column in the dataset.
I have provided both the total number of opens and the number of unique email addresses that have opened emails for each country,
this allows flexibility in the analysis by just using a different column.
*/
email_opens_by_region AS (
    SELECT
        country,
        COUNT(CASE WHEN event = 'open' THEN 1 END) AS opens,
        COUNT(DISTINCT CASE WHEN event = 'open' THEN email END) AS unique_opens,
        COUNT(CASE WHEN event = 'delivered' THEN 1 END) AS delivered,
        COUNT(CASE WHEN event = 'bounced' THEN 1 END) AS bounced,
        ROUND(COUNT(CASE WHEN event = 'open' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN event = 'delivered' THEN 1 END), 0), 2) AS open_rate_pct
        ROUND(COUNT(DISTINCT CASE WHEN event = 'open' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN event = 'delivered' THEN 1 END), 0), 2) AS dist_open_rate_pct,
        ROUND(COUNT(DISTINCT CASE WHEN event = 'open' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN event = 'delivered' THEN 1 END), 0), 2) AS dist_open_rate_pct2

    FROM joined_email_activity
    GROUP BY country
)

SELECT * FROM email_opens_by_region
