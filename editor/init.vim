" Ajmal Khan Neovim Config

call plug#begin("~/.vim/plugged")
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mhartington/oceanic-next'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': ['java']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ap/vim-buftabline'
Plug 'terryma/vim-expand-region'
Plug 'itchyny/vim-cursorword'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
call plug#end()

" Incsearch {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
"}}}

" Easymotion {{{
" <Leader>f{char} to move to {char}
map  <Space>f <Plug>(easymotion-bd-f)
nmap <Space>f <Plug>(easymotion-overwin-f)
" Move to line
map <Space>l <Plug>(easymotion-bd-jk)
nmap <Space>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
"}}}

" Enable line numbers
set number

" Oceanic-Next Theme
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

" Remap buffer switching
map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>

" Open file in Vim using FZF Ctrl-p
nmap <silent> <c-p> :Files<cr>

" Toggle NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>

" Deoplete {{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
"}}}

" Execute current Python3 file with F5
map <F5> :w<CR>:!python3 %<CR>

" Emacs motion keys added for Insert Mode for Vim
imap <C-a> <ESC>I
imap <C-e> <ESC>A
imap <C-f> <RIGHT>
imap <C-b> <LEFT>
imap <C-n> <DOWN>
imap <C-p> <UP>
" Coc.nvim {{{

" Basic {{{
set nobackup
set nowritebackup
set lazyredraw
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
"}}}

" Extensions {{{
let g:coc_global_extensions = [
\   'coc-yank',
\   'coc-python',
\   'coc-json',
\   'coc-snippets'
\ ]
"}}}

" Configuration {{{
let g:coc_user_config = {
\   'coc.preferences': {'formatOnSaveFiletypes': [ "python"]},
\   'suggest': {'floatEnable':1, 'enablePreview':1},
\   'diagnostic': {
\       'errorSign'             : '',
\       'warningSign'           : '',
\       'infoSign'              : '',
\       'hintSign'              : 'ﯦ',
\   },
\   'python': {
\       'jediEnabled'           : 0,
\       'linting.enabled'       : 1,
\       'linting.pylintEnabled' : 1,
\       'sortImports.path'      : '/usr/local/bin/isort',
\       'formatting.provider'   : 'autopep8',
\   },
\   'yank': {
\       'highlight.duration'    : 200,
\       'list.maxsize'          : 50,
\   },
\   'json': {
\       'format.enable'         : 1 ,
\   },
\ }

augroup vimrc
  autocmd VimEnter *
  \   if exists('g:did_coc_loaded')
  \|    for [key, value] in items(g:coc_user_config)
  \|        call coc#config(key, value)
  \|        unlet key value
  \|    endfor
  \|  endif
augroup end
"}}}

" Proper highlighting for config file {{{
autocmd FileType json syntax match Comment +\/\/.\+$+
"}}}

" Mappings {{{

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K for documentation preview
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" <l>rn for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"}}}

" Sign Colors {{{
hi CocInfoSign     ctermfg=Blue   guifg=#8caddb
hi CocHintSign     ctermfg=Gray   guifg=#b0b0b0
hi CocWarningSign  ctermfg=Yellow guifg=#f7cb45
"}}}

" Coc-Yank {{{
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
"}}}

" Coc-Snippets {{{
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"}}}

" Lightline {{{
let g:lightline = {
\ 'colorscheme': 'deepspace',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'cocstatus', 'modified', 'coc_error', 'coc_warning', 'coc_info', 'coc_hint' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent'  ],
\              [ 'fileformat', 'fileencoding', 'filetype'] ]
\ },
\ 'component_function': {
\   'cocstatus' : 'CocStatus'
\ },
\ 'component_expand': {
\   'coc_error'        : 'LightlineCocErrors',
\   'coc_warning'      : 'LightlineCocWarnings',
\   'coc_info'         : 'LightlineCocInfos',
\   'coc_hint'         : 'LightlineCocHints',
\   'coc_fix'          : 'LightlineCocFixes',
\ },
\ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
    let info = get(b:, 'coc_diagnostic_info', 0)
    if empty(info) || get(info, a:kind, 0) == 0
        return ''
    endif
    try
        let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
    catch
        let s = ''
    endtry
    return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
    return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
    return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
    return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
    return s:lightline_coc_diagnostic('hint', 'hint')
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
"}}}

" Using floating windows of Neovim to start fzf
if has('nvim')
  function! FloatingFZF(width, height, border_highlight)
    function! s:create_float(hl, opts)
      let buf = nvim_create_buf(v:false, v:true)
      let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
      let win = nvim_open_win(buf, v:true, opts)
      call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
      call setwinvar(win, '&colorcolumn', '')
      return buf
    endfunction
    " Size and position
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)
    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]
    " Draw frame
    let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)
    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
  endfunction
  let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }
endif

" Default Command
let $FZF_DEFAULT_COMMAND = 'fd -HI -tf'
let $FZF_DEFAULT_OPTS = '--ansi --layout=reverse --bind ctrl-a:select-all'
" Files with preview
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Goyo with Limelight for Focus Mode in Vim
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Enable Relative Line Numbers
set relativenumber
