PREVPWD=`pwd`
PREVENV_PATH=
PREV_PS1=
PREV_PATH=

handle_virtualenv(){
  if [ "$PWD" != "$PREVPWD" ]; then
    PREVPWD="$PWD";
    if [ -n "$PREVENV_PATH" ]; then
      if [ "`echo "$PWD" | grep -c $PREVENV_PATH`" = "0"  ]; then
         echo "[Virtualenv deactivated]"
         PS1=$PREV_PS1
         PATH=$PREV_PATH
         PREVENV_PATH=
      fi
    fi

    # activate virtualenv dynamically
    if [ -e "$PWD/.env" ] && [ "$PWD" != "$PREVENV_PATH" ]; then
      PREV_PS1="$PS1"
      PREV_PATH="$PATH"
      PREVENV_PATH="$PWD"
      #source $PWD/.venv
      source $PWD/.env/bin/activate
      echo "[Virtualenv `basename $PWD` activated]"
    fi
  fi
}

export PROMPT_COMMAND=handle_virtualenv
