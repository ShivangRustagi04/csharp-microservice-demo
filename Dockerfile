FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY OrderProcessingWorker.csproj .
RUN dotnet restore "OrderProcessingWorker.csproj"
COPY . .
RUN dotnet tool install -g dotnet-sonarscanner

ENV PATH="${PATH}:/root/.dotnet/tools"

RUN dotnet publish "OrderProcessingWorker.csproj" -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 as final
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT [ "dotnet", "OrderProcessingWorker.dll" ]
