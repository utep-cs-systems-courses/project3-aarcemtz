# makfile configuration
COMMON_OBJECTS  =
CPU             = msp430g2553
CFLAGS          = -mmcu=${CPU} -I../h
LDFLAGS		= -L/opt/ti/msp430_gcc/include

#switch the compiler (for the internal make rules)
CC              = msp430-elf-gcc
AS              = msp430-elf-as

all: run.elf

run.elf: ${COMMON_OBJECTS} p1_interrupt_handler.o main.o buzzer.o switches.o stateMachines.o led.o wdInterruptHandler.o ../lib/libTimer.a
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ $^
wdInterruptHandler.o: stateMachines.h
switches.o: switches.h
stateMachines.o: led.h stateMachines.h
led.o: led_s.s led.h
buzzer.o: buzzer.h

load: run.elf
	msp430loader.sh run.elf
clean:
	rm -f *.o *.elf *# *~
