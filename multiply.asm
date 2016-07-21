; multiply two 8-bit numbers
; input: %1, %2 - multipliers
; output: result in registers x,y (LO, HIGH)
; example: "multiple 200,3" produces X=$58, Y=$02 (result $0258=600)
    .macro multiply
    lda #0
    ldx #0
    ldy #0
    sta mul1 + 1
    lda #%1
    sta mul1 ; store 1st multiplier
    lda #%2
    sta mul2 ; store 2nd multiplier
start    
    lda mul2 
    beq end; ; 2nd number is exhausted
    lsr mul2
    bcc multtwo ; only multiply if significant bit is 0
    ; bit from last binary base == 1, add result to sum
    txa
    clc
    adc mul1
    tax
    tya
    adc mul1 + 1
    tay
multtwo
    ; multiply 1st number by 2
    asl mul1
    rol mul1 + 1
    bcc start ; always jump
mul1 .ds 2
mul2 .ds 1
end
    .endm