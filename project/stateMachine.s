
	#include "lcddraw.h"
	#include "switches.h"
	#include "lcdutils.h"
	#include "stateMachines.h"
	#include "buzzer.h"

	
	.arch msp430g2553
	.p2align 1,0
	.text
	.global state_advance
	.global state
	.extern move_shape_Left
	.extern move_shape_Right
	.extern clearScreen
	.extern my_color
	.extern COLOR_RED
	.extern COLOR_YELLOW
	.extern COLOR_MAGENTA
	.extern COLOR_BLUE
	.data
state:
	.word 0
jt:
	.word default
	.word case_1
	.word case_2
	.word case_3
	.word case_4
	.word end
state_advance:
	mov &state, r12		;MOVES STATE INTO REGISTER 12
	add r12, r12		;DOUBLE FOR WORDS IN SEQUENCE
	mov jt(r12), r0		;INDEXES JT TABLE IN REGISTER 0
default:
	mov #1, &state
case_1:
	mov #10, r12
	mov &COLOR_BLUE, &my_color
	call #move_shape_Left
	mov 0x0c8e, r12
	call #buzzer_set_period
	jmp end
case_2:
	mov #10, r12
	mov &COLOR_RED, &my_color
	call #move_shape_Right
	mov 0x09f7,r12
	call #buzzer_set_period
	jmp end
case_3:
	mov 0x001f, r12
	mov &COLOR_YELLOW, &my_color
	call #clearScreen
	mov 0x0eee, r12
	call #buzzer_set_period
	jmp end
case_4:
	mov 0x001f, r12
	mov &COLOR_MAGENTA, &my_color
	call #clearScreen
	mov #0, r12
	call #buzzer_set_period
	jmp end
end:
	pop r0
