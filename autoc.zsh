# zsh-shell-autocomplete for vscode
# GitHub : https://github.com/onvno/zsh-shell-autocomplete
# Email  : leewei2020@gmail.com
# Author : onvno 


autoload -U compinit
zle -N self-insert self-insert-incr
zle -N backward-delete-char-incr
compinit

bindkey -M emacs '^h' backward-delete-char-incr
bindkey -M emacs '^?' backward-delete-char-incr

unsetopt automenu
compdef -d scp
compdef -d tar
compdef -d make
compdef -d java
compdef -d svn
compdef -d cvs

# TODO:
#     cp dir/

now_predict=0

function limit-completion
{
	if ((compstate[nmatches] <= 1)); then
		zle -M ""
	elif ((compstate[list_lines] > 50)); then
		compstate[list]=""
		zle -M "too many matches."
	fi
}

function correct-prediction
{
	if ((now_predict == 1)); then
		if [[ "$BUFFER" != "$buffer_prd" ]] || ((CURSOR != cursor_org)); then
			now_predict=0
		fi
	fi
}

function remove-prediction
{
	if ((now_predict == 1)); then
		BUFFER="$buffer_org"
		now_predict=0
	fi
}

function show-prediction
{
	# assert(now_predict == 0)
	if
		((PENDING == 0)) &&
		((CURSOR > 1)) &&
		[[ "$PREBUFFER" == "" ]] &&
		[[ "$BUFFER[CURSOR]" != " " ]]
	then
	
		cursor_org="$CURSOR"
		buffer_org="$BUFFER"
		comppostfuncs=(limit-completion)
		zle complete-word
		cursor_prd="$CURSOR"
		buffer_prd="$BUFFER"
		if [[ "$buffer_org[1,cursor_org]" == "$buffer_prd[1,cursor_org]" ]]; then
			CURSOR="$cursor_org"
			if [[ "$buffer_org" != "$buffer_prd" ]] || ((cursor_org != cursor_prd)); then
				now_predict=1
			fi
		else
			BUFFER="$buffer_org"
			CURSOR="$cursor_org"
		fi
		echo -n "\e[32m"
	else
		zle -M ""
	fi
}

function preexec
{
	echo -n "\e[39m"
}

function self-insert-incr
{
	correct-prediction
	remove-prediction

	if { zle .self-insert } {
		if [[ "${BUFFER:0:3}" == "cd " ]] || [[ "${BUFFER:0:4}" == "cat " ]] || [[ "${BUFFER:0:5}" == "code " ]] {
			show-prediction
		}
	}
}

function backward-delete-char-incr
{
	correct-prediction
	remove-prediction
	if { zle backward-delete-char } {
		if [[ "${BUFFER:0:3}" == "cd " ]] || [[ "${BUFFER:0:4}" == "cat " ]] || [[ "${BUFFER:0:5}" == "code " ]] {
			show-prediction
		} else {
			remove-prediction
		}
	}
}
