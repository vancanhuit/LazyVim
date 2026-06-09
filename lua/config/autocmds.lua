-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ~/.config/nvim/lua/config/autocmds.lua
-- DevOps-focused filetype and large-file behavior.

local augroup = vim.api.nvim_create_augroup("devops_options", { clear = true })

-- YAML / Kubernetes / Helm / CI files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "yaml", "yaml.docker-compose", "helm", "gotmpl" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "100"
    vim.opt_local.wrap = false
  end,
})

-- Terraform / OpenTofu / HCL
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "terraform", "hcl" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.commentstring = "# %s"
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Shell scripts
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Makefiles require real tabs.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Logs: wrap visually, no spell, no heavy editing assumptions.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "log" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.number = true
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
    vim.opt_local.list = false
  end,
})

-- Common DevOps-ish filenames that benefit from explicit filetypes.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = {
    "*.tfvars",
    "*.tf",
    "*.hcl",
  },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = {
    "Dockerfile.*",
    "*.Dockerfile",
  },
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = {
    ".env",
    ".env.*",
    "*.env",
  },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Large files: avoid slow highlighting/plugins for giant logs, generated YAML, plans, etc.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup,
  callback = function(args)
    local ok, stat = pcall(vim.loop.fs_stat, args.file)
    if not ok or not stat then
      return
    end

    local size = stat.size or 0
    if size > 1024 * 1024 then -- > 1 MiB
      vim.b.large_file = true
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.list = false
      vim.opt_local.relativenumber = false
    end
  end,
})
