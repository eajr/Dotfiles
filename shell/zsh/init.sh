export PATH="$HOME/bin:$HOME/.local/bin:usr/local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
export BAT_THEME="TwoDark"

ZSH_THEME="cloud"

zstyle ':omz:update' mode auto

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git 
  zsh-syntax-highlighting 
  zsh-autosuggestions 
  zsh-256color 
  brew 
  bun 
  dotenv 
  dotnet 
  golang 
  node 
  npm 
  python 
  pip 
  rust 
  tmux 
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

source $ZSH/oh-my-zsh.sh

eval "$(fzf --zsh)"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
