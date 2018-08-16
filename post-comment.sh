body=$1
echo "$body"

resp=$(curl --header "Content-Type: application/json" --request POST --data "{\"body\":\"$body\"}" https://api.github.com/repos/m-kostrzewa/shelly/pulls/1/reviews -u m-kostrzewa)


echo $resp

reviewid=$(echo $resp | jq -r ".id")

echo $reviewid


curl --header "Content-Type: application/json" --request POST --data "{\"body\":\"$body\",\"event\":\"COMMENT\"}" https://api.github.com/repos/m-kostrzewa/shelly/pulls/1/reviews/$reviewid/events -u m-kostrzewa

