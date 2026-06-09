return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "groovy",
        "css",
        "latex",
        "norg",
        "scss",
        "vue",
        "html",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
}
