help:
	@echo try targets as:
	@echo   cl
	@echo   icl

# Compile Options
#
# /DNDEBUG (DEBUG)  builds release (debug) version of Bonanza.
# /DMINIMUM         disables some auxiliary functions that are not necessary to
#                   play a game, e.g., book composition and optimization of
#                   evaluation function.
# /DTLP             enables thread-level parallel search.
# /DMPV             enables multi-PV search.
# /DCSA_LAN         enables bonanza to talk CSA Shogi TCP/IP protcol.
# /DMNJ_LAN         enables a client-mode of distributed computing.
# /DDEKUNOBOU       enables dekunobou interface (avairable only for Windows).
# /DCSASHOGI        builds an engine for CSA Shogi (avairable only for
#                   Windows).
# /DNO_LOGGING      suppresses dumping log files.

FLAG = /DNDEBUG /DMINIMUM /DTLP /DMPV /DCSASHOGI /DNO_LOGGING

OBJS = data.obj main.obj io.obj proce.obj ini.obj utility.obj attack.obj\
       gencap.obj gennocap.obj gendrop.obj genevasn.obj mate3.obj genchk.obj\
       movgenex.obj makemove.obj unmake.obj time.obj csa.obj valid.obj\
       next.obj search.obj searchr.obj book.obj iterate.obj quiesrch.obj\
       swap.obj evaluate.obj root.obj hash.obj mate1ply.obj bitop.obj\
       rand.obj learn1.obj learn2.obj evaldiff.obj problem.obj ponder.obj\
       thread.obj dek.obj sckt.obj debug.obj phash.obj

cl:
	$(MAKE) -f Makefile.vs bonanza.exe CC="cl" LD="link"\
		CFLAGS="$(FLAG) /MT /W4 /nologo /O2 /Ob2 /Gr /GS- /GL"\
		LDFLAGS="/NOLOGO /out:bonanza.exe /LTCG"

icl:
	$(MAKE) -f Makefile.vs bonanza.exe CC="icl" LD="icl"\
		CFLAGS="/nologo $(FLAG) /Wall /O2 /Qipo /Gr"\
		LDFLAGS="/nologo /Febonanza.exe"

bonanza.exe : $(OBJS) bonanza.res
	$(LD) $(LDFLAGS) $(OBJS) bonanza.res User32.lib Ws2_32.lib

$(OBJS)  : shogi.h param.h

bonanza.res : bonanza.rc bonanza.ico
	rc /fobonanza.res bonanza.rc

.c.obj :
	$(CC) $(CFLAGS) /c $*.c

clean :
	del /q *.obj
	del /q *.res
	del /q bonanza.exe
