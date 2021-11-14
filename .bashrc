#!/usr/bin/bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function allips(){
ifconfig|awk '/inet / {sub(/addr:/, "", $2); print $2}'
}
if [ -f /etc/bashrc ];then
. /etc/bashrc
fi

###### netinfo - shows network information for your system
function netinfo()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`curl ifconfig.me `
echo "${myip}"
echo "---------------------------------------------------"
}

HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups
HISTSIZE=2000
HISTFILESIZE=2000

set -o noclobber
set visible-stats on

complete -W "$(echo $(cat ~/.bash_history|egrep '^ssh '|sort|uniq|sed 's/^ssh //'))" ssh

# User specific aliases and functions

set -o noclobber
#shopt -s no_empty_cmd_completion

### Add more colors
    [[ -x /usr/bin/dircolors ]] && {
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias vdir="vdir --color=auto"
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"
    }

export PAGER='most'

    alias ..='cd ..;pwd'
    alias ...='cd ../..;pwd'
    alias ....='cd ../../..;pwd'
    #alias la="ls -ashtF --color=auto"
    alias la="lsd -lah"
    alias lr="lsd -larh"
    alias l="lsd -lah"
    alias ll="lsd -lah"
    alias upd="sudo dnf update -y && sudo dnf upgrade -y"
    alias ins="sudo dnf install"
    alias rem="sudo dnf remove"
    alias autorem="sudo dnf autoremove"
    alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
    alias count="find . -type f | wc -l"
    alias cpv="rsync -a -v --info=progress2"
    alias netst="sudo netstat -plnt"
    alias lazy="sudo lazydocker"
    alias rm="rm -iv"
    alias which="type -all"
    alias top="sudo bpytop"
export JAVA_HOME=/usr/lib/jvm/jre-openjdk/bin
export PATH="$HOME/bin:$HOME/bin/sublime_text:$HOME/.local/bin:$PATH"

PS1='\[\e[0;38;5;45m\]\u\[\e[0m\]@\[\e[0;91m\]\h\[\e[0m\]:\[\e[0m\][\[\e[0;1m\]\w\[\e[0m\]]\[\e[0;97m\]:\[\e[0m\]\$\[\e0 '
