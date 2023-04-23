[ORG 0x7C00]

section .data
  count db 10 ; número de iterações do loop
  msg db "HELLO, USER", 0Ah ; mensagem a ser exibida
  msglen equ $-msg ; tamanho da mensagem

section .bss
  buffer resb 256 ; buffer para armazenar a mensagem

section .text
  global _start
  
_start:
  ; Configuração do segmento de dados
  mov ax, 0x9000 ; Endereço de destino do segmento de dados
  mov ds, ax
  mov es, ax
  
  ; Início do loop
  mov ecx, [count]
loop_start:
  cmp ecx, 0
  je loop_end ; salta para o final do loop se o contador for zero
  dec ecx ; decrementa o contador
  ; Escreve a mensagem no buffer
  mov ebx, buffer ; endereço do buffer
  mov eax, msg ; endereço da mensagem
  mov edx, msglen ; tamanho da mensagem
  mov ecx, ebx ; copia o endereço do buffer para ECX
  rep movsb ; copia a mensagem para o buffer
  ; Escreve o conteúdo do buffer no console
  mov eax, 4 ; chamada do sistema 'write'
  mov ebx, 1 ; arquivo de saída padrão (stdout)
  mov ecx, buffer ; endereço do buffer
  int 0x80 ; chama a função do sistema
  jmp loop_start ; volta para o início do loop

loop_end:
  ; Encerra o programa
  mov eax, 1 ; chamada do sistema 'exit'
  xor ebx, ebx ; código de saída = 0
  int 0x80 ; chama a função do sistema
