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

let g:blockit_H_char = exists('g:blockit_H_char')? g:blockit_H_char : '=-'
let g:blockit_V_char = exists('g:blockit_V_char')? g:blockit_V_char : '|'
let g:blockit_margin = exists('g:blockit_margin')? g:blockit_margin : 1
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
}}}



"//////////////////////////////////////////////////////////////////////
"                          Logic   functions                          /
"//////////////////////////////////////////////////////////////////////
function! blockit#print_result() range
	
		
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
	let txt = blockit#get_visual_text()
	let lines = split(txt, '\n')
	"line range
	let first = line("'<")
	let last  = line("'>")
endfunction


"============================
"the block main logic 
"parameters:
"
"first : the first line number
"last  : the first line number
"lines : a list, contains all text needs to be blocked
"
"return a list, with block characters
"============================
function! blockit#block(first, last, lines)
    let lines = getline(a:first,a:last)
    let maxl = 0
    for l in lines
        let maxl = strdisplaywidth(l)>maxl? strdisplaywidth(l):maxl
    endfor
	"the header/bottom line
    let h = blockit#calc_header(maxl)
	" the string para used for map()
	let map_str = "g:blockit_V_char . repeat(' ', g:blockit_margin)"
	let map_str = map_str . ".v:val . repeat(' ', maxl-strdisplaywidth(v:val))"
	let map_str = map_str . ".repeat(' ', g:blockit_margin) . g:blockit_V_char"
	call map(lines, map_str)
    let result = [h]
    call extend(result, lines)
    call add(result,h)
    execute a:first.','.a:last . ' d _'
    let s = a:first-1<0?0:a:first-1
    call append(s, result)
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

"TODO fixed width block
