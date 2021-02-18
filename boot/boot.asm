[org 0x7c00]
[bits 16]

KERNEL_OFFSET equ 0x1000
mov [BOOT_DRIVE],dl

    mov bp,0x9000
    mov sp,bp

    call load_kernel
    call switch_to_pm
    jmp $

load_kernel:
    pusha
    mov bx,KERNEL_OFFSET
    mov dh,15
    mov dl,[BOOT_DRIVE]
    call disk_load
    popa
    ret

[bits 32]
begin_pm:
    call detect_lm
    call execute_kernel
    jmp $

[bits 64]
begin_lm:
    call KERNEL_OFFSET
    jmp $

execute_kernel:
    call KERNEL_OFFSET
    jmp $

%include "lm/detect_lm.asm"
%include "lm/switch_to_lm.asm"
%include "pm/switch_to_pm.asm"
%include "pm/gdt.asm"
%include "print/print_string.asm"
%include "disk/disk_load.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55
