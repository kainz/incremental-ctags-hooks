#install via:
git config --global init.templatedir '~/.git_template'

So, this is a rudimentary set of git hooks which will incrementally update a tags file for your project under .git/tags on basically any branch change.

This is basically directly inspired from @tpope's writeup http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html on automating ctags with git.

My only problem with that idea was that it has to regenerate the whole ctags file on every branch change.  With large repos, this can become a problem, and other attempts (search for inotify+ctags and the like) tend to have poor performance on large amounts of file changes.

#Implementation
OK, this is the ugly part.  We temporarily write and execute a C program to filter 'removed' files from your ctags, then feed the remainder of changed files as seen by git-diff into a ctags --append.  While this is incredibly ugly, it is orders of magnitude faster than awk/sed/perl, and about 10-20% faster than CPython on my tests involving an approximately 80MB tags file.

#requirements

 * git 1.7.1 or newer
 * GCC (or a compatible frontend.)
 * POSIX/BSDish libc (we use `hsearch()`)
 * zsh or bash (i've attempted to make these scripts use your favorite shell to pull in your environment of choice, but I have not recently tested this stuff under bash.)
 * logger which supports the -t argument, for syslog output

#caveats
You probably dont want to run this on untrusted repos -- magic characters in filenames could do bad things to you!  Also, I have only tested this on Linux and ZSH 5.0.5.
