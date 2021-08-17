//Alternate LEDs from Off, Green, and Red
#include <msp430.h>
#include "libTimer.h"
#include "led.h"
#include "switches.h"
#include "buzzer.h"
#include "../lcdLib/lcdutils.h"
#include "../lcdLib/lcddraw.h"
#define LED BIT6/* note that bit zero req'd for display */
short redrawScreen = 1;
char state1=1;

void wdt_c_handler(){
  static int secCount = 0;
  secCount++;

  if (secCount == 75) {
    redrawScreen=1;
    secCount=0;
    switch(state1){
    case 1: move_shape_Left(10);  state1++; break;
    case 2: move_shape_Down(10);  state1++; break;
    case 3: move_shape_Right(10); state1++; break;
    case 4: move_shape_Up(10);    state1++; break;
    default: state1=1; break;
    }
  }
}
void main(void) {
  configureClocks();   // Setup master oscillator, CPU & peripheral clocks
  switch_init();
  lcd_init();
  led_init();
  buzzer_init();

  enableWDTInterrupts();   // Enable periodic interrupt
  or_sr(0x8);   // Enable interrupts

  P1DIR |= LED;            // Green led on when CPU on
  P1OUT |= LED;
  while(1){
    if(redrawScreen){
      redrawScreen=0;
      and_sr(~8);          // Disable interrupts
      clearScreen(COLOR_WHITE);
      my_shape(my_color);
      or_sr(8);            // Enable interrupts
    }
    P1OUT &= ~LED;         // led off
    or_sr(0x10);           // CPU OFF
    P1OUT |= LED;
  }
}

