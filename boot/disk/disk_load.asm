[bits 16]

disk_load:
    pusha 
    push dx

    mov ah,0x02
    mov al,dh
    mov ch,0x00
    mov dh,0x00
    mov cl,0x02
    int 0x13

    jc disk_read_error

    pop dx
    cmp al,dh
    jne sectors_error

    popa
    ret

disk_read_error:
    call print_nl
    mov bx,disk_read_error_msg
    call print_string
    call print_nl
    jmp $

sectors_error:
    call print_nl
    mov bx,sectors_error_msg
    call print_string
    call print_nl
    jmp $

disk_read_error_msg: db "Disk read error!",0
sectors_error_msg: db "sector read error!",0