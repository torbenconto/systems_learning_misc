;
; Copyright (c) 2023 Torben Conto
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
; THE SOFTWARE.
;

; Table of system calls
; %eax 	Name 	%ebx 	%ecx 	%edx 	%esx 	%edi
; 1 	sys_exit 	int 	- 	- 	- 	-
; 2 	sys_fork 	struct pt_regs 	- 	- 	- 	-
; 3 	sys_read 	unsigned int 	char * 	size_t 	- 	-
; 4 	sys_write 	unsigned int 	const char * 	size_t 	- 	-
; 5 	sys_open 	const char * 	int 	int 	- 	-
; 6 	sys_close 	unsigned int 	- 	- 	- 	-
;
section .data
    inputMsg db "Enter a number: "
    lenInputMsg equ $ - inputMsg

    outputMsg db "You have entered: "
    lenOutputMsg equ $ - outputMsg

section .bss
    num resb 5

section .text
    global _start

_start:
    mov edx, lenInputMsg  ; Input Message Length
    mov ecx, inputMsg     ; Message to Write
    mov ebx, 1            ; Stdout
    mov eax, 4            ;                     Syscall 4 = sys_write
    int 0x80              ; Call Kernel

    mov edx, 5            ; Len of Number
    mov ecx, num          ; Write to "num" which is 5 reserved bytes
    mov ebx, 2            ; Stdin
    mov eax, 3            ;                     Syscall 3 = sys_read
    int 0x80              ; Call Kernel
    
    mov edx, lenOutputMsg ; Output Message Length
    mov ecx, outputMsg    ; Message to Write
    mov ebx, 1            ; Stdout
    mov eax, 4            ;                     Syscall 4 = sys_write
    int 0x80              ; Call Kernel
    
    mov edx, 5            ; Len of num (num in .bss is 5 so 5) 
    mov ecx, num          ; Message to write (num)
    mov ebx, 1            ; Stdout
    mov eax, 4            ;                     Syscall 4 = sys_write
    int 0x80              ; Call Kernel

    mov eax, 1            ;                     Syscall 1 = sys_exit
    mov ebx, 0
    int 0x80