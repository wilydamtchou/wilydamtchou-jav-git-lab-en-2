UCC 131-1
Gitflows: Github, Gitlab

Lab 2 : Workflows and Branching Strategies

General Objectives
Put professional Git workflows (Git Flow, GitHub Flow, GitLab Flow, Trunk-Based Development) into practice in real-world conditions. 

Learning Objectives
At the end of this lab, the student will be able to: 
Manipulate local and remote branches 
Apply Git Flow in a complete release cycle 
Apply GitHub Flow on GitHub (PR, review, merge, branch deletion) 
Apply GitLab Flow on GitLab (MR, staging, environments, CI/CD) 
Understand Trunk-Based Development and feature toggles 
Choose a workflow adapted to a professional context 

General context of the lab 

You work in a DevOps team on a project named UCC-WeatherApp, an internal application used to check the weather.
Your mission: Simulate a full development cycle by applying different Git workflows.

Exercice 1: Branch management (essential basics)

1.1 Objectives
Master local and remote branches.

1.2 Actions
Initialize a local repository:


git init UCC-WeatherApp
cd UCC-WeatherApp


Create a feature/ui-header branch and switch to it. 
Add a header.html file. 
Make a commit. 
Go back to the main branch. 
Merge feature/ui-header into main. 

1.3 Deliverables
Commands used 
Output of git branch 
Merge message 

Exercice 2: Git Flow simulation (local) 

2.1 Objectives
Understand the develop, feature, release, and hotfix branches.

2.2 Actions
Create the develop branch from the main branch. 
Create the feature/api-client branch from the develop branch. 
Add the api.js file. 
Merge the feature/api-client branch into the develop branch. 
Create the release/1.0.0 branch. 
Add the CHANGELOG.md file to it. 
Merge the release/1.0.0 branch into the main branch, then into the develop branch. 
Simulate an urgent hotfix:
Create the hotfix/1.0.1 branch
Fix a bug
Merge the hotfix branch into the main branch, then the develop branch 

2.3 Expected tree


2.4 Deliverables
Branch tree 
Merge commands 
Commit messages 

Exercice 3: Github Flow (Local + Github)

3.1 Objectives
Implement GitHub Flow in real conditions.

3.2 Actions locales
Create a feature/footer branch. 
Add the footer.html file to it. 
Make a commit. 

3.2 Practical actions on GitHub
Create a GitHub repository 
Name: UCC-WeatherApp-GitHubFlow 
Add a README 
Add a .gitignore
Connect your local Repository


git remote add origin https://github.com/<user>/UCC-WeatherApp-GitHubFlow.git
git push -u origin main


Push the feature branch


git push -u origin feature/footer


Open a Pull Request
On GitHub → Pull Requests → New Pull Request
Base : main
Compare : feature/footer
Fill in :
Description
Checklist
Tests
Business Context
Do a code review
Add a reviewer
Add comments
Resolve conversations
Approve the PR 
Merge the Pull Request
Merge commit
Delete the feature branch
Check the history : On GitHub → Insights → Network
3.4 Deliverables Github
Link to the PR 
Screenshot of the merge 
Screenshot of the Network graph 
Justification of the choice of GitHub Flow 

Exercice 4: GitLab Flow (Local + GitLab)

4.1 Objectives

Implement GitLab Flow with environments and CI/CD. 

4.2 Actions locales
Create feature/weather-card. 
Add the card.html file to it. 
Make a commit. 
4.3 Practical actions on GitLab 
Create a GitLab Project
Name : UCC-WeatherApp-GitLabFlow
Add a README
Add a .gitignore
Connect your local Repository


git remote add origin https://gitlab.com/<user>/UCC-WeatherApp-GitLabFlow.git
git push -u origin main


Create an environment branch
On GitLab → Repository → Branches: Create the staging branch from the main branch.
Push the feature branch


git push -u origin feature/weather-card


Open a Merge Request (MR)
Source : feature/weather-card  
Target : staging 
Include :
Description
Checklist
Tests
Business Context
Add a pipeline CI/CD
Create the.gitlab-ci.yml file:


stages:
 - test


test_job:
 stage: test
 script:
   - echo "Tests OK"


Push the file.
Merge the MR into staging
Green Pipeline
Merge
Simuler un test QA


echo "QA OK" > qa-report.txt
git add qa-report.txt
git commit -m "Rapport QA"
git push


Merge staging → main
Create an MR staging → main  
Justification : Production deployment


Check environments
On GitLab → Deployments → Environments  
You should see:
staging
production

4.4 Deliverables GiLab
Link to MR feature → staging 
Link to MR staging → main 
Screenshot of environments 
Screenshot of the pipeline 
Justification of the choice of GitLab Flow

Exercice 5: Trunk-Based Development (TBD)

5.1 Objectives

Understand frequent merges and feature toggles.

5.2 Actions
Create the feature/temperature-toggle branch. 
Add toggle.js:



const temperatureFeatureEnabled = false;



Make a commit.
Merge immediately into the main branch. 
Add a second WIP commit. 
Merge again quickly. 

5.3 Deliverables
Explanation of the role of feature toggles 
Justification of fast merging 
Commands used 

Exercice 6: Choosing an appropriate workflow

6.1 Objectives

Analyze a professional context and choose a workflow.

6.1 Scénarios
For each scenario, propose the recommended workflow and justify your choice. 
SaaS startup deploying 10 times per day 
Team of 40 developers with monthly releases 
Large open-source project 
DevOps team with staging / preprod / prod 
Critical project requiring fast hotfixes 
6.2 Deliverables
Workflow chosen 
Professional justification 
