" Vim color file
" Maintainer:   tim ouyang <tim_ouyang@sunplus.com>
" Last Change:  2009 Jul 8

" Remove all existing highlighting and set the defaults.
hi clear
set background=dark

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "traditional"

highlight PreProc     ctermfg=cyan       ctermbg=black                 guifg=cyan       guibg=black
highlight Constant    ctermfg=red        ctermbg=black                 guifg=red        guibg=black
highlight Identifier  ctermfg=white      ctermbg=black                 guifg=white      guibg=black
highlight Statement   ctermfg=green      ctermbg=black                 guifg=green      guibg=black
highlight Comment     ctermfg=darkcyan   ctermbg=black                 guifg=darkcyan   guibg=black
highlight Type        ctermfg=yellow     ctermbg=black     cterm=bold  guifg=yellow     guibg=black
highlight Todo        ctermfg=white      ctermbg=darkcyan              guifg=white      guibg=darkcyan
highlight StatusLine  ctermfg=yellow     ctermbg=blue      cterm=none  guifg=yellow     guibg=blue      gui=none
highlight Normal      ctermfg=lightgray  ctermbg=black                 guifg=lightgray  guibg=black
highlight Search      ctermfg=white      ctermbg=brown                 guifg=white      guibg=brown

" vim: sw=2
