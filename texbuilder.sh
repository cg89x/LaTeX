# @Author: ChristianKontz
# @Date:   2020-11-23 14:30:36
# @Last Modified by:   Christian Kontz
# @Last Modified time: 2021-04-25 16:48:47
function tex_pdf {
	compiler=xelatex
	
	if grep -E -q 'pycode|.jl|svg' $1.tex; then
		printf "\nStep 1/3 - Compiling TeX file... (using $compiler) \n"
		$compiler -halt-on-error -interaction=nonstopmode -shell-escape $1.tex > $1.txt 
		grep '^!.*' --color=never $1.txt

		if grep -q 'pycode' $1.tex; then
			printf "\nMaking a quick stop to compile embedded Python code... \n"
			pythontex --interpreter python:/opt/anaconda3/bin/python $1.tex

			$compiler -halt-on-error -interaction=nonstopmode -shell-escape $1.tex > $1.txt
			grep '^!.*' --color=never $1.txt
		fi

		if ls | grep -q '.bib'; then 
			printf "\nStep 2/3 - Compiling BibTeX...\n"
			bibtex $1.aux > $1.txt
			grep '^!.*' --color=never $1.txt

			printf "\nStep 3/3 - Compiling TeX file again... \n"
			$compiler -halt-on-error -interaction=nonstopmode -shell-escape $1.tex > $1.txt
			grep '^!.*' --color=never $1.txt
		else
			printf "\nSkipping Step 2 and 3 - b/c no .bib file found \n"
		fi

		# printf "\nStep 4/4 - Compiling TeX file again... \n"
		# $compiler -halt-on-error -interaction=nonstopmode -shell-escape $1.tex > $1.txt
		# grep '^!.*' --color=never $1.txt
	else
		printf "\nStep 1/3 - Compiling TeX file... (using pdflatex)"
		pdflatex -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
		if ls | grep -q '.bib'; then 
			printf "\nStep 2/3 - Compiling BibTeX..."
			bibtex $1.aux > $1.txt
			printf "\nStep 3/3 - Compiling TeX file again... "
			pdflatex -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
			# pdflatex -synctex=1 -interaction=nonstopmode $1.tex > $1.txt
		fi
		grep '^!.*' --color=never $1.txt
	fi

	rm -f $1.fdb_latexmk $1.out $1.fls $1.txt
}
export tex_pdf