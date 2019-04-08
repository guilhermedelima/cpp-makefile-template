INC_DIR = include
SRC_DIR = src
DEP_DIR = dep
OBJ_DIR = obj
BIN_DIR = bin

CXX      = g++
CXXFLAGS = -I$(INC_DIR) -W -Wall
RM       = rm -rf --preserve-root

OBJ_FILES = $(foreach file,$(shell ls $(SRC_DIR)),$(OBJ_DIR)/$(file:.cpp=.o))
DEP_FILES = $(foreach file,$(shell ls $(SRC_DIR)),$(DEP_DIR)/$(file:.cpp=.d))

PROJECT_NAME = app
APP_FILE     = $(BIN_DIR)/$(PROJECT_NAME)

.PHONY: all clean

all: $(APP_FILE)

$(APP_FILE): $(OBJ_FILES) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^

$(DEP_DIR) $(OBJ_DIR) $(BIN_DIR):
	mkdir $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(DEP_DIR) $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -MM -MT $@ -MP -MF $(DEP_DIR)/$*.d $<
	$(CXX) $(CXXFLAGS) -o $@ -c $<

-include $(DEP_FILES)

clean:
	$(RM) $(BIN_DIR) $(OBJ_DIR) $(DEP_DIR)
