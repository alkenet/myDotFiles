# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#Shell hitory options
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.

#Bind keys to emacs style
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename 'homePath/.zshrc'

#Configure the prompt
autoload -Uz promptinit
promptinit
autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
autoload -Uz colors
colors
prompt adam1

#Completion and cd options
#setopt COMPLETE_ALIASES
setopt interactivecomments
setopt autocd #just type name dir for cd dir
#setopt GLOBDOTS #no need for dot for hidden variables
setopt longlistjobs
zstyle ':completion:*' special-dirs true #table complete ".." as dir
cd() {
  [[ ! -e $argv[-1] ]] || [[ -d $argv[-1] ]] || argv[-1]=${argv[-1]%/*}
  builtin cd "$@"
} #cd to dir if "cd /basedir/dir/file"

cdUndoKey() {
    popd      > /dev/null
    zle       reset-prompt
    echo
    ls
    echo
}

cdParentKey() {
    pushd .. > /dev/null
    zle      reset-prompt
    echo
    ls
    echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey

#git in right prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%r/%S %b %m%u%c"
zstyle ':vcs_info:git*' actionformats "%r/%S %b (%a) %m%u%c"
precmd () { vcs_info }
PS1="\$vcs_info_msg_0_$PS1"

export RPROMPT="%F%{$fg[red]%}\${vcs_info_msg_0_}"

#disable caps lock
setxkbmap -option caps:none

#Alias
alias ls='ls --color=auto'
alias ll='ls -lha'

#Add relevant things to PYTHONPATH
PYTHONPATH=$PYTHONPATH:relevantPath
export PYTHONPATH

#Overide files only when >| is used
set -o noclobber

#paranoia
#To avoid issues the following lines should be added to /etc/sudoers
#
#Defaults umask = 0022
#Defaults umask_override
#
umask 077

#Export relevant path
#To be Completed
export PATH=relevantPath/.gem/ruby/2.3.0/bin:$PATH
export PATH=relevantPath/anaconda3/bin:$PATH

#Fish-like shell syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh