" Vim filetype detection file
" Language:     AsciiDoc
" Maintainer:   Barry Arthur <barry.arthur@gmail.com>
" URL:          http://www.methods.co.nz/asciidoc/
" Licence:      Licensed under the same terms as Vim itself
" Remarks:      Vim 6 or greater

augroup Asciidoc
  au!
  au BufRead *.txt,README,TODO,CHANGELOG,NOTES call s:FTasciidoc()
  au BufNewFile *.asciidoc set filetype=asciidoc
augroup END

" Checks for a valid AsciiDoc document title after first skipping any
" leading comments.
" Original code by Stuart Rackham <srackham@gmail.com>
function! s:FTasciidoc()
  let in_comment_block = 0
  let n = 1
  while n < 50
    let line = getline(n)
    let n = n + 1
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
  if line !~ '.\{3,}'
    return
  endif
  let len = len(line)
  let line = getline(n)
  if line !~ '[-=]\{3,}'
    return
  endif
  if len < len(line) - 3 || len > len(line) + 3
    return
  endif
  set filetype=asciidoc
endfunction

" vim: et sw=2 sts=2:
