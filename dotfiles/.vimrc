colorscheme koehler
syntax on

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent
set expandtab

set hlsearch

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,utf-8

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
