local helpers = require('test.functional.helpers')(after_each)
local Screen = require('test.functional.ui.screen')
local spawn, set_session, clear = helpers.spawn, helpers.set_session, helpers.clear

describe('In ext-win mode', function()
  local screen
  local nvim_argv = {helpers.nvim_prog, '-u', 'NONE', '-i', 'NONE', '-N',
                     '--cmd', 'set shortmess+=I background=light noswapfile belloff= noshowcmd noruler',
                     '--embed'}

  before_each(function()
    local screen_nvim = spawn(nvim_argv)
    set_session(screen_nvim)
    screen = Screen.new()
    -- TODO(utkarshme): should not have to set ext_multigrid
    screen:attach({ext_windows=true, ext_multigrid=true})
    screen:set_default_attr_ids({
      [1] = {bold = true, reverse = true},
      [2] = {bold = true, foreground = Screen.colors.Blue1}
    })
  end)

  after_each(function()
    screen:detach()
  end)

  it('default initial screen is correct', function()
    screen:expect([[
    ## grid 1
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
                                                           |
      {1:[No Name]                                            }|
                                                           |
    ## grid 2
      ^                                                     |
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
      {2:~                                                    }|
    ]])
  end)

end)
