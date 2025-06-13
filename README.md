# Data Modelling for Ten Fin

Ten Fin is a new startup that operates in London. They write news stories about the latest happenings in the 
UK startup scene.

They have approached you for help. They need the skills of an Analytics Engineer to help prepare
their raw data for visualisation in Power BI. They email news stories to their customers whenever a story breaks.

This repo contains a duckdb file containing Ten Fin's raw data. There are two tables in the default schema called `main`.

The first table is `customer_profiles` which contains information about Ten Fin's userbase. A user can opt in or out of email tracking. Email tracking is when
their user activity is recorded for the purposes of product analytics.

The other table is `email_activity` which
holds all email event information whenever an email (containing a news story) is sent to a user.
An email is `bounced` if the user's email server rejected the email, `delivered` if the email was successfully sent to the user's inbox and `opened` if the user 
has opened the email.

## Setting up the environment

Using Python >= 3.9, create a virtual environment by installing the requirements in `requirements.txt`

The data is stored in a duckdb binary under the data folder. **There is no username or password required to access the database within the file.**
Duckdb is an embedded database that is similar to SQlite in that it runs in an in-memory process. No servers are required. You only need to load in the file using the Python SDK or establish a connection
via a database viewer (such as [DBeaver](https://duckdb.org/docs/guides/sql_editors/dbeaver.html) or [VScode](https://marketplace.visualstudio.com/items?itemName=Evidence.sqltools-duckdb-driver))


## Task
This assignment should take between 1-2 hours. Think carefully about your approach but do not go beyond
the scope of this task.

The Chief Editor at Ten Fin would like to understand which user region opens the greatest number of emails.
Your job is to prepare the data transformations so that a **single** table model is produced under `marts` that has all the necessary
columns & data to perform this analysis. You are not required to perform this analysis only to prepare the data.

The `requirements.txt` file contains the specific packages that you need to complete this assignment. *Do not install any other Python packages as they aren't necessary.* You are free to install
dbt packages but please note that they are not required to complete this task.

Your instructions are as follows
* In the `main` schema (do not create another schema)

    - Create two `staging` tables for each raw table (customer profiles and email activity) where you perform any necessary
transformations

    - Create one `mart` table where you use the `staging` table(s) to produce a mart that could be used to address the question at hand
* Add appropriate documentation and comments for the `staging` and `marts` models
* Make sure that your transformed tables are saved to the `ten_fin_db.duckdb` file and that it is checked into git
* Update **this README file** with step-by-step instructions as to how someone can recreate the models in dbt using your code. Be very specific in your instructions and make sure that your solution is reproducible.
* Create a *private* repo in Github and commit your work to that repo. Share access with the following user accounts: https://github.com/oneillre and https://github.com/solla-9fin

Note:
* Make sure to use appropriate best practices and base dbt functionality (no need to install additional packages)
* Use your best judgement and make sure that you can justify your design decisions

## Running the models

Detail your instructions here.
