; Compile:
; nasm -f win32 L1b_03_kbim2251.asm
; nlink L1b_03_kbim2251.obj -lio -o L1b_03_kbim2251.exe

%include 'io.inc'

global main 

section .text
main:
    mov eax, str_a
    call io_writestr
    call io_readint
    mov [va], eax
    call io_writeln
    mov eax, str_b
    call io_writestr
    call io_readint
    mov [vb], eax
    call io_writeln
    mov eax, str_c
    call io_writestr
    call io_readint
    mov [vc], eax
    call io_writeln
    mov eax, str_d
    call io_writestr
    call io_readint
    mov [vd], eax
    call io_writeln

    ;(NOT(b XOR a)) -- A
    mov eax, [va]
    mov ebx, [vb]
    XOR eax, ebx
    NOT eax
    push eax ; +1 stack

    ;(c XOR(b AND d)) -- B
    mov eax, [vb]
    mov ebx, [vd]
    AND eax, ebx
    mov ecx, [vc]
    XOR ecx, eax
    push ecx ; +1 stack

    ;A OR B
    pop eax
    pop ebx
    OR eax, ebx
    push eax ; stack: 1

    mov eax, str_r
    call io_writestr
    pop eax
    call io_writebin

    ret

section .data

    va dd 0
    vb dd 0
    vc dd 0
    vd dd 0

    str_a db 'a = ', 0
    str_b db 'b = ', 0
    str_c db 'c = ', 0
    str_d db 'd = ', 0
    str_r db '(NOT(b XOR a)) OR(c XOR(b AND d)) = ', 0

section .bss