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

" ------------------------------- "
" --- Leader key alternatives --- "
" ------------------------------- "

" They preserve the native leader key.

nmap , \
vmap , \

nmap <space> \
vmap <space> \

" --------------------------- "
" --- Indenting shortcuts --- "
" --------------------------- "

" Indent/Unindent visually selected lines without losing the selection.
vnoremap > >gv
vnoremap < <gv
" Indent single lines with a single keystroke. The ability to specify a motion
" is lost, but this caters for the more common use case, indent until the
" desired level is obtained.
nnoremap > >>
nnoremap < <<

" ---------------------- "
" --- vim-commentary --- "
" ---------------------- "

" Remap gc comments to leader-c
nmap <Leader>c gcc
vmap <Leader>c gc

autocmd FileType proto setlocal commentstring=//\ %s
autocmd FileType sql setlocal commentstring=--\ %s

" ------------------------------ "
" --- Move lines up and down --- "
" ------------------------------ "

" Move lines up and down with Ctrl-arrowup/down and Ctrl-j/k (in normal,
visual and insert mode)
" Note: only meant for small selections and small movements, will break
moving
" multiple lines down beyond the bottom.
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>
vnoremap <C-Down> :m '>+1<CR>gv
vnoremap <C-Up> :m '<-2<CR>gv
inoremap <C-Down> <ESC>:m .+1<CR>gi
inoremap <C-Up> <ESC>:m .-2<CR>gi
" For terminals where Ctrl-arrows are captured by the system.
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv
inoremap <C-j> <ESC>:m .+1<CR>gi
inoremap <C-k> <ESC>:m .-2<CR>gi

" ------------------ "
" --- Whitespace --- "
" ------------------ "

" --- Strip whitespace ---

set listchars=tab:»·,trail:·,extends:>,precedes:<
" toggle hidden characters highlighting:
nmap <silent> <Leader>h :set nolist!<CR>

function! <SID>StripTrailingWhitespaces()
  " store the original position
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c) " back to the original position
endfun

autocmd FileType Dockerfile,make,c,coffee,cpp,css,eruby,eelixir,elixir,html,java,javascript,json,markdown,php,puppet,python,ruby,scss,sh,sql,text,tmux,typescript,vim,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" --------------- "
" --- Pasting --- "
" --------------- "

set pastetoggle=<F3>

" --- Paste over visual selection preserving the content of the paste
buffer
" p   -> paste normally
" gv  -> reselect the pasted text
" y   -> copy it again
" `>  -> jump to the last character of the visual selection (built-in mark)
vnoremap <Leader>p pgvy`>

" ------------------------------------------------ "
" --- Navigate within and between vim and tmux --- "
" ------------------------------------------------ "

" Also see the corresponding tmux configuration in these dotfiles.

function! TmuxWinCmd(direction)
  let wnr = winnr()
  " try to move...
  silent! execute 'wincmd ' . a:direction
  " ...and if does nothing it means that it was the last vim pane,
  " so we forward the command back to tmux
  if wnr == winnr()
    call system('tmux select-pane -' . tr(a:direction, 'phjkl',
    'lLDUR'))
  end
endfunction

nmap <M-Up>     :call TmuxWinCmd('k')<CR>
nmap <M-Down>   :call TmuxWinCmd('j')<CR>
nmap <M-Left>   :call TmuxWinCmd('h')<CR>
nmap <M-Right>  :call TmuxWinCmd('l')<CR>

nmap <M-k> :call TmuxWinCmd('k')<CR>
nmap <M-j> :call TmuxWinCmd('j')<CR>
nmap <M-h> :call TmuxWinCmd('h')<CR>
nmap <M-l> :call TmuxWinCmd('l')<CR>

" do/end match with %
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
