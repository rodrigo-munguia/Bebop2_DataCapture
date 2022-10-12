########################################################################
####################### Makefile Template ##############################
########################################################################

OPT = -O0
# Armadillo
## As the Armadillo library uses recursive templates, compilation times depend on the level of optimisation:
##
## -O0: quick compilation, but the resulting program will be slow
## -O1: good trade-off between compilation time and execution speed
## -O2: produces programs which have almost all possible speedups, but compilation takes longer
## -O3: enables auto vectorisation when using gcc




#-------------------------------------------------------------------------------------------
# OpenCV
OPENCV_SRC_DIR := /usr/local/include/opencv4
OPENCV = `pkg-config opencv4 --cflags --libs`
OPENCVLIBRARIES = $(OPENCV)
#-------------------------------------------------------------------------------------------
# ARDroneSDK3

VISP_BUILD_DIR = /home/rodrigo/RESEARCH/visp-ws/visp-build
VISP_CFLAGS    = `$(VISP_BUILD_DIR)/bin/visp-config --cflags`
VISP_LDFLAGS   = `$(VISP_BUILD_DIR)/bin/visp-config --libs`
VISP_shared = -Wl,-rpath=/home/rodrigo/RESEARCH/visp-ws/visp-build/lib 
VISP_lib = /home/rodrigo/RESEARCH/visp-ws/visp-build/lib 

# Eigen
EIGEN_SRC_DIR := /usr/include/eigen3 # The place you unpacked or cloned Eigen.

#-------------------------------------------------------------------------------------------
# bebopcampure (this app)
LIB_DEPENDENCIES := -lpthread -lboost_system -lboost_thread



LIB_DEPENDENCIES_DIR := /usr/local/lib 
LIB_DIR := lib
LIB_INCLUDE := include
BIN		:= bin
OBJ     := obj
SRC		:= src
# Extra source code directories

CPPsrc = $(wildcard src/*.cpp) \
		 


		 

#-------------------------------------------------------------------------------------------
DEBUG = -ggdb

CXX		  := g++
CXX_FLAGS := -pthread -Wfatal-errors -g -Wall -Wextra -std=c++11 -fpermissive -static $(DEBUG) $(OPT)
 #-fpermissive

INCLUDE	:= -I$(LIB_INCLUDE) -I$(OPENCV_SRC_DIR) -I$(EIGEN_SRC_DIR)
INCLUDE2 := 
LIB		:= -L$(LIB_DIR) -L$(LIB_DEPENDENCIES_DIR) -L$(VISP_lib)


LIBRARIES	:=  $(LIB_DEPENDENCIES)  $(LIB_ARDrone_DEP) 

EXECUTABLE	:= bebop2capture



APPLICATION_OBJS = $(CPPsrc:.cpp=.o)


.PHONY: all

all: $(BIN)/$(EXECUTABLE) 



%.o: %.cpp 
		$(CXX)  -c -o  $@ $< $(CXX_FLAGS) $(INCLUDE) $(VISP_CFLAGS) 

$(BIN)/$(EXECUTABLE):$(APPLICATION_OBJS) 
		$(CXX)  -o $(BIN)/$(EXECUTABLE) $(APPLICATION_OBJS) $(VISP_shared)$(LIB) $(LIB_DEPENDENCIES)  $(OPENCVLIBRARIES) $(VISP_LDFLAGS)

$(shell   mkdir -p $(BIN))

run: clean all
	#clear
	./$(BIN)/$(EXECUTABLE)


clean: 
	-rm $(BIN)/*
	-rm $(APPLICATION_OBJS)





#SRCDIR := $(CPPsrc)
#SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
#OBJECTS     := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT)))


#$(OBJ)/%.o: %.cpp 
#		$(CXX) -c -o  $@ $< $(CXX_FLAGS) $(INCLUDE) 

#$(OBJ)/$(EXECUTABLE):$(OBJ)/*.o
#		$(CXX) $(APPLICATION_OBJS) $(LIB) $(OPENCVLIBRARIES) $(LIBRARIES) -o $(BIN)/$(EXECUTABLE)








