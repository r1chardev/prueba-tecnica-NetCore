namespace backU.Models
{
    public class Services
    {
        //typo de servicio
        public int service_type { get; set; }
        //base
        //public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int price { get; set; }
        //internet
        public int? megasxsegundo { get; set; }
        //phone
        public bool? llamadasInternacionales { get; set; }
        public bool? minutosIlimitados { get; set; }
        public int? cantidadMinutos { get; set; }
        //TV
        public string? planesCanales { get; set; }
    }

}
