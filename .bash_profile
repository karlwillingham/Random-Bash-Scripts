alias finder="cdf";
alias hey="send_text";

# Send Text to Friend quickly
function send_text() {
  # Defualt Call to Friend X
  if [ $# -eq 0 ] ; then
    local PHONE=xxxxxxxxxx
    local MESSAGE="Hey, hows it going?"
  elif [ $# -eq 1 ] ; then
    local PHONE=xxxxxxxxxx
    local MESSAGE=$1
  elif [ $# -eq 2 ] ; then
    local PHONE=$2
    local MESSAGE=$1
  else
    echo "Failed"
  fi

  # Apple Script - Send Text
  osascript <<EOD
    set targetBuddyPhone to "$PHONE"
    set targetMessage to "$MESSAGE"

    tell application "Messages"
        set targetService to 1st service whose service type = iMessage
        set targetBuddy to buddy targetBuddyPhone of targetService
        send targetMessage to targetBuddy
    end tell
EOD
}

# cd to the path of the front Finder window
# Add parameter to reverse the direction
cdf() {
  if [ $# -eq 0 ] ; then
  	target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  	if [ "$target" != "" ]; then
  		cd "$target"; pwd
  	else
  		echo 'No Finder window found' >&2
  	fi
  else
    open -a Finder ./; # Reverse Direction
  fi
}
