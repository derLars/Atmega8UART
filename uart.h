//##################################################
//#Friday, 09.Januar.2014 made by Lars C. Schwensen#
//##################################################

//#################################################################
//#This file handles the UART functionality                       #
//#DEVICE: atmega8                                                #
//#DEVELOPMENT BOARD: OLIMEX P-28                                 #
//#PROGRAMMER: USBPROG (avrispmkII clone)                         #
//#################################################################

//uart.h

#include <stdint.h>

#ifndef F_CPU
#define F_CPU 				1000000UL
#endif

#define BAUD				4800L

#define UBRR_VALUE ((F_CPU+BAUD*8)/(BAUD*16)-1)

void initUart(void);

void sendChar(uint8_t character);

uint8_t receiveChar(void);