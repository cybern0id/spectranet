;The MIT License
;
;Copyright (c) 2009 Dylan Smith
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
.include	"defs.inc"
.include	"spectranet.inc"
.text
;-----------------------------------------------------------------------------
; F_init: Initializes the interpreter
.globl F_init
F_init:
        ld hl, PARSETABLE
        ld b, NUMCMDS
.loop1:
        push bc
        call ADDBASICEXT
        pop bc
        jr c, .installerror1
        djnz .loop1
        ld hl, STR_basicinit
        call PRINT42
        ret
.installerror1:
        ld hl, STR_basinsterr
        call PRINT42
        ret

NUMCMDS		equ 9
STREAMPAGE	equ 0xFF		; This ROM
PARSETABLE:
P_connect:	defb	0x0b
		defw	CMD_CONNECT
		defb	STREAMPAGE
		defw	F_connect

P_close:		defb	0x0b
		defw	CMD_CLOSE
		defb	STREAMPAGE
		defw	F_close

P_listen:	defb	0x0b
		defw	CMD_LISTEN
		defb	STREAMPAGE
		defw	F_listen

P_accept:	defb	0x0b
		defw	CMD_ACCEPT
		defb	STREAMPAGE
		defw	F_accept
		
P_fopen:		defb	0x0b
		defw	CMD_FOPEN
		defb	STREAMPAGE
		defw	F_fopen

P_opendir:	defb	0x0b
		defw	CMD_OPENDIR
		defb	STREAMPAGE
		defw	F_opendir

P_oneof:		defb 	0x0b
		defw	CMD_ONEOF
		defb	STREAMPAGE
		defw	F_oneof

P_reclaim:	defb	0x0b
		defw	CMD_RECLAIM
		defb	STREAMPAGE
		defw	F_reclaim

P_ctrl:		defb	0x0b
		defw	CMD_CONTROL
		defb	STREAMPAGE
		defw	F_ctrl

CMD_CONNECT:	defb	"%connect",0
CMD_CLOSE:	defb	"%close",0
CMD_LISTEN:	defb	"%listen",0
CMD_ACCEPT:	defb	"%accept",0
CMD_FOPEN:	defb	"%fopen",0
CMD_OPENDIR:	defb	"%opendir",0
CMD_ONEOF:	defb	"%oneof",0
CMD_RECLAIM:	defb	"%reclaim",0
CMD_CONTROL:	defb	"%control",0

