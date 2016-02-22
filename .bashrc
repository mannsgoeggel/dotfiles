# .bashrc

# Sourced by purely interactive shells, e.g.:
# $ sudo su
# $ bash
# $ ssh user@host command
# Since .bash_profile sources .bashrc, this file is always sourced

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Set PS1 according to server you are working on
colorUser='0;32'
colorPath='0;36'
case "$HOSTNAME" in
    basil) colorServer='1;31';;
    *triumf*) colorServer='0;33';;
    lxplus*) colorServer='1;33';;
    cmslpc*) colorServer='0;33';;
    *) colorServer='1;35';;
esac
export PROMPT_DIRTRIM=3
export PS1="\[\033[${colorUser}m\]\u\[\033[00m\]@\[\033[${colorServer}m\]\h\[\033[00m\]: \[\033[${colorPath}m\]\w\[\033[00m\] \$ "

export LD_LIBRARY_PATH=~/pkg/lib:/uscms_data/d1/bschneid/pkg/lib:"${LD_LIBRARY_PATH}"
export MANPATH=~/pkg/share/man:uscms_data/d1/bschneid/pkg/share/man:"${MANPATH}"
export PATH=~/pkg/bin:/uscms_data/d1/bschneid/pkg/bin:~/.gem/ruby/2.2.0/bin:"${PATH}"
export PYTHONPATH=~/analysis/toolbox/:"${PYTHONPATH}"

export EDITOR=vim

# Set keyboard for proper use of backspace
#stty erase ^?

# Set termcap locally, needed for proper running of rxvt-unicode-256color and screen-256color-s
export TERMCAP=~/.termcap

test -s ~/.alias && . ~/.alias

xset b off &> /dev/null
#setxkbmap -layout us -variant altgr-intl &> /dev/null

# Source command-not-found hook
cnfhook=/usr/share/doc/pkgfile/command-not-found.bash
[ -f "$cnfhook" ] && . "$cnfhook" && unset cnfhook

# Set workspace variable on lxplus
if [[ "$HOSTNAME" == lxplus* ]]; then
    export workspace=/afs/cern.ch/work/b/bschneid/
fi
# Set workspace variable on fnal
if [[ "$HOSTNAME" == cmslpc* ]]; then
    export workspace=/uscms_data/d3/bschneid/
fi

# Set vi mode! Woohoo!
set -o vi

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTTIMEFORMAT="[%F_%H-%M-%S] "
# Change the file location because certain bash sessions truncate .bash_history
# file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Coreutils 8.25 introduced quotation marks for filenames with spaces when using
# ls in the terminal; the following option disables it
export QUOTING_STYLE=literal

# Start mpdscribble, but only when it is not yet running
pidof mpdscribble &>/dev/null
if [ $? -ne 0 ]; then
    mpdscribble 2>/dev/null
fi
