1：[以下脚本可以生成文件名的索引]
#!/bin/sh
# generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
find . -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | \
    sort -f >> filenametags 


2：[在filenametags的目录位置： ]
:let g:LookupFile_TagExpr = '"./filenametags"' 

注：如果不设定g:LookupFile_TagExpr的值，那么lookupfile插件会以tags选项定义的文件作为它的tag文件。

3：[使用]：
现在我们就可以使用lookupfile来打开文件了，按”<F5>“或输入”:LookupFile“在当前窗口上方打开一个lookupfile小窗口，开始输入文件名（至少4个字符），随着你的输入，符合条件的文件就列在下拉列表中了。文件名可以使用vim的正则表达式，这大大方便了文件的查找。你可以用”CTRL-N“和”CTRL-P“（或者用上、下光标键）来在下拉列表中选择你所需的文件。选中文件后，按回车，就可以在之前的窗口中打开此文件。

4：
[缓冲区查找]
:LUBufs

5：
[浏览目录]
:LUWalk


6：[Lookupfile配置]
Lookupfile插件提供了一些配置选项，通过调整这些配置选项，使它更符合你的工作习惯。下面是我的vimrc中关于lookupfile的设置，供参考：

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
nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>

[大小写不区分]
在用lookupfile插件查找文件时，是区分文件名的大小写的，如果想进行忽略大小写的匹配，可以使用vim忽略大小写的正则表达式，即在文件名的前面加上”\c”字符。举个例子，当你输入”\cab.c”时，你可能会得到”ab.c”、”Ab.c”、”AB.c”…
通常情况下我都进行忽略大小写的查找，每次都输入”\c”很麻烦。没关系，lookupfile插件提供了扩展功能，把下面这段代码加入你的vimrc中，就可以每次在查找文件时都忽略大小写查找了：

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
