set nu
set mouse=a

"And then highlight something with the mouse and press Control-C to copy it.
:vmap <C-C> "+y

"tab stuff
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
call pathogen#infect('~/my_vim/{}')
source ~/.vim_runtime/mark.vim

""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif

"映射LookupFile为,lk
"nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
"nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
"nmap <silent> <leader>lw :LUWalk<cr>

" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 


""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
"autocmd BufWinEnter \[Buf\ List\] setl nonumber 

nmap <silent> <leader>bc :Bclose<cr>
nmap <silent> <leader>bb :BufExplorer<cr>


""""""""""""""""""""""""""""""
" Trinity
""""""""""""""""""""""""""""""
nmap <F8>   :TrinityToggleAll<CR>
"autocmd BufEnter * if &ft !~ '^NERD_tree*' | silent! lcd %:p:h | endif
"autocmd BufEnter * :NERDTree
"NERD_tree



""""""""""""""""""""""""""""""
" project sesion setting
""""""""""""""""""""""""""""""
" execute project related configuration in current directory
if filereadable("workspace.vim")
    "source workspace.vim
endif

if filereadable("Session.vim")
    "source Session.vim
endif
if filereadable("local.viminfo")
    "rviminfo local.viminfo
endif

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  let b:filename_info = b:sessiondir . '/local.viminfo'
  exe "mksession! " . b:filename
  exe "wviminfo! " . b:filename_info
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
"  let b:sessionfile2 = b:sessiondir . "/session2.vim"

  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
 " if (filereadable(b:sessionfile2))
 "   exe 'rviminfo ' . b:sessionfile2
 " endif
endfunction
#au VimEnter * nested :call LoadSession()
#au VimLeave * :call MakeSession()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cn help vim doc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set helplang=cn
set encoding=utf-8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow_parentheses
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufEnter * RainbowParenthesesToggleAll
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
nmap <leader>bta :RainbowParenthesesToggleAll<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" high light
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"syn match cFuntions display "[a-zA-Z_]\{-1,}\s\{-0,}(\{1}"ms=s,me=e-1
"hi def link cFuntions Function
"syn match cIMdentifier display "[->a-zA-Z_]\{-1,}\s=\s"ms=s,me=e-2
"hi def link cIdentifier Identifier
"hi cIMdentifier cterm=bold,underline ctermfg=3 guifg=1 guibg=DarkRed
