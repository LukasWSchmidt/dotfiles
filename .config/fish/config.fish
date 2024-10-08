if status is-interactive

set -gx PATH /usr/local/bin /opt/homebrew/bin/ /run/current-system/sw/bin/kak $PATH
set -gx EDITOR kak
set -gx VISIAL kak
set -Ux EDITOR kak

set -g fish_greeting

# Better greeter
function fish_greeting
    echo Hello friend!
    echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname
end


# Yazi wrapper to change working dir after exit
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

#Aliases
alias k="kak"
alias ya="yazi"
#alias cd="z"
alias ls="exa --icons --tree --level=2"
alias cl="clear"
alias lg="lazygit"
alias nixrebuild="sudo -i nixos-rebuild switch --upgrade"

#this did work right?

#Fixes conflictions with kitty theme
set -e fish_color_normal
set -e fish_color_command
set -e fish_color_comment
set -e fish_color_keyword
set -e fish_color_quote


 
# Commands to run in interactive sessions can go here
end

#thefuck --alias | source
#needs to be at the end
#zoxide init fish | source
