#!/usr/bin/bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

###### find the IP addresses that are currently online in your network
function localIps()
{
for i in {1..254}; do
    x=`ping -c1 -w1 192.168.1.$i | grep "%" | cut -d"," -f3 | cut -d"%" -f1 | tr '\n' ' ' | sed 's/ //g'`
    if [ "$x" == "0" ]; then
        echo "192.168.1.$i"
    fi
done
}

function apt-history() {
      case "$1" in
        install)
              cat /var/log/dpkg.log | grep 'install '
              ;;
        upgrade|remove)
              cat /var/log/dpkg.log | grep $1
              ;;
        rollback)
              cat /var/log/dpkg.log | grep upgrade | \
                  grep "$2" -A10000000 | \
                  grep "$3" -B10000000 | \
                  awk '{print $4"="$5}'
              ;;
        *)
              cat /var/log/dpkg.log
              ;;
      esac
}

function cds() {
    # only change directory if a directory is specified
    [ -n "${1}" ] && cd $1
    lls
}

##################################################
# Mount/unmount CIFS shares; pseudo-         #
# replacement for smbmount           #
##################################################

######   $1 = remote share name in form of //server/share
#   $2 = local mount point
function cifsmount() { sudo mount -t cifs -o username=${USER},uid=${UID},gid=${GROUPS} $1 $2; }



function cifsumount() { sudo umount $1; }

##################################################
# Compress stuff                 #
##################################################

function compress_() {
   # Credit goes to: Daenyth
   FILE=$1
   shift
   case $FILE in
      *.tar.bz2) tar cjf $FILE $*  ;;
      *.tar.gz)  tar czf $FILE $*  ;;
      *.tgz)     tar czf $FILE $*  ;;
      *.zip)     zip $FILE $*      ;;
      *.rar)     rar $FILE $*      ;;
      *)         echo "Filetype not recognized" ;;
   esac
}

##################################################
# Cp with progress bar (using pv)        #
##################################################

function cp_p() {
    if [ `echo "$2" | grep ".*\/$"` ]
    then
        pv "$1" > "$2""$1"
    else
        pv "$1" > "$2"/"$1"
    fi
}

function allips(){
ifconfig|awk '/inet / {sub(/addr:/, "", $2); print $2}'
}
if [ -f /etc/bashrc ];then
. /etc/bashrc
fi

###### display private IP
function priv()
{
    ifconfig eth0|grep "inet adr"|awk '{print $2}'|awk -F ':' '{print $2}'
}

HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups
HISTSIZE=2000
HISTFILESIZE=2000

set -o noclobber
set visible-stats on
export EDITOR='vim'             # use default text editor
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
export PAGER='less -e'
complete -W "$(echo `cat ~/.bash_history | egrep '^ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh


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
    alias la="ls -lah"
    alias lr="ls -larh"
    alias l="ls -lah"
    alias ll="ls -lah"
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
    alias vim="nvim"

export PATH="$HOME/bin:/home/fg/.local/bin:$PATH"

PS1='\[\e[0;38;5;45m\]\u\[\e[0m\]@\[\e[0;91m\]\h\[\e[0m\]:\[\e[0m\][\[\e[0;1m\]\w\[\e[0m\]]\[\e[0;97m\]:\[\e[0m\]\$\[\e0 '
