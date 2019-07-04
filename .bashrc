# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#Special Settings
set -o vi

#Directory changes
alias cdn='cd $HOME/Notes/'
alias cdd='cd $HOME/Downloads/'
alias cdo='cd $HOME/Source/'
alias cdp='cd $HOME/Projects/'
alias cdh='cd $HOME'

# General aliases
alias wallOff='sudo cp $HOME/custom-commands/WallOffHosts /etc/hosts'
alias wallOn='sudo cp $HOME/custom-commands/WallOnHosts /etc/hosts'
alias rnu='ranger "$HOME/Unity Projects"'
alias rn='ranger'
alias yt='youtube-dl'
alias adw='adb shell cd /storage/self/primary/Download'
alias ins='sudo apt-get install'
alias uns='sudo apt-get purge'
alias update='sudo apt-get update; sudo apt-get upgrade;'
alias lsg='ls | grep' #Determines if a file or folder with a name containing a sequence of characters is in the current directory
alias backup='dpkg --get-selections > packages-list.txt'
alias show='apt show'
alias lynx='lynx -vikeys'
alias lsa='ls -laF'
alias fire='firejail --private'

#Programming
alias pyt='python3 -i'

#Git aliases 
alias gc='git clone'

# Edit config and system files
alias ebrc='vim $HOME/.bashrc'
alias evrc='vim $HOME/.vimrc'
alias esrc='sudo vim /etc/apt/sources.list'
alias mntx='encfs $HOME/Encrypted/vzz $HOME/Decrypted/.mntx'
alias umntx='fusermount -u $HOME/Decrypted/.mntx; echo "mntx unmounted"'
alias betterXev="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\\n\", $5, $8 }'"
alias gvr='gvim --remote'

#Bash powerline
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/share/powerline/bindings/bash/powerline.sh
#PATH="$PATH:/usr/lib/"

#Special functions! :D
search () { 
	apt search $@ | less


}
clean () {
	#Check if there is too many arguments
	if [ "$#" -gt "1" ] 
	then
		echo "Too many arguments. There are $#."
		return
	fi
	  
	case "$1" in
		'')
			;;
		soft)
			history -c ;;
		hard)
			history -c
			rm -r $HOME/tmp/; mkdir $HOME/tmp/ ;;
		*)
			echo "Invalid arguments"; return ;;
		esac

	echo "History clear"
	sudo apt-get autoremove #Cleanup packages
	echo "Clean complete"
}

wall(){
	if [ "$#" -gt "1" ] 
	then
		echo "Too many arguments. There are $#."
		return
	fi
	  
	case "$1" in
		on)
			sudo iptables -F

			#Allows lo, allows SSH in, allows packets related to connections established with output
			sudo iptables -A walkin -i lo -j ACCEPT 
			sudo iptables -A walkin -p tcp -m tcp --dport 22 -j ACCEPT
			sudo iptables -A walkin -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

			#Allows lo, allows ssh out, allows connections out that are owned by root, allows vpn
			sudo iptables -A walkout -o lo -j ACCEPT 
			sudo iptables -A walkout -p tcp -m tcp --dport 22 -j ACCEPT
			sudo iptables -A walkout -m owner --uid-owner root -j ACCEPT
			sudo iptables -A walkout -o tun0 -j ACCEPT

			sudo iptables -A INPUT -j walkin
			sudo iptables -A INPUT -j DROP

			sudo iptables -A OUTPUT -j walkout
			sudo iptables -A OUTPUT -j DROP
			#Not needed
			sudo iptables -P INPUT DROP
			sudo iptables -P OUTPUT DROP
			echo "Firewall is on"
			;;
		off)
			sudo iptables -F
			sudo iptables -P INPUT ACCEPT
			sudo iptables -P OUTPUT ACCEPT
			echo "Firewall is off"
			;;
		*)
			echo "Invalid arguments"; return ;;
		esac
}

#adb commands for moving files between the desktop and an android.
apull () {
	adb shell ls '/storage/self/primary/Download/'$1 | tr -d '\r' | xargs -n1 adb pull
}

als(){
	adb shell ls /storage/self/primary/Download/$1
}

apush() {
	adb push "$1" /storage/self/primary/Download; 
}

#Variables used by some vim plugins
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Base16 Shell <=-- My addition
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
