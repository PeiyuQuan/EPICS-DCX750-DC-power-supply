TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += DCX750Support

# Compile and add code to the support library
DCX750Support_SRCS += xxxRecord.c
DCX750Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
DCX750Support_SRCS += dbSubExample.c
DCX750Support_SRCS += devDCX750Version.c
DCX750Support_SRCS += DCX750Hello.c
DCX750Support_SRCS += initTrace.c

DCX750Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = DCX750Version.h
# Macro name
GENVERSIONMACRO = DCX750VERSION

# Build the IOC application
PROD_IOC = DCX750

# DCX750.dbd will be created and installed
DBD += DCX750.dbd

# DCX750.dbd will include these files:
DCX750_DBD += base.dbd
DCX750_DBD += xxxSupport.dbd
DCX750_DBD += dbSubExample.dbd
DCX750_DBD += devDCX750Version.dbd
DCX750_DBD += DCX750Hello.dbd
DCX750_DBD += initTrace.dbd
DCX750_DBD += asyn.dbd
DCX750_DBD += drvAsynIPPort.dbd
DCX750_DBD += drvAsynSerialPort.dbd
DCX750_DBD += calc.dbd
DCX750_DBD += stream-scalcout.dbd
DCX750_DBD += stream.dbd
DCX750_DBD += asSupport.dbd

# DCX750_registerRecordDeviceDriver.cpp derives from DCX750.dbd
DCX750_SRCS += DCX750_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
DCX750_SRCS_DEFAULT += DCX750Main.cpp
DCX750_SRCS_vxWorks += -nil-

# Link in the code from our support library
DCX750_LIBS += DCX750Support
DCX750_LIBS += asyn
DCX750_LIBS += calc
DCX750_LIBS += autosave
DCX750_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into DCX750Support
    sncExample_SNCFLAGS += +r
    DCX750_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    DCX750Support_SRCS += sncExample.stt
    DCX750Support_LIBS += seq pv
    DCX750_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    DCX750_LIBS += qsrv
    DCX750_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    DCX750_DBD += PVAServerRegister.dbd
    DCX750_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
DCX750_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devDCX750Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
