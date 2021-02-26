" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'vim-scripts/paredit.vim'
Plug 'morhetz/gruvbox'
Plug 'ncm2/float-preview.nvim'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf'
Plug 'vim-test/vim-test'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'Olical/conjure', { 'tag': 'v4.3.1' }
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'mhinz/vim-signify'
call plug#end()

" General
set number
set textwidth=120
set fo+=tl
set autoindent
set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2
au Filetype gitcommit set spell
set spelllang=en_US
set ignorecase
set smartcase
set clipboard=unnamedplus
map q <Nop>
set mmp=5000

"augroup numbertoggle
  "autocmd!
  "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

let mapleader = ","
let maplocalleader = ","
let g:LanguageClient_settingsPath=".lsp/settings.json"
"set completeopt-=preview
set hidden
" Highlight over 120 chars
match Error /\%121v.\+/
""Coc Explorer
:nmap <leader>pt :CocCommand explorer<CR>

" Coc
" Remap keys for gotos
" let g:coc_global_extensions = ['coc-conjure', 'coc-tsserver', 'coc-eslint']
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-lua']
command! -nargs=0 Format :call CocAction('format')

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <Tab> coc#refresh()
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
nmap <silent> [k :CocPrev<cr>
nmap <silent> ]k :CocNext<cr>
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
nnoremap <silent> sk :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

" Highlight symbol under cursor on CursorHold      
autocmd CursorHold * silent call CocActionAsync('highlight')
" Signature Help
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Rainbow
let g:rainbow_active = 1

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Gruvbox
autocmd vimenter * colorscheme gruvbox

" CntrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"Ale
let g:ale_fixers = {
    \  'javascript': ['eslint'],
    \  'typescript': ['eslint'],
    \ }

" Vim-clap
let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden -g "!.git/"'

nnoremap <leader>ac :Clap grep ++query=<cword><cr>
nnoremap <leader>fg :Clap grep<cr>
nnoremap <leader>fa :Clap grep ++opt=--no-ignore<cr>
nnoremap <leader>ff :Clap files --hidden<cr>
nnoremap <leader>fb :Clap buffers<cr>
nnoremap <leader>fw :Clap windows<cr>
nnoremap <leader>fr :Clap history<cr>
nnoremap <leader>fh :Clap command_history<cr>
nnoremap <leader>fj :Clap jumps<cr>
nnoremap <leader>fl :Clap blines<cr>
nnoremap <leader>fL :Clap lines<cr>
nnoremap <leader>fc :Clap commits<cr>
nnoremap <leader>ft :Clap filetypes<cr>
nnoremap <leader>fm :Clap marks<cr>
nnoremap <leader>el :Clap loclist<CR>

" NERDcommenter
noremap <leader>c :call NERDComment(0,"toggle")<CR>
filetype plugin on
let NERDSpaceDelims=1

" Vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" COC Tsserver
nmap <silent> tss :call CocAction('runCommand', 'tsserver.organizeImports')<CR>

" Terminal
:tnoremap <Esc> <C-\><C-n>

" Autoread
set autoread
au FocusGained,BufEnter * :checktime

" Python
let g:pymode_lint_ignore = "E501,W"
let g:ale_python_flake8_options = "--ignore=E501"
let test#python#runner = 'pytest'
