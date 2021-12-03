\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}[2014/08/16 Academic Paper class]

\LoadClass[12pt]{article}
\RequirePackage{fancyhdr}
\RequirePackage[breaklinks,pdfusetitle]{hyperref}
\RequirePackage{fullpage}

\let\@MyEmail\relax
\def\MyEmail#1{\def\@MyEmail{\texttt{#1}}}

\let\@MySubtitle\relax
\def\MySubtitle#1{\def\@MySubtitle{#1}}

\let\@MyTitle\relax
\def\MyTitle#1{\def\@MyTitle{#1}}

\let\@MyAuthor\relax
\def\MyAuthor#1{\def\@MyAuthor{#1}}

\title{\texorpdfstring{\vspace{-1.2 in} \@MyTitle{} \\
	\@MySubtitle}{\@MyTitle{} - \@MySubtitle}}


\author{\texorpdfstring{\@MyAuthor{} --  \@MyEmail}{\@MyAuthor{}}}

% \newcommand{\buildtitle}{
% 		\vspace{-2cm}
% 		% \vspace{-5em}
% 		\maketitle
% 		% \begin{center}
% 		\vspace{-1cm}
% 		% \end{center}
% 		% \noindent
% 		\rule{\linewidth}{0.5pt}
% }

% \pagestyle{fancy}
% \fancyhf{}
% \rhead{\@MyAuthor}
% \lhead{\@MyTitle{} -- \@MySubtitle{}}
% \fancyfoot[C]{\thepage}
% \setlength{\headsep}{0.35in}
% \setlength\parindent{0pt}