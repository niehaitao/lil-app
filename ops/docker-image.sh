#!/usr/bin/env bash

src_app_dev=
docker_file=
docker_repo=
docker_img=
docker_tag=

while getopts :s:f:r:i:t: o; do
    case "${o}" in
        s)
            src_app_dev=${OPTARG}      ;;
        f)
            docker_file=${OPTARG}        ;;
        r)
            docker_repo=${OPTARG}        ;;
        i)
            docker_img=${OPTARG}   ;;
        t)
            docker_tag=${OPTARG}       ;;
    esac
done
shift $((OPTIND-1))

docker_tag=${docker_tag}'-'$(date +"%Y%m%d-%H%M%S")

rm -rf ${src_app_dev}/index.html
sed 's/docker_tag/'${docker_tag}'/g' ${src_app_dev}/index.tmpl > ${src_app_dev}/index.html


echo ">>>> Createing Docker Image <<<<"
docker build ${src_app_dev} \
    -t ${docker_repo}/${docker_img}:${docker_tag} \
    -f ${docker_file}
    
docker push ${docker_repo}/${docker_img}:${docker_tag}

echo ''
echo '-source: '${src_app_dev}
echo '-target: '${docker_repo}/${docker_img}:${docker_tag}
echo ''