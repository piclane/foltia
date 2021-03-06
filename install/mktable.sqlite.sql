
drop table if exists  foltia_program ;

create table foltia_program (
tid integer PRIMARY KEY, 
title text ,
startweektype text,
starttime text,
lengthmin integer,
firstlight text,
officialuri text , 
aspect integer , 
psp integer , 
transfer text,
PSPdirname text 
);
create unique index foltia_program_tid_index on foltia_program (tid);

-- REVOKE ALL on "foltia_program" from PUBLIC;
-- GRANT UPDATE,SELECT,INSERT on "foltia_program" to "foltia";

drop table if exists  foltia_subtitle ;

create table foltia_subtitle (
pid integer  PRIMARY KEY,
tid integer, 
stationid integer,
countno integer,
subtitle text,
startdatetime integer,
enddatetime integer,
startoffset integer,
lengthmin integer,
m2pfilename text ,
PSPfilename text ,
epgaddedby integer , 
lastupdate timestamp,
filestatus integer
);
create unique index foltia_subtitle_pid_index on foltia_subtitle (pid);
create  index foltia_subtitle_tid_index on foltia_subtitle (tid);
create  index foltia_subtitle_stationid_index on foltia_subtitle (stationid);
create  index foltia_subtitle_enddatetime_index on foltia_subtitle (enddatetime);
create  index foltia_subtitle_startdatetime_index on foltia_subtitle (startdatetime);

-- REVOKE ALL on "foltia_subtitle" from PUBLIC;
-- GRANT UPDATE,SELECT,INSERT on "foltia_subtitle" to "foltia";

drop table if exists foltia_tvrecord;
create table foltia_tvrecord (
tid integer  ,
stationid integer,
bitrate integer ,
digital integer
);
create  index foltia_tvrecord_tid_index on foltia_tvrecord (tid);

-- REVOKE ALL on "foltia_tvrecord" from PUBLIC;
-- GRANT ALL on "foltia_tvrecord" to "foltia";


drop table if exists foltia_epg;
create table foltia_epg (
epgid integer   PRIMARY KEY AUTOINCREMENT,
startdatetime integer,
enddatetime integer,
lengthmin integer ,
ontvchannel text,
epgtitle text,
epgdesc text,
epgcategory text 
);
create  index foltia_epg_startdatetime_index on foltia_epg (startdatetime);
create  index foltia_epg_enddatetime_index on foltia_epg (enddatetime);
create  index foltia_epg_ontvchannel_index on foltia_epg (ontvchannel);

-- REVOKE ALL on "foltia_epg" from PUBLIC;
-- GRANT ALL on "foltia_epg" to "foltia";

drop table if exists foltia_m2pfiles;
create table foltia_m2pfiles (
m2pfilename text  PRIMARY KEY
);
-- REVOKE ALL on "foltia_m2pfiles" from PUBLIC;
-- GRANT ALL on "foltia_m2pfiles" to "foltia";

drop table if exists foltia_mp4files;
create table foltia_mp4files (
tid integer,
mp4filename text   PRIMARY KEY
);
-- REVOKE ALL on "foltia_mp4files" from PUBLIC;
-- GRANT ALL on "foltia_mp4files" to "foltia";

drop table if exists foltia_station;
CREATE TABLE foltia_station (
    stationid integer  PRIMARY KEY,
    stationname text,
    stationrecch integer,
    stationcallsign text,
    stationuri text,
    tunertype text,
    tunerch text,
    device text,
    ontvcode text,
	digitalch integer,
	digitalstationband integer
);
--    ADD CONSTRAINT foltia_station_pkey PRIMARY KEY (stationid);
-- REVOKE ALL on "foltia_station" from PUBLIC;
-- GRANT ALL on "foltia_station" to "foltia";

--
-- PostgreSQL database dump
--

-- SET client_encoding = 'EUC_JP';
-- SET check_function_bodies = false;

-- SET SESSION AUTHORIZATION 'foltia';

-- SET search_path = public, pg_catalog;

--
-- TOC entry 3 (OID 17158)
-- Name: foltia_station; Type: TABLE; Schema: public; Owner: foltia
--

--
-- TOC entry 4 (OID 17158)
-- Name: foltia_station; Type: ACL; Schema: public; Owner: foltia
--


-- SET SESSION AUTHORIZATION 'foltia';

--
-- Data for TOC entry 6 (OID 17158)
-- Name: foltia_station; Type: TABLE DATA; Schema: public; Owner: foltia
--
INSERT INTO foltia_program VALUES (0, 'EPG録画', '', '', NULL, '', '', 3, 1, '', '');
INSERT INTO foltia_tvrecord VALUES (0,0,5,1);

--
-- TOC entry 5 (OID 17163)
-- Name: foltia_station_pkey; Type: CONSTRAINT; Schema: public; Owner: foltia
--

-- ALTER TABLE ONLY foltia_station
--     ADD CONSTRAINT foltia_station_pkey PRIMARY KEY (stationid);

drop table if exists foltia_envpolicy;
CREATE TABLE foltia_envpolicy (
memberid integer  PRIMARY KEY,
userclass integer,
name text,
passwd1 text ,
adddate timestamp,
remotehost text
);
-- REVOKE ALL on "foltia_envpolicy" from PUBLIC;
-- GRANT ALL on "foltia_envpolicy" to "foltia";
create  index foltia_envpolicy_index on foltia_envpolicy (name);
insert into foltia_envpolicy  values ( '0','0','foltia','foltiapasswd',datetime('now'),'');
