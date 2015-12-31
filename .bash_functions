#function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}


gittag ()
{
  local today=`date`
  local secsSince1970=`date "+%s"`
  local daysSince1970=`expr $secsSince1970 / 3600`

  local command="git tag -a  -m "\"$today\"" "\"day-$daysSince1970\"" "
  echo $today
  echo $secsSince1970
  echo $daysSince1970
  echo $command
  $command
}

# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}


sendGcmMessage() {
    local usage="Usage:   $FUNCNAME devicePushToken message"
    [[ $GCM_API_KEY == "" ]] && echo "define an env var GCM_API_KEY with the API KEY " && return 2
    if  [ "$#" -lt "2" ]; then
        echo $usage
        return 1
    fi
    local HEADER1="Authorization:key=$GCM_API_KEY"
    local HEADER2="Content-Type:application/json"
    local POSTDATA="\"{ \\\"data\\\": $2, \\\"to\\\": \\\"$1\\\" }\""
    local URL="https://gcm-http.googleapis.com/gcm/send"
    #echo $POSTDATA

    local cmd="curl  --header $HEADER1 --header $HEADER2 -d $POSTDATA $URL"
    echo $cmd

    `$cmd`


    return 0
}
