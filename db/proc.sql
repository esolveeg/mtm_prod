USE mtm;




DROP PROCEDURE IF EXISTS Register;

DELIMITER //
CREATE  PROCEDURE `Register`(
    IN Iname VARCHAR(250),
    IN Iemail VARCHAR(250),
    IN Iimg VARCHAR(200),
    IN Ipassword VARCHAR(250),
    IN Icity_id VARCHAR(250),
    IN Iadmin boolean,
    IN IPhone VARCHAR(250)
)
BEGIN

   INSERT INTO users (
        name,
        email,
        img,
        `password`,
        city_id,
        admin,
        phone
   )
   VALUES (
        IName,
        IEmail,
        Iimg,
        IPassword,
        Icity_id,
        Iadmin,
        IPhone
   );
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS UserRead;

DELIMITER //
CREATE  PROCEDURE `UserRead`(IN emailOrPhone VARCHAR(250))
BEGIN
    SELECT
        id,
        admin,
        name,
        IFNULL(email , ""),
        img,
        phone,
        password
    FROM users 
    wHERE (CASE WHEN emailOrPhone REGEXP '^[0-9]+$' THEN phone = emailOrPhone ELSE email = emailOrPhone END);

END//
DELIMITER ;
DROP PROCEDURE IF EXISTS UserCreate;

DELIMITER //

CREATE PROCEDURE UserCreate(
    IN Iname varchar(250),
    IN Iemail varchar(250),
    IN Ipassword varchar(250),
    IN Iphone VARCHAR(250),
    IN Iadmin BOOLEAN
) BEGIN
INSERT INTO
    users (
        name,
        email,
        password,
        phone,
        admin
    )
VALUES
    (
        Iname,
        Iemail,
        Ipassword,
        Iphone,
        Iadmin
    );

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS UserById;
DELIMITER //
CREATE PROCEDURE UserById(IN Iid int)
BEGIN
        SELECT
        u.id,
        u.name,
        IFNULL(u.email , "") email,
        u.img,
        u.phone
        FROM users u
            WHERE  u.id = Iid;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UserDelete;

DELIMITER //


CREATE PROCEDURE UserDelete(IN id INT) BEGIN
UPDATE
    users u
SET
    deleted_at = now()
WHERE
    u.id = id;

END //



DELIMITER ;

DROP PROCEDURE IF EXISTS UserList;

DELIMITER //


CREATE PROCEDURE UserList()
BEGIN
    SELECT
    id,
    name,
    email,
    img,
    phone,
    admin,
    created_at

    FROM users;
    END//
DELIMITER ;
#----------------------------------------------------------------------#
# cars



DROP PROCEDURE IF EXISTS CarsListByUser;

DELIMITER //


CREATE PROCEDURE CarsListByUser(IN Iid INT) 
BEGIN
    SELECT c.id , b.name brand_name,b.name_ar brand_name_ar,t.name type_name,t.name_ar type_name_ar , c.model ,c.no ,c.img ,c.mileage 
        FROM cars c 
        JOIN types t ON c.type_id = t.id
        JOIN brands b ON t.brand_id = b.id 
        WHERE c.deleted_at IS NULL AND c.user_id =  CASE WHEN Iid = 0 THEN c.user_id ELSE Iid END;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS CarsCreate;

DELIMITER //

CREATE PROCEDURE CarsCreate(
    IN Itype_id INT,
    IN Imodel SMALLINT,
    IN Ino varchar(10),
    IN Iimg varchar(250),
    IN Imileage INT,
    IN Iuser_id INT
) BEGIN
INSERT INTO
    cars (
        type_id,
        model,
        no,
        img,
        mileage,
        user_id
    )
VALUES
    (
        Itype_id,
        Imodel,
        Ino,
        Iimg,
        Imileage,
        Iuser_id
    );
    SELECT LAST_INSERT_ID() id;

END //
DELIMITER ;



DROP PROCEDURE IF EXISTS CarsUpdate;

DELIMITER //
CREATE PROCEDURE CarsUpdate(
    IN Iid INT,
    IN Itype_id INT,
    IN Imodel SMALLINT,
    IN Ino VARCHAR(10),
    IN Iimg VARCHAR(250),
    IN Imileage VARCHAR(250)
) BEGIN
UPDATE
    cars
SET
    type_id = Itype_id,
    model = Imodel,
    no = Ino,
    img = Iimg,
    mileage = Imileage  
    WHERE id = Iid;

    SELECT Iid id;

END //
DELIMITER ;





DROP PROCEDURE IF EXISTS CarsDelete;

DELIMITER //


CREATE PROCEDURE CarsDelete(IN id INT) BEGIN
UPDATE
    cars c
SET
    deleted_at = now()
WHERE
    c.id = id;
    SELECT id;

END //
DELIMITER ;


#----------------------------------------------------------------------#
# tickets


DROP PROCEDURE IF EXISTS TicketListByUser;

DELIMITER //


CREATE PROCEDURE TicketListByUser(IN id INT) 
BEGIN
    SELECT id , price ,approved ,start_at ,end_at FROM tickets WHERE user_id = id;
END//
DELIMITER ;



#-------------------------------------------------------------------#
# articles
DROP PROCEDURE IF EXISTS ArticleDelete;
DELIMITER //


CREATE PROCEDURE ArticleDelete(IN id INT) BEGIN
UPDATE
    articles a
SET
    deleted_at = now()
WHERE
    a.id = id;

END //
DELIMITER ;


DROP PROCEDURE IF EXISTS ArticleCreate;
DELIMITER //
CREATE PROCEDURE ArticleCreate(
    IN Iuser_id INT,
    IN Ititle VARCHAR(250),
    IN Iimg VARCHAR(250)
) BEGIN
INSERT INTO
    articles (
        user_id,
        title,
        img
    )
VALUES
    (
        Iuser_id,
        Ititle,
        Iimg
    );


    SELECT LAST_INSERT_ID() id;

END //
DELIMITER ;
DROP PROCEDURE IF EXISTS ArticleUpdate;

DELIMITER //
CREATE PROCEDURE ArticleUpdate(
    IN Iid INT,
    IN Iuser_id INT,
    IN Ititle VARCHAR(250),
    IN Iimg VARCHAR(250)
) BEGIN
UPDATE
    articles
SET
    user_id = Iuser_id,
    title = Ititle,
    img = Iimg WHERE id = Iid;

END //
DELIMITER ;

DELIMITER ;
DROP PROCEDURE IF EXISTS ArticleList;
DELIMITER //

CREATE PROCEDURE `ArticleList`()
BEGIN
    SELECT a.* , u.name u_name  FROM articles  a  JOIN users u ON u.id = a.user_id;

END //
DELIMITER ;




# videos 
#------------------------------------------------------#
DROP PROCEDURE IF EXISTS VideosList;
DELIMITER //
CREATE  PROCEDURE `VideosList`()
BEGIN
    SELECT * FROM videos;
END//
DELIMITER ;








DROP PROCEDURE IF EXISTS UserUpdate;



DELIMITER //



CREATE PROCEDURE UserUpdate(
    IN id int,
    IN IName VARCHAR(250),
    IN IEmail VARCHAR(250),
    IN Iimg VARCHAR(200),
    IN IPassword VARCHAR(250),
    IN IPhone VARCHAR(250),
    IN Icity_id INT
) BEGIN

UPDATE
    users u
SET
    u.name = Iname,
    u.email = IEmail,
    u.img =  CASE WHEN Iimg = "" THEN u.img ELSE Iimg END ,
    u.password = CASE WHEN IPassword = "" THEN u.password ELSE IPassword END,
    u.Phone = IPhone,
    u.city_id = Icity_id
WHERE
    u.id = id;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS CategoryListByType;


DELIMITER //
CREATE  PROCEDURE `CategoryListByType`(IN Itype VARCHAR(50))
BEGIN
    SELECT
       id,name,icon
     FROM categories

     WHERE type = Itype;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS ConsultuntsListAll;


DELIMITER //
CREATE  PROCEDURE `ConsultuntsListAll`()
BEGIN
    SELECT
       *
     FROM consultunts;
END//



DELIMITER ;



DROP PROCEDURE IF EXISTS ConsultuntById ;
DELIMITER //

CREATE  PROCEDURE `ConsultuntById`(IN Iid INT)
BEGIN
    SELECT
       *
     FROM consultunts WHERE id = Iid;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS ConsultuntsCreate;


DELIMITER //
CREATE  PROCEDURE `ConsultuntsCreate`(
    IN Iname VARCHAR(250),
    IN Ititle VARCHAR(250),
    IN Iskills VARCHAR(250),
    IN Iimg TEXT,
    IN Ibreif TEXT
)
BEGIN
    INSERT INTO consultunts (
        name,
        title,
        skills,
        img,
        breif
    )
    VALUES (
        Iname,
        Ititle,
        Iskills,
        Iimg,
        Ibreif
    );
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS ConsultuntsUpdate;


DELIMITER //
CREATE  PROCEDURE `ConsultuntsUpdate`(
    IN Iid INT,
    IN Iname VARCHAR(250),
    IN Ititle VARCHAR(250),
    IN Iskills VARCHAR(250),
    IN Iimg TEXT,
    IN Ibreif TEXT
)
BEGIN
    UPDATE consultunts SET
        name = Iname ,
        title = Ititle ,
        skills = Iskills ,
        img = Iimg ,
        breif = Ibreif
    WHERE id = Iid;
END//
DELIMITER ;









DROP PROCEDURE IF EXISTS ProjectsCreate;

DELIMITER //
CREATE  PROCEDURE `ProjectsCreate`(
    IN Iuser_id INT,
    IN Icategory_id INT,
    IN Icity_id INT,
    IN Ititle VARCHAR(250),
    IN Istatus VARCHAR(100),
    IN Iimg VARCHAR(250),
    IN Iimgs VARCHAR(250),
    IN Ilogo VARCHAR(250),
    IN Ifund FLOAT,
    IN Ibreif TEXT,
    IN Ilocation TEXT,
    IN Iphone VARCHAR(250),
    IN Ifile VARCHAR(250),
    IN Iemail VARCHAR(250)
)
BEGIN
INSERT INTO
    projects (
        user_id,
        category_id,
        city_id,
        title,
        status,
        img,
        imgs,
        logo,
        fund,
        breif,
        location,
        phone,
        file,
        email
    )
VALUES
    (
        Iuser_id,
        Icategory_id,
        Icity_id,
        Ititle,
        Istatus,
        Iimg,
        Iimgs,
        Ilogo,
        Ifund,
        Ibreif,
        Ilocation,
        Iphone,
        Ifile,
        Iemail
    );


    SELECT LAST_INSERT_ID() id;

END//
DELIMITER ;



DROP PROCEDURE IF EXISTS CityListAll;

DELIMITER //
CREATE  PROCEDURE `CityListAll`()
BEGIN
    SELECT id,name from cities;
END//
DELIMITER ;



DROP PROCEDURE IF EXISTS FeaturesListAll;

DELIMITER //
CREATE  PROCEDURE `FeaturesListAll`()
BEGIN
    SELECT * from features;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS ServicesListAll;

DELIMITER //
CREATE  PROCEDURE `ServicesListAll`()
BEGIN
    SELECT id,name,name_ar,icon from services;
END//
DELIMITER ;



DROP PROCEDURE IF EXISTS ServiceCreate;

DELIMITER //
CREATE  PROCEDURE `ServiceCreate`(IName VARCHAR(100) , IIcon VARCHAR(100))
BEGIN
    INSERT INTO services ( name,icon) VALUES(IName , IIcon);
    SELECT LAST_INSERT_ID();
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS ServiceUpdate;

DELIMITER //
CREATE  PROCEDURE `ServiceUpdate`(IId INT , IName VARCHAR(100) , IIcon VARCHAR(100))
BEGIN
    UPDATE  services SET name = IName ,icon = IIcon WHERE id = IId;
    SELECT 1 updated;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS ServiceDelete;

DELIMITER //
CREATE  PROCEDURE `ServiceDelete`(IId INT )
BEGIN
    DELETE FROM services WHERE id = IId;
    SELECT 1 deleted;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS TicketCreate;
DELIMITER //
CREATE  PROCEDURE `TicketCreate`(
    Iuser_id int,
    Iservice_id int,
    Iprice double,
    Iapproved boolean,
    Istart_at datetime,
    Iend_at datetime
    
    )
BEGIN
    INSERT INTO tickets (
        user_id ,
        service_id ,
        price ,
        approved ,
        start_at ,
        end_at
    )
    VALUES (
    Iuser_id,
    Iservice_id,
    Iprice,
    Iapproved,
    Istart_at,
    Iend_at
    );
    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;




# cebters
DROP PROCEDURE IF EXISTS CentersById;

DELIMITER //
CREATE  PROCEDURE `CentersById`(IN Iid INT)
BEGIN
    SELECT c.id,c.name,c.brand_id ,b.name, c.location,c.location_map,c.day_offs,c.open_time , c.close_time ,c.logo from 
    centers c JOIN brands b ON c.brand_id = b.id 
    WHERE c.deleted_at IS NULL AND c.id = Iid;
END//
DELIMITER ;
DROP PROCEDURE IF EXISTS CentersListAll;

DELIMITER //
CREATE  PROCEDURE `CentersListAll`()
BEGIN
    SELECT c.id,c.name,c.location,c.location_map,c.day_offs,c.open_time , c.close_time ,c.logo from centers c WHERE c.deleted_at IS NULL;
END//
DELIMITER ;



DROP PROCEDURE IF EXISTS CentersCreate;

DELIMITER //
CREATE  PROCEDURE `CentersCreate`(
    Iname VARCHAR(250),
    Ilocation VARCHAR(250),
    Ilocation_map VARCHAR(250),
    Iday_offs VARCHAR(10),
    Iopen_time TIME,
    Iclose_time TIME,
    Ibrand_id INT,
    Ilogo VARCHAR(250)
)
BEGIN
    INSERT INTO centers (
        name,
        location,
        location_map,
        day_offs,
        open_time,
        close_time,
        brand_id,
        logo
    ) VALUES (
        Iname,
        Ilocation,
        Ilocation_map,
        Iday_offs,
        Iopen_time,
        Iclose_time,
        Ibrand_id,
        Ilogo
    );

    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;



DROP PROCEDURE IF EXISTS CentersUpdate;

DELIMITER //
CREATE  PROCEDURE `CentersUpdate`(
    Iid INT,
    Iname VARCHAR(250),
    Ilocation VARCHAR(250),
    Ilocation_map VARCHAR(250),
    Iday_offs VARCHAR(10),
    Iopen_time TIME,
    Iclose_time TIME,
    Ibrand_id INT,
    Ilogo VARCHAR(250)
)
BEGIN
UPDATE centers 
    SET name = Iname,
        location = Ilocation,
        location_map = Ilocation_map,
        day_offs = Iday_offs,
        open_time = Iopen_time,
        close_time = Iclose_time,
        brand_id = Ibrand_id,
        logo = Ilogo
    WHERE id = Iid;

    SELECT Iid;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS CentersAttachBrand;

DELIMITER //
CREATE  PROCEDURE `CentersAttachBrand`(
    Ibrand_id INT,
    Icenter_id INT
)
BEGIN
    INSERT INTO center_brands (
        brand_id,
        center_id
    ) VALUES (
        Ibrand_id,
        Icenter_id
    );

    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS CentersDetachBrand;

DELIMITER //
CREATE  PROCEDURE `CentersDetachBrand`(Iid INT)
BEGIN
    DELETE FROM center_brands WHERE id = Iid;

    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS CentersAttachClassfication;

DELIMITER //
CREATE  PROCEDURE `CentersAttachClassfication`(
    Iclassfication_id INT,
    Icenter_id INT
)
BEGIN
    INSERT INTO center_classfications (
        classfication_id,
        center_id
    ) VALUES (
        Iclassfication_id,
        Icenter_id
    );

    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS CentersDetachClassfication;

DELIMITER //
CREATE  PROCEDURE `CentersDetachClassfication`(
    Iid INT
)
BEGIN
    DELETE FROM center_classfications WHERE id = Iid;

    SELECT Iid;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS CentersDelete;

DELIMITER //

CREATE PROCEDURE CentersDelete(IN id INT) BEGIN
UPDATE
    centers c
SET
    deleted_at = now()
WHERE
    c.id = id;

    SELECT id;
END //
DELIMITER ;

# brands

DROP PROCEDURE IF EXISTS BrandsCreate;

DELIMITER //
CREATE  PROCEDURE `BrandsCreate`(
    Iname VARCHAR(250),
    Iname_ar VARCHAR(250),
    Iimg VARCHAR(250)
)
BEGIN
    INSERT INTO brands (
        name,
        name_ar,
        img
    ) VALUES (
        Iname,
        Iname_ar,
        Iimg
    );

    SELECT LAST_INSERT_ID() id;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS BrandsDelete;

DELIMITER //

CREATE PROCEDURE BrandsDelete(IN id INT) BEGIN
UPDATE
    brands b
SET
    deleted_at = now()
WHERE
    b.id = id;

    SELECT id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS BrandsUpdate;

DELIMITER //
CREATE  PROCEDURE `BrandsUpdate`(
    Iid INT,
    Iname VARCHAR(250),
    Iname_ar VARCHAR(250),
    Iimg VARCHAR(250)
)
BEGIN
UPDATE brands 
    SET name = Iname,
        name_ar = Iname_ar,
        img = Iimg
    WHERE id = Iid;

    SELECT Iid;
END//
DELIMITER ;



DROP PROCEDURE IF EXISTS BrandsListAll;

DELIMITER //
CREATE  PROCEDURE `BrandsListAll`()
BEGIN
    SELECT id , name , name_ar , img , created_at FROM brands WHERE deleted_at IS NULL;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS BrandsById;

DELIMITER //
CREATE  PROCEDURE `BrandsById`(IN Iid INT)
BEGIN
    SELECT id , name , name_ar , img , created_at FROM brands WHERE deleted_at IS NULL AND id = Iid;
END//
DELIMITER ;




# classifications

DROP PROCEDURE IF EXISTS ClassificationsFind;

DELIMITER //

CREATE PROCEDURE ClassificationsFind(IN Iid INT) 
BEGIN
    SELECT id , name , name_ar FROM classifications WHERE deleted_at IS NULL AND id = Iid;
END //
DELIMITER ;
DROP PROCEDURE IF EXISTS ClassificationsListAll;

DELIMITER //

CREATE PROCEDURE ClassificationsListAll() 
BEGIN
    SELECT id , name , name_ar FROM classifications WHERE deleted_at IS NULL;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS ClassificationsCreate;

DELIMITER //

CREATE PROCEDURE ClassificationsCreate(IN Iname VARCHAR(250) , IN Iname_ar VARCHAR(250) ) 
BEGIN
    INSERT INTO classifications (name , name_ar) VALUES (Iname ,Iname_ar);

    SELECT LAST_INSERT_ID() id;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS ClassificationsUpdate;


DELIMITER //

CREATE PROCEDURE ClassificationsUpdate(IN Iid INT , IN Iname VARCHAR(250) , IN Iname_ar VARCHAR(250) ) 
BEGIN
    UPDATE classifications SET name = Iname , name_ar =Iname_ar WHERE id = Iid;
    SELECT Iid id;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS ClassificationsDelete;
DELIMITER //

CREATE PROCEDURE ClassificationsDelete(IN id INT) BEGIN
UPDATE
    classifications c
SET
    deleted_at = now()
WHERE
    c.id = id;

    SELECT  id;

END //
DELIMITER ;





# classifications


DROP PROCEDURE IF EXISTS TypesFind;

DELIMITER //

CREATE PROCEDURE TypesFind(IN Iid INT) 
BEGIN
    SELECT t.id , t.name , t.name_ar , b.name brand_name , b.id brand_id 
    FROM types t 
    JOIN brands b ON t.brand_id = b.id 
    WHERE t.deleted_at IS NULL 
    AND t.id  = Iid;
END //
DELIMITER ;
DROP PROCEDURE IF EXISTS TypesListByBrand;

DELIMITER //

CREATE PROCEDURE TypesListByBrand(IN BrandId INT) 
BEGIN
    SELECT t.id , t.name , t.name_ar , b.name brand_name , b.id brand_id 
    FROM types t 
    JOIN brands b ON t.brand_id = b.id 
    WHERE t.deleted_at IS NULL 
    AND b.id  =  CASE WHEN BrandId = 0 THEN b.id ELSE BrandId END;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS TypesCreate;

DELIMITER //

CREATE PROCEDURE TypesCreate(IN Iname VARCHAR(250) , IN Iname_ar VARCHAR(250) , IN Ibrand_id INT ) 
BEGIN
    INSERT INTO types (name , name_ar , brand_id) VALUES (Iname ,Iname_ar , Ibrand_id);

    SELECT LAST_INSERT_ID() id;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS TypesUpdate;


DELIMITER //

CREATE PROCEDURE TypesUpdate(IN Iid INT , IN Iname VARCHAR(250) , IN Iname_ar VARCHAR(250) , IN Ibrand_id INT) 
BEGIN
    UPDATE types SET name = Iname , name_ar = Iname_ar , brand_id = Ibrand_id WHERE id = Iid;
    SELECT Iid id;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS TypesDelete;
DELIMITER //

CREATE PROCEDURE TypesDelete(IN id INT) BEGIN
UPDATE
    types t
SET
    deleted_at = now()
WHERE
    t.id = id;

    SELECT  id;

END //
DELIMITER ;


