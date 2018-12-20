 FROM microsoft/dotnet:2.1-sdk AS builder
 WORKDIR /code
 # caches restore result by copying csproj file separately
 COPY . .
 RUN dotnet restore
 RUN dotnet publish --output /app/ --configuration Release
 # Stage 2
 FROM microsoft/aspnetcore:2.0.6
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "AspNetCoreOnDocker.dll"]