" Author: Antônio Isaac
" Description: Personal .vimrc file
"
" All the plugins are managed via vim-plug
" To install the plugins type :PlugInstall
" To update the plugins type :PlugUpdate
" Leaderkey is spacebar

" => Pre-load ------------------------------------------------------------- {{{1

filetype plugin indent on

" Download and install vim-plug (cross platform).
if empty(glob(
    \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
    \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') .
    \ '/autoload/plug.vim --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" => Sane defaults --------------------------------------------------------
set encoding=utf-8

" Leader
let mapleader = " "

filetype plugin on
set nocompatible
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

set background=dark

" => vim-plug plugins ----------------------------------------------------- {{{1

" For vimwiki to utilize vim-table properly
let g:table_mode_corner='|'

call plug#begin()

Plug 'vimwiki/vimwiki'
Plug 'danilamihailov/vim-tips-wiki'
Plug 'dhruvasagar/vim-table-mode'
Plug 'w0rp/ale', {'for': ['c', 'python', 'bash', 'c++', 'rust']}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'Zabanaa/neuromancer.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

call plug#end()

colorscheme neuromancer

" Soft word wrap
set linebreak

" Make soft line breaks much better looking.
set breakindent

" Pretty soft break character.
let &showbreak = '> '

" Use Unix as the standart file type.
set ffs=unix,dos,mac

" Increase lower status bar height in diff mode.
if &diff
  set cmdheight=2
endif

" Exit terminal mode with double Esc tap.
if has('nvim')
  tnoremap <esc><esc> <c-\><c-n>
endif

" Disable line numbers in terminal.
au CursorMoved * if &buftype == 'terminal' | set nonumber | endif

" VIMWIKI OPTIONS
let g:vimwiki_list = [{
  \ 'template_path': '$HOME/vimwiki',
  \ 'template_default': 'def_template',
  \ 'template_ext': '.html'}]
" let g:vimwiki_dir_link = 'index'    " Open /index instead of directory listing.
" let g:vimwiki_folding = 'expr'      " Enable folding.
" autocmd FileType vimwiki set spell  " Enable spelling.
