require 'json'

def leerDatos()
  file = open("/api/datosClientes.json")
  json = file.read
  clientes = JSON.parse(json)
  return clientes
end

def datosCliente(correo)

  cad = 'Usuario no encontrado'
  for i in (0..clientes["clientes"].length-1)
    if clientes["clientes"][i]["correo"] == correo
      cad = " Mis Datos Personales:
      Nombre: #{clientes["clientes"][i]["nombre"]}
      Apellidos: #{clientes["clientes"][i]["apellidos"]}
      Correo Electrónico: #{correo}
      Código Postal: #{clientes["clientes"][i]["codigoPostal"]}
      Fecha de Nacimiento: #{clientes["clientes"][i]["FechaNacimiento"]} \n"
    end
  end
  return cad
end

Handler = Proc.new do |req, res|
  correo = req.query['correo'] || 'mariasanz@correo.ugr.es'

  clientes = leerDatos()
  cad = datosCliente(correo)

  res.status = 200
  res['Content-Type'] = 'text/text; charset=utf-8'
  res.body = cad.to_json
end
