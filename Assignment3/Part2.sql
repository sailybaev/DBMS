SELECT *FROM Flights WHERE airline_id = (SELECT airline_id FROM Airline WHERE airline_name = 'SkyHigh');


SELECT f.*, da.airport_name AS dan FROM Flights f INNER JOIN Airport da ON f.departure_airport_id = da.airport_id;


SELECT * FROM Airline WHERE airline_id NOT IN (
    SELECT DISTINCT airline_id
    FROM Flights
    WHERE scheduled_departure >= NOW() AND scheduled_departure < NOW() + INTERVAL '1 month'
);



SELECT p.* FROM Passengers p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
INNER JOIN Booking_flight bf ON b.booking_id = bf.booking_id
WHERE bf.flight_id = 1;



SELECT
    bf.flight_id,
    AVG(b.price) AS avg,
    SUM(b.price) AS total,
    MAX(b.price) AS mx,
    MIN(b.price) AS mn
FROM Booking b JOIN Booking_flight bf ON b.booking_id = bf.booking_id
GROUP BY bf.flight_id
ORDER BY bf.flight_id;


SELECT f.*, a.airport_name AS aan, al.airline_name
FROM Flights f
INNER JOIN Airport a ON f.arrival_airport_id = a.airport_id
INNER JOIN Airline al ON f.airline_id = al.airline_id
WHERE a.country = 'Japan';



SELECT f.*, EXTRACT(EPOCH FROM (scheduled_arrival - scheduled_departure)) / 60 AS travel_time_minutes FROM Flights f;


SELECT p.*, a.airport_name AS destination
FROM Passengers p JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Booking_flight bf ON b.booking_id = bf.booking_id
JOIN Flights f ON bf.flight_id = f.flight_id
JOIN Airport a ON f.arrival_airport_id = a.airport_id
WHERE DATE_PART('year', AGE(p.date_of_birth)) < 18;


SELECT p.first_name, p.last_name, p.passport_number, f.actual_arrival
FROM Passengers p
INNER JOIN Booking b ON p.passenger_id = b.passenger_id
INNER JOIN Booking_flight bf ON b.booking_id = bf.booking_id
INNER JOIN Flights f ON bf.flight_id = f.flight_id
INNER JOIN Airport a ON f.arrival_airport_id = a.airport_id
WHERE a.airport_name = 'GAM^B';


SELECT a.country AS ac, COUNT(f.flight_id) as fcount
FROM Flights f
JOIN Airline al ON f.airline_id = al.airline_id
JOIN Airport a ON f.departure_airport_id = a.airport_id
WHERE a.country = al.airline_country
GROUP BY a.country;