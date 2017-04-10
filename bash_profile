export CLICOLOR=1
export TERM=xterm-color

export HOMEBREW_NO_ANALYTICS=1

alias bashprofile='nano ~/.bash_profile && source ~/.bash_profile'

# Homebrew-file: https://github.com/rcmdnk/homebrew-file
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# Text editor
export EDITOR=nano

# Erase duplicates in history
export HISTCONTROL=ignoreboth:erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

# Fix Command and Option Left/Right (iTerm Setting)
# http://stackoverflow.com/a/10485061
# FOR  ACTION         SEND
# ⌘←  "HEX CODE"      0x01
# ⌘→  "HEX CODE"      0x05
# ⌥←  "SEND ESC SEQ"  b
# ⌥→  "SEND ESC SEQ"  f

GIT_PS1_SHOWDIRTYSTATE=1
source /usr/local/etc/bash_completion.d/git-prompt.sh

# Variable Length Prompt
# Get Unicode hex string using: "echo ★ | hexdump -C"
#PROMPT_CHAR="`printf '\xE2\x98\x85'`"
PROMPT_CHAR=">"
PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:15}...${DIR:${#DIR}-20}; else CurDir=$DIR; fi'
export PS1="\[\e[32m\][\$CurDir]\[\e[0m\] \$(__git_ps1)\n${PROMPT_CHAR} \[\e[0m\]"

# SSH Autocompletion
_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh scp sftp

# Aliases
alias ll='ls -alFh'
alias sublime='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias gs="echo \"> git status\";git status"
alias gdc="git difftool --cached"
alias gd="git diff"
alias gulc="git reset --soft HEAD~1"
alias gittree="git log --all --graph --decorate --pretty=oneline --abbrev-commit"
alias gittreen="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
--date=relative"
alias glf='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn - %cr]" --decorate --numstat'
alias glc='git log --pretty=format:"%C(yellow)%h %Cgreen%ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative'

# gc [branchname] usage
# gc      => git checkout master
# gc bugs => git checkout bugs
function gc {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

## Misc
alias owm='open -a "Marked 2" '
alias clearpyc="find . -name '*.pyc' -delete"
