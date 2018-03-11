"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set line break
set linebreak
set textwidth=0
set wrapmargin=0

" to recognize a list header
set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s*
set formatoptions+=n

"show the tabes
set list
set listchars=tab:\|\ ,trail:·,extends:#,nbsp:.

"do not break words joined by the following characters
set iskeyword+=_,@

" make >> and << work better
set shiftround

" wrap or not
set wrap
set whichwrap+=<,>,[,],h,l,b,s,~

" A buffer becomes hidden when it is abandoned
set hid

" use dialog when file was not saved
set confirm

"inline replace
set gdefault

"set auto-complete
set completeopt=longest,menu

"share clipboard
set clipboard+=unnamedplus

" set delay
set timeoutlen=1000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Screen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add a bit extra margin to the left
set foldcolumn=3

" Increase the space between lines
set linespace=3

"show the command typing
set showcmd

" Try to keep the cursor line in the vertically center (27 lines)
set scrolloff=3

"Always show current position
set ruler

"show line number
set number

" hightlight current line/col
"set cursorline
"set cursorcolumn

" colorscheme and background
let $VIM_TUI_ENABLE_TRUE_COLOR=1
"colorscheme Tomorrow-Night-Bright
set t_ut=

" colors
set colorcolumn=+1
hi ColorColumn NONE ctermbg=Cyan

"set font
""set guifont=Ubuntu\ Mono\ 13
"set guifont=DejaVu\ Sans\ Mono\ 12

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set dir to the current file's directory.
set autochdir

" Open dialog defaults to the current file's directory.
set browsedir=buffer

"Chinese vim messages (windows)
language messages zh_CN.utf-8

" encodeing just opened file.
set fileencodings=utf8,gbk,ucs-bom,cp936,gb2312,gb18030,big5,euc-jp,euc-kr

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ exec ":call UpdateCopyright()" |
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ exe "normal! zz" |
    \ endif

" Automatically update copyright notice with current year
autocmd BufWritePre *
    \ exec ":call UpdateCopyright()" |
    \ exec ":call DeleteTrailingWS()" |
    \ let &backupext = '.-' . strftime("%Y%m%d-%H%M%S")

" enable omni-completion
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType perl set omnifunc=perlcomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType node set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType cpp set omnifunc=cppcomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType d set omnifunc=ccomplete#Complete
autocmd Filetype octave set omnifunc=syntaxcomplete#Complete
autocmd FileType go set omnifunc=gocomplete#Complete

" commenting blocks of code.
                                       let b:comment_leader = '// '
autocmd FileType c,d,cpp,java,scala,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python,text   let b:comment_leader = '#  '
autocmd FileType conf,fstab,perl       let b:comment_leader = '#  '
autocmd FileType tex,octave            let b:comment_leader = '%  '
autocmd FileType mail                  let b:comment_leader = '>  '
autocmd FileType vim                   let b:comment_leader = '"  '
autocmd FileType lisp                  let b:comment_leader = ';; '
autocmd FileType haskell,vhdl,ada      let b:comment_leader = '-- '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Map \ to replace
noremap \ :1,$s/%/ic

" Disable highlight when <leader>/ is pressed.
noremap <silent> <leader>/ :noh<CR>

" Del the tailing ^M (to work with MSDOS files)
noremap <Leader>; mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

" Opens a new tab with the current buffer's path
noremap <leader><CR> :tabedit <c-r>=expand("%:p:h")<CR>/

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<CR>`z
nnoremap <M-k> mz:m-2<CR>`z
vnoremap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

" Delete trailing white spaces
noremap <leader><BS> :%s/\s\+$//ge<CR>

" F6: toggle and untoggle spell checking
noremap <F6> :setlocal spell!<CR>

" F7: build something
au FileType go nmap <F7> <Plug>(go-build)
au FileType tex nmap <F7> :!xelatex %<CR>
au FileType markdown nmap <F7> :!pandoc -f markdown+lhs % -o markdown.html -t dzslides -i -s -S --toc<CR>

" F8: open vim file explorer
noremap <F8> :NERDTreeToggle<CR>

" F9: run according to filetypes
au FileType go nmap <F5> :terminal<CR><Plug>(go-run)
au FileType python let g:pymode_run_bind = "<F5>"

" F10: be focus
noremap <F10> :Goyo<CR>

" F11: tags
noremap <F11> 2o<ESC>k:call AddPartingLine()<CR>j

" F12 attach copyright things
noremap <F12> :call AddCopyright()<CR>:call ProcessEnv()<CR>

" backspace in Visual mode deletes selection
vnoremap <BS> d
inoremap <C-BS> <C-W>
inoremap <C-Del> <C-O>dw

" Use CTRL-S for saving, also in Insert mode
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" CTRL-F4 is Close window
noremap  <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" emacsish keybindings
noremap  <C-G> <Esc>
vnoremap <C-G> <Esc>
snoremap <C-G> <Esc>
inoremap <C-G> <Esc>
cnoremap <C-G> <Esc>

" run a command
noremap  <C-Z> :
vnoremap <C-Z> :
snoremap <C-Z> :
inoremap <C-Z> <C-O>:

"Change Y to yank to end of line
map Y y$

" paste over without overwriting register
xnoremap p pgvy
xnoremap P Pgvy

" To avoid the extra 'shift' keypress when typing the colon to go to cmdline mode
noremap ; :
noremap ;; ;

" Quickly insert parenthesis/brackets/etc.:
inoremap <leader>( ()<esc>i
inoremap <leader>[ []<esc>i
inoremap <leader>{ {}<esc>i
inoremap <leader>' ''<esc>i
inoremap <leader>" ""<esc>i
inoremap <leader>` ``<esc>i
inoremap <leader>$ $$<esc>i
inoremap <leader>\| \|\|<esc>i

" brackets
inoremap <expr> <silent> ( MayCloseParentheses('(')
inoremap <expr> <silent> [ MayCloseParentheses('[')
inoremap <expr> <silent> { MayCloseParentheses('{')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
      buffer #
    else
      bnext
    endif
    if bufnr("%") == l:currentBufNum
      new
    endif
    if buflisted(l:currentBufNum)
      execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction

function! MayCloseParentheses(cmd)
    if col('.') == col('$')
        if a:cmd == '('
            return "()\<Left>"
        elseif a:cmd == '{'
            return "{}\<Left>"
        elseif a:cmd == '['
            return "[]\<Left>"
        endif
    else
        if a:cmd == '('
            return "("
        elseif a:cmd == '['
            return "["
        elseif a:cmd == '{'
            return "{"
        endif
    endif
endfunction

function! AddPartingLine()
    call append(line('.'), b:comment_leader . " · <=>---<=>   <=>---<=>   <=>---<=>   <=>---<=>   <=>---<=>   <=>---<=>")
endfunction

function! AddCopyright()
    call append(0, b:comment_leader . "==============================================")
    call append(1, b:comment_leader . "·")
    call append(2, b:comment_leader . "· Author: Maoji Wang")
    call append(3, b:comment_leader . "·")
    call append(4, b:comment_leader . "· maoji.wang@cs.nyu.edu")
    call append(5, b:comment_leader . "·")
    call append(6, b:comment_leader . "· Filename: ".expand("%:t"))
    call append(7, b:comment_leader . "·")
    call append(8, b:comment_leader . "· COPYRIGHT ".strftime("%Y"))
    call append(9, b:comment_leader . "·")
    call append(10, b:comment_leader . "· Description:")
    call append(11, b:comment_leader . "·")
    call append(12, b:comment_leader . "==============================================")
    call append(13, "")
    echohl WarningMsg | echo "copyright information added." | echohl None
endfunction

function! UpdateCopyright()
    let n=1
    while n < 20
        let line = getline(n)
        if line =~ '\s*\S*COPYRIGHT\S*.*$'
            if line !~ strftime("%Y")
                exe "g#\\cCOPYRIGHT \\(".strftime("%Y")."\\)\\@![0-9]\\{4\\}\\(-".strftime("%Y")."\\)\\@!#s#\\([0-9]\\{4\\}\\)\\(-[0-9]\\{4\\}\\)\\?#\\1-".strftime("%Y")
            endif
            echohl WarningMsg | echo "copyright information updated." | echohl None
            return
        endif
        let n = n + 1
    endwhile
    echohl WarningMsg | echo "no copyright information found." | echohl None
endfunction

function! ProcessEnv()
    let n=1
    while n < 3
        let line = getline(n)
        if line =~ '\s*\S*env\S*.*$'
            echohl WarningMsg | echo "env information exists." | echohl None
            return
        endif
        let n = n + 1
    endwhile
    if &filetype == 'tex'
        call append(0, b:comment_leader . "!/usr/bin/env pdflatex")
    elseif &filetype == 'sh'
        call append(0, b:comment_leader . "!/usr/bin/env fish")
    elseif &filetype == 'python' || &filetype == 'py'
        call append(0, b:comment_leader . "!/usr/bin/env python")
    elseif &filetype == 'octave' || &filetype == 'm'
        call append(0, "#  !/usr/bin/env octave")
    else
        call append(0, b:comment_leader . "!/usr/bin/env " . &filetype)
    endif
    call append(1, b:comment_leader . "-*- coding:utf-8 -*-")
    call append(2, "")
    echohl WarningMsg | echo "env information added(gg check it)!" | echohl None
endfunction

augroup LargeFile
        " Set options:
        "   eventignore+=FileType (no syntax highlighting etc
        "   assumes FileType always on)
        "   noswapfile (save copy of file)
        "   bufhidden=unload (save memory when other file is viewed)
        "   buftype=nowritefile (is read-only)
        "   undolevels=-1 (no undo possible)
        let g:large_file = 1048576 " 1MB

        au BufReadPre *
                \ let f=expand("<afile>") |
                \ if getfsize(f) > g:large_file |
                        \ set eventignore+=FileType |
                        \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
                \ else |
                        \ set eventignore-=FileType |
                \ endif
augroup END
