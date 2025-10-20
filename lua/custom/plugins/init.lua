-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'mfussenegger/nvim-lint',
    event = 'BufWritePost', -- or other appropriate event
    config = function()
      require('lint').setup {
        -- Global configuration for linters
        linters_by_ft = {
          markdown = { 'markdownlint' }, -- Link the 'markdown' filetype to the 'markdownlint' linter
        },
        -- You can also define custom linters if needed
        linters = {
          markdownlint = {
            cmd = 'markdownlint-cli2',
            args = { '--config', '~/.config/markdownlint.yaml', '$FILE' },
            parser = require('lint.parser').from_json,
          },
        },
      }
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'github/copilot.vim',
    -- You might add other configuration options here if needed,
    -- such as dependencies or lazy loading settings.
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          vim.ui.input({
            prompt = 'Quick Chat: ',
          }, function(input)
            if input ~= '' then
              require('CopilotChat').ask(input)
            end
          end)
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- Optional for icons
    },
    config = function()
      require('spectre').setup {
        -- Other Spectre configurations...
        vim.keymap.set('n', '<leader>sp', "<cmd>lua require('spectre').toggle()<CR>", { desc = 'Open Spectre' }),
        vim.keymap.set('n', '<leader>sx', "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = 'Open Spectre for selected word' }),
        vim.keymap.set('v', '<leader>sl', "<esc><cmd>lua require('spectre').open_visual()<CR>", { desc = 'Open Spectre for selected word' }),
        vim.keymap.set('n', '<leader>sm', "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", { desc = 'Open Spectre for selected word' }),
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    -- Optional: Add any configuration or keybindings for Fugitive here
    config = function()
      -- Example: Set a keybinding for Git status
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, desc = 'Git status' })
    end,
  },
}
