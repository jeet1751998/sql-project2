use hotel_management_db;

-- How many distinct guest have made bookings for a particular month? --
 SELECT COUNT( DISTINCT Customers_Customers_id) as total_customers
 FROM bookings 
 WHERE MONTH(Check_in_Date) = 8;
 
-- How many available rooms are in a particular hotel for a given date? --
SELECT rooms.Room_Avaliable 
FROM rooms JOIN hotels 
ON rooms.Hotels_Hotels_id = hotels.Hotels_id
WHERE Date_of_available = '2019-08-02' AND Room_Avaliable = 'YES' AND Hotel_Name = 'JW Marriott';

-- How many hotels are in a hotel chain?--
SELECT COUNT(Hotels_id), Hotel_Name
FROM hotels
WHERE Hotel_Chain_ID = 1 ;

-- How many books has a customer made in one year? --
SELECT COUNT(Customers_Customers_id) 
FROM bookings
WHERE YEAR(Check_in_Date) = 2019;

-- How many rooms are booked in a particular hotel on a given date? --
SELECT COUNT(Rooms_Room_id)
FROM bookings 
JOIN hotels ON
bookings.hotels_Hotels_id = hotels.Hotels_id
WHERE Hotel_name = 'Hotel-abc'  AND Check_in_Date = '2019-08-11';

-- List all the unique countries hotels are located in. --
SELECT DISTINCT Country from hotels;

-- How many rooms are available in a given hotel? --
SELECT COUNT(rooms.room_id) , Room_no
FROM rooms JOIN hotels ON rooms.Hotels_Hotels_id = hotels.Hotels_id
WHERE Room_Avaliable = "yes" and Hotel_name = "Hotel-abc";

-- List all the hotels that have a URL available. --
SELECT Hotel_name, url
FROM hotels WHERE url is not null;

-- List the rate for a room at a given time during the year--
DELIMITER //
CREATE FUNCTION get_price(dis_date DATETIME,room_id int)
RETURNS Int
	BEGIN
    DECLARE date_var varchar(50);
	SELECT MONTH(dis_date) INTO date_var;
		IF date_var = 'January' OR  date_var = 'March' THEN
          SELECT Jan_March_discount FROM rooms WHERE Room_id = room_id;
		ELSEIF date_var = 'July' OR  date_var = 'August' THEN
          SELECT July_August_Discount FROM rooms WHERE Room_id = room_id ;
		ELSEIF date_var = 'September' OR  date_var = 'December' THEN
          SELECT Sep_Dec_Discount FROM rooms WHERE Room_id = room_id ;
		ELSEIF 
		  SELECT Price FROM rooms WHERE Room_id = room_id ;
		END IF;
	END //

DELIMITER ;
select getprice(2019-07-11,1);
--  

