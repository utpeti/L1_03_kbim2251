; Compile:
; nasm -f win32 L1c_03_kbim2251.asm
; nlink L1c_03_kbim2251.obj -lio -o L1c_03_kbim2251.exe

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

    ;d mod 4 = ?: determines the exercise (0/1/2/3)
    mov eax, [vd]
    mov ebx, 4
    cdq
    div ebx

    cmp edx, 0
    je mod0

    cmp edx, 1
    je mod1

    cmp edx, 2
    je mod2

    cmp edx, 3
    je mod3


mod0: ;if d mod 4 = 0 : (b - a) * 3
    mov eax, [va]
    mov ebx, [vb]
    sub ebx, eax
    mov eax, ebx
    mov ecx, 3
    cdq
    imul ecx
    push eax ; +1 stack
    mov eax, str_r1
    jmp exit

mod1: ;if d mod 4 = 1 : 17 - a
    mov eax, 17
    sub eax, [va]
    push eax ; +1 stack
    mov eax, str_r2
    jmp exit

mod2: ;if d mod 4 = 2 : (9 - b) div c
    mov eax, 9
    sub eax, [vb]
    mov ebx, [vc]
    cdq
    idiv ebx
    push eax ; +1 stack
    mov eax, str_r3
    jmp exit

mod3: ;if d mod 4 = 3 : c * (c - b)
    mov eax, [vc]
    sub eax, [vb]
    mov ebx, [vc]
    cdq
    imul ebx
    push eax ; +1 stack
    mov eax, str_r4

exit:
    call io_writestr
    pop eax
    call io_writeint

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

    str_r1 db '(b - a) * 3 = ', 0
    str_r2 db '17 - a = ', 0
    str_r3 db '(9 - b) div c = ', 0
    str_r4 db 'c * (c - b) = ', 0

section .bss