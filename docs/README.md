# Practica-FTP-JavierGarcia

# Practica FTP: Javier García Santiago

## 1. Configuraciones previas

Creamos el repositorio.

![Creando el repositorio.](/docs/caps/repositorio.png)

Hacemos un gitclone con la url de nuestro repositorio de github.

![Clonando el repositorio.](/docs/caps/git_clone.png)

Creamos el **.gitignore**.

Hacemos un `vagrant init debian/bullseye64` para poder crear el archivo **Vagrantfile**.

![Haciendo el vagrant init.](/docs/caps/vagrant_init.png)

Creamos el **bootstrap.sh** donde vamos a ir guardadno los comandos que vayamos haciendo.


Editamos el **VagrantFile**.

![Editamos el vagrantFile.](//docs/caps/vagrantFile.png)

Y hacemos un `vagrant up` para arrancar la máquina.

![Vagrant up.](/docs/caps/vagrantUp.png)

## 2. Uso del cliente FTP gráfico

Nos vamos a la página de fileZilla, y una vez dentro le damos a Download. Una vez que se nos instale tenemos que seguir los pasos para instalarlo correctamente.

![Pagina FileZilla.](/docs/caps/descargaFilezilla.png)

Una vez que hemos completado la instalación, creamos el directorio **pruebasFTP**.

![Crear directorio.](/docs/caps/pruebasFTP.png)

Ahora añadimos dentro de él un archivo de texto llamado **datos1.txt**.

![Crear archivo.](/docs/caps/datos1.png)

Una vez creado, establecemos conexión con el servidor **ftp.cica.es** , y nos bajamos el archivo **check** que está dentro de el directorio **pub**.

![Descargar archivo.](/docs/caps/descCheck.png)

Si todo ha ido correctamente nos debería de aparecer en nuestro directorio.

![Comprobación.](/docs/caps/compDesc.png)

Como vemos en la imagen, se nos ha bajado correctamente el archivo, pero ahora vamos a intentar nosotros subir uno.

![Intento.](/docs/caps/subirArch.png)

Y como podemos comprobar nos pone permiso denegado, una vez comprobado esto nos desconectamos y pasamos a la instalación y configuración en Linux.

## 3. Instalación y configuración del servidor vsftpd sobre Linux

Una vez que hemos echo anteriormente el **vagrant up** nos conectamos a la máquina a traves de un **vagrant ssh**.

![vagrant ssh.](/docs/caps/vagrantSsh.png)

Una vez dentro de la máquina, lo primero que vamos a hacer es comprobar si tenemos el servicio **vsftpd** a través de un **sudo systemctl status vsftpd**.

![comprobacion vsftpd.](/docs/caps/Comprobación1.png)

En mi caso, como si lo tengo, podríamos continur perfectamente.

A continuación lo que vamos a ver es si el puerto 21 está escuchando, mediante un **sudo ss -tlpn | grep :21**.

![escucha 21.](/docs/caps/escucha21.png)

Como vemos el puerto 21 está escuchando, así que ahora vamos a hacer una copia de seguridad del archivo **/etc/vsftpd.conf** por si, hicieramos mal la configuración tener un respaldo.

![backup.](/docs/caps/crearBackup.png)

Una vez hecho eso, hacemos un **sudo nano /etc/vsftpd** y en él borramos todo el contenido anterior e introducimos los siguientes parámetros.

![edit fich.](/docs/caps/contConf.png)

Guardamos el archivo mediante **ctrl + o** y nos salimos con un **ctrl + x**.

Una vez configurado, aunque no hayamos creado todavía ningún usuario vamos a añadir a María como usuario no enjaulado mediante un **echo "maria" | sudo tee /etc/vsftpd.chroot_list**.

![añadir Maria.](/docs/caps/añadirMaria.png)

Y reiniciamos el servicio como vemos en la captura.

Ahora sí vamos a crear los usuarios Luis, María y Javi

![crear Usuarios.](/docs/caps/crearUsers.png)

Y a continuación les creamos sus directorios en el **/home** y le añadimos unos archivos mediante un **touch** (Aquí cometí varios errores, que fueron que me equivoqué al añadir el holamaria.txt, y se lo puse a luis, y el otro es que me daba unos errores al intentar conectar a luis, así que tuve que cambiarle los permisos(como ves en la última captura.)).

![crear Fich.](/docs/caps/crearFich.png)

![mod Luis.](/docs/caps/crearFichLuis.png)

Una vez creado directorios y todo el contenido, pasamos a las comprobaciones, nos conectamos a nuestro servidor a traves de FileZilla, de forma anónima.

![conect Anonimo.](/docs/caps/anonimo.png)

Como vemos lo redirige al directorio **/srv/ftp** el cual es el que le habíamos específicado anteriormente en el fichero de configuración para conexiones anónimas.

Ahora nos conectamos como María y comprobamos que puede salirse de su directorio, es decir, que no está enjaulado.

![conect Maria.](/docs/caps/maria_ns.png)

Y por último vamos con Luis, que al estar enjaulado, no puede salirse de su directorio de trabajo

![conect Luis.](/docs/caps/luis_ns.png).


## 4. Configuración del servidor vsftpd seguro Linux

Para poder darle más seguridad a nuestro servidor FTP, lo primero que debemos de hacer es crear un **certificado de autentificación**

![crear Cert](/docs/caps/crearcert.png)

Una vez creado, nos vamos al archivo de configuración que habiamos editado previamente (**/etc/vsftpd.conf**) y añadimos las siguientes líneas que son para añadir nuestro certificado.

![edit Fich](/docs/caps/confCert.png)

Posteriormente, una vez editado el archivo hacemos otro **sudo systemctl restart vsftpd**, y si nos sale una línea verde que pone **active (running)** significaría que está bien editado.

![comprobacion.](/docs/caps/comprobarPostEdicion.png)

Y ya pues nos vamos a FileZilla, y establecemos una conexión anonima segura.

![anonimo segura.](/docs/caps/anonimo_s.png)

Como vemos nos pide una contraseña, esto lo que permite es que no acceda nadie de forma anonima, lo que lo vuelve más seguro

Y por último comprobamos que con Luis y Maria si nos deja acceder y que nos aparece el candado de seguro abajo de la ventana.

![luis segura.](/docs/caps/luis_s.png)

![maria segura.](/docs/caps/maria_s.png)

Y así es como crear un servidor FTP y de forma segura

### Javier García Santiagp