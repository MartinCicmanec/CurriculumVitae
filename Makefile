filename=en_martin_cicmanec_cv
filename_cz=cz_martin_cicmanec_cv

pdf: ps
	ps2pdf ${filename}.ps
	ps2pdf ${filename_cz}.ps

pdf-print: ps
	ps2pdf -dColorConversionStrategy=/LeaveColorUnchanged -dPDFSETTINGS=/printer ${filename}.ps
	ps2pdf -dColorConversionStrategy=/LeaveColorUnchanged -dPDFSETTINGS=/printer ${filename_cz}.ps

text: html
	html2text -width 100 -style pretty ${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt
	html2text -width 100 -style pretty ${filename_cz}/${filename_cz}.html | sed -n '/./,$$p' | head -n-2 >${filename_cz}.txt

html:
	@#latex2html -split +0 -info "" -no_navigation ${filename}
	htlatex ${filename}
	@#latex2html -split +0 -info "" -no_navigation ${filename_cz}
	htlatex ${filename_cz}

ps:	dvi
	dvips -t letter ${filename}.dvi
	dvips -t letter ${filename_cz}.dvi

dvi:
	latex ${filename}
	bibtex ${filename}||true
	latex ${filename_cz}
	bibtex ${filename_cz}||true

read:
	evince ${filename}.pdf &
	evince ${filename_cz}.pdf &

aread:
	acroread ${filename}.pdf
	acroread ${filename_cz}.pdf

clean:
	rm -f ${filename}.ps ${filename}.pdf ${filename}.log ${filename}.aux ${filename}.out ${filename}.dvi ${filename}.bbl ${filename}.blg
	rm -f ${filename_cz}.ps ${filename_cz}.pdf ${filename_cz}.log ${filename_cz}.aux ${filename_cz}.out ${filename_cz}.dvi ${filename_cz}.bbl ${filename_cz}.blg