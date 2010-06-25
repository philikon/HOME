umask 022

# aliases
alias cdiff='cvs -q diff -u'
alias cup='cvs -q up -dP'
alias ls='ls -G'
alias df='df -h'
alias du='du -h'
alias diff='diff -u'
alias vlc='open -a VLC'
alias svnst='svn st --ignore-externals'
alias mkdir='mkdir -p'
alias bar='bzr'
alias wgets='wget --no-check-certificate'
alias gitx='open -a GitX .'
alias murky='open -a Murky .'
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
alias math='/Applications/Mathematica.app/Contents/MacOS/MathKernel'

# env vars
export LC_ALL=C
export JAVA_HOME=/usr
export CVS_RSH=ssh
export PS1='\u@\h:\w\$ '
export EDITOR=vim
export PATH=$HOME/bin:$HOME/.cabal/bin:/opt/bin:/opt/local/bin:/usr/local/bin:$PATH
export DISPLAY=:0.0

#if [ -f /opt/local/etc/bash_completion ]; then
#    . /opt/local/etc/bash_completion
#fi
