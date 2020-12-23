""""""""""""""""""
"   variables    "
""""""""""""""""""
let host_var = $HOME
let python3_host_prog_var = expand('~/.pyenv/shims/python')

""""""""""""""""""""
"  Initialization  "
""""""""""""""""""""
" python3 path
let g:python3_host_prog = python3_host_prog_var

call plug#begin('~/.vim/plugged')
" editing
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'easymotion/vim-easymotion', {'on': [
  \ '<Plug>(easymotion-j)', '<Plug>(easymotion-k)',
  \ '<Plug>(easymotion-s2)', '<Plug>(easymotion-overwin-f2)',
  \ '<Plug>(easymotion-sn)', '<Plug>(easymotion-tn)' ]}
Plug 'Yggdroot/indentLine'

" completion and linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" utilities
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-peekaboo'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deol.nvim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'jiangmiao/auto-pairs'
Plug 'twitvim/twitvim'
Plug 'mcchrish/nnn.vim'
Plug 'kassio/neoterm'

" colorschemes
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'

" tmux related
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" filetypes
" Plug 'fatih/vim-go', {'for': 'go'}
Plug 'ledger/vim-ledger', {'for': 'ledger'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'lervag/vimtex', {'for': 'tex'}

" dart / flutter related
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

"  Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"  vim auto save
Plug 'vim-scripts/vim-auto-save'

" filetype plugin indent and syntax is handled by plug#end
call plug#end()

if !has('nvim')
  packadd! matchit
  runtime ftplugin/man.vim
endif

augroup vimrc
  autocmd!
augroup END

"""""""""""""
"  Editing  "
"""""""""""""
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,default,latin1
set fileformats=unix,dos,mac
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent
set smartindent
set formatoptions+=jmB

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.c setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cc setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.h setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hh setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.j2 setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.dart setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" jump to the last known cursor position
au vimrc BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" enable brackted paste mode
if !has('nvim') && has('patch-8.0.0238') && $TERM =~? 'screen'
  let &t_BE = "\<Esc>[?2004h"
  let &t_BD = "\<Esc>[?2004l"
  exec "set t_PS=\<ESC>[200~ | set t_PE=\<ESC>[201~"
endif

if has('nvim')
    set clipboard=unnamedplus
else
    set clipboard=unnamed,autoselect,unnamedplus
endif

""""""""
"  UI  "
""""""""
set colorcolumn=81
set number
set ruler
set showcmd
set noshowmode
set cmdheight=1
set laststatus=2
set display=lastline
set lazyredraw
set showmatch
set wildmenu
set title
set mouse=a
set rnu

" colors
if $TERM =~? '.*-256color' && $TERM_PROGRAM !=? 'Apple_Terminal'
  set cursorline
  set termguicolors
  colorscheme molokai
  if !has('nvim') && $TERM =~? 'screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif
if exists('+inccommand')
  set inccommand=split
endif

" show whitespace errors
hi link WhitespaceError Error
au vimrc Syntax * syn match WhitespaceError /\s\+$\| \+\ze\t/

""""""""""""
"  Search  "
""""""""""""
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set tags=./.tags;~

"""""""""""
"  Cache  "
"""""""""""
if !has('nvim')
  set viminfo+=n~/Library/Caches/vim/viminfo
endif
"set dir=~/Library/Caches/vim/swap
set noswapfile
set backup
set backupdir=~/Library/Caches/vim/backup
set undofile
set undodir=~/Library/Caches/vim/undo
for s:d in [&dir, &backupdir, &undodir]
  if !isdirectory(s:d)
    call mkdir(iconv(s:d, &encoding, &termencoding), 'p')
  endif
endfor

""""""""""""
"  CoCVim  "
""""""""""""
set hidden
set updatetime=300

inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""""""""""""""""
"  Keybindings  "
"""""""""""""""""
let mapleader="\<Space>"
let maplocalleader="\<Space>\<Space>"
" XXX: Workaround for <Nop> bug in vim/vim#1548, neovim/neovim#6241
nnoremap <Space> \
xnoremap <Space> \

" basic keybindings
nnoremap ; :
" nnoremap j i
inoremap jj <Esc>

" a more logical mapping for Y
nnoremap Y y$
" add another option to go back to start / end
nnoremap <S-l> $
nnoremap <S-h> ^
" break undo before deleting a whole line
inoremap <C-u> <C-g>u<C-u>
" a more powerful <C-l>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>:call vimrc#refresh()<CR>

" find merge conflict marker
nnoremap <silent> <Leader>fc /\v^[<=>]{7}( .*<Bar>$)<CR>
xnoremap <silent> <Leader>fc /\v^[<=>]{7}( .*<Bar>$)<CR>
onoremap <silent> <Leader>fc /\v^[<=>]{7}( .*<Bar>$)<CR>
" find whitespace errors
nnoremap <silent> <Leader>f<Space> /\s\+$\<Bar> \+\ze\t<CR>
xnoremap <silent> <Leader>f<Space> /\s\+$\<Bar> \+\ze\t<CR>
onoremap <silent> <Leader>f<Space> /\s\+$\<Bar> \+\ze\t<CR>

" text objects
xnoremap <silent> ae gg0oG$
onoremap <silent> ae :<C-u>exe "normal! m`"<Bar>keepjumps normal! ggVG<CR>
xnoremap <silent> al <Esc>0v$
onoremap <silent> al :<C-u>normal! 0v$<CR>
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-u>normal! ^vg_<CR>
" XXX: Same feature as vim/vim#958
xmap im <Plug>(textobj-sandwich-literal-query-i)
omap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap am <Plug>(textobj-sandwich-literal-query-a)

" toggles
nnoremap <silent> <Leader>tn :NERDTreeToggle<CR>
nnoremap <silent> <Leader>th :setlocal bufhidden! bufhidden?<CR>
nnoremap <silent> <Leader>tl :ALEToggle<CR>
nnoremap <silent> <Leader>ts :setlocal spell! spell?<CR>
nnoremap <silent> <Leader>tt :TagbarToggle<CR>
nnoremap <silent> <Leader>tu :UndotreeToggle<CR>
nnoremap <silent> <Leader>tv :call vimrc#toggle_virtualedit()<CR>
nnoremap <silent> <Leader>t# :setlocal relativenumber! relativenumber?<CR>
nnoremap <silent> <Leader>t<Space> :AirlineToggleWhitespace<CR>

" FZF mappings
imap <C-x><C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-x><C-k> <Plug>(fzf-complete-word)
imap <C-x><C-x><C-l> <Plug>(fzf-complete-line)
inoremap <silent> <C-x><C-x><C-j> <Esc>:Snippets<CR>
nnoremap <silent> <Leader>fzf :Files<CR>
nnoremap <silent> <Leader>ffcp :Files <C-R>"<CR>
nnoremap <silent> <Leader>fzb :Buffers<CR>
nnoremap <silent> <Leader>fzl :Lines<CR>
nnoremap <silent> <Leader>g<C-]> :Tags <C-r>=expand("<cword>")<CR><CR>
nnoremap <silent> <Leader>q: :History:<CR>
nnoremap <silent> <Leader>q/ :History/<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader><C-o> :History<CR>
nnoremap <silent> <Leader><C-]> :BTags <C-r>=expand("<cword>")<CR><CR>

" easymotion
nmap <Leader>j <Plug>(easymotion-j)
xmap <Leader>j <Plug>(easymotion-j)
omap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
xmap <Leader>k <Plug>(easymotion-k)
omap <Leader>k <Plug>(easymotion-k)
nmap <Leader>s <Plug>(easymotion-s2)
xmap <Leader>s <Plug>(easymotion-s2)
omap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>s <Plug>(easymotion-overwin-f2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

" vim-easy-align
nmap g= <Plug>(EasyAlign)
xmap g= <Plug>(EasyAlign)

" vim-sandwich
nmap s <Nop>
xmap s <Nop>

" youcompleteme
" nnoremap <silent> <LocalLeader>K :YcmCompleter GetDoc<CR>
" nnoremap <silent> <LocalLeader>[i :YcmCompleter GetType<CR>
" nnoremap <silent> <LocalLeader><C-]> :YcmCompleter GoTo<CR>
" nnoremap <silent> <LocalLeader><C-r> :YcmCompleter GoToReferences<CR>

" ctags
noremap <Leader>[ <C-t>
noremap <Leader>] <C-]>
noremap <Leader>} g]

"  tabs
nnoremap <Leader><C-t> :tabnew<CR>

" Vimux
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>
noremap <Leader>vq :VimuxCloseRunner<CR>
noremap <Leader>vz :call VimuxZoomRunner()<CR>

"  spliviews
nnoremap <Leader>- :split<CR>
nnoremap <Leader>\| :vsplit<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap s> <C-w>>
nnoremap s< <C-w><

" terminal
if has('nvim')
    set sh=zsh
    let g:neoterm_default_mod=':botright'
    tnoremap tt <C-\><C-n>
    nnoremap <C-t> :Ttoggle resize=14<CR>
endif

" flutter
nnoremap <leader>fs :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>

""""""""""
"  Misc  "
""""""""""
let g:tex_flavor='latex'

filetype plugin indent on
syntax on

" See :h :DiffOrig
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis

" QuickFix "
au vimrc QuickfixCmdPost [^lA-Z]* botright cwindow
au vimrc QuickfixCmdPost l* botright lwindow

let s:has_rg = executable('rg')
if s:has_rg
  set grepprg=rg\ --vimgrep\ --hidden
endif

" markdown
let g:vim_markdown_folding_disabled = 1

" spellchecks
set dictionary+=/usr/share/dict/words

" nnn
let g:nnn#command = "NNN_FIFO='/tmp/nnn.fifo' NNN_COLORS=6666 NNN_FCOLORS=c1e2272e006033f7c6d6abc4 nnn -d"
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } } 
let g:nnn#action = {
    \ '<c-t>': 'tab split',
    \ '<c-x>': 'split',
    \ '<c-v>': 'vsplit'}

" FZF "
let g:fzf_action = {
  \ 'enter': 'tab split'}
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang Compilers
  \ call vimrc#fzf_compilers(0, <bang>0)
command! -bang BCompilers
  \ call vimrc#fzf_compilers(1, <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
if s:has_rg
    command! -bang -nargs=* Grep
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)
else
  command! -bang -nargs=* Grep
    \ call fzf#vim#grep('grep -r --line-number '.shellescape(<q-args>).' *', 0, <bang>0)
endif

" EasyMotion"
let g:EasyMotion_do_mapping=0
let g:EasyMotion_smartcase=1
let g:EasyMotion_use_migemo=1

" EditorConfig
let g:EditorConfig_exclude_patterns=['fugitive://.*', '\(M\|m\|GNUm\)akefile']

" UltiSnips "
let g:UltiSnipsExpandTrigger='<C-x>x'

" airline "
let g:airline_skip_empty_sections=1
if $USE_POWERLINE
  let g:airline_powerline_fonts=1
endif

" undotree "
let g:undotree_WindowLayout=2

" tagbar "
let g:tagbar_width = 30

if has('gui_vimr')
  source ~/.config/nvim/ginit.vim
endif

" AckVim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" NerdTreeToggle "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"  auto save
" vim-auto-save
let g:auto_save = 1  " enable AutoSave on Vim startup
