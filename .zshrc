# プロンプト記号はシンプルにした
PROMPT='$ '

# KCODEにUTF-8を設定
export LANG=ja_JP.UTF-8
export KCODE=u           

## 色を使用出来るようにする
autoload -Uz colors
colors

## タブ補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 日本語ファイル名を表示可能にする
setopt print_eight_bit

## ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## Aliasの設定
# core
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# custom
alias iterm='open -a /Applications/iTerm.app/ .'
alias fork='open -a /Applications/Fork.app/ .'
alias cat=bat
alias ls='exa -l'
alias lzd='lazydocker'

# pecoの設定
# cortrol+rで呼び出し
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# 使用するjdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
PATH=/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin

# direnv
eval "$(direnv hook zsh)"

# zplug
source ~/.zplug/init.zsh

# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# kubectl completion
source <(kubectl completion zsh)

# kube-ps1
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

