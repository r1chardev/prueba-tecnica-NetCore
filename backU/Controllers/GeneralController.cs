using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Reflection.Metadata;
using System.Text.Json;

namespace backU.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class GeneralController : ControllerBase
    {        

        public readonly string connection_string;

        public GeneralController(IConfiguration configuration)
        {
            connection_string = configuration.GetConnectionString("MAIN");
        }     
             

        [HttpPost("create_user")]
        public dynamic Post(string name, string mail, int document, string password)
        {
            int userId;

            using (SqlConnection connection = new(connection_string))
            {
                connection.Open();
                using (SqlCommand cmd = new("insert_users", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Agregar parámetros de entrada
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", mail);
                    cmd.Parameters.AddWithValue("@Document", document);
                    cmd.Parameters.AddWithValue("@Password", password);

                    // Agregar parámetro de salida
                    SqlParameter outputIdParam = new SqlParameter("@UserId", System.Data.SqlDbType.Int)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor del parámetro de salida
                    userId = (int)cmd.Parameters["@UserId"].Value;
                }
            }

            if (userId == 0)
            {
                return "El usuario con ese documento o ese correo ya se encuentra registrado en el sistema, si los datos son correctos por favor contacta con soporte";
            }
            return userId; // Retornar el ID del usuario creado
        }

        [HttpGet("login")]
        public dynamic GetServicePlan(int document, string password)
        {
            string response;

            using (SqlConnection connection = new SqlConnection(connection_string))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("users_login", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Agregar parámetro de entrada
                    cmd.Parameters.AddWithValue("@document", document);
                    cmd.Parameters.AddWithValue("@password", password);

                    // Agregar parámetro de salida con longitud máxima definida
                    SqlParameter outputIdParam = new SqlParameter("@response", System.Data.SqlDbType.NVarChar, -1)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor del parámetro de salida como string
                    response = cmd.Parameters["@response"].Value.ToString();
                }
            }

            
            if (response!= "Usuario o contraseña erroneos")
            {
                // Deserializar el string JSON a un objeto dinámico
                
                // Si las credenciales son correctas, puedes devolver un 200 OK
                return Ok(JsonSerializer.Deserialize<List<Dictionary<string, object>>>(response));
            }
            else
            {
                // Si las credenciales son incorrectas, devolver un 401 Unauthorized
                return Unauthorized(new { mensaje = "Usuario o contraseña erróneos." });
            }
        }

        //[HttpPost("transferir_dinero")]
        //public dynamic TransferirDinero(double monto, int id_cuenta_destino)
        //{
        //    int userId;

        //    using (SqlConnection connection = new(connection_string))
        //    {
        //        connection.Open();
        //        using (SqlCommand cmd = new("insert_users", connection))
        //        {
        //            cmd.CommandType = System.Data.CommandType.StoredProcedure;

        //            // Agregar parámetros de entrada
        //            cmd.Parameters.AddWithValue("@Name", name);
        //            cmd.Parameters.AddWithValue("@Email", mail);
        //            cmd.Parameters.AddWithValue("@Document", document);
        //            cmd.Parameters.AddWithValue("@Password", password);

        //            // Agregar parámetro de salida
        //            SqlParameter outputIdParam = new SqlParameter("@UserId", System.Data.SqlDbType.Int)
        //            {
        //                Direction = System.Data.ParameterDirection.Output
        //            };
        //            cmd.Parameters.Add(outputIdParam);

        //            // Ejecutar el comando
        //            cmd.ExecuteNonQuery();

        //            // Obtener el valor del parámetro de salida
        //            userId = (int)cmd.Parameters["@UserId"].Value;
        //        }
        //    }

        //    if (userId == 0)
        //    {
        //        return "El usuario con ese documento o ese correo ya se encuentra registrado en el sistema, si los datos son correctos por favor contacta con soporte";
        //    }
        //    return userId; // Retornar el ID del usuario creado
        //}

        [HttpPost("consultar_movimientos")]
        public dynamic ConsultarMovimientos(int user_id)
        {
            string response;

            using (SqlConnection connection = new SqlConnection(connection_string))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ObtenerMovimientosPorUsuario", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Agregar parámetro de entrada
                    cmd.Parameters.AddWithValue("@user_id", user_id);

                    // Agregar parámetro de salida con longitud máxima definida
                    SqlParameter outputIdParam = new SqlParameter("@response", System.Data.SqlDbType.NVarChar, -1)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor del parámetro de salida como string
                    response = cmd.Parameters["@response"].Value.ToString();
                }
            }


            if (response != "")
            {
                // Deserializar el string JSON a un objeto dinámico

                // Si las credenciales son correctas, puedes devolver un 200 OK
                return Ok(JsonSerializer.Deserialize<List<Dictionary<string, object>>>(response));
            }
            else
            {
                // Si las credenciales son incorrectas, devolver un 401 Unauthorized
                return Unauthorized(new { mensaje = "Usuario o contraseña erróneos." });
            }
        }

        [HttpPost("bloquear_cuentas")]
        public dynamic BloquearCuentas(int user_id, int banco_id)
        {
            string response;

            using (SqlConnection connection = new SqlConnection(connection_string))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_BloquearCuentaBancaria", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Agregar parámetro de entrada
                    cmd.Parameters.AddWithValue("@user_id", user_id);
                    cmd.Parameters.AddWithValue("@banco_id", banco_id);

                    // Agregar parámetro de salida con longitud máxima definida
                    SqlParameter outputIdParam = new SqlParameter("@rows_affected", System.Data.SqlDbType.NVarChar, -1)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor del parámetro de salida como string
                    response = cmd.Parameters["@rows_affected"].Value.ToString();
                }
            }

            return Ok($"Registros afectados: {response}");
            
           
        }

        [HttpPost("consultar_saldo_cuentas")]
        public dynamic ConsultarSaldoCuentas(int user_id)
        {
            string response;

            using (SqlConnection connection = new SqlConnection(connection_string))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("sp_ObtenerCuentasPorUsuario", connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Agregar parámetro de entrada
                    cmd.Parameters.AddWithValue("@user_id", user_id);                  

                    // Agregar parámetro de salida con longitud máxima definida
                    SqlParameter outputIdParam = new SqlParameter("@response", System.Data.SqlDbType.NVarChar, -1)
                    {
                        Direction = System.Data.ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor del parámetro de salida como string
                    response = cmd.Parameters["@response"].Value.ToString();
                }
            }


            if (response != "Usuario o contraseña erroneos")
            {
                // Deserializar el string JSON a un objeto dinámico
                
                // Si las credenciales son correctas, puedes devolver un 200 OK
                return Ok(JsonSerializer.Deserialize<List<Dictionary<string, object>>>(response));
            }
            else
            {
                // Si las credenciales son incorrectas, devolver un 401 Unauthorized
                return Unauthorized(new { mensaje = "Usuario o contraseña erróneos." });
            }
        }

    }



}
