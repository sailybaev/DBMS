--DML tasks

INSERT INTO airline (airline_name, airline_country) VALUES ('SkyHigh', 'France');

UPDATE airline SET airline_country = 'Spain' WHERE airline_name = 'SkyHigh';


DELETE FROM booking_flight where flight_id in (SELECT flight_id FROM Flights WHERE airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'KKG'));
DELETE FROM Flights WHERE airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'KKG');
delete from airline where airline_name = 'KKG';


INSERT INTO airline (airline_name, airline_country) VALUES ('AirAstana' , 'Kazakhstan') , ('AirNorth' , 'Canada') , ('EastFly' , 'China');



DELETE FROM booking_flight WHERE flight_id IN (SELECT flight_id FROM Flights WHERE EXTRACT(YEAR FROM scheduled_arrival) = 2023);
DELETE FROM Flights WHERE EXTRACT(YEAR FROM scheduled_arrival) = 2023;


INSERT INTO Flights (flight_id,flight_no,scheduled_departure,scheduled_arrival,departure_airport_id,arrival_airport_id,airline_id,status) VALUES
    (5002,'SH100', '2022-12-01 08:00:00', '2022-12-01 12:00:00', 1, (SELECT airport_id from airport where city = 'Sangzhou'), (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE),
    (5003,'SH101', '2022-12-01 13:00:00', '2022-12-01 17:00:00', 1, (SELECT airport_id from airport where city = 'Sangzhou'), (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE),
    (5004,'SH102', '2022-12-01 18:00:00', '2022-12-01 22:00:00', 1, (SELECT airport_id from airport where city = 'Sangzhou'), (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE);


UPDATE Flights SET scheduled_departure = scheduled_departure + interval '1 day', scheduled_arrival = scheduled_arrival + interval '1 day' WHERE flight_id = (SELECT airport_id FROM airport WHERE city = 'Hilotongan');



INSERT INTO Passengers (passenger_id,first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number)
VALUES (201,'John', 'Smith', '1980-01-01', 'Male', 'USA', 'USA', '123456789');


INSERT INTO Booking (booking_id,passenger_id, booking_platform, status, price)
VALUES (501,201, 'AviaSales', 'Confirmed', 500.00);


INSERT INTO Booking_flight (booking_flight_id,booking_id, flight_id)
VALUES (995,501,(SELECT flight_id FROM Flights WHERE arrival_airport_id = (SELECT airport_id from airport where city = 'Sangzhou') LIMIT 1));

INSERT INTO Boarding_pass (boarding_pass_id,booking_id, seat, boarding_time)
VALUES (1002,501,'12A', NOW());

UPDATE Booking
SET price = price * 1.1
WHERE booking_id IN (SELECT booking_id FROM Booking_flight WHERE flight_id IN (SELECT flight_id FROM Flights WHERE arrival_airport_id = (SELECT airport_id from airport where city = 'Wewit')));


DELETE FROM boarding_pass WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM baggage WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM baggage_check WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM booking_flight WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM Booking WHERE price < 1000;



-- join tasks


SELECT * FROM Flights where airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh');

SELECT f.flight_id , a.airport_name as destination from flights f JOIN airport a on f.departure_airport_id = a.airport_id;

SELECT airline_name FROM airline WHERE airline_id NOT IN (SELECT DISTINCT airline_id FROM Flights WHERE scheduled_departure >= CURRENT_DATE AND scheduled_departure < CURRENT_DATE + INTERVAL '1 month');

SELECT p.first_name || ' ' || p.last_name as fullName FROM Passengers p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
WHERE bf.flight_id = 5002;


SELECT
    bf.flight_id,
    AVG(b.price) AS average_price,
    SUM(b.price) AS total_price,
    MAX(b.price) AS maximum_price,
    MIN(b.price) AS minimum_price
FROM Booking b JOIN Booking_flight bf ON b.booking_id = bf.booking_id
GROUP BY bf.flight_id
ORDER BY bf.flight_id;

SELECT f.flight_id, a.airport_name AS arrival_airport_name, al.airline_name
FROM Flights f
JOIN Airport a ON f.arrival_airport_id = a.airport_id
JOIN Airline al ON f.airline_id = al.airline_id
WHERE a.country = 'Sangzhou';


SELECT p.*, a.airport_name AS destination
FROM Passengers p JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
JOIN Flights f ON bf.flight_id = f.flight_id
JOIN Airport a ON f.arrival_airport_id = a.airport_id
WHERE DATE_PART('year', AGE(p.date_of_birth)) < 18;


SELECT p.first_name, p.last_name, p.passport_number, CURRENT_TIMESTAMP as current_time_of_arrival
FROM Passengers p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
INNER JOIN Booking_flight bf ON b.booking_id = bf.booking_id
INNER JOIN boarding_pass bp on bp.booking_id = b.booking_id
WHERE bp.seat = 'RAS^B';

SELECT f.flight_id, a.airport_name AS departure_airport_name, al.airline_name
FROM Flights f
JOIN Airline al ON f.airline_id = al.airline_id
JOIN Airport a ON f.departure_airport_id = a.airport_id
WHERE a.country = al.airline_country AND f.departure_airport_id = a.airport_id
ORDER BY a.country;

