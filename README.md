### Airbnb Database System

This project was built to fulfill a use case to provide a database system for Airbnb, add some data to it, and then be able to interact with the data based on different business cases.

### Setting up the environment

#### Creating the database

Run the `/create_db.sql` file first. Then connect to the database in your database management system application or with the CLI.

This will also create the `airbnb` schema, which will then be used to accomodate all the tables, and data.

#### Create the tables

Run the `/create_tables.sql` to create the tables. These will then be added to the `airbnb` schema. 

#### Insert the data

Run the `/add_data.sql` file to insert data to all the tables. 

### Interacting with the database/use cases

#### Getting all listings

```sql
SELECT FROM "Listing";
```

#### Getting all bookings

```sql
SELECT FROM "Booking";
```

#### Getting all reviews

```sql
SELECT FROM "Review";
```

#### Getting all customer support tickets

```sql
SELECT FROM "SupportTicket";
```
### Notes

Using `OFFSET` when inserting data to tables with relations to other tables was necessary due to the fact that UUIDs are being used in the `INSERT` statements, so it would not be possible to guess the UUID values, as that is also going against the principle of UUIDs not being predicatble.
