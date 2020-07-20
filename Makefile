# NAME:			Jon Lovering

avrType=atmega328p
avrFreq=16000000 # 16 Mhz

CC = avr-gcc
CFLAGS = -DF_CPU=$(avrFreq) -mmcu=$(avrType)
CFLAGS += -Wall -Werror -Wextra -std=gnu99 -Os -pedantic

LIBSOURCEDIR = source
LIBOBJDIR = libobjects
LIBOBJECTS = $(patsubst $(LIBSOURCEDIR)/%.c,$(LIBOBJDIR)/%.o,$(wildcard $(LIBSOURCEDIR)/*.c))
LIBBINARY = libavruart.a

LIBINCLUDEDIR = include

CFLAGS += -I $(LIBINCLUDEDIR)

library: $(LIBOBJDIR) $(LIBBINARY)

$(LIBOBJDIR):
	mkdir $(LIBOBJDIR)

$(LIBBINARY): $(LIBOBJECTS)
	avr-ar sr $@ $<

$(LIBOBJDIR)/%.o: $(LIBSOURCEDIR)/%.c $(LIBOBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(LIBOBJDIR) $(LIBBINARY)