ans 1


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
inner join vehicle_status vstatus
 on vstatus.vehicle_status_id = v.vehicle_status_id




ans 2
SELECT
    v.vehicle_id, v.vehicle_name, v.registration_number, vt.vehicle_type_name, v.registration_number, 
  v.rental_price_per_day , vs.availability_status
FROM vehicle v
INNER JOIN vehicle_type vt 
    ON v.vehicle_type_id = vt.vehicle_type_id
INNER JOIN vehicle_status vs
  on v.vehicle_status_id = vs.vehicle_status_id
WHERE NOT EXISTS (
    SELECT 1
    FROM booking b
    WHERE b.vehicle_id = v.vehicle_id
);




ans3

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




ans 4
SELECT
    v.vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicle v
JOIN booking b
    ON v.vehicle_id = b.vehicle_id
GROUP BY
    v.vehicle_name
HAVING COUNT(b.booking_id) > 2;