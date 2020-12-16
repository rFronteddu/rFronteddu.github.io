---
title: "Globbing"
date: 2020-12-16T23:24:19Z
draft: false
---

Today I was playing with hugo and I wanted to automate my pipeline a bit so I made a script that looked like this:

    eval 'rm -rv !("hugo"|*.sh)'

But I quickly discovered that even if that would work on a shell it would not work on a script. That is because a script doesn't know how to process globbing (round parentesys expansion). To fix that I enabled glob changing the script as follows:

    shopt -s extglob
    eval 'rm -rv !("hugo"|*.sh)'
