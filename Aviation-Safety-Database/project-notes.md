# Design Document

By Sami Khan

Video overview: https://youtu.be/x3bJHSX7r3E

## Scope

The purpose of this database is to store and analyse aircraft incident data from 2000 to 2025, based on records sourced primarily from the Aviation Safety Network (ASN). This database includes:
- Aircraft involved in incidents (model, registration, serial number, etc.)
- Incidents and accidents from 2000–2025
- Human impact data (fatalities, occupants, etc.)
- Information about location and flight path
- Category of the incident (accident, serious incident, unlawful interference, unknown etc)
- Sources of reporting and confidence rating of the report

This database does not includes:
- Real-time incident updates or live feeds
- Maintenance schedules or historical service logs
- Personal identities
- Weather conditions

## Functional Requirements

A user should be able to:
- Query incidents by aircraft model, operator, or location
- Identify fatal or high-damage incidents
- Filter incidents by date range, country, or phase of flight
- View which investigative agency reported each incident
- Analyze total and average fatalities
- Cross-reference incidents with aircraft airframe hours

A user will not be able to:
- Cross reference information after the export of data was taken (19/08/2025)
- Create visual dashboards or location mapping
- Undergo fault prediction or risk scoring (planned for future development)
- Identify subsystems that could have caused the incident (planned for future development)


## Representation

### Entities

The database includes the following entities

### Aircraft

The aircraft table includes:

- `id`, which is a unique `INTEGER` serving as the `PRIMARY KEY` for each aircraft.
- `registration`, a `TEXT` field for the aircraft registration or tail number. This field is essential for identifying individual aircraft.
- `msn`, a `TEXT` field that stores the aircraft's Manufacturer Serial Number (MSN). While not always required, it's a helpful technical identifier.
- `model`, a `TEXT` field for the aircraft model (e.g., “Cessna 550 Citation II”).
- `operator`, a `TEXT` field denoting the company or organization operating the aircraft.
- `engine_model`, a `TEXT` field for the engine type used on the aircraft.
- `airframe_hours`, an `INTEGER` field indicating total flight hours. This field may be `NULL` if not reported.


### Incident

The incident table includes:

- `id`, a unique `TEXT` value (e.g., INC-20000101-001) serving as the `PRIMARY KEY`.
- `aircraft_id`, an `INTEGER` `FOREIGN KEY` referencing the aircraft table.
- `date`, a `DATE` field representing the date of the incident.
- `time`, a `TEXT` field for the time of the incident (formatted as HH:MM).
- `location_id`, a `TEXT` `FOREIGN KEY` referencing the location table.
- `category_id`, a `TEXT` `FOREIGN KEY` referencing the incident_category table.
- `is_fatal`, a `BOOLEAN` field that is `TRUE` if fatalities > 10, `FALSE` if fatalities < 10 and `Unknown` if fatalities is unknown

Each incident must be associated with an aircraft, category, and location, enforced by `FOREIGN KEY` constraints.

### Casualties

The casualties table includes:

- `incident_id`, a `TEXT` `PRIMARY KEY` and `FOREIGN KEY` referencing the `incident` table.
- `fatalities`, an `INTEGER` for the number of onboard fatalities.
- `occupants`, an `INTEGER` for total number of people onboard.
- `other_fatalities`, an `INTEGER` for third-party or ground fatalities.
- `aircraft_damage`, a `TEXT` field describing aircraft damage (e.g., “Substantial” or “Destroyed”).
- `nature`, a `TEXT` field categorizing the flight (e.g., “Private”, “Ferry”, “Scheduled”).
- `phase`, a `TEXT` field for the phase of flight during the incident (e.g., “Landing”, “En route”).

This is a one-to-one table linked directly to each incident for detailed damage and human impact information.

### Flight_Path

The `flight_path` table includes:

- `incident_id`, a `TEXT` `PRIMARY KEY` and `FOREIGN KEY` referencing the `incident` table.
- `departure_airport`, a `TEXT` field storing the departure airport's name or code.
- `destination_airport`, a `TEXT` field storing the destination airport's name or code.

This table is a one-to-one extension of incident, representing the flight’s origin and destination.

### Location

The location table includes:

- `id`, a `TEXT` `PRIMARY KEY` (e.g., LOC-USA-001).
- `continent`, a `TEXT` field identifying the specific continent.
- `country`, a `TEXT` field naming the country.
- `description`, a `TEXT` field for the full location string.

### Category

The category table includes:

- `id`, a `TEXT` `PRIMARY KEY` (e.g., CAT-ACC-001).
- `name`, a `TEXT` field for the category name (e.g., “Accident”, “Incident”, “Unlawful Interference”).

### Report_Source

The report_source table includes:

- `id`, a `TEXT` `PRIMARY KEY` (e.g., SRC-NTSB).
- `source`, a `TEXT` field for the reporting authority (e.g., “NTSB”).
- `confidence_rating`, a `TEXT` field summarizing how reliable the source is

### Incident_Source (primarily to join incident and report_source)

The incident_source table includes:

- `incident_id`, a `TEXT` `FOREIGN KEY` referencing the `incident` table.
- `source_id`, a `TEXT` `FOREIGN KEY` referencing the `report_source` table.
All columns in the `incident_source` table are required and hence should have the `NOT NULL` constraint applied.


### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

[ER Diagram](ER%20Diagram.png)

As detailed by the diagram:

 - An aircraft can only have one or multiple incidents. (If it had 0 it wouldnt be in this database)
 - Incidents can only be associated to one location but one location can host multiple or no incidents.
 - Incidents can only be associated to one category, whereas a category can be associated with 0 to many incidents: 0 if no incidents fall under that category.
 - An incident has one and only one corresponding casualties record and vice versa
 - An incident has one and only one corresponding flight path record and vice versa. This relationship is also strictly one-to-one, since each incident either has exactly one flight path or none at all
- An incident can be linked to 0 to many report sources through the incident_source join table: 0 if no sources have been recorded yet, and many if multiple organizations reported on the same incident. Conversely, a report source can be linked to 1 incident source as this is a join table that requires an incident source to link to.


## Optimizations


- Filter incidents where fatalities > 10 returns is_fatal = TRUE, fatalities < 10 returns is_fatal = False and fatalities is unknown returns is_fatal = Unknown.
- Included registration alongisde aircraft table to ensure fast lookups.

Ultimately these changes were made to improve read performance and enable easier querying

## Limitations

The design has some limitations. Large datapoints may be missing due to incomplete information about crashes, and while major incidents are often reported by reliable sources, smaller ones may not be, making them less accurate.

 Searching manually can also be difficult since text entries for departure and destination airports are unpredictable. Additionally, the database may not represent certain aspects very well, such as the precise cause of an incident, weather conditions, or other external contributing factors.

## Extra Notes

The ultimate goal of this project is to produce a structured database that can be analyzed by military aircraft organizations to identify the root causes of defects and to, potentially in the future, organize these defects by subsystem or point in production—enabling more informed decision-making and proactive strategies to reduce future occurrences.
