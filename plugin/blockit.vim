" blockit : wrap lines in a block
" Author  : Kai Yuan <kent.yuan@gmail.com>
" License: {{{
"Copyright (c) 2014 Kai Yuan
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

if exists("g:loaded_blockit")
	finish
endif

let g:loaded_blockit = 1

let s:version = '1.0.0'
command! BlockitVersion echo "[blockit] Version: " . sversion

" mappings for visual selection
"{{{

vnoremap <silent><unique> <Plug>BlockitVisual      :<c-u>call blockit#block_visual()<cr>

if !hasmapto('<Plug>BlockitVisual', 'v')
	vmap <leader>bi <Plug>BlockitVisual
endif
"}}}
"
" blockit command
command! -range Block <line1>,<line2>call blockit#block_cmd()


" vim: fdm=marker ts=2 sw=2 tw=78 expandtab foldlevel=0
