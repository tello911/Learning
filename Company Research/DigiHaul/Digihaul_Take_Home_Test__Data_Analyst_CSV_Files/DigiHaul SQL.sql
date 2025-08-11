-- SQL Query:

-- Retrieve shipments with multiple pickups and multiple deliveries

SELECT s.ShipmentID
FROM shipments s
JOIN pickup_locations p ON s.ShipmentID = p.ShipmentID
JOIN delivery_locations d ON s.ShipmentID = d.ShipmentID
GROUP BY s.ShipmentID
HAVING COUNT(DISTINCT p.pickupid) > 1
   AND COUNT(DISTINCT d.deliveryid) > 1;

-- Calculate average pickup delay grouped by region

SELECT ship.region,
       AVG(TIMESTAMPDIFF(MINUTE, p.ScheduledPickupTime, p.ActualPickupTime)) AS avg_pickup_delay_minutes
FROM pickup_locations p
JOIN shipments s ON p.shipmentid = s.shipmentid
JOIN shippers ship ON s.shipperid = ship.shipperid
GROUP BY ship.region;


-- Utilization below 50%


/*

-- Not sure the definition

*/

-- List top 5 carriers with highest average delivery delays

SELECT c.CarrierID,
       AVG(TIMESTAMPDIFF(MINUTE, d.ScheduledDeliveryTime, d.ActualDeliveryTime)) AS avg_delivery_delay_minutes
FROM delivery_locations d
JOIN shipments s ON d.ShipmentID = s.ShipmentID
JOIN carriers c ON s.CarrierID = c.CarrierID
GROUP BY c.CarrierID
ORDER BY avg_delivery_delay_minutes DESC
LIMIT 5;
