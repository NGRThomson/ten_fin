WITH

customer_profiles AS (
    SELECT * FROM {{ source('main', 'customer_profiles') }}
),

/*
Standardize the email column by removing leading and trailing whitespace and converting to lowercase
Convert allow_email_tracking to a boolean value
Add data quality checks for email validation

I have assumed that allow_email_tracking is false unless explicitly set to 'yes'. 
This is mainly because laws around data privacy are complex and it is not clear what the default value should be.
*/
customer_profiles_cleaned AS (
    SELECT
        name,
        country,
        modified_at,
        TRIM(LOWER(email)) AS email,
        CASE
            WHEN allow_email_tracking = 'yes' THEN TRUE
            ELSE FALSE
        END AS allow_email_tracking,
        -- Add data quality flag for valid email format
        CASE 
            WHEN email LIKE '%@%.%' AND email NOT LIKE '%@%.@%' THEN TRUE
            ELSE FALSE
        END AS is_valid_email_format
    FROM customer_profiles
    WHERE email IS NOT NULL
)

SELECT * FROM customer_profiles_cleaned
