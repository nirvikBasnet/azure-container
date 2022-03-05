#####################################################################################
# Requirements for this demo
# 1. Install docker          - https://docs.docker.com/desktop/#download-and-install 
# 2. Install dotnet core sdk - https://dotnet.microsoft.com/download/dotnet-core
#####################################################################################
cd ./m2/demos


#This is our simple hello world web app and will be included in the course downloads.
ls -ls ./webapp


#Step 1 - Build our web app first and test it prior to putting it in a container
dotnet build ./webapp
dotnet run --project ./webapp #Open a new terminal to test.
curl http://localhost:5000


#Step 2 - Let's publish a local build...this is what will be copied into the container
dotnet publish -c Release ./webapp


#Step 3 - Time to build the container and tag it...the build is defined in the Dockerfile
docker build -t webappimage:v1 .


#In docker 3.0, by default output from commands run in the container during the build aren't written to console
#Add you need to add --progress plain to see the output from commands running during the build
#If you already built the image you'll need to delete the image and your build cache so new layers are built
#docker rmi webappimage:v1 && docker builder prune --force && docker image prune --force
#docker build --progress plain -t webappimage:v1 .


#Step 4 - Run the container locally and test it out
docker run --name webapp --publish 8080:80 --detach webappimage:v1
curl http://localhost:8080


#Delete the running webapp container
docker stop webapp
docker rm webapp


#The image is still here...let's hold onto this for the next demo.
docker image ls webappimage:v1
