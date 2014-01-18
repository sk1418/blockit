" HowMuch : wrap lines in a block
" Author  : Kai Yuan <kent.yuan@gmail.com>
" License: {{{
"Copyright (c) 2013 Kai Yuan
"Permission is hereby granted, free of charge, to any person obtaining a copy of
"this software and associated documentation files (the "Software"), to deal in
"the Software without restriction, including without limitation the rights to
"use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
"the Software, and to permit persons to whom the Software is furnished to do so,
"subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
"FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
"COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
"IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
"CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists("g:autoloaded_blockit") 
  finish
endif
"let g:autoloaded_blockit = 1


"//////////////////////////////////////////////////////////////////////
"                              Variables                              /
"//////////////////////////////////////////////////////////////////////
"{{{
let g:blockit_H_char = exists('g:blockit_H_char')? g:blockit_H_char : '='
let g:blockit_V_char = exists('g:blockit_V_char')? g:blockit_V_char : '|'
let g:blockit_margin = exists('g:blockit_margin')? g:blockit_margin : 1
let g:blockit_fixed_length = exists('g:blockit_fixed_length')? g:blockit_fixed_length : 0


"}}}

"//////////////////////////////////////////////////////////////////////
"                         Helper  functions                         
"//////////////////////////////////////////////////////////////////////
"{{{
"============================
" get visual selected text
"============================
function! blockit#get_visual_text()
  try
    let v_save = @v
    normal! gv"vy
    return @v
  finally
    let @v = v_save
  endtry
endfunction

"============================
" build HowMuch error message
"============================
function! blockit#err(msg)
  echohl ErrorMsg
  echon "[blockit Err]" . a:msg
  echohl None
endfunction
"}}}



"//////////////////////////////////////////////////////////////////////
"                          Logic   functions                          /
"//////////////////////////////////////////////////////////////////////

"============================
"the block main logic 
"parameters:
"
"lines : a list, contains all text needs to be blocked
"
"return a list, with block characters
"============================
function! blockit#block(lines)
  let my_lines = a:lines
  " get maxlen
  let maxl = blockit#max_len(my_lines)
  "the header/bottom line
  let h = blockit#calc_header(maxl)
  " the string para used for map()
  let map_str = "g:blockit_V_char . repeat(' ', g:blockit_margin)"
  let map_str = map_str . ".v:val . repeat(' ', maxl-strdisplaywidth(v:val))"
  let map_str = map_str . ".repeat(' ', g:blockit_margin) . g:blockit_V_char"
  call map(my_lines, map_str)
  let result = [h]
  call extend(result, my_lines)
  call add(result,h)
  return result
endfunction

"============================
" block the text from command
"============================
function! blockit#block_cmd() range
  let lines = getline(a:firstline,a:lastline)
  execute a:firstline.','.a:lastline . ' d _'
  let real_first = a:firstline-1<0?0:a:firstline-1
  let result = blockit#block(lines)
  call append(real_first, result)
endfunction


"============================
" handle visual selection, in fact 
" only block-wise select needs special
" handling
"
" the invokation of this function should 
" be come from mapping, instread of command
"============================
function! blockit#block_visual()
  if visualmode() ==# 'v'
    call blockit#err("char-wise selection is not supported")
    return
  endif
  let txt = blockit#get_visual_text()
  let lines = split(txt, '\n')
  "line range
  let first = line("'<")
  let last  = line("'>")

  let result_txt = join(blockit#block(lines), "\n")
  "replace the original selection with blocked text
  let ve_save = &virtualedit
  let v_save = @v
  let &virtualedit = 'all'
  let pos = getpos("'<")
  let end_pos = getpos("'>")

  "add empty line before and after the visual area
  execute pos[1] . 'pu! _'
  execute end_pos[1]+1 . 'pu _'

  call setreg('v', result_txt,visualmode())
  normal! gvx
  call setpos('.', pos)
  normal! "vP

  "restore the @v reg
  let @v = v_save
  let &virtualedit = ve_save
  
endfunction



"=================================
" calculate the header/bottom border
" length, and return the built line
" For example H_char was longer than 1
" the "block" should look pretty
"=================================
function! blockit#calc_header(maxlen)
  let n = a:maxlen+(g:blockit_margin+strdisplaywidth(g:blockit_V_char))*2
  let line = repeat(g:blockit_H_char, n)
  return strpart(line, 0, n)
endfunction


"=================================
"get the max length of the line in 
"given list. the fixed_length option
"is considered too.
"=================================
function! blockit#max_len(lines)
  let maxl = 0
  if g:blockit_fixed_length > 4 "length was fixed
    let maxl = g:blockit_fixed_length - 2* (g:blockit_margin + strdisplaywidth(g:blockit_V_char))
  else
    "calculate the maxl
    for l in a:lines
      let maxl = strdisplaywidth(l)>maxl? strdisplaywidth(l):maxl
    endfor
  endif
  return maxl
endfunction



" vim: fdm=marker ts=2 sw=2 tw=78 expandtab foldlevel=0
