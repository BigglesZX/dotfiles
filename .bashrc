##
## This is intentionally incomplete right now
## I just wanted somewhere to stash a few bash snippets, not a whole file yet
##

# --- PROMPT ----

# get git branch name
function git-branch-name {
    echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

# get git dirty status
function git-dirty {
    st=$(git status 2>/dev/null | tail -n 1)
    if [ -n "$st" ]
    then
        if [[ $st != "nothing to commit (working directory clean)" ]]
        then
            echo "*"
        fi
    fi
}


function make-prompt {
    # define some colours
    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local GREEN="\[\033[0;32m\]"
    local BLUE="\[\033[0;34m\]"
    local LIGHT_RED="\[\033[1;31m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local WHITE="\[\033[1;37m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local COLOR_NONE="\[\e[0m\]"
    
    # are we in a virtualenv?
    # NOTE this line gets around the problem of virtualenvwrapper not observing PROMPT_COMMAND,
    # we just do the virtualenv prepending ourselves, no problem
    if test -z "$VIRTUAL_ENV" ; then
        local VIRTUALENV_STRING=""
    else
        local VIRTUALENV_STRING="($(basename $VIRTUAL_ENV))"
    fi

    # are we root?
    if (( $UID == 0 )) ; then
        local CHAR="#"
    else
        local CHAR="\$"
    fi

    # coloured term with user, host, cwd, git status
    PS1="${VIRTUALENV_STRING}${GREEN}\u${BLUE}@${GREEN}\h${COLOR_NONE}:${BLUE}\w${COLOR_NONE}(${YELLOW}$(git-branch-name)${RED}$(git-dirty)${COLOR_NONE})${CHAR} "
    # return to first column
    PS1="\[\033[G\]$PS1"
}

PROMPT_COMMAND=make-prompt

# --- ITERM STUFF ---
# $1 = type; 0 - both, 1 - tab, 2 - title
# rest = text
setTerminalText () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTerminalText 0 $@; }
stt_tab   () { setTerminalText 1 $@; }
stt_title () { setTerminalText 2 $@; }

source "$(dirname "${BASH_SOURCE}")/.aliases"
