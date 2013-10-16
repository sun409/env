" au! QuickFixCmdPre *.[ch] call Search_Word()
func Search_Word()
  let w = expand("<cword>")             " grab word at the current cursor
  exe "vimgrep " w " *.c *.h"
  exe 'copen'
endfun
