
if [ -d "tmp/" ]; then
    rm -rf tmp/
fi

git clone https://github.com/m-kostrzewa/shelly tmp

pushd tmp
    branch=$(curl https://api.github.com/repos/m-kostrzewa/shelly/pulls/1 | jq -r ".head.ref")

    git fetch origin "pull/1/head:$branch"
    tree > ../old.txt

    git checkout $branch
    tree > ../proposed.txt
popd

./post-comment.sh "\`\`\`\n OLD: $(sed '{:q;N;s/\n/\\n/g;t q}' old.txt) \n\n\n PROPOSED: $(sed '{:q;N;s/\n/\\n/g;t q}' proposed.txt) \n\`\`\`"
