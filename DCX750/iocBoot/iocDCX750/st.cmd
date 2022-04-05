#!../../bin/linux-x86_64/DCX750

#- You may have to change DCX750 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/DCX750.dbd"
DCX750_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/DCX750App/Db")
epicsEnvSet ("PREFIX", "SLAC:DCX750:")
epicsEnvSet ("PORT", "serial1")

drvAsynSerialPortConfigure("serial1","/dev/ttyUSB0",0,0,0)
asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\r\n")
asynSetOption("serial1",0,"baud","38400")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")
#asynSetTraceIOMask("serial7",0, ESCAPE)
#asynSetTraceMask("serial7", 0, ERROR|DRIVER|FLOW)
asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)

dbLoadRecords("${TOP}/DCX750App/Db/DCX750.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:DCX750:")
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(SSCAN)/db/scan.db", "P=$(PREFIX),MAXPTS1=2000,MAXPTS2=200,MAXPTS3=20,MAXPTS4=10,MAXPTSH=10")

cd "${TOP}/iocBoot/${IOC}"
iocInit

