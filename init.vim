" ~/.vimrc

call plug#begin('~/.local/share/nvim/plugged')
" Configuration for vim-plug
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/grep.vim'
Plug 'morhetz/gruvbox'
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'                                               " bottom status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sensible'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'junegunn/goyo.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'rizzatti/dash.vim'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-obsession'
Plug 'majutsushi/tagbar'
call plug#end()

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" Easier mappings for movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fzf/ripgrep mappings
nnoremap <C-p>p :Files<CR>
nnoremap <C-p>h :Files ~<CR>
nnoremap <C-p>l :BLines<CR>
nnoremap <C-p>g :Rg<CR>

" remove search highlight when pressing esc
nnoremap <esc> :noh<CR><esc> 

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''🐵'', ''🙈'')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

set t_Co=256
set number " line numbers
set list " visible whitespaces
syntax on
filetype plugin indent on
let g:NERDTreeWinSize = 50

" startify
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, {'d': '~/Documents'} ]

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" rainbow parentheses always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Open new buffer with Startify
nnoremap <C-f>v :vnew<CR>:Startify<CR>
nnoremap <C-f>h :new<CR>:Startify<CR>
nnoremap <C-f>n :enew<CR>:Startify<CR>

map <C-t> :NERDTreeToggle<CR>
map <F5> :e! %<CR>

set expandtab
set shiftwidth=4
au Filetype xml setlocal shiftwidth=2
au Filetype scala setlocal shiftwidth=2
colorscheme gruvbox

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
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

hi default CocHighlightText  guibg=#00bfff ctermfg=LightBlue

function! SaveIfUnsaved()
    if &modified
        :silent! w
    endif
endfunction
au FocusLost,BufLeave,InsertLeave * :call SaveIfUnsaved()
" Read the file on focus/buffer enter
au FocusGained,BufEnter * :silent! !

set noswapfile

" Reselect visual block after indent/outdent. Allow ident/outdent multiple
" times
vnoremap < <gv
vnoremap > >gv

" Markdown
let vim_markdown_preview_hotkey='<C-m>'

" Tagbar
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
    \ }
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
    \ }
nmap <F8> :TagbarToggle<CR>

" Dash
:nmap <silent> <leader>d <Plug>DashSearch

"Indent
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black   ctermbg=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=0*
