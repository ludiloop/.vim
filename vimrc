"For "management of individually installed plugins in ~/.vim/bundle (or
" ~\vimfiles\bundle), adding `execute pathogen#infect()` to the top of your
" .vimrc is the only other setup necessary.
execute pathogen#infect()

"function that will automatically update the help tags for each directory in the runtimepath
call pathogen#helptags()

filetype plugin indent on

" Use Vim settings, rather than Vi settings (much better!).                    
" This must be first, because it changes other options as a side effect.       
set nocompatible 

syntax on                       "syntax highlighting
set title                       "change the terminal's title

set pastetoggle=<F2>

set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set clipboard=unnamedplus
set wrap                        "Wrap lines
set textwidth=79
set formatoptions=qrn1          "look at that, do not just copy/paste it
set colorcolumn=80
set number                      "set relativenumber

"set norelativenumber

" mail line wrapping
"au BufRead /tmp/mutt-* set tw=72

set autoindent
set complete-=i
set showmatch                   "Show matching brackets
set smarttab

"no tabs in source file, all tabs are 4 space characters
set tabstop=4
set shiftwidth=4
set expandtab

"set nrformats-=octal "numbers that start with 0 are considered octal ctrl-a/x
set shiftround                  "use multiple of shiftwidth when indenting with '<' and '>'

set ttimeout
set ttimeoutlen=50

set history=50

set tabpagemax=50

if !empty(&viminfo)
        set viminfo^=!
endif

set laststatus=2
" from stackoverflow Q/A about vim statusline
set statusline=%F%m%r%h%w\ 
set statusline+=%{fugitive#statusline()}\    
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ [line\ %l\/%L]          
set statusline+=%{rvm#statusline()}

" syntastic setup
let g:syntastic_always_populate_loc_list = 1                               
let g:syntastic_auto_loc_list = 1                                          
let g:syntastic_check_on_open = 1                                          
let g:syntastic_check_on_wq = 0

set ruler
set showcmd	                    "display incomplete commands
set nobackup
set nowritebackup

set autoread                    "reload files changed on disk, i.e. via `git checkout`
au FocusLost * :wa              "save file when Vim loses focus

set scrolloff=1                 "show context above/below cursor line
set cursorline                  "highlight cursor line
set wildmenu                    "visual autocomplete for command menu
set sidescrolloff=5             "number of cols from horizontal edge to  start scrolling

set display+=lastline

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
        set mouse=a
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
        set ttymouse=xterm
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
        syntax on
        set hlsearch
endif

"It clears the search buffer when you press ,/
nmap <silent> ,/ :nohlsearch<CR>

" Colours
"set t_Co=256
if &term == "xterm"
  set background=dark
  colorscheme base16-default
else
  " Theme setting.
  " Two principal themes for dark and light background
  " Function ToggleColours
  " See comments in theme
  let g:hybrid_use_Xresources = 1
  set background=dark
"  colorscheme solarized
  colorscheme badwolf
endif
"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:hybrid_use_Xresources = 1
"let g:rehash256 = 1
"colorscheme solarized

if &listchars ==# 'eol:$'
        set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
        if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
                let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
        endif
endif

"if &shell =~# 'fish$'
"        set shell=/bin/bash
"endif

set autoread
set fileformats+=mac

set guifont=Inconsolata:h15
set guioptions-=L

" Mapping to NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']
let NERDChristmasTree=1

" Allow saving of files as sudo when I forgot to start vim using sudo.
"cmap w!! w !sudo tee > /dev/null %
cmap w!! w !sudo tee % >/dev/null

" neocomplete setup >= vim7.3.885
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#sources#syntax#min_keyword_length = 3

" cfmt setup
let g:cfmt_style = '-linux'
autocmd BufWritePre *.c,*.h Cfmt

" Unite setup (from bling.github.io unite-dot-vim) , browse through the rest of
" file searching like ctrlp.vim
nnoremap <C-p> :Unite file_rec/async<CR>
" content searching like ack.vim or ag.vim
nnoremap <space>/ :Unite grep:.<CR>

" vim-go mappings
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical) remap shift insert

au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" vim-airline setup
let g:airline_theme= 'tomorrow'

" close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" python-syntax setup
"let python_highlight_all = 1

" why this needs to be at the end of the file
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" for markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" On linux make copy paste work with xclip
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> p:call setreg("\"",system("xclip -o -selection clipboard"))<CR>
