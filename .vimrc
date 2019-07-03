syntax on
filetype plugin indent on
colorscheme deus
set ai
set number
set mouse=a
set breakindent
set encoding=utf-8   "Added this for vim-hug
:set nu rnu

"Pymode stuff
let g:pymode_folding = 0

" turn hybrid line numbers off
":set nonumber norelativenumber
":set nonu nornu

" toggle hybrid line numbers
":set number! relativenumber!
":set nu! rnu!

"Triggers for number toggling
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

nmap <F2> <c-w>
nmap <A-;> :wincmd l<cr>
nmap <A-j> :wincmd h<cr>
nmap <A-k> :wincmd j<cr>
nmap <A-l> :wincmd k<cr>
:command Ter vert term

"Powerline setup
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"set laststatus=2 "Always show statusline
set t_Co=256 "Use 256 colours (Use this setting only if your terminal supports 256 colours)
set guifont=Roboto\ Mono\ Medium\ for\ Powerline\ 10
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1

"CtrlP plugin bindings
nmap <leader>d :CtrlPBuffer<cr>
nmap <leader>s :CtrlPMRU<cr>
nmap <leader>f :BuffergatorOpen<cr>

"NERDTree bingings
:command Nt NERDTreeToggle
nmap <leader>a :NERDTreeToggle<cr>


"Buffergator bindings
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
nmap <leader>kk :BuffergatorMruCycleNext<cr>
let g:buffergator_autoexpand_on_split=0

"Stuff for faster movement and aesthetics
:set cursorline
nmap <leader>w :bp<cr>
nmap <leader>e :bn<cr>
nmap <C-n> <C-d> 
nmap <C-m> <C-u> 
nmap <leader>o o<Esc>k
nmap <leader>p <C-w><C-r>
nmap <leader><Space> f(a

"Copy and pasting
vmap <C-c> "+y
nmap <S-y> "+p

set guioptions-=m "menu bar 
set guioptions-=T "toolbar
set guicursor+=a:blinkon0 "Remove weird blinking cursor
"set guioptions-=r "scrollbar 
nmap <leader>T :vsplit <BAR> :wincmd l <BAR> :enew <cr>
nmap <leader>bq :bp <BAR> bd #<cr>
autocmd vimenter * NERDTree
nmap <leader>:ob :OpenBookmark<cr>
let g:deoplete#enable_at_startup = 1 "Enables deoplete
autocmd FileType python setlocal completeopt-=preview "Romoves docwindow for Jedi-vim

"Omnisharp taken from the ReadMe I think
let g:OmniSharp_timeout = 5
set completeopt=longest,menuone,preview
set previewheight=5
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_highlight_types = 1
augroup omnisharp_commands 
	autocmd!

"Custom commands command -nargs=1 Ss execute ":mks ~/.vim/sessions/<args>"
command -nargs=1 So execute ":so ~/.vim/sessions/<args>"


" air-line
 let g:airline_powerline_fonts = 1

 if !exists('g:airline_symbols')
     let g:airline_symbols = {}
     endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"     nmap <leader>bl :BuffergatorOpen<cr>
let g:ctrlp_working_path_mode = 'r'

" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1
