" ---- Initialize Settings ----
set termguicolors

" ---- Vim Plug ----
" Install vim-plug
if has('vim_starting')
  set rtp+=~/.local/share/nvim/site/autoload/plug.vim
  if !filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
    echo 'install vim-plug...'
    call system('curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  end
endif


" ---- Plugins ----
call plug#begin('~/.local/share/nvim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File explorer
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

" Syntax Highlight
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'

" Language Server
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Toggle comments
Plug 'tyru/caw.vim'

" Text
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'knsh14/vim-github-link'
Plug 'voldikss/vim-translator'

" Edit browser textarea content
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

" Terminal
Plug 'voldikss/vim-floaterm'

" Test
Plug 'janko/vim-test'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ColorScheme
Plug 'lifepillar/vim-solarized8'
Plug 'jnurmine/Zenburn'
Plug 'Rigellute/rigel'

call plug#end()

let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction


" ---- Vim Settings ----

" Default Shell
set sh=fish

" Appearance
set title
set hidden
set background=dark
set cmdheight=2
set laststatus=2
set showcmd
set number
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set ruler
set list
set listchars=tab:>-,trail:_,extends:<
set showmatch
syntax enable

set encoding=utf-8
set mouse=a
set wildmenu
set backspace=indent,eol,start
set smartindent
set updatetime=300 " Default is 4000
set clipboard=unnamed
set formatoptions+=mM
filetype plugin indent on

set noswapfile
set nobackup
set noundofile

"Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan


" ---- Key Mappings ----
noremap ; :

" Use spacebar as leader key
let mapleader = "\<Space>"

" Quit
nnoremap <silent> <leader>q :q<Cr>

" Buffer controls
nnoremap <silent> { :bprev<Cr>
nnoremap <silent> } :bnext<Cr>

nnoremap <silent> <leader>[ :bprev<Cr>
nnoremap <silent> <leader>] :bnext<Cr>

nnoremap <silent> <leader>w :bdelete<CR>
nnoremap <silent> <leader>W :bdelete!<CR>

" ---- Emacs keymap ----
inoremap <silent> <C-a> <HOME>
inoremap <silent> <C-e> <END>
inoremap <silent> <C-n> <Down>
inoremap <silent> <C-p> <Up>
inoremap <silent> <C-b> <Left>
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-h> <BS>
inoremap <silent> <C-d> <Del>


" ---- Windows ----
" Split
set splitbelow
set splitright
nnoremap <C-w>- :sp<CR>
nnoremap <C-w>\ :vs<CR>
nnoremap <M--> :sp<CR>
nnoremap <M-\> :vs<CR>

" Move
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize window
nnoremap <M-j> <C-w>-
nnoremap <M-k> <C-w>+
nnoremap <M-l> <C-w>>
nnoremap <M-h> <C-w><
" Reset window
nnoremap <M-r> <C-w>=
" Maximize window
nnoremap <M-a> <C-w>_<C-w><Bar>


" ---- Terminal ----
" Exit terminal mode with '\\'
tnoremap <silent> \\ <C-\><C-n>
" Open terminal in insert mode
" autocmd TermOpen term://* startinsert


" ---- Others ----
if executable('pdftotext')
  " https://github.com/jalan/pdftotext
  " pip3 install pdftotext

  " Convert PDF file to text
  autocmd BufRead *.pdf :enew | 0read !pdftotext -layout -nopgbrk "#" -
  autocmd BufRead *.pdf setlocal readonly nolist
else
  " Open PDF file with other application
  autocmd BufRead *.pdf execute('!open %') | execute('bdelete')
endif


" ---- Plugins ----
if s:plug.is_installed('vim-easymotion')
  nmap <leader><leader> <Plug>(easymotion-overwin-f)
endif


if s:plug.is_installed('vim-floaterm')
  let g:floaterm_width = 0.9
  let g:floaterm_height = 0.9
  let g:floaterm_autoinsert = v:false
  nnoremap <silent> <C-t> :FloatermToggle<Cr>
  nnoremap <silent> <leader>tt :FloatermNew<Cr>
  nnoremap <silent> <leader>t] :FloatermNext<Cr>
  nnoremap <silent> <leader>t[ :FloatermPrev<Cr>
  nnoremap <silent> <leader>tw :FloatermKill<Cr>
endif


if s:plug.is_installed('fzf.vim')
  nnoremap <leader>f :Rg<Cr>
  vmap <leader>f :Rg<Cr>
  nnoremap <leader>p :Files<Cr>
  nnoremap <leader><TAB> :Buffers<Cr>
  nnoremap <Leader>/ :Rg<Space>
  nnoremap <Leader>h :BCommits<Cr>
endif


if s:plug.is_installed('coc.nvim')
  let g:coc_global_extensions = [
        \ 'coc-snippets',
        \ 'coc-tsserver',
        \ 'coc-vetur',
        \ 'coc-svelte',
        \ 'coc-prettier',
        \ 'coc-eslint',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-lists',
        \ 'coc-highlight',
        \ 'coc-omnisharp',
        \ 'coc-yaml',
        \ 'coc-tailwindcss',
        \ 'coc-styled-components',
        \ ]

  nmap <silent><C-]> <Plug>(coc-definition)
  nmap <silent><Leader>r  <Plug>(coc-rename)
  nnoremap K :call <SID>show_documentation()<CR>
  nmap <C-p> <Plug>(coc-diagnostic-prev)
  nmap <C-n> <Plug>(coc-diagnostic-next)

  nnoremap [Coc] <Nop>
  nmap <Leader>c [Coc]
  nmap [Coc]d <Plug>(coc-definition)
  nmap [Coc]t <Plug>(coc-type-definition)
  nmap [Coc]i <Plug>(coc-implementation)
  nmap [Coc]r <Plug>(coc-references)
  nmap [Coc]f  <Plug>(coc-format-selected)
  vmap [Coc]f  <Plug>(coc-format-selected)
  nmap [Coc]p <Plug>(coc-diagnostic-prev)
  nmap [Coc]n <Plug>(coc-diagnostic-next)
  nnoremap [Coc]o  :<C-u>CocList outline<cr>
  nnoremap [Coc]s  :<C-u>CocList -I symbols<cr>
  nnoremap [Coc]k :call <SID>show_documentation()<CR>

  " Show documentation in preview window
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocActionAsync('doHover')
    endif
  endfunction

  " Highlight symbol and show documentation under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Tab completion
  inoremap <expr> <Tab> pumvisible() ? "\<Down>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<Up>" : "\<S-Tab>"
endif


if s:plug.is_installed('vim-gitgutter')
  nmap ]g <Plug>(GitGutterNextHunk)
  nmap [g <Plug>(GitGutterPrevHunk)
endif


if s:plug.is_installed('defx.nvim')
  " Disable netrw
  let loaded_netrwPlugin = 1

  " Auto refresh
  autocmd BufWritePost * call defx#redraw()
  autocmd BufEnter * call defx#redraw()

  nnoremap <silent> <Leader>e :<C-u> Defx -search=`expand('%:p')` <CR>

  " Start Defx when Vim is started without file arguments.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Defx | endif

  " Show defx view when split window is opened
  nnoremap <C-w>- :sp \| Defx<CR>
  nnoremap <C-w>\ :vs \| Defx<CR>

  call defx#custom#option('_', {
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'explorer',
      \ 'columns': 'indent:git:icons:filename:mark',
      \ 'resume': 0,
      \ })

  autocmd FileType defx call s:defx_my_settings()
  function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
    \ defx#do_action('open_tree')
    nnoremap <silent><buffer><expr> h
    \ defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> <CR>
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> o
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> t
    \ defx#do_action('multi', ['quit',['open','tabnew']])
    nnoremap <silent><buffer><expr> F
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
    \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> D
    \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy
    \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> u
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Tab>
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> R
    \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> C
    \ defx#do_action('change_vim_cwd')
  endfunction
endif


if s:plug.is_installed('caw.vim')
  " Ctrl + / to toggle comments.
  nmap <C-_> <Plug>(caw:hatpos:toggle)
  vmap <C-_> <Plug>(caw:hatpos:toggle)
endif


if s:plug.is_installed('goyo.vim')
  let g:goyo_width = "70%"
  " Ctrl + Enter to toggle Goyo
  nnoremap <silent> <C-CR> :Goyo<CR>
endif


if s:plug.is_installed('vim-translator')
  let g:translator_target_lang = "ja"
endif


if s:plug.is_installed('vim-airline')
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  set laststatus=2
endif


if s:plug.is_installed('vim-airline-themes')
  let g:airline_theme = 'murmur'
endif


if s:plug.is_installed('rigel')
  set background=dark
  let g:rigel_airline = 1
  let g:airline_theme = 'rigel'
  colorscheme rigel
endif


" if s:plug.is_installed('vim-solarized8')
"   set background=dark
"   colorscheme solarized8_flat
" endif


" if s:plug.is_installed('Zenburn')
"   set background=dark
"   colorscheme zenburn
" endif

