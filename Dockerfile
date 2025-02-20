# Use official .NET SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy everything and restore dependencies
COPY . .
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o /out

# Use a runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out ./

# Expose the API port
EXPOSE 8080

# Run the API
ENTRYPOINT ["dotnet", "BooksManagementAPI.dll"]
