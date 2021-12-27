section .data
    extern len_cheie, len_haystack
    i	dd 0
    j   dd 0
    k	dd 0
    lines dd 0
    dec_format db "%d", 10, 0

section .text
    global columnar_transposition
    extern printf

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor eax, eax
    xor edx, edx
    ; Calculam numarul de linii ale matricei dupa formula data:
    ; nr_lines = ceil(len_haystack / len_cheie) + 1
    mov al, byte [len_haystack]
    mov dl, byte [len_cheie]
    div dl
    ; Facand operatiile de mai devreme vom avea in registrul al valoarea
    ;floor si de aceea noi adaugam 2 pentru a obtine valoarea ceil + 1
    add al, 2
    mov byte [lines], al ; Mutam intr-o variabila auxiliara in memorie numarul
    ;de linii ale matricei
    ;Acum avem in variabila lines numarul de linii ale matricei
    xor ecx, ecx
loop_i:
    mov dword [i], ecx
    xor edx, edx
loop_j:
    mov dword [j], edx
    ;Vedem daca len_key * j + key[i] < len_haystack
    xor eax, eax
    xor edx, edx
    mov ecx, dword [i]; Punem i-ul in ecx deoarece avem nevoie de el
    mov ax, word [len_cheie]; Punem in al valoarea len_cheie 
    mov dx, word [j]; Punem in al valoarea lui j
    mul dx; Facem inmultirea len_cheie * j
    add eax, dword [edi + ecx * 4]; Adunam la valoarea len_cheie * j, valoarea key[i]
    cmp eax, dword [len_haystack]; Comparam daca aceasta valoare este mai mica decat lungimea haystack-ului
    jl update; Daca este vom copia valoarea din haystack in ciphertext
    jmp continue; Daca nu este pur si simplu mergem in continuare

update:
    xor ecx, ecx
    xor edx, edx
    mov dl, byte [esi + eax]; Valoarea caracterului din plain
    mov cl, byte [k]; Pozitia la care trebuie sa introduc in ciphertext
    mov byte [ebx + ecx], dl; Adaugam la pozitia calculata valoarea caracterului din plain 
    inc cl; Incrementam valoarea lui cl
    mov dword [k], ecx; Actualizam valoarea lui k din memorie cu valoarea lui ecx
    jmp continue
    
continue:
    ;Actualizam j-ul in memorie
    mov edx, dword [j]
    inc edx
    cmp edx, dword [lines]
    jl loop_j
    ;Actualizm i-ul in memorie
    mov ecx, dword [i]
    inc ecx
    cmp ecx, dword [len_cheie]
    jl loop_i    
 
    ;Pentru ca i, j, k si lines pentru urmatorul test sa inceapa cu 0
    mov dword [i], 0
    mov dword [j], 0
    mov dword [k], 0
    mov dword [lines], 0
    
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
