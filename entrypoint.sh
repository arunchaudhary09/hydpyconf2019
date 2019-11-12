#!/bin/sh 

set -x

echo '👍 ENTRYPOINT HAS STARTED—INSTALLING THE GEM BUNDLE'
bundle install
bundle list | grep "jekyll ("
echo '👍 BUNDLE INSTALLED—BUILDING THE SITE'
bundle exec jekyll build -d build
echo '👍 THE SITE IS BUILT—PUSHING IT BACK TO GITHUB-PAGES'
ls -al
cd build 
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
remote_branch="test" && \
git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
git add . && \
echo -n 'Files to Commit:' && ls -l | wc -l && \
git commit -m'action build'  && \
git push --force $remote_repo master:$remote_branch && \
rm -fr .git && \
cd ../
echo '👍 GREAT SUCCESS!'
