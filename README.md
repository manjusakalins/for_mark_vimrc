# vim_rc
nmap <F8>   :TrinityToggleAll<CR> 
nmap <unique> <silent> <F5> <Plug>LookupFile
imap <unique> <expr> <silent> <F5> (pumvisible() ? "\<Plug>LookupFileCE" :
            \ "")."\<Esc>\<Plug>LookupFile"

buffer:
number+ctrl ^


