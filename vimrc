" Setup
" --------

set nocompatible

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install Bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
  source ~/.vimrc.bundles.local
endif

" Compat fixes for filetype plugins
syntax on
filetype off
filetype on
filetype plugin indent on

" Basic conf
"---------------

colorscheme solarized
set background=dark

set autoindent
set autoread
set clipboard=unnamed
set cursorline
set encoding=utf-8
set expandtab
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2  " always show status line
set number
set ruler
set scrolloff=3  " always have 3 lines showing above/below scroll pos
set shiftwidth=2
set showcmd  " extra info in the bottom bar when in visual mode
set showmatch
set smartcase  " only do case-sensitive search if there's a cap in the pattern
set softtabstop=2
set tabstop=8
set wildignore=log/**,node_modules/**,tmp/**
set wildmenu  " fancy autocomplete for commands (try :color <tab> for demo)
set wildmode=longest,list,full

" Status line settings
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Custom filetypes
au BufNewFile,BufRead *.md set filetype=markdown

" Highlight extra (trailing) whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

if &term =~ '256color'
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Keyboard shortcuts
" --------------------

let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>a :Ack<space>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nmap <leader>g :GitGutterToggle<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
"let g:snips_trigger_key = '<C-j>'
map <C-n> :NERDTreeToggle<CR>


" Plugin conf
" --------------------

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Main advantage: respects .gitignore!
" brew install the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column' " Use in Ack.vim

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use in CtrlP
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Nerdtree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git$','\.hg','\.svn','\.bzr', '\.DS_Store']
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
autocmd vimenter * if !argc() | NERDTree | endif    " Open NERDTree by default if no files are passed to vim

" Syntastic
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
let g:syntastic_python_checkers = ['pyflakes']

" Virtualenvs
let g:virtualenv_auto_activate = 1

" Better CoffeeScript highlighting
hi link coffeeObject NONE
hi link coffeeBracket NONE
hi link coffeeCurly NONE
hi link coffeeParen NONE
hi link coffeeSpecialVar Identifier

" Airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 0

" YouCompleteMe
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_filetype_blacklist = {
            \ 'html' : 1,
            \ 'htmldjango' : 1,
            \ 'markdown' : 1,
            \ 'text': 1,
            \ 'vim' : 1,
            \}
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_key_invoke_completion = '<C-Space>'


if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction
