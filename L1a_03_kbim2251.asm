; Compile:
; nasm -f win32 L1a_03_kbim2251.asm
; nlink L1a_03_kbim2251.obj -lio -o L1a_03_kbim2251.exe

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
    mov eax, str_e
    call io_writestr
    call io_readint
    mov [ve], eax
    call io_writeln
    mov eax, str_f
    call io_writestr
    call io_readint
    mov [vf], eax
    call io_writeln
    mov eax, str_g
    call io_writestr
    call io_readint
    mov [vg], eax

    ;((c - (b * a)) div (a + b))
    mov eax, [va]
    mov ebx, [vb]
    cdq
    imul ebx
    mov ecx, [vc]
    sub ecx, eax
    mov ebx, [va]
    add ebx, [vb]
    mov eax, ecx
    cdq
    idiv ebx
    push eax ; +1 stack

    ;((b + e) div c) 
    mov eax, [vb]
    add eax, [ve]
    mov ecx, [vc]
    cdq
    idiv ecx
    push eax ; +1 stack

    ;((f + g - 8) mod (g div 3)) 
    mov eax, [vf]
    add eax, [vg]
    sub eax, 8
    mov ebx, eax
    mov eax, [vg]
    mov ecx, 3
    cdq
    idiv ecx
    mov ecx, eax
    mov eax, ebx
    cdq
    idiv ecx
    push edx ;+1 stack

    ;+d

    ;gathering the results
    pop eax
    pop ebx
    pop ecx
    sub ecx, ebx
    sub ecx, eax
    add ecx, [vd]

    ;final result
    mov eax, str_r
    call io_writestr
    mov eax, ecx
    call io_writeint

    ret

section .data
    str_a db 'a = ', 0
    str_b db 'b = ', 0
    str_c db 'c = ', 0
    str_d db 'd = ', 0
    str_e db 'e = ', 0
    str_f db 'f = ', 0
    str_g db 'g = ', 0

    str_r db '((c - (b * a)) div (a + b)) - ((b + e) div c) - ((f + g - 8) mod (g div 3)) + d = ', 0

    va dd 0
    vb dd 0
    vc dd 0
    vd dd 0
    ve dd 0
    vf dd 0
    vg dd 0

section .bss