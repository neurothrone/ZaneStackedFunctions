using System.Net;
using System.Text.Json;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;

namespace ZaneStackedFunctions.Api;

public class GetRandomExcuseFunction
{
    private static readonly string[] Excuses =
    {
        "My computer exploded.",
        "I got stuck in an endless email loop.",
        "My pet python is shedding and needs supervision.",
        "Aliens abducted my homework.",
        "The dog ate my laptop.",
        "I got lost in the metaverse and couldn't escape.",
        "I accidentally set my alarm for PM instead of AM.",
        "I was practicing social distancing... from everyone.",
        "My grandma challenged me to a gaming tournament.",
        "My Wi-Fi ran out of data.",
        "The internet was too slow to function.",
        "I mistakenly set my phone to 'Airplane Mode' and it flew away.",
        "My cat hid my car keys.",
        "My dog locked me out.",
        "My parrot changed my password and won’t tell me what it is.",
        "Gravity stopped working for me temporarily.",
        "I got stuck in an existential crisis.",
        "I was time-traveling and lost track of reality."
    };

    [Function("GetRandomExcuse")]
    public static async Task<HttpResponseData> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "excuses/random")]
        HttpRequestData req)
    {
        var randomExcuse = Excuses[new Random().Next(Excuses.Length)];
        var response = req.CreateResponse(HttpStatusCode.OK);
        response.Headers.Add("Content-Type", "application/json");

        var json = JsonSerializer.Serialize(new { excuse = randomExcuse });
        await response.WriteStringAsync(json);

        return response;
    }
}