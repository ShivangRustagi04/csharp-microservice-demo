FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY OrderProcessingWorker.csproj .
RUN dotnet restore "OrderProcessingWorker.csproj"
COPY . .
RUN dotnet publish "OrderProcessingWorker.csproj" -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as final
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT [ "dotnet", "OrderProcessingWorker.dll" ]
