Vehicle Rental System – SQL Queries & Explanations




---

Query 1: INNER JOIN

Requirement

Retrieve booking information along with:

Customer name

Vehicle name


SQL Code

SELECT
    b.booking_id,
    u.name AS customer_name,
    v.vehicle_name,
    b.start_date,
    b.end_date,
    vstatus.availability_status
FROM booking b
INNER JOIN users u
    ON b.user_id = u.user_id
INNER JOIN vehicle v
    ON b.vehicle_id = v.vehicle_id
INNER JOIN vehicle_status vstatus
    ON vstatus.vehicle_status_id = v.vehicle_status_id;

Explanation (Step by Step)

1. The query starts from the booking table.


2. INNER JOIN users connects each booking with the customer who made it.


3. INNER JOIN vehicle retrieves the booked vehicle details.


4. INNER JOIN vehicle_status fetches the availability status of the vehicle.


5. SELECT displays booking ID, customer name, vehicle name, rental dates, and availability.


6. INNER JOIN ensures only records with matching values in all tables are returned.




---

Query 2: NOT EXISTS

Requirement

Find all vehicles that have never been booked.

SQL Code

SELECT
    v.vehicle_id,
    v.vehicle_name,
    v.registration_number,
    vt.vehicle_type_name,
    v.rental_price_per_day,
    vs.availability_status
FROM vehicle v
INNER JOIN vehicle_type vt 
    ON v.vehicle_type_id = vt.vehicle_type_id
INNER JOIN vehicle_status vs
    ON v.vehicle_status_id = vs.vehicle_status_id
WHERE NOT EXISTS (
    SELECT 1
    FROM booking b
    WHERE b.vehicle_id = v.vehicle_id
);

Explanation (Step by Step)

1. The query selects all vehicles with their type and availability status.


2. INNER JOIN vehicle_type identifies the category of each vehicle.


3. INNER JOIN vehicle_status shows whether the vehicle is available, rented, or under maintenance.


4. NOT EXISTS checks if the vehicle appears in the booking table.


5. If no matching booking exists, the vehicle is included in the result.


6. This returns vehicles that have never been booked.




---

Query 3: WHERE Clause

Requirement

Retrieve all available vehicles of a specific type (e.g., Cars).

SQL Code

SELECT
    v.vehicle_id,
    v.vehicle_name,
    vt.vehicle_type_name,
    v.registration_number,
    v.model,
    v.rental_price_per_day,
    vs.availability_status
FROM vehicle v
JOIN vehicle_type vt
    ON v.vehicle_type_id = vt.vehicle_type_id
JOIN vehicle_status vs
    ON v.vehicle_status_id = vs.vehicle_status_id
WHERE
    vt.vehicle_type_name = 'Car'
    AND vs.availability_status = 'available';

Explanation (Step by Step)

1. The query starts from the vehicle table.


2. JOIN vehicle_type identifies the type of each vehicle.


3. JOIN vehicle_status checks availability.


4. WHERE vehicle_type_name = 'Car' filters only cars.


5. AND availability_status = 'available' filters only available vehicles.


6. The result shows available cars only.




---

Query 4: GROUP BY & HAVING

Requirement

Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

SQL Code

SELECT
    v.vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicle v
JOIN booking b
    ON v.vehicle_id = b.vehicle_id
GROUP BY
    v.vehicle_name
HAVING COUNT(b.booking