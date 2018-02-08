echo ---------------
echo START OF SCRIPT
echo ---------------
echo
cd ~
if [ -d "Build" ]; then
  echo deleting old build files
  rm -r ~/Build
fi
echo "killing all docker containers and removing all images (if any)"
docker kill $(docker ps -a -q)
docker rmi -f $(docker images -q)
echo making new build directory
mkdir Build
echo moving files into build
mv /home/ubuntu/target /home/ubuntu/Build
mv /home/ubuntu/frontend /home/ubuntu/Build
mv
cd /home/ubuntu/Build/target
echo Building backend image
docker build -t backend .
echo Running backend image
docker run -d -p 3000:8080 backend
echo Backend now available at NODE-IP:3000
cd /home/ubuntu/Build/frontend
echo Building frontend image
docker build -t frontend .
echo Running frontend image
docker run -d -p 49160:3000 frontend
echo frontend now available at NODE-IP:49160
echo
echo -------------
echo END OF SCRIPT
echo -------------
