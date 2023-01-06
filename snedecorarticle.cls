% \iffalse meta-comment
%% File: snedecorarticle.cls
% Copyright
% 2022 Luis Damiano
%      https://github.com/luisdamiano/snedecor-latex
%
% This file is part of the `Snedecor bundle'.
% -------------------------------------------
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Luis Damiano.
%
% The list of all files belonging to the `Snedecor Bundle' is
% given in the file `manifest.txt'.
% \fi

%%
%% Snedecor LaTeX class file for articles
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{snedecorarticle}[2022/05/06 The Snedecor bundle class for nice articles]

% Base class -------------------------------------------------------------------
%% Pass unhandled options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Load Snedecor commons --------------------------------------------------------
\RequirePackage{snedecorcommons}

% Font -------------------------------------------------------------------------
% Line spacing
\RequirePackage{setspace}
\doublespacing{}

% Layout -----------------------------------------------------------------------
%% Landscape pages
\RequirePackage{pdflscape}

%% Labels
\RequirePackage[notref, notcite]{showkeys}
\renewcommand\showkeyslabelformat[1]{\fbox{\normalfont\tiny\ttfamily#1}}

%% Margins
\RequirePackage{geometry}
\geometry{left=1in,right=1in,bottom=1in,top=1in}

%% Line number
\RequirePackage[mathlines]{lineno}
\setrunninglinenumbers{}
\leftlinenumbers{}
\renewcommand{\linenumberfont}{\tiny\sffamily\color{black!50}}
\linenumbers{}

% Headers ----------------------------------------------------------------------
% \RequirePackage{fancyhdr}
% \thispagestyle{fancy}
% \fancyhf{}
% %\fancyfoot{}
% \fancyhf[LH]{%
%   \infohl{Info}
%   \warnhl{Warning}
%   \alerthl{Alert}
%   \TODO{todo}
% }
% \fancyhf[CF]{\thepage}
% \renewcommand{\headrulewidth}{0pt}
% \renewcommand{\footrulewidth}{0pt}

% Title page -------------------------------------------------------------------
\RequirePackage{authblk}

% Paragraphs -------------------------------------------------------------------
\RequirePackage{widows-and-orphans}
\WaOsetup{check=warning,prevent-all}

% Figures ----------------------------------------------------------------------
\RequirePackage{graphicx}

% Captions ---------------------------------------------------------------------
\RequirePackage{caption}
\captionsetup{labelfont=bf}
\captionsetup{width=.95\textwidth}

% Colors -----------------------------------------------------------------------
\RequirePackage{xcolor}

% Number lines inside equations ------------------------------------------------
%% https://tex.stackexchange.com/a/461192/225233
\RequirePackage{etoolbox}
%% Patch 'normal' math environments:
\newcommand*\linenomathpatch[1]{%
  \cspreto{#1}{\linenomath}%
  \cspreto{#1*}{\linenomath}%
  \csappto{end#1}{\endlinenomath}%
  \csappto{end#1*}{\endlinenomath}%
}
%% Patch AMS math environments:
\newcommand*\linenomathpatchAMS[1]{%
  \cspreto{#1}{\linenomathAMS}%
  \cspreto{#1*}{\linenomathAMS}%
  \csappto{end#1}{\endlinenomath}%
  \csappto{end#1*}{\endlinenomath}%
}

%% Definition of \linenomathAMS depends on whether the mathlines option is
%% provided
\expandafter\ifx\linenomath\linenomathWithnumbers{}
\let\linenomathAMS\linenomathWithnumbers{}
%% The following line gets rid of an extra line numbers at the bottom:
\patchcmd\linenomathAMS{\advance\postdisplaypenalty\linenopenalty}{}{}{}
\else
\let\linenomathAMS\linenomathNonumbers{}
\fi

\linenomathpatch{equation}
\linenomathpatchAMS{gather}
\linenomathpatchAMS{multline}
\linenomathpatchAMS{align}
\linenomathpatchAMS{alignat}
\linenomathpatchAMS{flalign}
\linenomathpatchAMS{intertext} % Doesn't work: lines are not numbered
\linenomathpatchAMS{shortintertext} % Doesn't work: lines are not numbered

%% Disable line numbering during measurement step of multline
\makeatletter
\patchcmd{\mmeasure@}{\measuring@true}{
  \measuring@true{}
  \ifnum-\linenopenaltypar>\interdisplaylinepenalty{}
  \advance\interdisplaylinepenalty-\linenopenalty{}
  \fi
}{}{}
\makeatother

% Pseudocode -------------------------------------------------------------------
\RequirePackage{algorithm}

\RequirePackage{algorithmic}
\algsetup{indent=2em} %% Indentation length
\algsetup{linenosize=\small} %% Line number size
\algsetup{linenodelimiter=} %% No delimiter after line number
\setboolean{ALC@noend}{true} %% no end statements

% Editing ----------------------------------------------------------------------
\RequirePackage{todonotes}
\setuptodonotes{
  backgroundcolor=orange!30,
  textcolor=black,
  linecolor=orange,
  bordercolor=orange!50,
  noshadow
}
\makeatletter
\renewcommand{\@todonotes@textwidth}{2cm}
\makeatother
\providecommand{\TODO}[1]{\todo{\setstretch{1}\tiny\ttfamily\selectfont#1\par}}

\RequirePackage{mdframed}
\def\msgbox#1{
  \begin{mdframed}[linewidth=.5pt]
    #1
  \end{mdframed}
}
\def\infobox#1{
  \begin{mdframed}[backgroundcolor=green!40,linewidth=0.1pt]
    #1
  \end{mdframed}
}
\def\warnbox#1{
  \begin{mdframed}[backgroundcolor=yellow!40,linewidth=0.1pt]
    #1
  \end{mdframed}
}
\def\alertbox#1{
  \begin{mdframed}[backgroundcolor=red!40,linewidth=0.1pt]
    #1
  \end{mdframed}
}

\RequirePackage{soul}
\def\infohl#1{\sethlcolor{green}\hl{#1}}
\def\warnhl#1{\sethlcolor{yellow}\hl{#1}}
\def\alerthl#1{\sethlcolor{red}\hl{#1}}

% Debug
% ------------------------------------------------------------------------
\overfullrule=1in
\RequirePackage[l2tabu, orthodox]{nag}

\RequirePackage{lipsum}\RequirePackage[base]{babel} % need to go together
% \RequirePackage{lua-visual-debug}
\RequirePackage{layout}

% References -------------------------------------------------------------------
\RequirePackage{xr}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks,
  citecolor=violet,
  linkcolor=orange,
  urlcolor=blue
}

\RequirePackage{cleveref}
\crefname{proof}{proof}{proofs}
