
%main::stmt = (
'addatq.1' => "SELECT count(*) FROM foltia_tvrecord WHERE tid = ?",
'addatq.2' => "SELECT count(*) FROM foltia_tvrecord WHERE tid = ? AND stationid = ?",
'addatq.3' => "SELECT count(*) FROM foltia_tvrecord WHERE tid = ? AND stationid = '0'",
'addatq.addcue.1' => "SELECT * FROM foltia_tvrecord WHERE tid = ?",
'addatq.addcue.2' => "SELECT * FROM foltia_tvrecord WHERE tid = ? AND stationid = ?",
'addatq.addcue.3' => "SELECT * from foltia_subtitle WHERE tid = ? AND startdatetime > ? AND startdatetime < ?",
'addatq.addcue.4' => "SELECT stationid , stationrecch FROM foltia_station where stationid = ?",
'addatq.addcue.5' => "SELECT * from foltia_subtitle WHERE tid = ? AND stationid = ? AND startdatetime > ? AND startdatetime < ?",
'addatq.addcue.6' => "SELECT stationid , stationrecch FROM foltia_station where stationid = ?",

'addpidatq.1' => "SELECT count(*) FROM foltia_subtitle WHERE pid = ?",
'addpidatq.2' => "SELECT bitrate,digital FROM foltia_tvrecord , foltia_subtitle WHERE foltia_tvrecord.tid = foltia_subtitle.tid AND pid = ?",
'addpidatq.3' => "SELECT stationrecch, digitalch, digitalstationband ,foltia_station.stationid FROM foltia_station,foltia_subtitle WHERE foltia_subtitle.pid = ? AND foltia_subtitle.stationid = foltia_station.stationid",
'addpidatq.4' => "SELECT * FROM foltia_subtitle WHERE pid = ?",

'changestbch.1' => "SELECT foltia_station.tunertype, foltia_station.tunerch, foltia_station.stationrecch, foltia_station.stationid FROM foltia_subtitle, foltia_station WHERE foltia_subtitle.stationid = foltia_station.stationid AND foltia_subtitle.pid = ?",

'envpolicyupdate.1' => "SELECT userclass,name,passwd1 FROM foltia_envpolicy",

'foltialib.getstationid.1' => "SELECT count(*) FROM foltia_station WHERE stationname = ?",
'foltialib.getstationid.2' => "SELECT stationid,stationname FROM foltia_station WHERE stationname = ?",
'foltialib.getstationid.3' => "SELECT max(stationid) FROM foltia_station",
'foltialib.getstationid.4' => "INSERT INTO foltia_station (stationid, stationname, stationrecch) VALUES (?, ?, ?)",
'foltialib.getpidbympegfilename.1' => "SELECT pid FROM foltia_subtitle WHERE m2pfilename = ? LIMIT 1",
'foltialib.changefilestatus.1' => "UPDATE foltia_subtitle SET filestatus = ?, lastupdate = now() WHERE pid = ?",
'foltialib.getfilestatus.1' => "SELECT filestatus FROM foltia_subtitle WHERE pid = ?",

'getxml2db.1' => "SELECT count(*) FROM foltia_program WHERE tid = ?",
'getxml2db.2' => "INSERT into foltia_program VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?)",
'getxml2db.3' => "SELECT title FROM foltia_program WHERE tid = ?",
'getxml2db.4' => "UPDATE foltia_program SET title = ? where tid = ?",
'getxml2db.5' => "SELECT count(*) FROM foltia_subtitle WHERE tid = ? AND pid = ?",
'getxml2db.6' => "UPDATE foltia_subtitle SET stationid = ?, countno = ?, subtitle = ?, startdatetime = ?, enddatetime = ?, startoffset = ?, lengthmin = ? WHERE tid = ? AND pid = ?",
'getxml2db.7' => "UPDATE foltia_subtitle SET stationid = ?, countno = ?, subtitle = ?, startdatetime = ?, enddatetime = ?, startoffset = ?, lengthmin = ? WHERE tid = ? AND pid = ?",
'getxml2db.8' => "INSERT into foltia_subtitle (pid, tid, stationid, countno, subtitle, startdatetime, enddatetime, startoffset, lengthmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
'getxml2db.9' => "INSERT into foltia_subtitle (pid, tid, stationid, countno, subtitle, startdatetime, enddatetime, startoffset, lengthmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",

'ipodtranscode.1' => "SELECT foltia_subtitle.pid,foltia_subtitle.tid,foltia_subtitle.m2pfilename,filestatus,foltia_program.aspect,foltia_subtitle.countno FROM foltia_subtitle, foltia_program, foltia_m2pfiles WHERE filestatus >= ? AND filestatus < ? AND foltia_program.tid = foltia_subtitle.TID AND foltia_program.PSP = 1 AND foltia_m2pfiles.m2pfilename = foltia_subtitle.m2pfilename ORDER BY enddatetime ASC LIMIT 1",
'ipodtranscode.2' => "SELECT title, countno, subtitle FROM foltia_program, foltia_subtitle WHERE foltia_program.tid = foltia_subtitle.tid AND foltia_subtitle.pid = ?",
'ipodtranscode.updatemp4file.1' => "UPDATE foltia_subtitle SET PSPfilename = ? WHERE pid = ?",
'ipodtranscode.updatemp4file.2' => "INSERT INTO foltia_mp4files VALUES (?, ?)",

'ipodtranscode.counttranscodefiles.1' => "SELECT count(*) FROM foltia_subtitle, foltia_program, foltia_m2pfiles WHERE filestatus >= ? AND filestatus < ? AND foltia_program.tid = foltia_subtitle.TID AND foltia_program.PSP = 1 AND foltia_m2pfiles.m2pfilename = foltia_subtitle.m2pfilename",

'mklocalizeddir.1' => "SELECT title FROM foltia_program where tid = ?",

'recwrap.1' => "UPDATE foltia_subtitle SET m2pfilename = ? WHERE pid = ?",
'recwrap.2' => "INSERT into foltia_m2pfiles VALUES (?)",
'recwrap.3' => "SELECT psp,aspect,title FROM foltia_program WHERE tid = ?",
'recwrap.4' => "SELECT subtitle FROM foltia_subtitle WHERE tid = ? AND countno = ?",
'recwrap.5' => "UPDATE foltia_subtitle SET PSPfilename = ? WHERE pid = ?",
'recwrap.6' => "INSERT into foltia_mp4files VALUES (?, ?)",
'recwrap.7' => "SELECT foltia_subtitle.tid,foltia_subtitle.countno,foltia_subtitle.subtitle,foltia_subtitle.startdatetime ,foltia_subtitle.enddatetime ,foltia_subtitle.lengthmin ,foltia_tvrecord.bitrate , foltia_subtitle.startoffset , foltia_subtitle.pid ,foltia_tvrecord.digital FROM foltia_subtitle ,foltia_tvrecord WHERE foltia_tvrecord.tid = foltia_subtitle.tid AND foltia_tvrecord.tid = ? AND foltia_subtitle.startdatetime = ? AND foltia_tvrecord.digital = 1",

'schedulecheck.1' => "SELECT count(*) FROM foltia_tvrecord",
'schedulecheck.2' => "SELECT tid ,stationid FROM foltia_tvrecord",

'singletranscode.1' => "SELECT pid FROM foltia_subtitle WHERE m2pfilename = ?",
'singletranscode.2' => "SELECT count(*) FROM foltia_subtitle WHERE tid = ? AND countno = ?",
'singletranscode.3' => "SELECT count(*) FROM foltia_subtitle WHERE tid = ?",
'singletranscode.4' => "SELECT psp,aspect,title FROM foltia_program WHERE tid = ?",
'singletranscode.5' => "SELECT subtitle FROM foltia_subtitle WHERE tid = ? AND countno = ?",
'singletranscode.6' => "UPDATE foltia_subtitle SET PSPfilename = ? WHERE pid = ?",
'singletranscode.7' => "INSERT into foltia_mp4files values (?, ?)",

'updatem2pfiletable.1' => "DELETE FROM foltia_m2pfiles",
'updatem2pfiletable.2' => "INSERT into foltia_m2pfiles values (?)",
'updatem2pfiletable.3' => "DELETE FROM foltia_mp4files",
'updatem2pfiletable.4' => "INSERT into foltia_mp4files values (?, ?)",

'xmltv2foltia.chkerase.1' => "DELETE FROM foltia_epg WHERE startdatetime > ? AND ontvchannel = ?",
'xmltv2foltia.registdb.1' => "SELECT max(epgid) FROM foltia_epg",
'xmltv2foltia.registdb.2' => "INSERT INTO foltia_epg VALUES (?, ?, ?, ?, ?, ?, ?, ?)",

);

1;
