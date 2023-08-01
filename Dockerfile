# Use the official .NET SDK as the base image
FROM mcr.microsoft.com/dotnet/sdk:7.0.109 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY PoojaStores\PoojaStores.csproj .

# Restore NuGet packages
RUN dotnet restore

# Copy the entire project to the container
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use a smaller runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:7.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the previous build stage to the current stage
COPY --from=build /app/out .

# Expose the port that your application listens on
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "PoojaStores\PoojaStores.dll"]
