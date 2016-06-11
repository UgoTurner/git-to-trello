#!/bin/bash

TRELLO_KEY="YOUR_KEY"
TRELLO_TOKEN="YOUR_TOKEN"
current_project="$2"
#current_project=$(git config --local remote.origin.url)
current_branch=$(git branch | grep "*" | sed 's/* //')
current_user=$(git config user.email)

if [ -z "$(git log origin/$current_branch..HEAD)" ];
then
    echo "No commits."
fi

add_card_comment (){
    curl  -s --request POST "https://api.trello.com/1/cards/$1/actions/comments" \
    --data "key=$TRELLO_KEY&token=$TRELLO_TOKEN&text=$2" > /dev/null
    echo "\033[0;36mAdd comment to Trello card #$1\033[0m"
}

git log origin/$current_branch..HEAD --reverse --pretty=oneline --abbrev-commit \
| while read commit;
do
    commit_id=$(echo "$commit" | awk -F' ' '{print $1}')
    commit_full_msg=$(echo "$commit" | cut -d" " -f2-)
    raw_card_id=$(echo "$commit_full_msg" | grep -o '#[[:alnum:]]*')
    if [ ! -z "$raw_card_id" ] && [ "$raw_card_id" != "#" ];
    then
        card_id=$(echo "$raw_card_id" | sed 's/#//g')
        commit_clean_msg=$(echo "$commit_full_msg" | sed 's|'"$raw_card_id "'||g')
        comment="Commit [#$commit_id]($current_project/commit/$commit_id) - $commit_clean_msg"
        add_card_comment "$card_id" "$comment"
    fi
done