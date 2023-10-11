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

section .text
    global _start

_start: 
    mov edx, 13      ; Len of "name"
    mov ecx, name    ; Message to write
    mov ebx, 1       ; stdout
    mov eax, 4       ; sys_write
    int 0x80         ; Call kernel

    mov [name], dword "John" ; If the name is not the same length it will not replace my name properly in memory

    mov edx, 13      ; Len of new "name"
    mov ecx, name    ; Message to write
    mov ebx, 1       ; stdout
    mov eax, 4       ; sys_write
    int 0x80         ; Call kernel

    mov eax, 1       ; sys_exit
    int 0x80         ; Call kernel

section .data
    name db "Alex Lastname "