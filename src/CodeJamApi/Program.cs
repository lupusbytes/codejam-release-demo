using System.Reflection;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
app.UseHttpsRedirection();
app.UseSwagger();
app.UseSwaggerUI();

app.MapGet(
        "/version",
        () => new { Version = Assembly
            .GetExecutingAssembly()
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()?
            .InformationalVersion ?? "Unknown" })
    .WithName("GetApiVersion")
    .WithOpenApi();

app.MapGet(
        "/ping",
        () => new { Message = "pong" })
    .WithName("Ping")
    .WithOpenApi();

app.MapGet(
    "/hello",
    () => new { Message = "World!" })
    .WithName("Hello")
    .WithOpenApi();

app.Run();