#!/usr/bin/env bash
function title(){
  echo -e "\n\n\e[1m\e[47m\e[96m$1\e[49m\e[39m\e[0m"
}

while getopts :s:r:p:v:c: o; do
    case "${o}" in
        s)
            source=${OPTARG}        ;;
        r)
            repo=${OPTARG}   ;;
        p)
            password=$(cat ${OPTARG})      ;;
        v)
            version=${OPTARG}       ;;
        c)
            chart=${OPTARG}       ;;
    esac
done
shift $((OPTIND-1))

app_version=${version}'-'$(date +"%Y%m%d-%H%M%S")

title ">>>> Packaging Helm Chart ${chart}: ${version} / ${app_version} <<<<"

rm -rf /tmp/${chart}
cp -r  ${source} /tmp/${chart}
source=/tmp/${chart}
target=/tmp/charts-target
rm -rf ${target}
mkdir  ${target}

o_package=$(helm package ${source}  \
    --destination=${target}         \
    --version=${version}            \
    --app-version=${app_version} )
echo ${o_package}

title ">>>> Uploading Helm Chart ${version} <<<<"
source=$(echo ${o_package}| sed 's/.*\:\ //g')
echo 'source: '${source}
target=${repo}/$(echo ${source}| sed 's/.*\///g')
echo 'target: '${target}

curl -H "X-JFrog-Art-Api:${password}" -T  ${source} ${target}


# title ">>>> Updating Helm Chart Repos <<<<"
# helm repo update


