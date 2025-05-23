## Debug callstack
A tiny Luanit mod that allows overriding of functions and printing their callstack when they're called

## Usage
Call `debug_callstack.get_override` providing the function and its name, and assign back to original, e.g.:

```lua
core.forceload_block = debug_callstack.get_override(core.forceload_block, "forceload_block")
```
