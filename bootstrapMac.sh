#!/bin/bash

echo "Bootstrap Script for OS X";
me=`whoami`;


promptQ(){
    echo "$1 ? (y/n) : [y]";
    read reply;
    if [[ "$reply" == "y" ]] || [[ "$reply" == "" ]]; then
        return 0;
    else
        return 1;
    fi; 
}




#   Homebrew
if promptQ "Homebrew"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    brew install cask brew-cask;
fi;


#   BASH 4
if promptQ "Bash 4"; then
    brew install bash bash-completion;
    echo '/usr/local/bin/bash' | sudo tee --append /etc/shells > /dev/null;
    chsh -s '/usr/local/bin/bash';
    echo "export PROMPT_DIRTRIM=2" >> ~/.bash_profile;
fi;

#   Nano
if promptQ "Default Nano"; then
    echo "export EDITOR=nano" >> ~/.bashrc
fi;

#   Utils
if promptQ "wget, ifstat.etc"; then
    brew install bash-completion curl iftop ifstat wget;
    echo 'alias iftop="iftop -B"';
fi;

#   Resume in Wget
if promptQ "wget -c  always"; then
    echo 'alias wget="wget -c"' >> ~/.bash_profile;
fi;

#   JDK
if promptQ "JDK"; then
    brew cask install java;
fi;
#   Alfred
if promptQ "Go the Alfred Way"; then
    brew cask install alfred;
fi;

#   Chrome
if promptQ "Google Chome"; then
    brew cask install google-chrome;
fi;

#   Sublime Text
if promptQ "Sublime Text"; then
    brew cask install sublime-text;
    ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl;
fi;

#   iTerm
if promptQ "iTerm"; then
    brew cask install iterm2;
    curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
    source ~/.iterm2_shell_integration.`basename $SHELL`
fi;

#   iTerm - Monokai Theme
if promptQ "Monokai Theme for iTerm"; then
    git clone --depth=1 git://github.com/stephenway/monokai.terminal.git;
    cp monokai.terminal/Monokai.itermcolors ~/;
    rm -rf monokai.terminal;
    echo "Open ~/Monokai.itermcolors after opening iTerm once. Preferences > Profiles > Colors > Monokai";
fi;

#   Git
if promptQ "Git"; then
    brew install git;
fi;

#   ScrollReverser
if  promptQ "ScrollReverser"; then
    brew cask install scroll-reverser;
fi;

#   Android File Transfer
if promptQ "Android File Transfer"; then
    brew cask install android-file-transfer;
fi;

#   VLC
if promptQ "VLC"; then
    brew cask install vlc;
fi;

#   Spotify
if promptQ "Spotify"; then
    brew cask install spotify;
fi;

#   NameChanger
if promptQ "NameChanger"; then
    brew cask install namechanger;
fi;

#   Transmission
if promptQ "Transmission"; then
    brew cask install transmission;
fi;

#   Seashore
if promptQ "Seashore"; then
    brew cask install seashore;
fi;

#   GNU Core Utils
if promptQ "GNU Core Utils"; then
    brew tap homebrew/dupes;
    brew install coreutils binutils diffutils ed findutils gawk gnu-indent gnu-sed gnu-tar gnu-which gnutls grep gzip screen watch wdiff --with-gettext file-formula less openssh rsync svn unzip --default-names;
    echo "export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH" >> ~/.bash_profile;
fi;

#   The Silver Searcher
if promptQ "The Silver Searcher (ag)"; then
    brew install the_silver_searcher;
fi;

#   IntelliJ
if promptQ "IntelliJ"; then
    brew cask install intellij-idea;
fi;

#   Android Studio
if promptQ "Android Studio"; then
    brew cask install android-studio;
fi;

brew cask alfred link;


###################
#  Bash Settings  #
###################

# Avoid duplicates in History
echo "export HISTCONTROL=ignoredups:erasedups" >> ~/.bash_profile
# When the shell exits, appendd to the history file instead of overwriting it
echo "shopt -s histappend" >> ~/.bash_profile

echo "source ~/.bash-addons/useful-aliases" >> ~/.bash_profile

mkdir ~/.bash-addons
shopt -s dotglob;
cp -r addons/* ~/.bash-addons;
chmod +x ~/.bash-addons/*;
shopt -u dotglob;

if promptQ "Tab-complete SSH hosts"; then
    echo "source ~/.bash-addons/ssh_tab_complete" >> ~/.bash_profile;
fi;

if promptQ "Show Current Dir as Terminal Title"; then
    echo $'PROMPT_COMMAND=\'echo -ne "\033]0; ${PWD##*/}\007"\'' >> ~/.bash_profile;
fi;

#############
#    Git    #
#############

if promptQ "Add Git Prompt"; then
   echo "source ~/.bash-addons/git-prompt" >> ~/.bash_profile; 
fi;

if promptQ "Git Completion"; then
   echo "source ~/.bash-addons/.git-completion.sh" >> ~/.bash_profile; 
fi;

git config --global rerere.enabled true;
git config --global core.editor nano;
git config --global alias.co checkout;
git config --global alias.cob 'checkout -b';
git config --global alias.br branch;
git config --global alias.cm commit;
git config --global alias.ca 'commit -a';
git config --global alias.caa 'commit -a --amend';
git config --global alias.cma 'commit --amend';
git config --global alias.st status;
git config --global alias.rb rebase;
git config --global alias.cp cherry-pick;
git config --global alias.ss 'stash save';
git config --global core.excludesfile ~/.gitignore;
cp gitignore ~/.gitignore


if promptQ "Bro Pages"; then
    sudo gem install bropages;
fi;
