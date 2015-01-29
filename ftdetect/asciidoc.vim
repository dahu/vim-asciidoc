" Vim filetype detection file
" Language:     AsciiDoc
" Maintainer:   Barry Arthur <barry.arthur@gmail.com>
" URL:          http://asciidoc.org/
"               https://github.com/dahu/vim-asciidoc
" Licence:      Licensed under the same terms as Vim itself
" Remarks:      Vim 6 or greater

augroup Asciidoc
  au!
  au BufRead *.txt,README,TODO,CHANGELOG,NOTES call s:FTasciidoc()
  au BufRead,BufNewFile *.asciidoc,*.adoc,*.ad set filetype=asciidoc
augroup END

" Checks for a valid AsciiDoc document title after first skipping any
" leading comments.
" Original code by Stuart Rackham <srackham@gmail.com>
function! s:FTasciidoc()
  let in_comment_block = 0
  let n = 1
  while n < 50
    let line = getline(n)
    let n += 1
    if line =~ '^/\{4,}$'
      if ! in_comment_block
        let in_comment_block = 1
      else
        let in_comment_block = 0
      endif
      continue
    endif
    if in_comment_block
      continue
    endif
    if line !~ '\(^//\)\|\(^\s*$\)'
      break
    endif
  endwhile
  if line =~ '^[=#]\+\s\+\w'
    set filetype=asciidoc
    return
  endif
  let len = len(line)
  if len < 3
    return
  endif
  let nextline = getline(n)
  if nextline !~ '[-=]\{3,}'
    return
  endif
  let nextlen = len(nextline)
  if len < (nextlen - 3) || len > (nextlen + 3)
    return
  endif
  set filetype=asciidoc
endfunction
