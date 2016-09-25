
# Resurrect

Resurrect reopens your last deleted buffers. When you delete a buffer Resurrect
adds it to a list of recently closed buffers and you can then use `:Resurrect`
to reopen the last closed buffer. Repeated calls to `:Resurrect` will work
through the list reopening each buffer in reverse historical order.  The
behaviour is designed to be as similar as possible to the way modern browsers
reopen last closed tabs.


## Why not...?

```
<C-^>
```

Pressing `<C-^>` will open the alternative file, which is often the buffer that
was just deleted. But repeated presses will just toggle between the two, not
open earlier files. Also the alternative file is not always the last buffer, it
depends on the language.


#### Most recently used plugins.

Plugins such as [mru.vim](https://github.com/vim-scripts/mru.vim) and
[mru](https://github.com/yegappan/mru) provide easy access to the most recently
opened files, but this is not the most recently *closed* files, and is not as
quick to just reopen.


## Installation

You can use your favorite plugin manager, I like
[vim-plug](https://github.com/junegunn/vim-plug).

```vim
Plug 'supercrabtree/vim-resurrect'
```

## Customisation

By default Resurrect reopens any kind of file but you probably want to ignore a
few kinds of file, for example anything in the `.git` dir:

```vim
let g:resurrect_ignore_patterns = [ '/.git/' ]
```

Or to also ignore all fugitive diffs:

```vim
let g:resurrect_ignore_patterns = [ '/.git/', '^fugitive://' ]
```

Each string is a regular expression and any file that matches any of them will
be ignored by Resurrect. Here is a full example:

```vim
let g:resurrect_ignore_patterns = [
\  '/.git/',
\  'fugitive://',
\  '/undotree_2',
\  '/__CtrlSF__'
\]
```
