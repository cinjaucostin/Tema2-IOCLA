section .text
    global rotp
    extern printf

section .data
    dec_format db "%d", 10, 0
   
;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE
    xor ebx, ebx
    dec ecx
label:
    mov al, byte [esi + ebx]; mutam in eax ce avem in plaintext[ebx]
    mov [edx + ebx], al; mutam in ciphertext ce avem in plaintext[ebx]
    mov al, byte [edi + ecx]; mutam in eax ce avem in key[ecx]   
    xor [edx + ebx], al; facem xor intre ciphertext[ebx] si key[ecx]
    inc ebx; Incrementam ebx-ul
    loop label

    ;Mai facem o data operatia din label pentru a actualiza si ultimul
    ;caracter din cipertext(pentru ebx = len -1 si ecx = 0)
    mov al, byte [esi + ebx]
    mov [edx + ebx], al
    mov al, byte [edi + ecx]
    xor [edx + ebx], al

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
