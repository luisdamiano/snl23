% \iffalse meta-comment
%% File: snedecorbeamer.cls
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
%% Snedecor LaTeX class file for presentation
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{snedecorbeamer}[2022-05-06 The Snedecor bundle class for nice presentations]

% Base class -------------------------------------------------------------------
%% Change aspect ratio to 16:9
% \setlength\beamer@paperwidth{16.00cm}%
% \setlength\beamer@paperheight{9.00cm}%
\PassOptionsToClass{aspectratio=169}{beamer}
%% Vertical flushing
\PassOptionsToClass{t}{beamer}

%% Pass unhandled options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass{beamer}

% Load Snedecor commons --------------------------------------------------------
\RequirePackage{snedecorcommons}

% Layout -----------------------------------------------------------------------
%% Margins
\setbeamersize{
  text margin left=0.3cm,  %% Match https://github.com/josephwright/beamer/blob/c7c6724634d8aa260864ad4efa525b34ea94354e/base/themes/outer/beamerouterthemedefault.sty#L167
  text margin right=0.3cm
}

%% Navigation bar
\beamertemplatenavigationsymbolsempty{}

%% Footer
\setbeamertemplate{footline}{%
  \begin{beamercolorbox}[wd=\textwidth, ht=2.5ex, sep=.3cm, right]{footline}%
    \usebeamerfont{page number in head/foot}%
    \color{gray}\tiny%
    \insertframenumber{}/\inserttotalframenumber{}
  \end{beamercolorbox}
}

% \defbeamertemplate{frame}{maximalwidth}{%
%   \setbeamersize{
%     text margin left=1ex,
%     text margin right=1ex
%   }
% }
% \define@key{beamerframe}{maximalwidth}[true]{%
%   \setbeamertemplate{frame}[maximalwidth]%
% }

%% Captions
\RequirePackage{caption}
\captionsetup{labelfont={scriptsize,bf},font=scriptsize}

%% Page number
\RequirePackage{appendixnumberbeamer}

% Standout frames --------------------------------------------------------------
\RequirePackage{tikz}
\newcommand\standout[1]{
  {
    % \setbeamercolor{background canvas}{bg=palette primary}
    % \setbeamercolor{normal text}{fg=palette secondary}
    \begin{frame}
      \begin{tikzpicture}[overlay, remember picture]
        \node[anchor=center] at (current page.center) {
          \begin{beamercolorbox}[center]{title}
            \Huge
%           \color{palette secondary}
            #1
          \end{beamercolorbox}};
      \end{tikzpicture}
    \end{frame}
  }
}

% Overlays ---------------------------------------------------------------------
%% Fix \pause in align environment
%% https://tex.stackexchange.com/a/75550/225233
\let\save@measuring@true\measuring@true
\def\measuring@true{%
  \save@measuring@true
  \def\beamer@sortzero##1{\beamer@ifnextcharospec{\beamer@sortzeroread{##1}}{}}%
  \def\beamer@sortzeroread##1<##2>{}%
  \def\beamer@finalnospec{}%
}

% Lists ------------------------------------------------------------------------
\setbeamertemplate{itemize subitem}{{\textendash}}
