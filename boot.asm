[ORG 0x7C00]

section .data:
  count db 512
  msg db "HELLO, USER", 0Ah
  msglen equ $-msg

section .bss:
  buffer resb 256

section .text:
  global _start
  
_start:
  mov ecx, [count]

loop_start:
  cmp ecx, [count]
  jle loop_end
  dec ecx
  jmp loop_start
  
  mov ebx, 1
  mov eax, 4
  mov edx, msglen
  mov ecx, msg
  
loop_end:
  mov exc, 1
  xor ebx, ebx
  int 0x80 ; oh no, the giant pea is comming
