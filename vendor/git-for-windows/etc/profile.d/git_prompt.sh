#PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;35m\]@\[\033[00m\]\[\033[01;33m\]\h\[\033[00m\]\[\033[34m\]:\[\033[01;34m\]\w\[\033[32m\]\$\[\033[00m\]'
USR_HOST="\[\033[01;32m\]\u\[\033[01;35m\]@\[\033[00m\]\[\033[01;33m\]\h\[\033[00m\]"

PS1='\[\033]0;${PWD//[^[:ascii:]]/?}\007\]'
PS1="$PS1$USR_HOST "
#PS1="$PS1"'\[\033[01;35m\] ^___^ '                     # new line
#PS1="$PS1"'\[\033[01;32m\]'         # change to green
#PS1="$PS1"'$(date +"%Y-%m-%d") '                   # time
PS1="$PS1"'\[\033[01;37m\]\t '
#PS1="$PS1"'@'
#PS1="$PS1"'\[\033[01;33m\]'        # change to purple
#PS1="$PS1"'\h'                     # show MSYSTEM
PS1="$PS1"'\[\033[01;34m\]'         # change to brownish yellow
PS1="$PS1"'\w'                      # current working directory
PS1="$PS1"'\[\033[0m\]'             # change color
PS1="$PS1"'\n'                     # new line
PS1="$PS1"'$ '                     # prompt: always $

function rd {
  git branch > /dev/null 2>&1 || return 1
  cd "$(git rev-parse --show-cdup)"
}

function set_git_prompt {
#  local last_commit_in_unix_time
#  local now_in_unix_time
  local tmp_flags
  local flags
#  local seconds_since_last_commit
#  local minutes_since_last_commit
#  local days_since_last_commit
#  local minutes_so_far_today
  local branch
#  local seconds_since_last_remote_check
  local svn_branch
  #last_commit_in_unix_time=$(git log "HEAD" --pretty=format:%ct 2> /dev/null | sort | tail -n1)
  last_commit_in_unix_time=""
  #now_in_unix_time=$(date +%s)
  #seconds_since_last_remote_check=$((now_in_unix_time - $BGP_LAST_REMOTE_CHECK))
  branch=$(git branch --no-color 2> /dev/null | grep '*' | sed 's/\*//g' | sed 's/ //g' | sed 's/(//g' | sed 's/)//g' | awk -F / '{print $NF}')
  svn_branch=$(svn info 2> /dev/null | grep "Repository Root" | awk -F / '{print $NF}')
  tmp_flags=$(git status --porcelain 2> /dev/null | cut -c1-2 | sed 's/ //g' | cut -c1 | sort | uniq)
  flags="$(echo $tmp_flags | sed 's/ //g')"
  
  if [ $branch ] || [ $flags  ] || [ $svn_branch  ]; then
    if [ $branch ]; then
      branch="\[\e[1;31m\]${branch}\[\e[0m\]"
    else
      if [ $svn_branch ]; then
        branch="\[\e[1;31m\]svn\[\e[0m\]"
      else
        branch="\[\e[1;31m\]^_^\[\e[0m\]"
      fi
    fi
    if [ $flags ]; then
      PS1="${BGP_ORIGINAL_PS1/\\$ /} <${minutes_since_last_commit}${branch}\[\e[0m\]>$BGP_GIT_REMOTE_STATUS\n\$ "
    else
      PS1="${BGP_ORIGINAL_PS1/\\$ /} <${minutes_since_last_commit}${branch}\[\e[0m\]>$BGP_GIT_REMOTE_STATUS\n\$ "
    fi
  else
    #PS1=$BGP_ORIGINAL_PS1
    PS1="${BGP_ORIGINAL_PS1/\\$ /}\n\$ "
  fi
}

#BGP_ORIGINAL_PS1=$PS1
#PROMPT_COMMAND=set_git_prompt
