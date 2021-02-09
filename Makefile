# Makefile

PROJ_NAME=sample

COMPILER=pdflatex

pdf:
	${COMPILER} ${PROJ_NAME}
	${COMPILER} ${PROJ_NAME}
	
read:
	zathura ${PROJ_NAME}.pdf &

clean:
	rm -f *.{ps,toc,log,lof,lot,aux,out,dvi,bbl,blg}