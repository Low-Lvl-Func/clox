# Compiler and Flags
CC       := gcc
CFLAGS   := -Wall -Wextra -std=c11 -pedantic -Iinclude
DEPFLAGS := -MMD -MP

# Directories
SRC_DIR   := src
BUILD_DIR := build
BIN_DIR   := bin

# Target Binary Name
TARGET    := $(BIN_DIR)/clox

# Discover all .c files in src/ and map them to .o files in build/
SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

# Default Rule
all: $(TARGET)

# Link the executable
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(OBJS) -o $@

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(DEPFLAGS) -c $< -o $@

# Create directories if they don't exist
$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Include automatically generated dependency files (.d)
-include $(DEPS)

.PHONY: all clean