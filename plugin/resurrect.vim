if exists("g:resurrect_loaded")
  finish
endif

let g:resurrect_loaded = 1
let g:resurrect_home = $HOME.'/.vim/resurrect'
let g:resurrect_dir = $HOME.'/.vim/resurrect'.getcwd()
let s:resurrect_file = g:resurrect_dir.'/resurrect.txt'

if !isdirectory(g:resurrect_dir)
  call mkdir(g:resurrect_dir, 'p')
endif

if !filereadable(s:resurrect_file)
  call writefile([], s:resurrect_file)
endif


function! s:stripEmptyLines(list)
  return filter(a:list, '!empty(v:val)')
endfunction


function! s:onVimLeave()
  call writefile(s:resurrect_file_lines, s:resurrect_file)
endfunction


function! s:onBufAdd(filename)
  let l:withoutFileName = filter(s:resurrect_file_lines, 'v:val != "'.a:filename.'"')
  let s:resurrect_file_lines = l:withoutFileName
endfunction


function! s:onBufDelete(filename)
  if empty(a:filename)
    return
  endif
  let l:withoutFileName = filter(s:resurrect_file_lines, 'v:val != "'.a:filename.'"')
  let s:resurrect_file_lines = [a:filename] + l:withoutFileName
endfunction


function! s:onVimLeave()
  call writefile(s:resurrect_file_lines, s:resurrect_file)
endfunction


function! s:resurrectBuffer()
  if len(s:resurrect_file_lines) == 0
    echo 'No more buffers to resurrect'
    return
  endif
  execute 'edit' s:resurrect_file_lines[0]
endfunction


let s:resurrect_file_lines = readfile(s:resurrect_file)
let s:resurrect_file_lines = s:stripEmptyLines(s:resurrect_file_lines)


augroup resurrect
  au!
  au BufAdd * call s:onBufAdd(expand('<afile>:p'))
  au BufDelete * call s:onBufDelete(expand('<afile>:p'))
  au VimLeave * call s:onVimLeave()
augroup END

command! Resurrect call s:resurrectBuffer()

