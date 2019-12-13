set nocompatible                " choose no compatibility with legacy vi

"" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
"" Ctrl P search
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Don't ignore _hidden_ dot files
let g:ctrlp_show_hidden = 1

call vundle#begin()

"Vundle
Plugin 'gmarik/Vundle.vim'

"Rails
Plugin 'tpope/vim-rails'

"Ruby
Plugin 'vim-ruby/vim-ruby'

"Go
Plugin 'fatih/vim-go'

"Nerdtree
Plugin 'scrooloose/nerdtree'

"Vim Fugitive (Git)
Plugin 'tpope/vim-fugitive'

"JS / JSX
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

"Ack
Plugin 'mileszs/ack.vim'

"do...end
Plugin 'tpope/vim-endwise'

"Surround
Plugin 'tpope/vim-surround'

" Colorschemes
Plugin 'rafi/awesome-vim-colorschemes'

"CoffeeScript
Plugin 'kchmck/vim-coffee-script'

"Tables
Plugin 'godlygeek/tabular'

call vundle#end() 

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
colorscheme pablo


"Go
 let g:go_fmt_command = "goimports"
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1

let g:go_highlight_string_spellcheck = 1


"" Whitespace
set nowrap                      " don't wrap lines
set ts=2 sts=2 sw=2 expandtab
set number
set numberwidth=5
"set list listchars=tab:»·,trail:·,nbsp:·

set splitbelow
set splitright
set autoindent
set winwidth=83
set noswapfile
set backspace=indent,eol,start

"" Mouse
" set mouse=a

"" Ctrl P
let g:ctrlp_custom_ignore = 'node_modules'

"" do/end match with %
runtime macros/matchit.vim

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Nerdtree config
map <C-n> :NERDTreeToggle<CR>   
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Line length
set colorcolumn=85

set term=screen-256color

inoremap § <Esc>
