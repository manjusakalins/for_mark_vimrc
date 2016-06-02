1: [vi 中应用]
vim支持8种cscope的查询功能，如下：

s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
d: 查找本函数调用的函数
c: 查找调用本函数的函数
t: 查找指定的字符串
e: 查找egrep模式，相当于egrep功能，但查找速度快多了
f: 查找并打开文件，类似vim的find功能
i: 查找包含本文件的文件


Cscope只在第一次解析时扫描全部文件，以后再调用cscope，它只扫描那些改动过的文件，这大大提高了cscope生成索引的速度。

下表中列出了cscope的常用选项：

-R: 在生成索引文件时，搜索子目录树中的代码
-b: 只生成索引文件，不进入cscope的界面
-q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
-k: 在生成索引文件时，不搜索/usr/include目录
-i: 如果保存文件列表的文件名不是cscope.files时，需要加此选项告诉cscope到哪儿去找源文件列表。可以使用”–“，表示由标准输入获得文件列表。
-Idir: 在-I选项指出的目录中查找头文件
-u: 扫描所有文件，重新生成交叉索引文件
-C: 在搜索时忽略大小写
-Ppath: 在以相对路径表示的文件前加上的path，这样，你不用切换到你数据库文件所在的目录也可以使用它了。

:cs kill 0
:cs add cscope.out


2：[生成]
find -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.h' -o -name '*.mk' > cscope.files
cscope -Rbq

或者加速方式：
find -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.h' -o -name '*.mk' > cscope.files
cscope -Rbkq cscope.files
cscope


2.1 [文件有改动] 重新执行即可
find -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.h' -o -name '*.mk' > cscope.files
cscope -Rbq

3 [rc ]
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

