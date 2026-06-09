local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

g.autoformat = true

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.snacks_animate = true

opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smartcase = true
opt.clipboard = "unnamedplus"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
}

opt.mouse = "a"

opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "▸",
  precedes = "◂",
  nbsp = "␣",
}

opt.colorcolumn = "120"
opt.textwidth = 0

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case -hidden --glob '!.git/*'"
  opt.grepformat = "%f:%l:%c:%m"
end

opt.wildignore = {
  "*/node_modules/*",
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*",
  "*/.DS_Store/*",
  "*/target/*",
  "*/dist/*",
  "*/build/*",
  "*/__pycache__/*",
  "*/.venv/*",
  "*/.cache/*",
}

opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "globals",
}
