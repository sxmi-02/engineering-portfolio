CREATE TABLE aircraft (
    "id" INTEGER,
    "registration" TEXT,
    "msn" TEXT,
    "model" TEXT,
    "operator" TEXT,
    "engine_model" TEXT,
    "total_airframe_hours" INTEGER,
    PRIMARY KEY("id")
);

CREATE TABLE incident (
    "id" TEXT ,
    "aircraft_id" INTEGER NOT NULL,
    "date" DATE,
    "time" TEXT,
    "location_id" TEXT NOT NULL,
    "category_id" TEXT NOT NULL,
    "is_fatal" TEXT CHECK ("is_fatal" IN ('yes', 'no', 'unknown')),
    PRIMARY KEY("id"),
    FOREIGN KEY ("aircraft_id") REFERENCES "aircraft"("id"),
    FOREIGN KEY ("location_id") REFERENCES "location"("id"),
    FOREIGN KEY ("category_id") REFERENCES "category"("id")
);

CREATE TABLE casualties (
    "incident_id" TEXT,
    "fatalities" INTEGER,
    "occupants" INTEGER,
    "other_fatalities" INTEGER,
    "aircraft_damage" TEXT,
    "nature" TEXT,
    "phase" TEXT,
    PRIMARY KEY ("incident_id"),
    FOREIGN KEY ("incident_id") REFERENCES "incident"("id")
);

CREATE TABLE flight_path (
    "incident_id" TEXT,
    "departure_airport" TEXT,
    "destination_airport" TEXT,
    PRIMARY KEY ("incident_id"),
    FOREIGN KEY ("incident_id") REFERENCES "incident"("id")
);

CREATE TABLE location (
    "id" TEXT,
    "continent" TEXT,
    "country" TEXT,
    "description" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE category (
    "id" TEXT,
    "name" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE report_source (
    "id" TEXT,
    "source" TEXT,
    "confidence_rating" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE incident_source (
    "incident_id" TEXT NOT NULL,
    "source_id" TEXT NOT NULL,
    PRIMARY KEY ("incident_id", "source_id"),
    FOREIGN KEY ("incident_id") REFERENCES "incident"("id"),
    FOREIGN KEY ("source_id") REFERENCES "report_source"("id")
);

CREATE INDEX "Incident_Date" ON "incident"("date");
CREATE INDEX "Location_Country" ON "Location"("country");
CREATE INDEX "Category_Type" ON "category"("name");
