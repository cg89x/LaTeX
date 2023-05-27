# @Author: Christian Kontz
# @Date:   2023-05-27 13:24:42
# @Last Modified by:   Christian Kontz
# @Last Modified time: 2023-05-27 13:24:52

function tex_pdf {
	compiler=xelatex
	# compiler=lualatex

	# if grep -E -q 'gemini' $1.tex; then
	if grep -E -q 'gemixiXXXXXxx' $1.tex; then
		latexmk -pdflatex='lualatex -interaction nonstopmode' -pdf $1.tex
		# latexmk -pdf -C
		# $compiler -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 $1.tex > $1.txt 
	elif grep -E -q 'gemini|pycode|.jl|svg' $1.tex; then
		printf "\nStep 1/3 - Compiling TeX file... (using $compiler) \n"
		$compiler -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 $1.tex > $1.txt 
		grep '^!.*' --color=never $1.txt

		if grep -q 'pycode' $1.tex; then
			printf "\nMaking a quick stop to compile embedded Python code... \n"
			pythontex --interpreter python:/opt/anaconda3/bin/python $1.tex

			$compiler -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 $1.tex > $1.txt
			grep '^!.*' --color=never $1.txt
		fi

		if ls | grep -q '.bib'; then 
			printf "\nStep 2/3 - Compiling BibTeX...\n"
			bibtex $1.aux > $1.txt
			grep '^!.*' --color=never $1.txt

			printf "\nStep 3/3 - Compiling TeX file again... \n"
			$compiler -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 $1.tex > $1.txt
			grep '^!.*' --color=never $1.txt
		else
			printf "\nSkipping Step 2 and 3 - b/c no .bib file found \n"
		fi

		# printf "\nStep 4/4 - Compiling TeX file again... \n"
		# $compiler -halt-on-error -interaction=nonstopmode -shell-escape -synctex=1 $1.tex > $1.txt
		# grep '^!.*' --color=never $1.txt
	else
		printf "\nStep 1/3 - Compiling TeX file... (using pdflatex)"
		pdflatex -shell-escape -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
		if ls | grep -q '.bib'; then 
			printf "\nStep 2/3 - Compiling BibTeX..."
			bibtex $1.aux > $1.txt
			printf "\nStep 3/3 - Compiling TeX file again... "
			pdflatex -shell-escape -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
			# pdflatex -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
		fi
		grep '^!.*' --color=never $1.txt
	fi

	rm -f $1.fdb_latexmk $1.out $1.fls $1.txt
}
export tex_pdf