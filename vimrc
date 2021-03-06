" Use Vim settings rather than Vi settings
"
" Explicitly setting this is helpful when using the -u option. Should be first
" line in vimrc
set nocompatible

" Use 24-bit color with the guifg and guibg attributes
set termguicolors

" Set color map for syntax highlighting
set background=dark

syntax enable

colorscheme jellybeans

" Apply custom highlights
fun! s:Highlight()
	highlight ColorColumn guibg=red

	" Make separator background between vertical split windows transparent
	highlight VertSplit guibg=NONE

	" Hide ~ characters shown for empty lines
	highlight EndOfBuffer guifg=bg
endfun

call s:Highlight()

" Reapply custom highlights when the color scheme is reloaded
augroup Highlight
	autocmd! ColorScheme * call s:Highlight()
augroup end

" Create alternate mappings for exiting insert mode
inoremap jk <esc>
inoremap kj <esc>

" Set custom <leader> key
let mapleader = "\<space>"

set encoding=utf-8

" Enable line numbers
set number

" Set tab width
set tabstop=2
set shiftwidth=0

" Make tabs visible
set list
let &listchars = "tab:│\<space>"

" Enable automatic file-type based indentation
filetype plugin indent on

" Configure spellchecking
set spelllang=en_us
set spellcapcheck=""

" Compile and create spell file if it does not exist or is not readable
if !filereadable(expand("~/.vim/spell/en.utf-8.add.spl"))
	mkspell! ~/.vim/spell/en.utf-8.add
endif

" Map dot to work the same in visual mode as it does in normal mode
vnoremap . :normal.<cr>

" Make backspace more effective
set backspace=indent,eol,start

" Set scroll margin for window top and bottom
set scrolloff=1

" Create mappings for splitting a new window with a specified file
nnoremap <c-j> :split<space>
nnoremap <c-l> :vsplit<space>

" Set the location for a new split window relative to its parent
set splitbelow splitright

" Remove separator character between vertical split windows
set fillchars-=vert:\|

" Create mappings for changing focus between windows
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" Highlight the 81st virtual column of a line when it exceeds 80 characters
fun! s:HighlightColumn()
	if !exists("w:highlightcolumn")
		let w:highlightcolumn = 1
		call matchadd("ColorColumn", '\%81v.', 20)
	endif
endfun

" Call s:HighlightColumn on all windows
augroup HighlightColumn
	autocmd! VimEnter,WinEnter * call s:HighlightColumn()
augroup end

" Create mappings for writing and quitting
nnoremap <leader>w :w<cr>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>a :qa<cr>
nnoremap <silent> <leader>x :x<cr>

" Make the status line always visible
set laststatus=2

" Show line and column number of cursor and relative positon of text
set ruler

" Capitalize the first letter of a word and enter insert mode
nnoremap <leader>cc vlvbvUi

" Allow specified keys that move the cursor left/right to move to the
" previous/next line when the cursor is on the first/last character in the line
set whichwrap+=h,l,<,>,[,]

" Enhance matches with '%'
packadd! matchit

" Open vimrc in a new tab
nnoremap <silent> <leader>v :tabedit $MYVIMRC<cr>

" Close the current tab
nnoremap <silent> <leader>z :tabclose<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle Goyo
nnoremap <silent> <leader>o :Goyo<cr>

" Toggle Limelight
nnoremap <silent> <leader>i :Limelight!!<cr>

" Toggle Goyo and Limelight
nnoremap <silent> <leader>gi :Goyo<cr>:Limelight!!<cr>

""""""""""""""""""""""""""""""""""""""""
"
" NERD Tree
""""""""""""""""""""""""""""""""""""""""

" Remove superfluous UI items
let NERDTreeMinimalUI = 1

" Show dotfiles
let NERDTreeShowHidden = 1

" Toggle NERD Tree
nnoremap <silent> <leader>t :NERDTreeToggle<cr>

" Find the current file in the NERD Tree
nnoremap <silent> <leader>f :NERDTreeFind<cr>

" Automatically open NERD Tree on Vim start up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""

" Reduce update delay for vim-gitgutter
set updatetime=250

" Create mappings for vim-gitgutter that do not conflict with the <leader>h
" prefix
nmap <leader>gs <plug>GitGutterStageHunk
nmap <leader>gu <plug>GitGutterUndoHunk
nmap <leader>gp <plug>GitGutterPreviewHunk

let g:gitgutter_sign_modified = "•"
let g:gitgutter_sign_modified_removed = g:gitgutter_sign_modified . "_"

let g:airline_powerline_fonts = 1

" Toggle Colorizer
nmap <silent> <leader>cl <plug>Colorizer

""""""""""""""""""""""""""""""""""""""""
"
" UltiSnips
""""""""""""""""""""""""""""""""""""""""

" Edit snippets for current filetype
nnoremap <silent> <leader>s :UltiSnipsEdit<cr>

" Open edit window in new tab
let g:UltiSnipsEditSplit = "tabdo"

" Set directory in which to search for snippet files
let g:UltiSnipsSnippetDirectories = [$HOME . "/.vim/ultisnips"]
