CREATE TABLE IF NOT EXISTS address(
	address_id SERIAL PRIMARY KEY,
	address VARCHAR(30) NOT NULL,
	address2 VARCHAR(30),
	city VARCHAR(15) NOT NULL,
	state VARCHAR(15) NOT NULL,
	zip_code INTEGER NOT NULL,
	country VARCHAR(20), 
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---
CREATE TABLE IF NOT EXISTS movie(
	movie_id SERIAL PRIMARY KEY,
	title VARCHAR(30) NOT NULL,
	release_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE movie
ADD COLUMN theater_id INTEGER NOT NULL;

ALTER TABLE movie
ADD CONSTRAINT fk_movie_theater
FOREIGN KEY (theater_id) REFERENCES theater(theater_id);

---


CREATE TABLE IF NOT EXISTS theater(
	theater_id SERIAL PRIMARY KEY,
	address_id INTEGER NOT NULL,
	FOREIGN KEY(address_id) REFERENCES address(address_id),
	manager_name VARCHAR(30),
	movie_id INTEGER NOT NULL, 
	FOREIGN KEY(movie_id) REFERENCES movie(movie_id)
);


ALTER TABLE theater 
ADD COLUMN ticket_id INTEGER NOT NULL;

ALTER TABLE theater
ADD CONSTRAINT fk_theater_ticket
FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id);

---


CREATE TABLE IF NOT EXISTS customer(
	customer_id SERIAL PRIMARY KEY,
	theater_id INTEGER NOT NULL, 
	FOREIGN KEY(theater_id) REFERENCES theater(theater_id),
	first_name VARCHAR(30) NOT NULL, 
	last_name VARCHAR(30) NOT NULL, 
	phone_number VARCHAR(20) NOT NULL,
	address_id INTEGER NOT NULL,
	FOREIGN KEY(address_id) REFERENCES address(address_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	registered_online BOOL
);


ALTER TABLE customer
ADD COLUMN ticket_id INTEGER NOT NULL;

ALTER TABLE customer
ADD CONSTRAINT fk_customer_ticket
FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id);

---

CREATE TABLE IF NOT EXISTS online_user(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(15) NOT NULL UNIQUE,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	email VARCHAR(30) NOT NULL UNIQUE,
	pw_hash VARCHAR NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	loyalty_club BOOL
);

---

CREATE TABLE IF NOT EXISTS ticket(
	ticket_id SERIAL PRIMARY KEY,
	seat_number VARCHAR(5),
	user_id INTEGER NOT NULL,
	FOREIGN KEY(user_id) REFERENCES online_user(user_id),
	movie_id INTEGER NOT NULL,
	FOREIGN KEY(movie_id) REFERENCES movie(movie_id),
	purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	theater_id INTEGER NOT NULL,
	FOREIGN KEY(theater_id) REFERENCES theater(theater_id),
	description VARCHAR(250),
	valid_until TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




