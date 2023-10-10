section .data:
    message db "Hello, World!", 0xa
    len equ $ - message


section .text:
    global _start

_start:
    mov edx,len     ; Message Length
    mov ecx,message ; Message to Write
    mov ebx,1       ; Stdout
    mov eax,4       ; System_write call number
    int 0x80        ; Call Kernel

    mov eax,1       ; Sys exit
    int 0x80         ; Call Kernel