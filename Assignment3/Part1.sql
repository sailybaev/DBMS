insert into airline (airline_name , airline_country) values ('SkyHigh' , 'France');

update airline set airline_country = 'Spain' where airline_name = 'SkyHigh';


DELETE FROM Flights WHERE airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'PUI');
delete from airline where airline_name = 'PUI';

insert into airline(airline_name , airline_country) values
                                                        ('AirNorth' , 'Canada'),
                                                        ('AirAstana' , 'Kazakhstan'),
                                                        ('EastFly' , 'China');


UPDATE flights SET status = NULL;
ALTER TABLE flights ALTER COLUMN status TYPE BOOLEAN USING CASE WHEN status='Male' THEN TRUE ELSE FALSE END;


INSERT INTO Flights (flight_id,flight_no,scheduled_departure,scheduled_arrival,departure_airport_id,arrival_airport_id,airline_id,status) VALUES
    (5002,'SH100', '2022-12-01 08:00:00', '2022-12-01 12:00:00', 1, 8, (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE),
    (5003,'SH101', '2022-12-01 13:00:00', '2022-12-01 17:00:00', 1, 8, (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE),
    (5004,'SH102', '2022-12-01 18:00:00', '2022-12-01 22:00:00', 1, 8, (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh'), TRUE);


UPDATE Flights
SET scheduled_departure = scheduled_departure + INTERVAL '1 hour' WHERE arrival_airport_id = 16;



DELETE FROM Booking_flight WHERE flight_id IN (SELECT flight_id FROM Flights WHERE EXTRACT(YEAR FROM scheduled_arrival) = 2023);
DELETE FROM Flights WHERE EXTRACT(YEAR FROM scheduled_arrival) = 2023;





INSERT INTO Passengers (passenger_id,first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number)
VALUES (201,'John', 'Smith', '1980-01-01', 'Male', 'USA', 'USA', '123456789');

INSERT INTO Booking (booking_id,passenger_id, booking_platform, status, price)
VALUES (501,201, 'AviaSales', 'Confirmed', 500.00);


INSERT INTO Booking_flight (booking_flight_id,booking_id, flight_id)
VALUES (995,501,(SELECT flight_id FROM Flights WHERE arrival_airport_id = 8 LIMIT 1));


INSERT INTO Boarding_pass (boarding_pass_id,booking_id, seat, boarding_time)
VALUES (1002,501,'12A', NOW());



UPDATE Booking
SET price = price * 1.1
WHERE booking_id IN (
SELECT booking_id FROM Booking_flight
    WHERE flight_id IN (SELECT flight_id FROM Flights WHERE arrival_airport_id = 12)
);



DELETE FROM boarding_pass WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM baggage WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM baggage_check WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM booking_flight WHERE booking_id IN (
    SELECT booking_id FROM Booking WHERE price < 1000);
DELETE FROM Booking WHERE price < 1000;
