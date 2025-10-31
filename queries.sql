-- Top 10 aircraft with the most air_frame_hours
SELECT "model", "operator", "total_airframe_hours" FROM "aircraft" WHERE "total_airframe_hours" IS NOT NULL
  AND "total_airframe_hours" != 'NULL'
ORDER BY "total_airframe_hours" DESC LIMIT 10;

-- All incidents sourced from NTSB
SELECT * FROM "report_source" WHERE "source" IS "NTSB";

-- Model of the flights that had an incident at 00:01
SELECT "aircraft"."model" FROM "aircraft"
JOIN "incident" ON "aircraft"."id" = "incident"."aircraft_id" WHERE "incident"."time" = '00:01';

-- The model of the flight that crashed in East Timor
SELECT "model" FROM "aircraft" WHERE "id" IN (
    SELECT "aircraft_id" FROM "incident" WHERE "location_id" = (
      SELECT "id" FROM "location" WHERE "country" = 'East Timor'));

-- The total number of incidents that occured on each continent in order of most to least
SELECT "location"."continent", COUNT("incident"."id") AS "total_incidents" FROM "incident"
JOIN "location" ON "incident"."location_id" = "location"."id"
GROUP BY "location"."continent" ORDER BY "total_incidents" DESC;

-- The dates of every incident from a military airshow
SELECT "incident"."date", "incident"."time" FROM "incident"
JOIN "casualties" ON "casualties"."incident_id" = "incident"."id"
WHERE "casualties"."nature" = 'Military' AND "casualties"."phase" LIKE '%airshow%';

-- Most common category of an incident
SELECT "category"."name", COUNT("incident"."id") AS "incident_count" FROM "incident"
JOIN "category" ON "incident"."category_id" = "category"."id"
GROUP BY "category"."name" ORDER BY "incident_count" DESC LIMIT 1;

-- The flight that planned to travel from John F. Kennedy to Heathrow
SELECT "aircraft"."msn", "aircraft"."model", "aircraft"."operator" FROM "aircraft"
JOIN "incident" ON "aircraft"."id" = "incident"."aircraft_id"
JOIN "flight_path" ON "incident"."id" = "flight_path"."incident_id"
WHERE "flight_path"."departure_airport" LIKE '%John F. Kennedy%' AND "flight_path"."destination_airport" LIKE '%Heathrow%';

-- Top 10 incidents with the most fatalities
SELECT "incident"."date", "incident"."time", "aircraft"."model",("casualties"."fatalities" + "casualties"."other_fatalities") AS "total_fatalities"
FROM "incident"
JOIN "casualties" ON "casualties"."incident_id" = "incident"."id"
JOIN "aircraft" ON "aircraft"."id" = "incident"."aircraft_id"
WHERE "casualties"."fatalities" IS NOT NULL AND "casualties"."fatalities" != 'NULL'
  AND "casualties"."other_fatalities" IS NOT NULL AND "casualties"."other_fatalities" != 'NULL'
ORDER BY "total_fatalities" DESC LIMIT 10;
