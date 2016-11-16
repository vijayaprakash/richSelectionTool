#-
# ==========================================================================
# Copyright (c) 2011 Autodesk, Inc.
# All rights reserved.
# 
# These coded instructions, statements, and computer programs contain
# unpublished proprietary information written by Autodesk, Inc., and are
# protected by Federal copyright law. They may not be disclosed to third
# parties or copied or duplicated in any form, in whole or in part, without
# the prior written consent of Autodesk, Inc.
# ==========================================================================
#+

ifndef INCL_BUILDRULES

#
# Include platform specific build settings
#
TOP := ..
include $(TOP)/buildrules


#
# Always build the local plug-in when make is invoked from the
# directory.
#
all : plugins

endif

#
# Variable definitions
#

SRCDIR := $(TOP)/richSelectionTool
DSTDIR := $(TOP)/richSelectionTool

richSelectionTool_SOURCES  := $(TOP)/richSelectionTool/richSelectionTool.cpp
richSelectionTool_OBJECTS  := $(TOP)/richSelectionTool/richSelectionTool.o
richSelectionTool_PLUGIN   := $(DSTDIR)/richSelectionTool.$(EXT)
richSelectionTool_MAKEFILE := $(DSTDIR)/Makefile

#
# Include the optional per-plugin Makefile.inc
#
#    The file can contain macro definitions such as:
#       {pluginName}_EXTRA_CFLAGS
#       {pluginName}_EXTRA_C++FLAGS
#       {pluginName}_EXTRA_INCLUDES
#       {pluginName}_EXTRA_LIBS
-include $(SRCDIR)/Makefile.inc


#
# Set target specific flags.
#

$(richSelectionTool_OBJECTS): CFLAGS   := $(CFLAGS)   $(richSelectionTool_EXTRA_CFLAGS)
$(richSelectionTool_OBJECTS): C++FLAGS := $(C++FLAGS) $(richSelectionTool_EXTRA_C++FLAGS)
$(richSelectionTool_OBJECTS): INCLUDES := $(INCLUDES) $(richSelectionTool_EXTRA_INCLUDES)

depend_richSelectionTool:     INCLUDES := $(INCLUDES) $(richSelectionTool_EXTRA_INCLUDES)

$(richSelectionTool_PLUGIN):  LFLAGS   := $(LFLAGS) $(richSelectionTool_EXTRA_LFLAGS) 
$(richSelectionTool_PLUGIN):  LIBS     := $(LIBS)   -lOpenMayaRender -lOpenMayaUI -lOpenMayaAnim -lOpenMaya -lFoundation $(richSelectionTool_EXTRA_LIBS) 

#
# Rules definitions
#

.PHONY: depend_richSelectionTool clean_richSelectionTool Clean_richSelectionTool


$(richSelectionTool_PLUGIN): $(richSelectionTool_OBJECTS) 
	-rm -f $@
	$(LD) -o $@ $(LFLAGS) $^ $(LIBS)

depend_richSelectionTool :
	makedepend $(INCLUDES) $(MDFLAGS) -f$(DSTDIR)/Makefile $(richSelectionTool_SOURCES)

clean_richSelectionTool:
	-rm -f $(richSelectionTool_OBJECTS)

Clean_richSelectionTool:
	-rm -f $(richSelectionTool_MAKEFILE).bak $(richSelectionTool_OBJECTS) $(richSelectionTool_PLUGIN)


plugins: $(richSelectionTool_PLUGIN)
depend:	 depend_richSelectionTool
clean:	 clean_richSelectionTool
Clean:	 Clean_richSelectionTool

