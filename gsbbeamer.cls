% @Author: ChristianKontz
% @Date:   2021-01-13 08:39:47
% @Last Modified by:   ChristianKontz
% @Last Modified time: 2021-01-13 09:42:38

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gsbbeamer}[2014/08/16 GSB beamer class]
\LoadClass{beamer}

\hypersetup{
	% pdfusetitle,
	breaklinks,
	colorlinks,
	linkcolor={red!50!black},
	citecolor={blue!50!black},
	urlcolor={blue!80!black},
}

\RequirePackage{appendixnumberbeamer}
\RequirePackage[absolute,overlay]{textpos}

\definecolor{cardinal}{HTML}{8C1515}

\mode<presentation>
{  \usetheme{CambridgeUS} % AnnArbor | Antibes | Bergen | Berkeley | Berlin | Boadilla | boxes | CambridgeUS | default | Dresden | Warsaw | Rochester
	\useinnertheme{circles} % circles | default | inmargin | rectangles | rounded
	
	\usecolortheme{beaver} % albatross | beaver | beetle | crane | default | dolphin | dove | fly | lily | orchid |rose |seagull | seahorse
	\usefonttheme{default} % default | professionalfonts | serif | structurebold | structureitalicserif | structuresmallcapsserif
	% \useoutertheme{infolines} % default | infolines | miniframes | shadow | sidebar | smoothbars | smoothtree | split | tree
	\useoutertheme[subsection=false]{smoothbars}
	
	% transparent overlays only for uncover, alternatively use visible
	\setbeamercovered{transparent}
	% turn off navigation elements
	\beamertemplatenavigationsymbolsempty

	% \setbeamercolor{palette primary}{bg=cardinal,fg=white}
	% \setbeamercolor{palette secondary}{bg=cardinal,fg=white}
	% \setbeamercolor{palette tertiary}{bg=cardinal,fg=white}
	% \setbeamercolor{palette quaternary}{bg=cardinal,fg=white}

	\setbeamercolor{section in head/foot}{bg=cardinal,fg=white}
	\setbeamercolor{section in sidebar}{bg=cardinal,fg=white}
	\setbeamercolor{section in sidebar shaded}{bg=cardinal,fg=white}
	\setbeamercolor{section name}{bg=cardinal,fg=white}
	\setbeamercolor{author in head/foot}{bg=cardinal,fg=white}
	
	\setbeamercolor{subsection in head/foot}{fg=cardinal}
	\setbeamercolor{subsection in sidebar}{fg=cardinal}
	\setbeamercolor{subsection in sidebar shaded}{fg=cardinal}
	
	\setbeamercolor{frametitle}{fg=cardinal}
	\setbeamercolor{title}{fg=cardinal}
	\setbeamercolor{section name}{fg=white}

	\setbeamercolor{itemize item}{fg=cardinal}

	\setbeamertemplate{itemize item}[square]
	\setbeamercolor{itemize subitem}{fg=cardinal}
	\setbeamertemplate{itemize subitem}[triangle]

	\setbeamertemplate{enumerate items}[circle]
	\setbeamercolor{item projected}{fg=white,bg=cardinal}
	\setbeamercolor{enumerate item}{fg=cardinal,bg=black}
	\setbeamercolor{enumerate subitem}{fg=cardinal,bg=black}

	\setbeamertemplate{items}[fg=cardinal]
	\setbeamertemplate{local structure}[fg=cardinal]
}

\let\@MyEmail\relax
\def\MyEmail#1{\def\@MyEmail{\vspace{0.5em} \footnotesize {\texttt{#1}}}}

\let\@MySubtitle\relax
\def\MySubtitle#1{\def\@MySubtitle{#1}}

\let\@MyTitle\relax
\def\MyTitle#1{\def\@MyTitle{#1}}

\let\@BottomTitle\relax
\def\BottomTitle#1{\def\@BottomTitle{#1}}

\let\@MyInstitute\relax
\def\MyInstitute#1{\def\@MyInstitute{#1}}

\let\@MyAuthor\relax
\def\MyAuthor#1{\def\@MyAuthor{#1}}

\let\@BottomAuthor\relax
\def\BottomAuthor#1{\def\@BottomAuthor{#1}}

\title[\@BottomTitle{}]{\texorpdfstring{\@MyTitle{}}{\@MyTitle{} - \@MySubtitle}}

\subtitle[\@MySubtitle]{\@MySubtitle}

\author[\@BottomAuthor{}]{\texorpdfstring{\@MyAuthor{} \\ \@MyInstitute{} \\ \@MyEmail}{\@MyAuthor{}}}

\newcommand{\unilogo}{
  \setlength{\TPHorizModule}{1pt}
  \setlength{\TPVertModule}{1pt}
   % textblock{}{x,y}: pos(x) = leftUpperCorner + (x * \TPHorizModule), pos(y) = leftUpperCorner - (y * \TPVertModule)
  \begin{textblock}{1}(303.5,16)
   \includegraphics[scale=0.1525]{gsb-logo2}
  \end{textblock}
  } 

\newenvironment{myframe}{
	\setbeamercolor{page number in head/foot}{fg=cardinal}
	\setbeamercolor{section in head/foot}{fg=white}
	\begin{frame}{\subsecname}
		\unilogo
	}{
	\end{frame}
}

\newenvironment{myitems}{
	\itemize\addtolength{\itemsep}{10pt}}
	{\enditemize
}

\newenvironment{myenums}{
	\enumerate\addtolength{\itemsep}{10pt}
	}
	{\endenumerate
}


\pdfstringdefDisableCommands{%
	  \let\color\empty % no warning for using color in sections
}

\newcommand{\white}{\color{white}}
\newcommand{\cardinal}{\color{white}}
\newcommand{\black}{\color{black}}

%% automatic section title slide before each new section starts
\newcommand\mytableofcontents{%
   \begingroup
   \def\beamer@writeslidentry{\clearpage\beamer@notesactions}%
   \setbeamercolor{page number in head/foot}{fg=date in head/foot.bg}
   \frame{%
	  \frametitle{\subsubsecname}%
	  \unilogo
	   \vfill
		\centering
		\addtocounter{framenumber}{-1}
		\begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{author in head/foot}
		\usebeamerfont{title}\insertsectionhead\par%
		\end{beamercolorbox}
		\vfill
   }%
   \endgroup
}
\let\orig@section\section
\renewcommand\section[1]{\orig@section{#1}\mytableofcontents}


\newcommand{\mytitlepage}{
	\setbeamercolor{page number in head/foot}{fg=date in head/foot.bg}
	\begin{frame}[noframenumbering]{\subsecname}
		\titlepage
		\unilogo
	\end{frame}
}