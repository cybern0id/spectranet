;The MIT License
;
;Copyright (c) 2008 Dylan Smith
;
;Permission is hereby granted, free of charge, to any person obtaining a copy
;of this software and associated documentation files (the "Software"), to deal
;in the Software without restriction, including without limitation the rights
;to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;copies of the Software, and to permit persons to whom the Software is
;furnished to do so, subject to the following conditions:
;
;The above copyright notice and this permission notice shall be included in
;all copies or substantial portions of the Software.
;
;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;THE SOFTWARE.

;---------------------------------------------------------------------------
; do_callbas
; Not really a trap, but it handles the effects of an RST 0x10 'callbas'
; exit (which will get re-trapped by a subsequent return via RST 8)
do_callbas
	ld e, (hl)		; Get the subroutine address into DE
	inc hl
	ld d, (hl)
	inc hl			; hl now is the return address
	push hl			; put the return address back on the stack
	ld hl, 0		; entry code to RST 8
	push hl
	ld hl, 8		; return address for Spectrum ROM to return
	push hl
	push de			; the actual address in ROM we want to call
	ld hl, (v_hlsave)	; restore HL
	ld de, (v_desave)	; restore de
	jp UNPAGE		; page out

;---------------------------------------------------------------------------
; do_rst8
; Figure out what needs to be done when an RST 8 trap occurs.
do_rst8
	ld (v_hlsave), hl	; save hl without disturbing stack
	pop hl			; get stack value - entry code
	push af
	ld a, h			; check for zero - Spectrum ROM routine return
	or l
	jr z, .returnfromzxrom	; returning from a Spectrum ROM call
	
	; The call to the interpreter would end up here.
	; For now just reshuffle the stack so we can pass control back
	; to the ZX rom.
	pop af
	push hl			; put the code back on the stack
	ld hl, 0x000B		; address to return to
	push hl			; stack it for the RET at UNPAGE
	ld hl, (ZX_CH_ADD)	; do the same as the first RST 8 instruction
	jp UNPAGE		; re-enter the ZX ROM

.returnfromzxrom
	pop af			; restore af
	ld hl, (v_hlsave)	; restore hl
	ret			; go back to the calling routine.

