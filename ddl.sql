CREATE DATABASE sdp;
USE sdp;

CREATE TABLE member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(128) NOT NULL,
    member_email VARCHAR(128) NOT NULL,
    member_password VARCHAR(255) NOT NULL,
    member_phone VARCHAR(24) NOT NULL,
    member_address VARCHAR(255) NOT NULL,
	member_country VARCHAR(2) NOT NULL,
    member_credit_card VARCHAR(16),
	member_reward_points INT NOT NULL DEFAULT 0,
    member_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (member_email)
) ENGINE=InnoDB;

CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(128) NOT NULL,
    staff_email VARCHAR(128) NOT NULL,
    staff_password VARCHAR(255) NOT NULL,
    staff_phone VARCHAR(24) NOT NULL,
    staff_address VARCHAR(255) NOT NULL,
    staff_role TINYINT NOT NULL DEFAULT 0,
    staff_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (staff_email)
) ENGINE=InnoDB;

CREATE TABLE genre (
	genre_id INT PRIMARY KEY AUTO_INCREMENT,
	genre_name VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(255) NOT NULL,
    book_author VARCHAR(255),
	book_publisher VARCHAR(255),
	genre_id INT NOT NULL,
	book_description TEXT NOT NULL,
    book_stock INT NOT NULL,
    book_price DECIMAL(10,2) NOT NULL,
    book_years SMALLINT NOT NULL,
	CONSTRAINT fk_genre_book FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
) ENGINE=InnoDB;

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    feedback_scale TINYINT NOT NULL,
    feedback_comment VARCHAR(255) NOT NULL,
    feedback_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    CONSTRAINT fk_feedback_member FOREIGN KEY (member_id) REFERENCES member(member_id),
    CONSTRAINT fk_feedback_book FOREIGN KEY (book_id) REFERENCES book(book_id),
	UNIQUE (member_id, book_id)
) ENGINE=InnoDB;

CREATE TABLE feedback_rating (
    rating_scale TINYINT NOT NULL,
    rating_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    feedback_id INT NOT NULL,
    member_id INT NOT NULL,
    CONSTRAINT fk_rating_feedback FOREIGN KEY (feedback_id) REFERENCES feedback(feedback_id),
    CONSTRAINT fk_rating_member FOREIGN KEY (member_id) REFERENCES member(member_id),
	UNIQUE (feedback_id, member_id)
) ENGINE=InnoDB;

CREATE TABLE `order` (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_recipient_name VARCHAR(255) NOT NULL,
    order_recipient_phone VARCHAR(24) NOT NULL,
    order_recipient_address VARCHAR(255) NOT NULL,
    order_payment_method VARCHAR(255) NOT NULL,
    order_transaction_id VARCHAR(24) NOT NULL,
    order_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	order_status VARCHAR(24) NOT NULL,
    member_id INT NOT NULL,
    CONSTRAINT fk_order_member FOREIGN KEY (member_id) REFERENCES member(member_id)
) ENGINE=InnoDB;

CREATE TABLE order_detail (
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    order_detail_quantity INT NOT NULL,
    CONSTRAINT fk_order_detail_order FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    CONSTRAINT fk_order_detail_book FOREIGN KEY (book_id) REFERENCES book(book_id)
) ENGINE=InnoDB;

CREATE TABLE request (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    request_quantity INT NOT NULL,
    staff_id INT NOT NULL,
    request_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_request_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT fk_request_book FOREIGN KEY (book_id) REFERENCES book(book_id)
) ENGINE=InnoDB;