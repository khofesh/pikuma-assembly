    processor 6502

    seg code
    org $F000       ;define the code origin at $F000

Start:
    sei             ;disable interrupts
    cld             ;disable the BCD (binary-coded decimal) decimal math mode
    ldx #$FF        ;loads the X register with #$FF
    txs             ;transfer the X register to the stack pointer (s)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clean the page zero region ($00 to $FF)
; that means the entire RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0          ;A = 0
    ldx #$FF        ;X = #$FF
MemLoop:
    dex             ;X--
    sta $0,X        ;store the value of A inside memory address $0 + X
    bne MemLoop     ;loop until X is equal to zero (or until z-flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start     ;reset vector at $FFFC (where the program starts)
    .word Start     ;interrupt vector at $FFFE (unused in the VCS)