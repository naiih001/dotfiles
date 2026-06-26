" ---- Lightweight Vim Setup ----

" --- General ---
set nocompatible
filetype plugin indent on
syntax on

" --- Appearance ---
set number
set relativenumber
set showmatch
set matchtime=2
set ruler
set showcmd
set wildmenu
set laststatus=2
set novisualbell
set noerrorbells
set termguicolors
set nowrap

" --- Indentation ---
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent

" --- Search ---
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <Esc><Esc> :nohlsearch<CR>

" --- Editing ---
set backspace=indent,eol,start
set hidden
set scrolloff=5
set sidescrolloff=5

" --- Files & Backup ---
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undodir

" --- Clipboard ---
set clipboard^=unnamedplus

" --- Split management ---
set splitbelow
set splitright

" --- Key mappings ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap ; :
vnoremap ; :
nnoremap gh ^
xnoremap gh ^
nnoremap gl g_
xnoremap gl g_
nnoremap gj }
xnoremap gj }
nnoremap gk {
xnoremap gk {

" --- Leader mappings ---
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :Files<CR>

" ---- Plugin Manager ----
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'github/copilot.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" --- Plugin Config ---
let g:lightline = { 'colorscheme': 'ashen' }

" --- LSP ---
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_fold_enabled = 0

nnoremap gd :LspDefinition<CR>
nnoremap K :LspHover<CR>
nnoremap gi :LspImplementation<CR>
nnoremap gr :LspReferences<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>
nnoremap <leader>d :LspDocumentDiagnostic<CR>
nnoremap [d :LspPreviousDiagnostic<CR>
nnoremap ]d :LspNextDiagnostic<CR>

" --- Asyncomplete ---
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview

autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
function! s:on_lsp_buffer_enabled() abort
  setlocal completeopt-=preview
  setlocal omnifunc=lsp#complete
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> <leader>li <plug>(lsp-document-symbol-search)
endfunction

" --- Theme ---
colorscheme ashen
