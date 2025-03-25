#!/usr/bin/env bash
memory=$(free -m | awk 'NR==2{printf("%s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2)}')
memory_percent=${memory//*(/}
memory_percent=${memory_percent//)/}
memory_percent=${memory_percent%.*}

if free | grep Swap;
then
    swap=$(free -m | awk 'NR==3{printf("%s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2)}')
    swap_percent=${swap//*(/}
    swap_percent=${swap_percent//)/}
    swap_percent=${swap_percent%.*}
    if (( swap_percent > 5 || memory_percent > 80 )); then
	    echo '{"text": "'"$memory - SWAP $swap"'", "class": "critical"}'
    elif (( memory_percent > 65 )); then
	    echo '{"text": "'"$memory - SWAP $swap"'", "class": "warning"}'
    else
	    echo '{"text": "'"$memory - SWAP $swap"'"}'
    fi
else
    echo '{"text": "'" $memory"'"}'
fi
