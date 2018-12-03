" Begin /etc/vimrc

set nocompatible
syntax on
set showcmd
set ruler
"set backspace=2
set history=512
set encoding=utf-8
set hlsearch
set nu
set cino=:0g0t0(sus 
set colorcolumn=81
set showmatch
set matchtime=5
set scrolloff=3

" auto detect filetype and indent
filetype plugin on
filetype indent on

" auto read changes from file.
set autoread

" set TAB to 4 bytes.
"set expandtab
"set shiftwidth=8
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set smarttab
"set lbr

" set the background color
"if (&term == "iterm") || (&term == "putty")
"	set background=dark
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
   
try
	colorscheme desert
catch
endtry

set background=dark


" set ctags support and auto change to upper dir to find TAGS
set tags=tags;/

"Auto indent
set ai

"Smart indet
set si

"C-style indeting
set cindent

"Wrap lines
"set wrap

"Set mapleader
let mapleader = "."
let g:mapleader = "."

" map some plugin: Tlist, bufexpore, explore
nmap <silent> <leader>b :BufExplorer<cr>
nmap <silent> <leader>e :Explore<cr>
nmap <silent> <leader>t :TlistToggle<cr>

" set cscope support
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	
	" add database in current dir or upper dir until to / 
	" add database in up directory call findup stript
	let csdbfile = glob("`findup.sh . cscope.out`")
	if (csdbfile != "")
		exe "cs add " . csdbfile
		exe "cd " . fnamemodify(csdbfile, ':p:h')
	endif

	" map the cscope command to CTRL + \
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Tlist configure
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal g'\"" | endif
	filetype indent on
endif

" expand "//" to "/* */" in C language and expand "/**" to "/**<cr>*<cr>*/" mode
"au BufNewFile,BufRead *.[ch] iabbrev // /*!cursor! */<esc>:call search('!cursor!', 'b')<cr>cf!
"au BufNewFile,BufRead *.[ch] iabbrev /** /**<cr><tab>!cursor! <cr>/<esc>:call search ('!cursor!', 'b')<cr>cf!

" set number line at left and set max number is 4
" set number
" set numberwidth=4

" set status bar at buttom.
set laststatus=2
set statusline=%F\ [TYPE=%Y]\ [ASCII:HEX=\%03.3b:%02.2B]\ [POS=%04l,%04v][%p%%]\ [LINES=%L]

"SET Comment START
autocmd BufNewFile *.sh,*.php,*.js,*.cpp,*.py,*.[ch] exec ":call SetComment()" |normal 10Go

func SetComment()
	if &filetype == 'sh'
		call setline(1,'#!/bin/bash')
		call append(1, '#')
		call append(2, '#      Filename: '.expand('%'))
		call append(3, '#')
		call append(4, '#        Author: g.goodian@gmail.com')
		call append(5, '#   Description: ---')
		call append(6, '#        Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(7, '# Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, '#')
		call append(9, '')
	elseif &filetype == 'python'
		call setline(1,'#!/usr/bin/env python')
		call append(1, '# -*- coding:utf-8 -*-')
		call append(2, '#')
		call append(3, '#      Filename: '.expand('%'))
		call append(4, '#')
		call append(5, '#        Author: g.goodian@gmail.com')
		call append(6, '#   Description: ---')
		call append(7, '#        Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, '# Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(9, '#')
		call append(10, '')
		call append(11, 'import os')
		call append(12, 'import sys')
		call append(13, '')
	else
		call setline(1, '/*')

		call append(1, ' *')
		call append(2, ' *      Filename: '.expand("%"))
		call append(3, ' *')
		call append(4, ' *        Author: g.goodian@gmail.com')
		call append(5, ' *   Description: ---')
		call append(6, ' *        Create: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(7, ' * Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		call append(8, ' */')
		call append(9, '')
	endif

	if &filetype == 'php'
		call append(10, '<?php')
		call append(11, '')
	elseif &filetype == 'cpp'
		call append(10, '#include <iostream>')
		call append(11, 'using namespace std;')
		call append(12, '')
	elseif &filetype == 'c'
		call append(10, '#include <stdio.h>')
		call append(11, '#include <stdlib.h>')
		call append(12, '')
	endif
endfunc

map <F2> :call SetComment()<CR>:10<CR>o
"SET Comment END

"SET Last Modified Time START

func DataInsert()
	call cursor(9,1)
	if search ('Last Modified') != 0
		let line = line('.')
		if &filetype == 'sh' || &filetype == 'python'
			call setline(line, '# Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		else
			call setline(line, ' * Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
		endif
	endif
endfunc

autocmd FileWritePre,BufWritePre *.sh,*.php,*.js,*.cpp,*.c,*.h,*.py,*.java ks|call DataInsert() |'s
"SET Last Modified Time END
"
" End /etc/vimrc

