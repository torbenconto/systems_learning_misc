#!/bin/bash

# Check for the correct number of command-line arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <asm_file>"
    exit 1
fi

# Get the input ASM file name from the command-line argument
asm_file="$1"

# Check if the ASM file exists
if [ ! -f "$asm_file" ]; then
    echo "Error: ASM file '$asm_file' not found."
    exit 1
fi

# Extract the base name (without extension) of the ASM file
asm_base_name="${asm_file%.*}"

# Assemble the ASM file to create an object file
nasm -f elf "$asm_file" -o "${asm_base_name}.o"

# Check if the assembly was successful
if [ $? -ne 0 ]; then
    echo "Assembly failed."
    exit 1
fi

# Link the object file to create an executable
ld -m elf_i386 -s "${asm_base_name}.o" -o "${asm_base_name}"

# Check if the linking was successful
if [ $? -eq 0 ]; then
    echo "Build successful: ${asm_base_name}"
else
    echo "Linking failed."
    exit 1
fi

# Optionally, you can clean up the object file after linking (uncomment the next line)
# rm "${asm_base_name}.o"

exit 0
