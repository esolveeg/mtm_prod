USE mtm;


# classifications
INSERT INTO
    classifications (`name` , `name_ar`)
VALUES
    ("Mechanic" , "ميكانيكا"),
    ("Body & Paint" , "دهان");
# videos 
INSERT INTO
    videos(name, url, image )
VALUES
    (
        "World's Coolest Concept Car - Mercedes AVTR",
        'https://www.youtube.com/watch?v=ekgUjyWe1Yc',
        'assets/videos/01.jpeg'
    );





# services
INSERT INTO
    services (name,name_ar, icon)
VALUES
    (
        'Regular check-ups',
        'صيانة دورية',
        'clipboard-check-multiple-outline'
    ),
    (
        'check-up',
        'صيانة',
        'clipboard-check-multiple-outline'
    ),
    (
        'buy',
        'اشتري',
        'car-back'
    ),
    (
        'sell',
        'بيع',
        'car-back'
    ),
    (
        'wensh',
        'اطلب ونش',
        'bus-outline'
    ),
    (
        'spare parts',
        'قطع الغيار',
        'application-outline'
    ),
    (
        'service centers',
        'مراكز الخدمة',
        'car-cog'
    ),
    (
        'ask me',
        'اسالني',
        'message-outline'
    );

# cities
INSERT INTO
    cities (`name` , `name_ar`)
VALUES
    ("Cairo" , "القاهرة"),
    ("Giza" , "الجيزة"),
    ('Alexandria' , 'الأسكندرية'),
    ("Dakahlia" , "الدقهلية"),
    ("Sea" , "البحر"),
    ("Beheira" , "البحيرة"),
    ("Fayoum" , "الفيوم"),
    ("Gharbiya" , "الغربية"),
    ("Ismailia" , "الإسماعلية"),
    ("Menofia" , "المنوفية");



# users
INSERT INTO
    users (
        name,
        email,
        img,
        password,
        phone,
        admin
    )
VALUES
    (
        'ahmed mohamed moustafa',
        'a.mohamed@gmail.com',
        'assets/members/male-01.jpg',
        '123456',
        '01010101010',
        0
    ),
    (
        'nadya el khoshromy',
        'nadia@gmail.com',
        'assets/members/female-01.jpg',
        '123456',
        '01010101011',
        0
    ),
    (
        'Mashal Ali Albrgs',
        'mashal@gmail.com',
        'assets/members/male-02.jpg',
        '123456',
        '01010101012',
        0
    ),
    (
        'admin',
        'admin@mtm.com',
        'assets/members/female-02.jpg',
        'mtm123456',
        '01010101013',
        1
    )
    ;

# articles
INSERT INTO
    articles (
        title,
        title_ar,
        img,
        status,
        published_at,
        user_id
    )
VALUES
    (
        'lorem ipsum 1',
        'كيفية إقناع المستثمرين والممولين بفكرة مشروعك',
        'assets/blog/01.jpeg',
        'active',
        now(),
        4
    ),
    (
        'lorem ipsum 2',
        'التوازن في عجلة الحياة تجاه ذاتك واهدافك',
        'assets/blog/02.jpeg',
        'active',
        now(),
       4
    ),
    (
        'lorem ipsum 3',
        'كيف واجهت شركة جنرال إلكتريك مشكلاتها المالية',
        'assets/blog/03.jpeg',
        'active',
        now(),
        4
    );



#brands
INSERT INTO brands (
    name , 
    name_ar , 
    img 
) VALUES (
    'Nissan',
    'نيسان',
    'assets/nissan-logo.png'
),
(
    'Bmw',
    'بي ام',
    'assets/bmw-logo.jpeg'
);


# types
INSERT INTO
    types (`name` , `name_ar` , `brand_id`)
VALUES
    ("Qashqai" , "قشقاي" , 1),
    ("320I" , "320I" , 2);
# videos 
INSERT INTO
    videos(name, url, image )
VALUES
    (
        "World's Coolest Concept Car - Mercedes AVTR",
        'https://www.youtube.com/watch?v=ekgUjyWe1Yc',
        'assets/videos/01.jpeg'
    );
# centers
INSERT INTO
    centers (
        name,
        location,
        brand_id,
        location_map,
        day_offs,
        open_time,
        close_time,
        logo
    )
VALUES
    (
        'center 1',
        '26,734 views Published on 24 June 2015',
        1,
        'https://www.google.com/maps/d/embed?mid=1ksBysRv_ZSolbXZfUY7bqdJDYXM&ehbc=2E312',
        '6,7',
        '12:00:00',
        '24:00:00',
        'assets/center-logo.jpg'
    ),
    (
        'center 2',
        '26,734 views Published on 24 June 2015',
        2,
        'https://www.google.com/maps/d/embed?mid=1ksBysRv_ZSolbXZfUY7bqdJDYXM&ehbc=2E312',
         '6,7',
        '12:00:00',
        '24:00:00',
        'assets/center-logo.jpg'
    ),
    (
        'center 3',
        '26,734 views Published on 24 June 2015',
        1,
        'https://www.google.com/maps/d/embed?mid=1ksBysRv_ZSolbXZfUY7bqdJDYXM&ehbc=2E312',
         '6,7',
        '12:00:00',
        '24:00:00',
        'assets/center-logo.jpg'
    );

# cars
INSERT INTO cars (
    model , 
    no , 
    img , 
    mileage , 
    user_id , 
    type_id 
) VALUES (
    2022,
    'اب 123',
    'assets/cars/nissan.jpg',
    100,
    1,
    1
) , (
    2021,
    'اج123',
    'assets/cars/bmw.jpg',
    500,
    2,
    2
);