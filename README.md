# Git-hook : Git to Trello

On each push containing commits with a trello card id (ex: #xxx), creates a comment on the associated trello card.

## Install

> Move the 2 files (pre-push and got-to-trello.sh) into the .git/hooks of your project.
> Generate a trello developper key : [https://trello.com/app-key](https://trello.com/app-key)
> Generate a trello api token : https://trello.com/1/authorize?expiration=never&scope=read,write,account&response_type=token&name=Server%20Token&key=[YOUR_DEV_KEY]
> Set the two credentials in the git-to-trello.sh file

## Use

> add at the begining of your commit message "#unique_trello_card_id" (found in the trello card url : https://trello.com/c/**kMClMV9d**/1-test)
> exemple : git commit -m "#kMClMV9d my first git commit in a trello card comment"