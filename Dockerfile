# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the application inside the container
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image as the base image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the built application from the build container to the runtime container
COPY --from=build /app/out .

# Expose the port on which the application will listen (change this if your app uses a different port)
EXPOSE 80

# Command to run the application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
