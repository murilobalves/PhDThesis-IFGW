\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{ifgw}[2021/02/05 v0.0.1 IFGW class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper, 12pt]{book}

\RequirePackage[T1]{fontenc}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{xkeyval}

\geometry{%
	top=3cm,
	bottom=2cm,
	right=2cm,
	left=3cm,
	includehead,
	% includefoot,
}

\linespread{1.5}
% \parindent1.5em
\parindent2em

\AtBeginDocument{
	\def\captionfont{\small}
	\pagestyle{frontheadings}
}

\renewcommand{\chaptermark}[1]{\markboth{\thechapter.~#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.~#1}{}}

\def\cleardoublepage{\clearpage
	\if@twoside
		\ifodd 
			\c@page
		\else
			\vspace*{\fill}
			\thispagestyle{empty}
			\newpage
			\if@twocolumn\hbox{}\newpage\fi
		\fi
	\fi
}

\newcommand{\theyear}{\the\year}

\newcommand{\thetitle}{}
\let\oldtitle\title           
\renewcommand{\title}[1]{%   
	\oldtitle{#1}%
	\renewcommand{\thetitle}{#1}
}

\newcommand{\theauthor}{}
\let\oldauthor\author
\renewcommand{\author}[1]{%
	\oldauthor{#1}%
	\renewcommand{\theauthor}{#1}
}

\newcommand{\theinstitute}{}
\newcommand{\institute}[1]{%
	\renewcommand{\theinstitute}{#1}
}

\newcommand{\theuniversity}{}
\newcommand{\university}[1]{%
	\renewcommand{\theuniversity}{#1}
}

\newcommand{\thesupervisor}{}
\newcommand{\thesupervisorname}{Supervisor}
\newcommand{\supervisor}[2][Supervisor]{%
	\renewcommand{\thesupervisorname}{#1}
	\renewcommand{\thesupervisor}{#2}
}

\newcommand{\thecosupervisor}{}
\newcommand{\thecosupervisorname}{}
\newcommand{\cosupervisor}[2][Co-supervisor]{%
	\renewcommand{\thecosupervisorname}{#1}
	\renewcommand{\thecosupervisor}{#2}
}

\newcommand{\thelocation}{}
\newcommand{\location}[1]{%
	\renewcommand{\thelocation}{#1}
}

\newcommand{\thefacepagetext}{}
\newcommand{\facepagetext}[1]{
	\renewcommand{\thefacepagetext}{#1}
}
\def\logo@align@center{center}
\def\logo@align@left{flushleft}
\def\logo@align@right{flushright}
\newlength{\logo@width}

\define@key{logo}{width}[2cm]{\setlength\logo@width{#1}}
\define@key{logo}{align}{\def\logo@align{\csname logo@align@#1\endcsname}}
\setkeys{logo}{align=center, width=2cm}

\newcommand{\thelogo}{}
\newcommand{\logo}[2][]{
	\setkeys{logo}{#1}
	\renewcommand{\thelogo}{\includegraphics[width=\logo@width]{#2}}
}

\renewcommand{\maketitle}{%
	\thispagestyle{empty}
	\begin{\logo@align}
		\if\thelogo\@empty\relax\else\centering\thelogo\fi
	\end{\logo@align}
	\begin{center}
		\vfil 
		\if\theuniversity\@empty\relax\else\MakeUppercase{\theuniversity}\fi 
		\vfil
		\if\theinstitute\@empty\relax\else\theinstitute\fi
		\vskip.15\textwidth
		\if\theauthor\@empty\relax\else\MakeUppercase{\theauthor}\fi
		\vskip.15\textwidth
		\if\thetitle\@empty\relax\else\MakeUppercase{\bfseries\thetitle}\fi
		\vfill
		\vfill
		\if\thelocation\@empty\relax\else\MakeUppercase{\thelocation \\~ \the\year}\fi
	\end{center}
}

\newcommand{\facepage}{
	\cleardoublepage
	\thispagestyle{empty}
	\begin{center}
		\if\theauthor\@empty\relax\else\MakeUppercase{\theauthor}\fi
		\vskip.15\textwidth
		\if\thetitle\@empty\relax\else\MakeUppercase{\bfseries\thetitle}\fi
		\vfill
		\hspace*{7.5cm}
		\begin{minipage}{8.5cm}
			\if\thefacepagetext\@empty\relax\else\thefacepagetext\fi
			\vskip\baselineskip
			\if\thesupervisor\@empty\relax\else\thesupervisorname:~\thesupervisor\fi
			\vfill
			\if\thecosupervisor\@empty\relax\else\thecosupervisorname:~\thecosupervisor\fi
		\end{minipage}
		\vfill
		\if\thelocation\@empty\relax\else\MakeUppercase{\thelocation \\~ \the\year}\fi
	\end{center}
	\newpage
}

\def\ps@headings{%
	\def\@evenhead{\vbox{\thepage\hfill\rightmark\vskip.75\p@\hrule\relax}}
	\def\@oddhead{\vbox{\leftmark\hfill\thepage\vskip.75\p@\hrule\relax}}
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\let\@mkboth\markboth
}

\def\ps@plain{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{{\hfill\thepage}}
    \def\@evenhead{{\thepage\hfill}}
}

\def\ps@myheadings{\ps@headings}

\def\ps@frontheadings{%
    \let\@oddhead\@empty\let\@evenhead\@empty
    \def\@oddfoot{{\hfil\thepage\hfil}}
    \def\@evenfoot{{\hfil\thepage\hfil}}
}

\def\ps@frontheadings{\ps@empty}

\let\oldfrontmatter\frontmatter
\renewcommand\frontmatter{\oldfrontmatter\pagestyle{frontheadings}}
\let\oldmainmatter\mainmatter
\renewcommand\mainmatter{\oldmainmatter\pagestyle{headings}}

\def\@makechapterhead#1{%
	\vspace*{20\p@}
	{\raggedright\huge\scshape\@chapapp~\thechapter}
	\vskip 15\p@
	\begin{flushleft}
		\linespread{1}\selectfont{\huge\textbf{\textsc{#1}}\par\nobreak}
	\end{flushleft}
	\vskip 5\p@ \rule{\textwidth}{1.5\p@}\vskip 35\p@
	\pagestyle{headings}
}

\def\@makeschapterhead#1{%
	\cleardoublepage
	\vspace*{20\p@}
	\thispagestyle{frontheadings}
	\begin{flushleft}
		\linespread{1}\selectfont{\Huge\bfseries\textsc{#1}\par\nobreak}
	\end{flushleft}
	\vskip 30\p@
}

\newcommand{\theabstractname}{Abstract}
\newcommand\abstractname[1]{
	\renewcommand{\theabstractname}{#1}
}

\newenvironment{abstract}[1][]{%
	\chapter*{\theabstractname}
	\thispagestyle{frontheadings}
	\addcontentsline{toc}{chapter}{\theabstractname}
	\@mkboth{\theabstractname}{}
	\renewcommand{\theabstractname}{Abstract}
	\pagestyle{frontheadings}
	\begin{singlespace}
		\noindent #1
	\end{singlespace}
	\vskip\baselineskip
	\noindent
}
{ }

\newcommand{\bra}[1]{\left\langle#1\right|}
\newcommand{\ket}[1]{\left|#1\right\rangle}
\newcommand{\braket}[3][\@nil]{
	\def\tmp{#1}
	\ifx\tmp\@nnil
		\left\langle#2\middle|#3\right\rangle
	\else
		\left\langle#2\left|#1\right|#3\right\rangle
	\fi
}

\endinput