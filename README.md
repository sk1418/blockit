**blockit** readme

	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	.. <><><><><><><><><><><><><><><><><><><><><><><><><><><> ..
	.. ^ -------------------------------------------------- ^ ..
	.. ^ |       ____   __              __      ____ __   | ^ ..
	.. ^ |      / __ ) / /____   _____ / /__   /  _// /_  | ^ ..
	.. ^ |     / __  |/ // __ \ / ___// //_/   / / / __/  | ^ ..
	.. ^ |    / /_/ // // /_/ // /__ / ,<    _/ / / /_    | ^ ..
	.. ^ |   /_____//_/ \____/ \___//_/|_|  /___/ \__/    | ^ ..
	.. ^ |                        - wrap text in block    | ^ ..
	.. ^ -------------------------------------------------- ^ ..
	.. <><><><><><><><><><><><><><><><><><><><><><><><><><><> ..
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


##Introduction
When we are coding or editing text in vim, sometimes we want to wrap some lines of text (or in visual selections) in a block, which built by ascii chars. **blockit** is the vim plugin, to make this work easily to be done. One can "draw" block in different style. Please read next section for detailed features.

##Features

- horizontal/vertical char of the block border could be defined separately
- margin between text and block border can be customized
- block width can be dynamic (auto fit text width) or fixed
- supports 4 in-block text alignment (No align., left-align., right align. center align.)
- supports line-wise and block-wise visual selection text blocking (via key-mapping)
- provide command to block line range


##Configuration
There are 5 variables could be customized to configurate block style: (more detailed information please check the plugin doc.)

varialbe                 |values                                                 |default
---                      |---                                                    |---
`g:blockit_H_char`       |`string:` horizontal border char(s)                    |`'-'`
`g:blockit_V_char`       |`string:` vertical border char(s)                      |'&#124;'
`g:blockit_margin`       |`int:` margin between text and border                  |`1`
`*g:blockit_fixed_length`|`int:` if you want the block has fixed width, value >=5|`0`
`g:blockit_align`        |`string:` one of `'c','l','r','n'`                     |`'n'` (no alignment)

**`*`** for the fixed length, please read the plugin docs for details.


##Usage

It is easy to use the **blockit** plugin. There are two commands and one mapping ready to use.

###command

- `[range]:Block`: This command will block the line range, with the settings in "Configuration" section.  
- `:BlockitVersion`  will print the current version info of installed **blockit**

###Mapping

Mapping is **only** available in `line-wise` or `block-wise` visual selection mode.

Default:

	<leader>bi

This mapping will block the visual selected text.

You can of course customize the mapping in this way:

	vmap (Your_Mapping) <Plug>BlockitVisual

##Demo

###Demo1 
- dynamic block width
- H-border `'@'`  (`g:blockit_H_char='@'`)
- V-border `'*'`  (`g:blockit_V_char='*'`)
- blockit via command
- text alignment: `center` (`g:blockit_align='c'`) 

![demo1](https://raw.github.com/sk1418/sharedResources/master/blockit/demo1.gif)

###Demo2 

Use all default configurations:

- dynamic block width
- H-char in border: `'-'` (default)
- V-char in border: `'|'`    (default)
- blockit via visual selection  (`<leader>bi`)
- text alignment: no alignment (default)

![demo2](https://raw.github.com/sk1418/sharedResources/master/blockit/demo2.gif)

###Demo3

- fixed block width: `40`   (`g:blockit_fixed_length=40`)
- H-char in border: `'.-'`  (`g:blockit_H_char='.-'`)
- V-char in border: `'..'`    (`g:blockit_V_char='..'`)
- blockit via visual selection  (`<leader>bi`)
- text alignment: `right` (`g:blockit_align='r'`) 

![demo3](https://raw.github.com/sk1418/sharedResources/master/blockit/demo3.gif)
