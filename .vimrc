"set tabstop=4
"set shiftwidth=4
"set expandtab

"set autoindent
set cindent
set cinoptions=g0,t0
set nobackup
set visualbell
set nocompatible
set backspace=indent,eol,start
set ruler
set antialias
"set gfn=Consolas:h11		" for Windows
"set gfn=MiscFixed\ Semi-Condensed\ 11	" for Linux
set gfn=Liberation\ Mono\ 12		" for Linux
"set gfw==細明體:h12
set number
set showmatch
set hlsearch
set incsearch
set ignorecase smartcase
set paste
set nowrap
set grepprg=ack\ --column
set grepformat=%f:%l:%c:%m
set splitright
"set mouse=a		" Enable mouse all the time. Use Shift+Mouse to make the selection copied to Xterm
set cscopequickfix=s-,c-,d-,i-,t-,e-
set laststatus=2

set t_Co=256	" Make the terminal 256 colors
" set background=dark
" set background=light
" colors traditional
colors delek
" colors ir_black
" colors silent
" colors wombat256mod
" colors summerfruit256
syntax enable

if has("multi_byte")
	set encoding=utf-8
	setglobal fileencoding=big5
	set fileencoding=big5
	" set bomb
	" set termencoding=big5
    set termencoding=utf-8
	" set fileencodings=ucs-bom,taiwan,utf-8,prc,ucs-2le,latin1,chinese
	set fileencodings=big-5,ucs-bom,utf-8,chinese
	" set guifont=Consolas:h11			" for Windows
	" set guifontwide=細明體:h11
	set gfn=Liberation\ Mono\ 12		" for Linux
else
	echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
    set fileencodings=ucs-bom,utf-8,chinese
endif

let c_space_errors = 1

" hi CursorLine cterm=NONE ctermbg=DarkBlue guibg=DarkBlue
" hi CursorLine cterm=NONE ctermbg=Yellow guibg=Yellow
" autocmd BufEnter * setlocal cursorline
" autocmd BufLeave * setlocal nocursorline
"set cursorline
nnoremap <C-L> :set cursorline!<CR>

autocmd BufEnter * call ShowCursorLine()
function! ShowCursorLine()
	" If the window is quickfix go on
    if (bufname('%') != '-TabBar-')
		setlocal cursorline
	endif
	if (bufname('%') != '__Tag_List__' && bufname('%') != '-TabBar-' && bufname('%') != '')
		setlocal statusline=%f%<%m%r%h%w%=%l,%v/%L\ [%Y][%{&ff}][\@%o\ %p%%][ASCII=\%04.8b][HEX=0x\%04.4B]
	endif
endfunction

" autocmd BufAdd,BufNewFile,BufRead * nested
" 	\ if &buftype != "help" |
" 	\	tab sball	|
"	\ endif

" Use trinity instead
"nnoremap <silent> <F8> :TlistToggle<CR>
"let Tlist_Use_Right_Window=0
"let Tlist_File_Fold_Auto_Close=1
"let Tlist_Exit_OnlyWindow=1

" Toggle line number on/off
" nmap <F7> :set number! number?<CR>
nnoremap <F7> :set nonumber!<CR>

"ctrl-hjkl switches windows
" map <C-J> <C-W>j
" map <C-K> <C-W>k
" map <C-H> <C-W>h
" map <C-L> <C-W>l

" Go to the next entry
nmap <F4> :cn<CR>
" Go to the previous entry
nmap <F3> :cp<CR>

"SuperTab settings
let g:SuperTabMidWordCompletion = 0
let g:SuperTabRetainCompletionType = 0
let g:SuperTabMappingTabLiteral = '<c-_>'

"tabbar
"let Tb_MoreThanOne=0
map <F5> :tabprevious<CR>
map <F6> :tabnext<CR>
"map <F8> :TbToggle<CR>

map <F12> :BufExplorer<CR>

" Open and close the taglist.vim separately
nmap <F9>  :TrinityToggleTagList<CR>
" Open and close all the three plugins on the same time
"nmap <F9> :TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately
nmap <F10> :TrinityToggleSourceExplorer<CR>
" Open and close the NERD_tree.vim separately
nmap <F11> :TrinityToggleNERDTree<CR>

:command! -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
:command! -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft=&ft
		let b:oldbin=&bin
		" set new options
		setlocal binary " make sure it overrides any textwidth, etc.
		let &ft="xxd"
		" set status
		let b:editHex=1
		" switch to hex editor
		%!xxd
	else
		" restore old options
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		" set status
		let b:editHex=0
		" return to normal editing
		%!xxd -r
	endif
	" restore values for modified and read only state
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction

" Do not expand TAB in Makefile
autocmd FileType make setlocal noexpandtab

" vim -b : edit binary using xxd-format!
augroup Binary
	au!
	au BufReadPre  *.bin let &bin=1
	au BufReadPost *.bin if &bin | %!xxd
	au BufReadPost *.bin set ft=xxd | endif
	au BufWritePre *.bin if &bin | %!xxd -r
	au BufWritePre *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
augroup END

autocmd BufEnter * call MyLastWindow()
function! MyLastWindow()
	" If the window is quickfix go on
	if &buftype=="quickfix"
		" If this window is last on screen quit without warning
		if winbufnr(2) == -1
			quit!
		endif
	endif
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
	" vim -b : edit binary using xxd-format!
	augroup Binary
		au!
		au BufReadPre *.bin,*.hex setlocal binary
		au BufReadPost *
					\ if &binary | Hexmode | endif
		au BufWritePre *
					\ if exists("b:editHex") && b:editHex && &binary |
					\	let oldro=&ro | let &ro=0 |
					\	let oldma=&ma | let &ma=1 |
					\	exe "%!xxd -r" |
					\	let &ma=oldma | let &ro=oldro |
					\	unlet oldma | unlet oldro |
					\ endif
		au BufWritePost *
					\ if exists("b:editHex") && b:editHex && &binary |
					\	let oldro=&ro | let &ro=0 |
					\	let oldma=&ma | let &ma=1 |
					\	exe "%!xxd" |
					\	exe "set nomod" |
					\	let &ma=oldma | let &ro=oldro |
					\	unlet oldma | unlet oldro |
					\ endif
	augroup END
endif

autocmd BufWritePre * :%s/\s\+$//e
"autocmd BufWritePre * :Space2Tab

autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	exe "normal! g`\"" |
	\ endif

" Append modeline after last line in buffer.
" Use substitute() (not printf()) to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
	let save_cursor = getpos('.')
	let append = ' vim: set ts='.&tabstop.' sw='.&shiftwidth.' tw='.&textwidth.' noet ft=cpp.doxygen: '
	$put = substitute(&commentstring, '%s', append, '')
	call setpos('.', save_cursor)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

