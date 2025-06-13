WITH

email_activity AS (
    SELECT * FROM {{ source('main', 'email_activity') }}
),

/*
Standardize the email column by removing leading and trailing whitespace and converting to lowercase
Filter out any rows where email is null
*/
email_activity_cleaned AS (
    SELECT
        event_time,
        event,
        TRIM(LOWER(email)) AS email
    FROM email_activity
    WHERE email IS NOT NULL
)

SELECT * FROM email_activity_cleaned
