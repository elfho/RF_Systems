OKULAR=/usr/bin/okular
LATEX=/usr/bin/latex
PDFLATEX=/usr/bin/latex
DVIPDF=/usr/bin/dvipdf
DETEX=/usr/bin/detex
BIBTEX=/usr/bin/bibtex
SED=/bin/sed
SCP=/usr/bin/scp

ifndef $(OUT)
OUT=$(DOC)
endif

# this just attempts to build all the *.tex files
all:
	for i in *.tex ; do \
		echo Making $$i ; \
		make DOC=$$( echo $$i | $(SED) -e 's/\.tex$$//' ) $$i build ; \
	done ;

clean:
	rm *.aux *.dvi *.log *.out *.pdf *.blg *.bbl

build:
	$(PDFLATEX) -jobname $(OUT) -output-format=pdf "$(DEF)\input $(DOC)"
	if [ -f $(DOC).bib ] ; then $(BIBTEX) $(DOC) ; fi ;
	-$(PDFLATEX) -jobname $(OUT) -output-format=pdf "$(DEF)\input $(DOC)"
	#-$(DETEX) "$(DEF)\input $(DOC)" > $(OUT).txt
	-$(PDFLATEX) -jobname $(OUT) -output-format=pdf "$(DEF)\input $(DOC)"
	
	