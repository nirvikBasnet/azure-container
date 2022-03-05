FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

RUN mkdir /app
WORKDIR /app

COPY ./webapp/bin/Release/netcoreapp3.1/publish ./
COPY ./config.sh ./

RUN bash config.sh

EXPOSE 80
ENTRYPOINT ["dotnet", "webapp.dll"]