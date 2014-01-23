SELECT 'OPTIONS';
CREATE TABLE OPTIONS(
    SIMULATION_TITLE            varchar,
    FLOW_UNITS          	varchar,
    INFILTRATION        	varchar,
    FLOW_ROUTING        	varchar,
    START_DATE          	varchar,
    START_TIME          	varchar,
    REPORT_START_DATE   	varchar,
    REPORT_START_TIME   	varchar,
    END_DATE            	varchar,
    END_TIME            	varchar,
    SWEEP_START         	varchar,
    SWEEP_END           	varchar,
    DRY_DAYS            	integer,
    REPORT_STEP         	varchar,
    WET_STEP            	varchar,
    DRY_STEP            	varchar,
    ROUTING_STEP        	varchar,
    ALLOW_PONDING       	varchar,
    INERTIAL_DAMPING    	varchar,
    VARIABLE_STEP       	float,
    LENGTHENING_STEP    	float,
    MIN_SURFAREA        	float,
    NORMAL_FLOW_LIMITED 	varchar,
    SKIP_STEADY_STATE   	varchar,
    FORCE_MAIN_EQUATION 	varchar,
    LINK_OFFSETS        	varchar,
    MIN_SLOPE           	float
);
INSERT INTO OPTIONS VALUES (
    'Swmm Simulation',
    'CFS',
    'HORTON',
    'DYNWAVE',
    '01/01/1988',
    '00:00:00',
    '01/01/1988',
    '00:00:00',
    '01/01/1988',
    '08:00:00',
    '01/01',
    '12/31',
    0,
    '00:00:30',
    '00:15:00',
    '01:00:00',
    '0:00:30 ',
    'NO',
    'NONE',
    0.75,
    0,
    12.566,
    'SLOPE',
    'NO',
    'H-W',
    'DEPTH',
    0
);

SELECT 'EVAPORATION';
CREATE TABLE EVAPORATION(
    SIMULATION_TITLE varchar,
    CONSTANT float,
    DRY_ONLY varchar
);
INSERT INTO EVAPORATION VALUES (
    'Swmm Simulation',
    0.0,
    'NO'
);

SELECT 'JUNCTIONS';
CREATE TABLE JUNCTIONS(
    Name varchar,
    InvertElev float,
    MaxDepth float,
    InitDepth float,
    SurchargeDepth float,
    PondedArea float
);
INSERT INTO JUNCTIONS VALUES (10309, 101.60, 9.40, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (15009, 111.50, 13.50, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (16009, 102.00, 18.00, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (16109, 102.80, 22.20, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (80408, 124.60, 13.40, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (80608, 118.30, 16.70, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (81009, 128.20, 8.80, .00, 0, 0);
INSERT INTO JUNCTIONS VALUES (81309, 117.50, 12.50, .00, 0, 0);
ALTER TABLE JUNCTIONS ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE JUNCTIONS ADD COLUMN geom geometry(POINT,2154);
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(4978.950 2421.050)'::geometry WHERE Name = '15009';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(2494.740 2421.050)'::geometry WHERE Name = '16009';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(2494.740 7536.840)'::geometry WHERE Name = '16109';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(10115.7907536.840)'::geometry WHERE Name = '80408';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(7463.160 7536.840)'::geometry WHERE Name = '80608';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(9989.470 2421.050)'::geometry WHERE Name = '81009';
UPDATE JUNCTIONS SET geom = 'SRID=2154;POINT(7568.420 2421.050)'::geometry WHERE Name = '81309';

SELECT 'OUTFALLS';
CREATE TABLE OUTFALLS(
    Name varchar,
    InvertElev float,
    OutfallType varchar,
    StageOrTimeSeries varchar
);
INSERT INTO OUTFALLS VALUES(10208, 89.9, 'FREE', 'NO');
ALTER TABLE OUTFALLS ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE OUTFALLS ADD COLUMN geom geometry(POINT,2154);
UPDATE OUTFALLS SET geom = 'SRID=2154;POINT(-578.950 4947.370)'::geometry WHERE Name = '10208';

SELECT 'STORAGE';
CREATE TABLE STORAGE(
    Name varchar,
    InvertElev float,
    MaxDepth float,
    InitDepth float,
    StorageCurve varchar,
    CurveParam1 float,
    CurveParam2 float,
    CurveParam3 float,
    PondedArea float,
    EvapFrac float
);
INSERT INTO STORAGE VALUES ('82309', 112.30, 42.70, .00, 'FUNCTIONAL', 100, 0, 0, 0, 0);
INSERT INTO STORAGE VALUES ('OffLine', 112.30, 42.70, .00, 'FUNCTIONAL', 100, 0, 0, 0, 0); 
ALTER TABLE STORAGE ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE STORAGE ADD COLUMN geom geometry(POINT,2154);
UPDATE STORAGE SET geom = 'SRID=2154;POINT(4957.890 7536.840)'::geometry WHERE Name = '82309';
UPDATE STORAGE SET geom = 'SRID=2154;POINT(6515.671 4882.892)'::geometry WHERE Name = 'OffLine';

SELECT 'CONDUITS';
CREATE TABLE CONDUITS(
    Name varchar,
    InletNode varchar,
    OutletNode varchar,
    Length float,
    ManningN float,
    InletOffset float,
    OutletOffset float,
    InitFlow float,
    MaxFlow float
);
INSERT INTO CONDUITS VALUES ('8040', '80408', '80608', 1800.0, 0.015, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('8060', '80608', '82309', 2075.0, 0.015, 0.0, 2.2, 0.0, 0);
INSERT INTO CONDUITS VALUES ('8100', '81009', '81309', 5100.0, 0.015, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('8130', '81309', '15009', 3500.0, 0.015, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('1030', '10309', '10208', 4500.0, 0.016, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('1570', '15009', '16009', 5000.0, 0.0154, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('1600', '16009', '16109', 500.0, 0.015, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('1630', '16009', '10309', 300.0, 0.015, 0.0, 0.0, 0.0, 0);
INSERT INTO CONDUITS VALUES ('1602', '82309', '16109', 5000.0, 0.034, 0.0, 0.0, 0.0, 0);
ALTER TABLE CONDUITS ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE CONDUITS ADD COLUMN geom geometry(LINESTRING,2154);
UPDATE CONDUITS AS d SET geom = ST_MakeLine((SELECT geom FROM JUNCTIONS AS s WHERE d.InletNode = s.Name 
                                       UNION SELECT geom FROM STORAGE   AS s WHERE d.InletNode = s.Name
                                       UNION SELECT geom FROM OUTFALLS  AS s WHERE d.InletNode = s.Name), 
                                            (SELECT geom FROM JUNCTIONS AS s WHERE d.OutletNode = s.Name 
                                       UNION SELECT geom FROM STORAGE   AS s WHERE d.OutletNode = s.Name
                                       UNION SELECT geom FROM OUTFALLS  AS s WHERE d.OutletNode = s.Name));
SELECT 'PUMPS';
CREATE TABLE PUMPS(
    Name varchar,
    InletNode varchar,
    OutletNode varchar,
    PumpCurve varchar,
    InitStatus varchar,
    StartupDepth float,
    ShutoffDepth float
);
INSERT INTO PUMPS VALUES('PUMPOne', '82309', 'OffLine', 'PUMPCURVEforPUMP1@82309-15009', 'ON', 0, 0);
INSERT INTO PUMPS VALUES('BackFlow', 'OffLine', '82309', 'PUMPCURVEforPUMP1@82309-15009', 'ON', 0, 0);
ALTER TABLE PUMPS ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE PUMPS ADD COLUMN geom geometry(POINT,2154);
UPDATE PUMPS SET geom = 'SRID=2154;POINT(4957.890 7536.840)'::geometry WHERE Name = 'PUMPOne';
UPDATE PUMPS SET geom = 'SRID=2154;POINT(6515.671 4882.892)'::geometry WHERE Name = 'BackFlow';

SELECT 'XSECTIONS';
CREATE TABLE XSECTIONS(
    Link varchar,
    Shape varchar,
    Geom1 float,
    Geom2 float,
    Geom3 float,
    Geom4 float,
    Barrels float
);
INSERT INTO XSECTIONS VALUES('8040', 'CIRCULAR', 4.0, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('8060', 'CIRCULAR', 4.0, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('8100', 'CIRCULAR', 4.5, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('8130', 'CIRCULAR', 4.5, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('1030', 'TRIANGULAR', 9.0, 54.0, 0, 0, 1.0);
INSERT INTO XSECTIONS VALUES('1570', 'CIRCULAR', 5.5, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('1600', 'CIRCULAR', 6.0, 0.0, 0.0, 0.0, 1.0);
INSERT INTO XSECTIONS VALUES('1630', 'TRIANGULAR', 9.0, 54.0, 0, 0, 1.0);
INSERT INTO XSECTIONS VALUES('1602', 'CIRCULAR', 5.0, 0.0, 0.0, 0.0, 1.0);

SELECT 'CONTROLS';
CREATE TABLE CONTROLS(
    Rule varchar
);
INSERT INTO CONTROLS VALUES (
'RULE BackFlow1
IF LINK 8040 FLOW > 1
THEN PUMP BackFlow SETTING = 1.0
AND PUMP PumpOne SETTING = 0.0
ELSE PUMP BackFlow SETTING = 0.0
AND PUMP PumpOne SETTING = 1.0
');

SELECT 'INFLOWS';
CREATE TABLE INFLOWS(
    Node varchar,
    Parameter varchar,
    TimeSeries varchar,
    ParamType varchar,
    UnitFactor float,
    ScaleFactor float
);
INSERT INTO INFLOWS VALUES ('80408',   'FLOW', 'INFLOW@80408', 'FLOW', 1.0, 1.0);
INSERT INTO INFLOWS VALUES ('81009',   'FLOW', 'INFLOW@81009', 'FLOW', 1.0, 1.0);
INSERT INTO INFLOWS VALUES ('82309',   'FLOW', 'INFLOW@82309', 'FLOW', 1.0, 1.0);
INSERT INTO INFLOWS VALUES ('OffLine', 'FLOW', 'INFLOW@82309', 'FLOW', 1.0, 1.0);

SELECT 'CURVES';
CREATE TABLE CURVES(
    Name varchar,
    Type varchar,
    Xvalue float,
    Yvalue float
);
INSERT INTO CURVES VALUES ('PUMPCURVEforPUMP1@82309-15009', 'Pump1', 0, 5.0);
INSERT INTO CURVES VALUES ('PUMPCURVEforPUMP1@82309-15009', NULL, 25.0, 10.0);
INSERT INTO CURVES VALUES ('PUMPCURVEforPUMP1@82309-15009', NULL, 600, 20.0);

SELECT 'TIMESERIES';
CREATE TABLE TIMESERIES(
    Name varchar,
    DateTime timestamp,
    Value float
);
INSERT INTO TIMESERIES VALUES ('INFLOW@82309', '01/01/1988 00:00', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@82309', '01/01/1988 00:15', 40.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@82309', '01/01/1988 03:00', 40.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@82309', '01/01/1988 03:15', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@82309', '01/01/1988 12:00', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@80408', '01/01/1988 00:00', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@80408', '01/01/1988 00:15', 45.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@80408', '01/01/1988 03:00', 45.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@80408', '01/01/1988 03:15', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@80408', '01/01/1988 12:00', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@81009', '01/01/1988 00:00', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@81009', '01/01/1988 00:15', 50.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@81009', '01/01/1988 03:00', 50.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@81009', '01/01/1988 03:15', 0.00000);
INSERT INTO TIMESERIES VALUES ('INFLOW@81009', '01/01/1988 12:00', 0.00000);

SELECT 'REPORT';
CREATE TABLE REPORT(
    SIMULATION_TITLE varchar,
    INPUT varchar,
    CONTROLS varchar,
    SUBCATCHMENTS varchar,
    NODES varchar,
    LINKS varchar
);
INSERT INTO REPORT VALUES (
'Swmm Simulation',
'YES',
'YES',
'ALL',
'ALL',
'ALL'
);


