select
* FROM incident WHERE 
ST_contains(ST_Geomfromtext ('Polygon((-118.3 34.03, -118.3 34.02, -118.2 34.02, -118.2 34.03,-118.3 34.03))'), 
incident.INCIDENT_LOCATION);

select * from incident;
select * from officer;

SELECT DISTANCE(GEOMFROMTEXT('Point(42.260223 -71.800010)'),GEOMFROMTEXT('Point(42.245647 -71.802521)'));

select ST_DISTANCE_SPHERE(
officer.officer_location,
(select incident_location from incident where incident_id=481)) from officer;


SELECT * FROM officer where 
ST_DISTANCE_SPHERE(
officer.officer_location,
(select incident_location from incident where incident_id=15))<250;

select zone.*,officer.*,
CASE
    WHEN ST_contains(zone.zone_area,officer.officer_location)  =1 THEN "IN"
    WHEN ST_contains(zone.zone_area,officer.officer_location)  =0 THEN "OUT"    
END as "in/out"
from zone,officer where zone.SQUAD_NUMBER=officer.SQUAD_NUMBER and officer.SQUAD_NUMBER=5
order by badge_number;

select * from zone,route where st_intersects(zone_area,route.ROUTE_LINE) and route.ROUTE_NUMBER=3;

SELECT BADGE_NUMBER,
ST_DISTANCE_SPHERE(
officer.officer_location,
(select incident_location from incident where incident_id=481)
) as "DISTANCE",
OFFICER_NAME 
FROM officer 
where ST_DISTANCE_SPHERE(officer.officer_location,(select incident_location from incident where incident_id=481))<250 order by DISTANCE;







