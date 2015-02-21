##################################################
#Sunday, 31.August.2014 made by Lars C. Schwensen#
##################################################

#################################################################
#This is a standard makefile to compile and flash an ATmega8    #
#on an OLIMEX p-28 development board.                           #
#The programmer is an USBPROG which works as an avrispmkII clone#
#################################################################

#the µC device
MCU=atmega8

#the name of the finally output file
OUTPUTNAME=pr0gramm

#the format of the finally output file
OUTPUTFORMAT=ihex

#all the project files
#REPLACE THESE FILES WITH YOUR PROJECT FILES!!!!
PRJSRC=main.c uart.c 

#project files as .o files
OBJECTS= $(PRJSRC:.c=.o)

#additional includes
INCLUDES=
LIBRARIES=
#optimization level between (s0 (zero) and s3 (maximum))
OPTIMIZE=s

#the Programmer
PROGRAMMER=avrispmkII
CONNECTION=usb

#compilerflags
CFLAGS= -mmcu=$(MCU) -O$(OPTIMIZE)

#linkerflags
LDFLAGS= 

#executables
CC=/opt/avr8-gnu-toolchain-linux_x86_64/bin/avr-gcc
OBJCOPY=/opt/avr8-gnu-toolchain-linux_x86_64/bin/avr-objcopy
AVRDUDE=avrdude

all: $(OUTPUTNAME).hex clean flash

#create the hex file
$(OUTPUTNAME).hex : $(OUTPUTNAME).elf
	$(OBJCOPY)  -j .text -j .data -O $(OUTPUTFORMAT) $(OUTPUTNAME).elf $(OUTPUTNAME).hex

#link the object files 
$(OUTPUTNAME).elf: $(OBJECTS)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(OUTPUTNAME).elf $(LDFLAGS) $(OBJECTS)

#create object files
.c.o: 
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

#flash the µC
flash:
	sudo $(AVRDUDE) -F -V -c $(PROGRAMMER) -p ATmega8 -P $(CONNECTION) -U flash:w:$(OUTPUTNAME).hex

#set internal 8MHZ
fuse8:
	sudo $(AVRDUDE) -c $(PROGRAMMER) -p ATmega8 -U lfuse:w:0xe4:m -U hfuse:w:0xd9:m 

#set internal 4MHZ
fuse4:
	sudo $(AVRDUDE) -c $(PROGRAMMER) -p ATmega8 -U lfuse:w:0xe3:m -U hfuse:w:0xd9:m 

#set internal 1MHZ
fuse1:
	sudo $(AVRDUDE) -c $(PROGRAMMER) -p ATmega8 -U lfuse:w:0xe1:m -U hfuse:w:0xd9:m 

clean:
	rm -f *.o
	rm -f *.elf
