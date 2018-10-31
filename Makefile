OBJS =data.o main.o io.o proce.o utility.o ini.o attack.o book.o makemove.o \
      unmake.o time.o csa.o valid.o bitop.o iterate.o searchr.o search.o \
      quiesrch.o evaluate.o swap.o  hash.o root.o next.o movgenex.o \
      genevasn.o gencap.o gennocap.o gendrop.o mate1ply.o rand.o learn1.o \
      learn2.o evaldiff.o problem.o ponder.o thread.o sckt.o debug.o mate3.o \
      genchk.o phash.o

# Compile Options
#
# -DNDEBUG (DEBUG)  builds release (debug) version of Bonanza.
# -DMINIMUM         disables some auxiliary functions that are not necessary to
#                   play a game, e.g., book composition and optimization of
#                   evaluation function.
# -DTLP             enables thread-level parallel search.
# -DMPV             enables multi-PV search.
# -DCSA_LAN         enables bonanza to talk CSA Shogi TCP/IP protcol.
# -DMNJ_LAN         enables a client-mode of cluster computing.
# -DNO_LOGGING      suppresses dumping log files.

OPT =-DNDEBUG -DMINIMUM -DTLP -DCSA_LAN -DMNJ_LAN -DXBOARD -DMPV

help:
	@echo "try targets as:"
	@echo
	@echo "  gcc"
	@echo "  icc"

gcc:
	$(MAKE) CC=gcc CFLAGS='-std=gnu99 -O3 -Wall $(OPT)' LDFLAG1='-lm -lpthread' bonanza

icc:
	$(MAKE) CC=icc CFLAGS='-w2 $(OPT) -std=gnu99 -O2 -ipo' LDFLAG1='-static -ipo -pthread' bonanza

bonanza : $(OBJS)
	$(CC) -o bonanza $(OBJS) $(LDFLAG1) $(LDFLAG2)

$(OBJS) : shogi.h param.h

.c.o :
	$(CC) -c $(CFLAGS) $*.c

clean :
	rm *.o
	rm -fr profdir
	rm bonanza
