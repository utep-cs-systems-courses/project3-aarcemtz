# makfile configuration
COMMON_OBJECTS  =
CPU             = msp430g2553
CFLAGS          = -mmcu=${CPU} -Os -I../h
LDFLAGS		= -L../lib -L/opt/ti/msp430_gcc/include

#switch the compiler (for the internal make rules)

CC              = msp430-elf-gcc
AS              = msp430-elf-gcc -mmcu=${CPU} -c
all: run.elf

run.elf: ${COMMON_OBJECTS} wdt_handler.o p1_interrupt_handler.o main.o buzzer.o switches.o stateMachines.o led.o ../lib/libTimer.a
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ $^ -lTimer -lLcd

#wdInterruptHandler.o: stateMachines.h
switches.o: switches.h stateMachine.s
stateMachines.o: stateMachine.s stateMachines.h
led.o: led_s.s led.h
buzzer.o: buzzer.h

load: run.elf
	msp430loader.sh run.elf
clean:
	rm -f *.o *.elf *# *~
