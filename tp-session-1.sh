#!/usr/bin/env bash

###############################################################################
# TP1 UCC 131-1: Fundamentals of Git
# Corrected and commented script
###############################################################################

###############################################################################
# PRACTICAL WORK PREPARATION
###############################################################################

# Remove any previous directory to start from a clean environment.
rm -rf tp-session1-git

###############################################################################
# EXERCISE 1: Initializing a Git Repository
###############################################################################
echo "===================="
echo "EXERCISE 1: Repository Initialization"
echo "===================="

# Create the working directory for the lab
mkdir tp-session1-git
cd tp-session1-git

# Initialize the Git repository
git init

# Check the repository status (no commits, no tracked files)
git status


###############################################################################
# EXERCISE 2: Git Areas (Working Directory, Staging Area, Repository)
###############################################################################
echo
echo "===================="
echo "EXERCISE 2: WD / STAGING / REPOSITORY"
echo "===================="

# 1. Create a file in the Working Directory
#    - WD: file exists on disk but is not yet tracked by Git.
echo "Git is a distributed version control system." > notes.txt

# 2. git status: 'notes.txt' appears as an untracked file
git status

# 3. git add: move notes.txt into the Staging Area (index)
git add notes.txt

# 4. git status: 'notes.txt' is now staged (ready to be committed)
git status

# 5. git commit: record the file in the Repository
#    - Creates a snapshot (commit) of notes.txt
git commit -m "Added notes.txt: definition of Git"


###############################################################################
# EXERCISE 3: Modifications, diffs, and commits
###############################################################################
echo
echo "===================="
echo "EXERCISE 3: Modifications, diffs, and commits"
echo "===================="

# 1. Modify the file: add a new line (Working Directory modified)
echo "It uses a snapshot-based model." >> notes.txt

# 2. git diff: compare Working Directory (modified) and Staging Area (previous version)
git diff

# 3. git add: stage the modifications
git add notes.txt

# 4. git diff --staged: compare Staging Area and HEAD (last commit)
git diff --staged

# 5. git commit: create a new snapshot including the new line
git commit -m "Added explanation about the snapshot model"


###############################################################################
# EXERCISE 4: History and navigation
###############################################################################
echo
echo "===================="
echo "EXERCISE 4: Git History"
echo "===================="

# 1. git log: detailed history (hash, author, date, message)
git log

# 2. git log --oneline: condensed history (one line per commit)
git log --oneline

# 3. git log --oneline --graph --decorate --all:
#    - --graph: ASCII representation of the commit graph
#    - --decorate: show branch/tag names
#    - --all: show all references
git log --oneline --graph --decorate --all


###############################################################################
# EXERCISE 5: File restoration (git restore vs git checkout)
###############################################################################
echo
echo "===================="
echo "EXERCISE 5: File Restoration"
echo "===================="

# 1. Simulate a bad manipulation in the Working Directory
#    Example: deleting the first line (as if done in an editor)
#    Here, we replace the content with only the second sentence.
echo "It uses a snapshot-based model." > notes.txt

# At this point, the WD no longer matches the last commit.
git status

# 2. git restore: restore the file to the state of the last commit (HEAD)
git restore notes.txt

# 3. After restore, notes.txt returns to its committed state.
git status

# PEDAGOGICAL COMMENT:
# - git restore: modern, explicit command for restoring files.
# - git checkout: mainly used to switch branches; its use for restoring files
#   is older and less clear. For teaching purposes, git restore is preferred.


###############################################################################
# EXERCISE 6: Deleting and renaming files (git rm, git mv)
###############################################################################
echo
echo "===================="
echo "EXERCISE 6: Deletion and Renaming"
echo "===================="

# 1. Create a file 'draft.txt'
echo "draft" > draft.txt

# 2. Add it to Git tracking
git add draft.txt
git commit -m "Added draft.txt"

# 3. Delete with git rm
#    - Removes the file from the WD
#    - Stages the deletion in the index (Staging Area)
git rm draft.txt

# 4. Commit the deletion
git commit -m "Deleted draft.txt"

# COMMENT:
# - git rm: deletes the file AND stages the deletion for the next commit.
# - rm alone: deletes the file physically, but Git sees it as “deleted but not staged”.

# 5. Rename notes.txt to git-notes.txt using git mv
#    - git mv is equivalent to mv + git add + git rm
git mv notes.txt git-notes.txt

# 6. Commit the rename
git commit -m "Renamed notes.txt to git-notes.txt"


###############################################################################
# EXERCISE 7: Understanding Git snapshots (git ls-tree)
###############################################################################
echo
echo "===================="
echo "EXERCICE 7: Git Snapshots"
echo "===================="

# 1. Display condensed history
git log --oneline

# Retrieve the last commit (HEAD) for inspection.
# Note: we could also use a specific hash from the log.
LAST_COMMIT_HASH=$(git rev-parse HEAD)

echo "Inspecting snapshot of commit: $LAST_COMMIT_HASH"

# 2. git ls-tree -r <hash>: list the contents (tree) of the snapshot
#    - -r: recursive
git ls-tree -r "$LAST_COMMIT_HASH"

# COMMENT:
# - A Git snapshot is a complete picture of the project state (files + directory tree).
# - Git stores objects: blobs (file contents) and trees (directories).
# - This snapshot model makes Git fast, reliable, and merge-friendly.


###############################################################################
# EXERCISE 8: Debugging with git bisect (simple educational version)
###############################################################################
echo
echo "=============================="
echo "EXERCISE 8: Debugging with git bisect"
echo "=============================="
echo
echo "Objective: Automatically identify the commit that introduced a bug."
echo "Git bisect uses binary search to find the first faulty commit."
echo

echo "Step 1: Creating several successive versions..."
echo

# Version 1 (good)
echo "version 1" > version.txt
git add version.txt
git commit -m "Version 1"

# Version 2
echo "version 2" > version.txt
git commit -am "Version 2"

# Version 3
echo "version 3" > version.txt
git commit -am "Version 3"

# Version 4 (BUG introduced intentionally)
echo "version 4 - BUG" > version.txt
git commit -am "Version 4"

# Version 5
echo "version 5" > version.txt
git commit -am "Version 5"

# Version 6
echo "version 6" > version.txt
git commit -am "Version 6"

echo
echo "Step 2: Preparing the bisect"
echo "--------------------------------"
echo "HEAD contains the bug (version 6)."
echo "Version 1 was good."
echo

GOOD_COMMIT=$(git log --grep="Version 1" --format="%H" | head -n 1)

echo "GOOD commit (Version 1): $GOOD_COMMIT"
echo "BAD commit (HEAD): $(git rev-parse HEAD)"
echo

echo "Step 3: Starting the bisect"
echo "--------------------------------"
git bisect start
git bisect bad
git bisect good "$GOOD_COMMIT"

echo
echo "Git has now selected an intermediate commit."
echo "Open version.txt to check whether it contains the BUG."
echo
echo "If the file contains 'BUG':"
echo "    git bisect bad"
echo
echo "If the file does NOT contain 'BUG':"
echo "    git bisect good"
echo
echo "Repeat until Git displays:"
echo "    <hash> is the first bad commit"
echo

echo "Step 4: Ending the bisect"
echo "--------------------------------"
git bisect reset
echo "Repository returned to normal state."
echo

echo "Exercise 8 completed."
echo "=============================="

###############################################################################
# END OF PRACTICAL WORK
###############################################################################
echo
echo "===================="
echo "TP1 completed (corrected script executed successfully)."
echo "===================="