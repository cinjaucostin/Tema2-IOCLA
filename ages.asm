; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages
    extern printf

section .data
    present_day	dw 0
    present_month dw 0
    present_year dd 0
    dec_format db "%d", 10, 0

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
 
    xor ebx, ebx
    ; Observatie: pentru day si month vom lucra cu registrii de dim 2 bytes
    ; spre exemplu ax, si pentru campul year vom lucra cu registrii de dimensiune 4 bytes adica eax.
    mov ax, word [esi + my_date.day]; Punem in ax valoarea zilei curente
    mov word [present_day], ax; Punem in variabila special definita valoarea zilei curente
    mov ax, word [esi + my_date.month]; Punem in ax valoarea lunii curente
    mov word [present_month], ax; Punem in variabila special definita pentru luna prezenta valoarea lunii curente
    mov eax, dword [esi + my_date.year]; Punem in eax valoarea anului curent
    mov dword [present_year], eax; Punem in variabila numarul anului curent

label:
    mov ax, word [edi + ebx * my_date_size + my_date.day]; punem in ax ziua de nastere
    cmp ax, word [present_day]; comparam ziua de nastere cu ziua din prezent
    jg if1; Daca ziua de nastere este mai mare decat ziua din prezent sarim la labelul if1
    jmp if2; Altfel sarim la label-ul if2

if1:
    ; Inseamna ca ziua de nastere este mai mare decat ziua curenta
    mov ax, word [present_month]; Mutam in ax luna curenta
    ; Si drept urmare, vom decrementa luna curenta
    dec ax
    mov word [present_month], ax; Actualizam valoarea din memorie a lunii curente

if2:
    ; Inseamna ca ziua de nastere este mai mica decat ziua curenta
    mov ax, word [edi + ebx * my_date_size + my_date.month]; Mutam in ax luna de nastere
    cmp ax, word [present_month]; Comparam luna de nastere cu luna curenta
    jg update; Daca luna de nastere este mai mare decat luna curenta sarim la update
    jmp calculate; Altfel sarim la calculate

update:
    ; In acest caz decrementam anul curent
    mov eax, dword [present_year]
    dec eax
    mov dword [present_year], eax

calculate:
    mov eax, dword [present_year]; Punem in eax valoarea anului curent
    cmp eax, dword [edi + ebx * my_date_size + my_date.year]; Comparam valoarea anului curent cu valoarea anului de nastere
    jl impossible; Nu se poate ca anul de nastere sa fie mai mare decat anul curent
    sub eax, dword [edi + ebx * my_date_size + my_date.year]; Scadem din anul curent anul de nastere si obtinem varsta
    mov dword [ecx + ebx * 4], eax; Adaugam varsta obtinuta in vectorul de varste
    jmp continue; Sarim la continue

impossible:
    mov dword [ecx + ebx * 4], 0
    jmp continue
  
continue:
    ; Mutam in variabile datele specifice urmatoarei structuri din vector
    mov ax, word [esi + my_date.day]
    mov word [present_day], ax
    mov ax, word [esi + my_date.month]
    mov word [present_month], ax
    mov eax, dword [esi + my_date.year]
    mov dword [present_year], eax
    inc ebx
    cmp ebx, edx; Daca nu am ajuns la capatul vectorului de structurii sarim la label pentru
    ; a relua toti pasii facuti pana acum
    jne label
 
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
