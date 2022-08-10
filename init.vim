"
"		  _ ____
"		 | |  _ \				  Jader Brasil <___________@gmail.com>
"		 | | |_) |						 nvim configuration file
"	 _	 | |  _ <
"	| |__| | |_) |
"	 \____/|____/
"
"
" $ figlet JB -f big
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "
let maplocalleader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" LSP: begin
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'ojroques/nvim-lspfuzzy'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    " For vsnip users.
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    "Plug 'hrsh7th/cmp-vsnip'
    "Plug 'hrsh7th/vim-vsnip'
" LSP: end

" WRITING: begin
    Plug 'ellisonleao/glow.nvim'
    Plug 'masukomi/vim-markdown-folding'
    Plug 'brymer-meneses/grammar-guard.nvim'
    "Plug 'rhysd/vim-grammarous'
    "Plug 'dpelle/vim-LanguageTool'
" WRITING: end

" LANGS: begin
    Plug 'rust-lang/rust.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'lervag/vimtex'
    Plug 'ziglang/zig.vim'
    Plug 'untitled-ai/jupyter_ascending.vim'
    Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'rafi/vim-venom', { 'for': 'python' }
    Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }
" LANGS: end

" GENERAL: begin
    Plug 'tpope/vim-surround'
    Plug 'junegunn/goyo.vim'
    Plug 'jreybert/vimagit'
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-commentary'
    Plug 'ap/vim-css-color'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'fladson/vim-kitty' "kitty.conf highlight
    Plug 'sheerun/vim-polyglot'
    Plug 'rcarriga/nvim-notify'

    Plug 'jpalardy/vim-slime' "using tmux

    "Plug 'vim-airline/vim-airline'
    Plug 'itchyny/lightline.vim'						" Lightline statusbar
    "Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'

    Plug 'preservim/nerdtree'
    "Plug 'kyazdani42/nvim-web-devicons' " for file icons
    "Plug 'kyazdani42/nvim-tree.lua'
" GENERAL: end
call plug#end()

set title
set bg=dark
colo gruvbox8
set guifont=FiraCode\ Nerd\ Font\ Mono:h16
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd

" Always change the directory to working directory of file in current buffer - http://vim.wikia.com/wiki/VimTip64
" set autochdir

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

" Tab and line stuff
	set ts=4 "tablestop
	set sw=4 "shiftwidth
	set sts=4
	set expandtab

    " wrap
    set tw=79 "text width
	set wrap linebreak "no wrap in middle of word

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Enable autocompletion:
	set wildmode=longest,list,full

    map  <C-j> <C-n>
    map! <C-j> <C-n>
    map  <C-k> <C-p>
    map! <C-k> <C-p>

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>oe :setlocal spell! spelllang=en_us<CR>
	map <leader>op :setlocal spell! spelllang=pt<CR>

"""""""""""
    " Set working directory
    nnoremap <Leader>. :lcd %:p:h<CR>

    "" Opens an edit command with the path of the currently edited file filled in
    noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

    "" Opens a tab edit command with the path of the currently edited file filled
    noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
""""""""""""""


" fzf.vim maps
    map <Leader>ff :Files<CR>
    map <Leader>FF :Rg<CR>
    map <Leader>fF :Rg<CR>

" Grammar Check with LanguageTool
    "let g:languagetool_jar='/usr/share/java/languagetool/languagetool-commandline.jar'
    "let g:languagetool_cmd='/usr/bin/languagetool'
    "let g:languagetool_lang='en-US'
    "map <leader>lp :let g:languagetool_lang='pt-BR'<CR>
    "map <leader>lc :LanguageToolClear<CR>
    "map <leader>ll :LanguageToolCheck<CR>
    """let g:languagetool_disable_rules='HUNSPELL_RULE'

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" vim-slime
    let g:slime_target = "tmux"

" jupyter_ascending
    nmap <leader>xx <Plug>JupyterExecute
    nmap <leader>xX <Plug>JupyterExecuteAll
" magma-nvim jupyter_client
    nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
    nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
    xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
    nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
    nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
    nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>

    let g:magma_automatically_open_output = v:false

" Nerd tree (nerdtree)
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" vim-airline
    let g:airline#extensions#fzf#enabled = 1

" Source source and open
	map <leader>ss :source $MYVIMRC<CR>
	map <leader>so :e $MYVIMRC<CR>

" Tabs
	" Go to tab by number
	noremap <leader>1 1gt
	noremap <leader>2 2gt
	noremap <leader>3 3gt
	noremap <leader>4 4gt
	noremap <leader>5 5gt
	noremap <leader>6 6gt
	noremap <leader>7 7gt
	noremap <leader>8 8gt
	noremap <leader>9 9gt
	noremap <leader>0 :tablast<cr>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Latex
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    " Runs a script that cleans out tex build files whenever I close out of a .tex file.
        autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
    let g:vimwiki_listsyms = ' ○◐●✓'
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Goyo plugin makes text more readable when writing prose:
	map <leader>mg :Goyo \| set bg=dark \| set linebreak<CR>
" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=120
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
	\ 'colorscheme': 'darcula',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 			  [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
	\ }

" Always show statusline
set laststatus=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically deletes all trailing whitespace and newlines at end of file on save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s/\n\+\%$//e
    call cursor(l, c)
endfun
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
	"autocmd BufWritePre * %s/\s\+$//e
	"autocmd BufWritePre * %s/\n\+\%$//e
	"autocmd BufWritePre *.[ch] %s/\%$/\r/e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

" lua stuff
lua vim.notify = require('notify')

" Vimtex
augroup Vimtex
    au FileType tex nnoremap <leader>p :VimtexTocToggle<CR>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Extra stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
for f in split(glob('~/.config/nvim/extra/[^#]*.vim'), '\n')
	exe 'source' f
endfor

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
