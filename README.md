Create a PostgreSQL database and table to store contact information. CREATE DATABASE contactdb;

\c contactdb

CREATE TABLE contacts ( id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, phone VARCHAR(15) NOT NULL, email VARCHAR(100) NOT NULL );
