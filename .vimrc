set nocompatible                " choose no compatibility with legacy vi

call plug#begin()

"" Ctrl P search
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Don't ignore _hidden_ dot files
let g:ctrlp_show_hidden = 1

" Vim Tmux navigator
Plug 'christoomey/vim-tmux-navigator'

"CoffeeScript
Plug 'kchmck/vim-coffee-script'

"Colorschemes
Plug 'rafi/awesome-vim-colorschemes'

"Commentary
Plug 'tpope/vim-commentary'

"Endwise - do...end
Plug 'tpope/vim-endwise'

"Rails
Plug 'tpope/vim-rails'

"Ruby
Plug 'vim-ruby/vim-ruby'

"Surround
Plug 'tpope/vim-surround'

"Tables
Plug 'godlygeek/tabular'

" JavaScript support
Plug 'pangloss/vim-javascript'

" JS and JSX syntax
Plug 'maxmellon/vim-jsx-pretty'

"Multiple cursors
Plug 'terryma/vim-multiple-cursors'

"Nerdtree
Plug 'scrooloose/nerdtree'

"Vim Fugitive (Git)
Plug 'tpope/vim-fugitive'

"Gitgutter (shows changed lines in sidebar)
Plug 'airblade/vim-gitgutter'

"Vim RSpec
Plug 'thoughtbot/vim-rspec'

" Initialize plugin system
call plug#end()

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
filetype indent on       " load file type plugins + indentation

colorscheme lucius

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

""Mouse
" set mouse=a

"" Ctrl P ignore
" set wildignore+=*/.git/*,*/node_modules/*,*/.DS_Store,*/vendor,*/dist/*
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist\|vendor\'

"RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "!bundle exec rspec {spec}"

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

" Move lines up and down with Ctrl-arrowup/down and Ctrl-j/k (in normal, visual and insert mode)
" Note: only meant for small selections and small movements, will break moving
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

runtime macros/matchit.vim

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Nerdtree config
" Open with leader + n
nmap <leader>n :NERDTree<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show hidden files
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$']

"" Line length
set colorcolumn=85

set term=screen-256color

"" View TSX files as Typescript
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END
