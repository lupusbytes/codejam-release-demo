FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-noble AS build
ARG TARGETARCH
WORKDIR /source

# Copy .csproj file for LupusBytes.CS2.GameStateIntegration.Api
COPY src/CodeJamApi/*.csproj ./src/CodeJamApi/

# Restore as distinct layer
RUN dotnet restore --arch $TARGETARCH ./src/CodeJamApi

# Copy the rest of the source code
COPY src/ ./src/

# Copy required config files from root directory
COPY Directory.Build.props .

# Build the app
RUN dotnet publish --arch $TARGETARCH ./src/CodeJamApi/*.csproj -o /app

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-noble-chiseled
EXPOSE 8080
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["./CodeJamApi"]