#!/usr/bin/env bash

###############################################################################
# TP2 UCC 131-1: Git Workflows and Branching Strategies
# Fully commented and corrected script
###############################################################################

echo
echo "===================================================="
echo "TP2: Git Workflows and Branching Strategies"
echo "===================================================="
echo

###############################################################################
# EXERCISE 1: Branch Management (Essential Foundations)
###############################################################################
echo
echo "===================="
echo "EXERCISE 1: Branch Management"
echo "===================="

# Create the project directory and initialize Git
git init UCC-WeatherApp
cd UCC-WeatherApp

# Create a feature branch for the UI header
git checkout -b feature/ui-header

# Add a simple HTML header
echo "<h1>Weather App</h1>" > header.html

# Stage the file
git add header.html

# Commit the new UI header
git commit -m "Added UI header"

# Switch back to main (assumes main exists; otherwise create it)
git checkout -b main 2>/dev/null || git checkout main

# Merge the feature branch using --no-ff to preserve history
git merge feature/ui-header --no-ff -m "Merge feature/ui-header into main"

# List branches
git branch


###############################################################################
# EXERCISE 2: Git Flow Simulation (Local)
###############################################################################
echo
echo "===================="
echo "EXERCISE 2: Git Flow Simulation"
echo "===================="

# Create develop branch from main
git checkout -b develop main

# Create a feature branch from develop
git checkout -b feature/api-client develop

# Add a simple JS API client
echo "console.log('API client');" > api.js

# Stage and commit
git add api.js
git commit -m "Added API client"

# Merge feature branch into develop
git checkout develop
git merge feature/api-client --no-ff -m "Merge feature/api-client"

# Start a release branch
git checkout -b release/1.0.0 develop

# Add a changelog
echo "Version 1.0.0" > CHANGELOG.md
git add CHANGELOG.md
git commit -m "Prepared release 1.0.0"

# Merge release into main
git checkout main
git merge release/1.0.0 --no-ff -m "Release 1.0.0"

# Sync develop with release
git checkout develop
git merge release/1.0.0 --no-ff -m "Sync develop with release 1.0.0"

# Create a hotfix branch from main
git checkout -b hotfix/1.0.1 main

# Add a critical fix
echo "Critical fix" > fix.txt
git add fix.txt
git commit -m "Critical hotfix 1.0.1"

# Merge hotfix into main
git checkout main
git merge hotfix/1.0.1 --no-ff -m "Hotfix 1.0.1"

# Sync develop with hotfix
git checkout develop
git merge hotfix/1.0.1 --no-ff -m "Sync develop with hotfix 1.0.1"


###############################################################################
# EXERCISE 3: GitHub Flow (Local Part)
###############################################################################
echo
echo "===================="
echo "EXERCISE 3: GitHub Flow (Local)"
echo "===================="

# Create a feature branch for the footer
git checkout -b feature/footer

# Add a footer HTML file
echo "<footer>WeatherApp © 2025</footer>" > footer.html

# Stage and commit
git add footer.html
git commit -m "Added HTML footer"

echo
echo "=== GitHub Part ==="
echo "Push to GitHub, open a Pull Request, perform review, merge, delete branch."
echo "This part must be done on GitHub UI."
echo


###############################################################################
# EXERCISE 4: GitLab Flow (Local + GitLab)
###############################################################################
echo
echo "===================="
echo "EXERCISE 4: GitLab Flow"
echo "===================="


# PART A — LOCAL WORK
echo
echo "=== Part A: Local GitLab Flow Setup ==="
echo

# Create a feature branch for the weather card UI component
git checkout -b feature/weather-card

# Add a simple UI card component
echo "<div class='card'>Weather Card</div>" > card.html

# Stage and commit the new UI component
git add card.html
git commit -m "Added weather card UI"

# Create the 'staging' branch locally
echo
echo "Creating local 'staging' branch..."

# The staging branch represents the pre-production environment in GitLab Flow.
# It is used to validate features before merging into main (production).
git checkout -b staging main

# Push the staging branch to GitLab so it becomes available remotely
git push -u origin staging

echo "'staging' branch created locally and pushed to GitLab."
echo

# Create the .gitlab-ci.yml file (CI/CD pipeline definition)
echo "Creating .gitlab-ci.yml (CI/CD pipeline)..."

# The pipeline contains a single test stage with a simple script
cat << 'EOF' > .gitlab-ci.yml
stages:
  - test

test_job:
  stage: test
  script:
    - echo "Tests OK"
EOF

# Stage and commit the CI/CD configuration
git add .gitlab-ci.yml
git commit -m "Added basic GitLab CI pipeline (.gitlab-ci.yml)"

echo ".gitlab-ci.yml created and committed."

echo
echo "=== Local setup for GitLab Flow completed ==="
echo
echo "Next steps must be performed on GitLab:"
echo
echo "1. Pushing feature branch to GitLab and Open a Merge Request (MR) from feature/weather-card → staging"
echo "   Expected MR description:"
echo "     ## Description"
echo "     Added weather card UI."
echo
echo "     ## Context"
echo "     Required for version 1.1."
echo
echo "     ## Checklist"
echo "     - [x] Manual tests"
echo "     - [x] Lint OK"
echo "     - [x] CI green"
echo
echo "2. Ensure the CI/CD pipeline runs and turns green"
echo "3. Merge into staging (merge commit)"
echo "4. Perform QA on staging"
echo "   Example:"
echo "     echo 'QA OK' > qa-report.txt"
echo "     git add qa-report.txt"
echo "     git commit -m 'QA report'"
echo "     git push"
echo
echo "5. Open MR from staging → main"
echo "   Justification: production deployment"
echo
echo "6. Verify GitLab environments:"
echo "   GitLab → Deployments → Environments"
echo "   Expected:"
echo "     - staging"
echo "     - production"
echo


###############################################################################
# EXERCISE 5: Trunk-Based Development (TBD)
###############################################################################
echo
echo "===================="
echo "EXERCISE 5: Trunk-Based Development"
echo "===================="

# Create a short-lived feature branch
git checkout -b feature/temperature-toggle

# Add a feature toggle
echo "const temperatureFeatureEnabled = false;" > toggle.js

# Stage and commit
git add toggle.js
git commit -m "Added temperature feature toggle"

# Merge immediately into main (frequent merges)
git checkout main
git merge feature/temperature-toggle --no-ff -m "Merge toggle"

# Second commit on the same feature branch
git checkout feature/temperature-toggle
echo "// TODO: implementation" >> toggle.js
git commit -am "WIP toggle"

# Merge again into main
git checkout main
git merge feature/temperature-toggle --no-ff -m "Merge WIP toggle"


###############################################################################
# EXERCISE 6: Choosing the Right Workflow
###############################################################################
echo
echo "===================="
echo "EXERCISE 6: Workflow Selection"
echo "===================="

echo "Refer to the table in the TP for workflow recommendations."
echo "This section is conceptual and does not require shell commands."
echo


###############################################################################
# END OF TP2
###############################################################################
echo
echo "===================="
echo "TP2 completed successfully."
echo "===================="