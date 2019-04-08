" PSR-2 configuration
setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPhpIndent()
setlocal indentkeys+=0=,0),=EO,o,O,*<Return>,<>>,<bs>,{,}

" Only define the function once.
if exists("*GetPhpIndent")
    finish
endif

function GetPhpIndent()
    " Find a non-empty line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " Hit the start of the file, use zero indent.
    if lnum == 0
        return 0
    endif

    let line = getline(lnum)    " last line
    let cline = getline(v:lnum) " current line
    let ind = indent(lnum)

    let restore_ic=&ic
    let &ic=1 " ignore case

    let ind = <SID>HtmlIndentSum(lnum, -1)
    let ind = ind + <SID>HtmlIndentSum(v:lnum, 0)

    let &ic=restore_ic

    let ind = indent(lnum) + (&sw * ind)

    " Indent: Braces {}, (), and []
    if line =~ '[{(\[]\s*\(?>\s*\)\=$'
       let ind = ind + &sw
    endif

    if cline =~ '^\s*\(<?php\s*\)\=[)}\]]'
       let ind = ind - &sw
       if searchpairpos('^\s*switch\s*(', '', '}', 'b')[0] != 0
          let ind = ind - &sw
       endif
    endif

    " Indent: implements
    if line =~ 'implements\s*$'
       let ind = ind + &sw
    endif

    if cline =~ '^\s*{'
       if searchpairpos('^\s*class\|^\s*abstract\s\+class', '', '{', 'b')[0] != 0
          let ind = ind - &sw
       endif
    endif

    " Indent: switch, case
    if line =~ '^\s*\(case.*\|default\s*\):'
       let ind = ind + &sw
    endif
    if cline =~ '^\s*\(case.*\|default\s*\):' && line !~ '^\s*switch\s*('
       let ind = ind - &sw
    endif

    " Intend: block comment
    if line =~ '^\s*\/\*' && line !~ '\*\/'
       let ind = ind + 1
    endif

    if line =~ '\*\/\s*$' && line !~ '\/\*'
       let ind = ind - 1
    endif

    return ind
endfunction


" [-- helper function to assemble tag list --]
fun! <SID>HtmlIndentPush(tag)
    if exists('g:html_indent_tags')
        let g:html_indent_tags = g:html_indent_tags.'\|'.a:tag
    else
        let g:html_indent_tags = a:tag
    endif
endfun


" [-- <ELEMENT ? - - ...> --]
call <SID>HtmlIndentPush('a')
call <SID>HtmlIndentPush('abbr')
call <SID>HtmlIndentPush('acronym')
call <SID>HtmlIndentPush('address')
call <SID>HtmlIndentPush('article')
call <SID>HtmlIndentPush('aside')
call <SID>HtmlIndentPush('audio')
call <SID>HtmlIndentPush('b')
call <SID>HtmlIndentPush('bdo')
call <SID>HtmlIndentPush('big')
call <SID>HtmlIndentPush('blockquote')
call <SID>HtmlIndentPush('body')
call <SID>HtmlIndentPush('button')
call <SID>HtmlIndentPush('canvas')
call <SID>HtmlIndentPush('caption')
call <SID>HtmlIndentPush('center')
call <SID>HtmlIndentPush('cite')
call <SID>HtmlIndentPush('code')
call <SID>HtmlIndentPush('colgroup')
call <SID>HtmlIndentPush('del')
call <SID>HtmlIndentPush('dfn')
call <SID>HtmlIndentPush('dir')
call <SID>HtmlIndentPush('div')
call <SID>HtmlIndentPush('dl')
call <SID>HtmlIndentPush('em')
call <SID>HtmlIndentPush('fieldset')
call <SID>HtmlIndentPush('font')
call <SID>HtmlIndentPush('footer')
call <SID>HtmlIndentPush('form')
call <SID>HtmlIndentPush('frameset')
call <SID>HtmlIndentPush('h1')
call <SID>HtmlIndentPush('h2')
call <SID>HtmlIndentPush('h3')
call <SID>HtmlIndentPush('h4')
call <SID>HtmlIndentPush('h5')
call <SID>HtmlIndentPush('h6')
call <SID>HtmlIndentPush('head')
call <SID>HtmlIndentPush('header')
call <SID>HtmlIndentPush('html')
call <SID>HtmlIndentPush('i')
call <SID>HtmlIndentPush('iframe')
call <SID>HtmlIndentPush('ins')
call <SID>HtmlIndentPush('kbd')
call <SID>HtmlIndentPush('label')
call <SID>HtmlIndentPush('legend')
call <SID>HtmlIndentPush('main')
call <SID>HtmlIndentPush('map')
call <SID>HtmlIndentPush('menu')
call <SID>HtmlIndentPush('nav')
call <SID>HtmlIndentPush('noframes')
call <SID>HtmlIndentPush('noscript')
call <SID>HtmlIndentPush('object')
call <SID>HtmlIndentPush('ol')
call <SID>HtmlIndentPush('optgroup')
call <SID>HtmlIndentPush('p')
call <SID>HtmlIndentPush('pre')
call <SID>HtmlIndentPush('q')
call <SID>HtmlIndentPush('s')
call <SID>HtmlIndentPush('samp')
call <SID>HtmlIndentPush('script')
call <SID>HtmlIndentPush('section')
call <SID>HtmlIndentPush('select')
call <SID>HtmlIndentPush('small')
call <SID>HtmlIndentPush('span')
call <SID>HtmlIndentPush('strong')
call <SID>HtmlIndentPush('style')
call <SID>HtmlIndentPush('sub')
call <SID>HtmlIndentPush('sup')
call <SID>HtmlIndentPush('table')
call <SID>HtmlIndentPush('tbody')
call <SID>HtmlIndentPush('td')
call <SID>HtmlIndentPush('textarea')
call <SID>HtmlIndentPush('tfoot')
call <SID>HtmlIndentPush('th')
call <SID>HtmlIndentPush('thead')
call <SID>HtmlIndentPush('title')
call <SID>HtmlIndentPush('tr')
call <SID>HtmlIndentPush('tt')
call <SID>HtmlIndentPush('u')
call <SID>HtmlIndentPush('ul')
call <SID>HtmlIndentPush('var')

delfun <SID>HtmlIndentPush

set cpo-=C

" [-- count indent-increasing tags of line a:lnum --]
fun! <SID>HtmlIndentOpen(lnum)
    let s = substitute('x'.getline(a:lnum),
                \ '.\{-}\(\(<\)\('.g:html_indent_tags.'\)\>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-decreasing tags of line a:lnum --]
fun! <SID>HtmlIndentClose(lnum)
    let s = substitute('x'.getline(a:lnum),
                \ '.\{-}\(\(<\)/\('.g:html_indent_tags.'\)\>>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-increasing '{' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentOpenAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^{]\+', '', 'g'))
endfun

" [-- count indent-decreasing '}' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentCloseAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^}]\+', '', 'g'))
endfun

" [-- return the sum of indents respecting the syntax of a:lnum --]
fun! <SID>HtmlIndentSum(lnum, style)
    if a:style == match(getline(a:lnum), '^\s*</')
        if a:style == match(getline(a:lnum), '^\s*</\<\('.g:html_indent_tags.'\)\>')
            let open = <SID>HtmlIndentOpen(a:lnum)
            let close = <SID>HtmlIndentClose(a:lnum)
            if 0 != open || 0 != close
                return open - close
            endif
        endif
    endif
    if '' != &syntax &&
                \ synIDattr(synID(a:lnum, 1, 1), 'name') =~ '\(css\|java\).*' &&
                \ synIDattr(synID(a:lnum, strlen(getline(a:lnum)) - 1, 1), 'name')
                \ =~ '\(css\|java\).*'
        if a:style == match(getline(a:lnum), '^\s*}')
            return <SID>HtmlIndentOpenAlt(a:lnum) - <SID>HtmlIndentCloseAlt(a:lnum)
        endif
    endif
    return 0
endfun

" vim: set ts=3 sw=3:
