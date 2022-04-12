
DROP DATABASE IF EXISTS mtm;

CREATE DATABASE mtm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mtm;

DROP TABLE IF EXISTS cities;

CREATE TABLE cities(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250),
    `name_ar` VARCHAR(250)
) ENGINE = INNODB;


DROP TABLE IF EXISTS brands;

CREATE TABLE brands(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250),
    `name_ar` VARCHAR(250),
    `img` TEXT,
    `created_at` datetime DEFAULT now(),
    `deleted_at` datetime
) ENGINE = INNODB;

DROP TABLE IF EXISTS consultunts;



DROP TABLE IF EXISTS users;

CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250) NOT NULL,
    `email` VARCHAR(250) UNIQUE,
    `img` VARCHAR(300) DEFAULT "assets/members/default.png",
    `password` VARCHAR(250),
    city_id INT,
    CONSTRAINT fk_user_city FOREIGN KEY(city_id) REFERENCES cities(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    `phone` VARCHAR(250) UNIQUE NOT NULL,
    `admin` BOOLEAN DEFAULT FALSE,
    `created_at` datetime DEFAULT now(),
    `deleted_at` datetime
) ENGINE = INNODB;





DROP TABLE IF EXISTS centers;

CREATE TABLE centers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250) NOT NULL,
    `location` VARCHAR(250) NOT NULL,
    `location_map` VARCHAR(250) NOT NULL,
    `working_hours` VARCHAR(250) NOT NULL,
    brand_id INT NOT NULL,
    CONSTRAINT fk_center_brand FOREIGN KEY(brand_id) REFERENCES brands(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    `logo` VARCHAR(250) NOT NULL,
    `created_at` datetime DEFAULT now(),
    `deleted_at` datetime
) ENGINE = INNODB;



DROP TABLE IF EXISTS parts;

CREATE TABLE parts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250) NOT NULL,
    `name_ar` VARCHAR(250) NOT NULL,
    brand_id INT,
    CONSTRAINT fk_part_brand FOREIGN KEY(brand_id) REFERENCES brands(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    `image` VARCHAR(250),
    `created_at` datetime DEFAULT now(),
    `deleted_at` datetime
) ENGINE = INNODB;


DROP TABLE IF EXISTS cars;

CREATE TABLE cars(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `model` SMALLINT,
    `img` VARCHAR(300) DEFAULT "assets/members/default-car.png",
    `mileage` INT,
    user_id INT,
    CONSTRAINT fk_car_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    brand_id INT,
    CONSTRAINT fk_car_brand FOREIGN KEY(brand_id) REFERENCES brands(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    `created_at` datetime DEFAULT now(),
    `deleted_at` datetime
) ENGINE = INNODB;

DROP TABLE IF EXISTS services;

CREATE TABLE services(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250),
    `name_ar` VARCHAR(250),
    `icon` VARCHAR(250),
    `deleted_at` datetime
) ENGINE = INNODB;

DROP TABLE IF EXISTS videos;

CREATE TABLE videos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250),
    `url` VARCHAR(300),
    `image` VARCHAR(250)
) ENGINE = INNODB;

DROP TABLE IF EXISTS msgs;

CREATE TABLE msgs(
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_id INT,
    CONSTRAINT fk_msg_from FOREIGN KEY(from_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    to_id INT,
    CONSTRAINT fk_msg_to FOREIGN KEY(to_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    `breif` TEXT,
    seen datetime
) ENGINE = INNODB;

DROP TABLE IF EXISTS articles;

CREATE TABLE articles(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    CONSTRAINT fk_article_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    `title` VARCHAR(250),
    `title_ar` VARCHAR(250),
    `img` VARCHAR(250),
    `status` ENUM('pending', 'active', 'declined') DEFAULT 'pending',
    `views` int DEFAULT 0 NOT NULL,
    `created_at` datetime DEFAULT now(),
    `published_at` datetime,
    `deleted_at` datetime
) ENGINE = INNODB;

DROP TABLE IF EXISTS tickets;

CREATE TABLE tickets(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    CONSTRAINT fk_tickets_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    service_id INT,
    CONSTRAINT fk_tickets_role FOREIGN KEY(service_id) REFERENCES services(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    price FLOAT UNSIGNED,
    method ENUM('card', 'cash') DEFAULT 'cash',
    approved BOOLEAN DEFAULT 0,
    start_at datetime,
    end_at datetime
) ENGINE = INNODB;
#seeds