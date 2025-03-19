#!/bin/bash

palabra=$1
if [ "$palabra" == "install" ]; then
        echo "Instalando Kapac..."
        git clone https://github.com/toch-2303/Kapac
        clear
        echo "Instalado con éxito"
elif [ "$palabra" == "uninstall" ]; then
        echo "Desinstalando Kapac..."
        rm -rf Kapac
        echo "Desinstalación completada"
elif [ "$palabra" == "help" ]; then
        cd Kapac
        lynx help.html
elif [ "$palabra" == "about" ]; then
        cd Kapac
        lynx about.html
elif [ "$palabra" == "contact" ]; then
        cd Kapac
        lynx contact.html
elif [ "$palabra" == "web" ]; then
        cd Kapac
        lynx index.html
elif [ "$palabra" == "commands" ]; then
        echo "------- Comandos ----------"
        echo -e "install: sirve para instalar nuestro github
uninstall: sirve para desinstalar nuestro github
help: te lleva a nuestro apartado de ayuda
about: te lleva a nuestro apartado acerca de nosotros
contact: te lleva a nuestra página para que puedas contactarte con nosotros
web: te lleva a nuestra página web
robot: te muestra un robot muy lindo :)
    (sin comando): te lleva a nuestra shell interactiva"
elif [ "$palabra" == "robot" ]; then
        echo "                    _____ "
        echo "                   |     | "
        echo "                   | | | | "
        echo "                   |_____| "
        echo "             ____ ___|_|___ ____ "
        echo "            ()___)         ()___) "
        echo "            // /|           |\ \\ "
        echo "           // / |           | \ \\ "
        echo "          (___) |___________| (___) "
        echo "          (___)   (_______)   (___) "
        echo "          (___)     (___)     (___) "
        echo "          (___)      |_|      (___) "
        echo "          (___)  ___/___\___   | | "
        echo "           | |  |           |  | | "
        echo "           | |  |___________| /__ \  "
        echo "          /___\   |||    ||| //   \\ "
        echo "         //    \\  |||    ||| \\   // "
        echo "         \\    //  |||    |||  \\ // "
        echo "          \\  //  ()__)  (__() "
        echo "                 ///       \\\ "
        echo "                ///         \\\ "
        echo "              _///___     ___\\\_   "
        echo "             |_______|   |_______|     "
else
mostrar_logo(){
echo -e "\033[32m"
cat << "EOF"

_    _                                                __    __
|  \  /  \                                              /      \  /      \
| $$ /  $$ __    __    __    ___                       |  $$$$$$\|  $$$$$$\
| $$/  $$ |      \  /      \  |      \  /       \      | $$  | $$| $$_  \$$
| $$  $$   \$$$$$$\|  $$$$$$\  \$$$$$$\|  $$$$$$$      | $$  | $$ \$$    \
| $$$$$\  /      $$| $$  | $$ /      $$| $$            | $$  | $$ _\$$$$$$\
| $$ \$$\|  $$$$$$$| $$/   $$|  $$$$$$$| $$_           | $$/   $$|  \  | $$
| $$  \$$\\$$    $$| $$    $$ \$$    $$ \$$     \       \$$    $$ \$$    $$
 \$$   \$$ \$$$$$$$| $$$$$$$   \$$$$$$$  \$$$$$$$        \$$$$$$   \$$$$$$
                   | $$
                   | $$
                    \$$
EOF
echo -e "\033[0m"
}
clear
mostrar_logo

HOME_DIR="$HOME/kapacOS_HOME"
DIR_ACTUAL="$HOME/kapacOS_HOME"
CONTADOR_FILE="$HOME_DIR/contador.txt"

mkdir -p "$HOME_DIR"

if [ -f "$CONTADOR_FILE" ]; then
    contador=$(cat "$CONTADOR_FILE")
else
    contador=0
fi

echo "Contador de palabras mágicas = $contador"

echo "¿Cómo te llamas?"
read usuario

echo "$usuario Bienvenid@ a tu terminal interactiva"

palabras_magicas=("porfa" "gracias" "por favor")

palabras_malas=("estupido" "rata" "malo")

function verificar_palabra_magica {
    for palabra in "${palabras_magicas[@]}"; do
        if [[ "$1" == *"$palabra"* ]]; then
            return 0
        fi
    done
    return 1
}

function verificar_palabra_mala {
    for palabra in "${palabras_malas[@]}"; do
        if [[ "$1" == *"$palabra"* ]]; then
            return 0
        fi
    done
    return 1
}

function limpiar_nombre_directorio {
    local nombre=$1
    for palabra in "${palabras_magicas[@]}"; do
        nombre=${nombre// $palabra/}
        nombre=${nombre//$palabra/}
    done
    nombre=$(echo "$nombre" | xargs)
    echo "$nombre"
}


function guardar_contador {
    echo "$contador" > "$CONTADOR_FILE"
}

while true; do
    echo -e -n "\033[33m$usuario Kapac OS> \033[0m"
    read -r comando args

    if verificar_palabra_magica "$args"; then
        ((contador++))
        echo "¡Gracias por tu amabilidad! Puntos: $contador"
        guardar_contador
    elif verificar_palabra_mala "$args"; then
        ((contador --))
        echo "¡Por favor no uses malas palabras! Puntos: $contador"
        guardar_contador
    else
        if [[ "$comando" == "mkdir" || "$comando" == "crear" ]]; then
            echo "¿Cuál es la palabra mágica?"
            read palabra_magica
            if [[ " ${palabras_magicas[@]} " =~ " $palabra_magica " ]]; then
                nombre_limpio=$(limpiar_nombre_directorio "$args")
                if [ -z "$nombre_limpio" ]; then
                    echo "Uso: mkdir <nombre_del_directorio>"
                else
                    mkdir "$DIR_ACTUAL/$nombre_limpio" 2>/dev/null #|| echo "Error: No se pudo crear el directorio"
                    echo "Directorio '$nombre_limpio' creado correctamente."
                fi
            else
                echo "¡No es la palabra mágica! Intenta de nuevo."
            fi
        fi
    fi

    case $comando in
        "muerte")
        echo "Esta vida no es para mi"
        echo "Veré que hay del otro lado"
        kill -9 $$ ;;
        "contador")
        echo "Puntos: $contador"
        ;;
        "clear" | "limpiar")
        tput reset
        mostrar_logo
        ;;
        "salir")
            clear
            break
            ;;
        "fecha")
            date
            ;;
        "listar")
            ls "$DIR_ACTUAL"
            ;;
        "mkdir" | "crear")
            if [ -z "$args" ]; then
                echo "Uso: mkdir <nombre_del_directorio>"
            else
                nombre_limpio=$(limpiar_nombre_directorio "$args")
                mkdir "$DIR_ACTUAL/$nombre_limpio" 2>/dev/null || echo "Error: No se pudo crear el directorio"
            fi
            ;;
        "mover")
            if [ -z "$args" ]; then
                echo "Uso: mover <nombre_del_directorio>"
            elif [ -d "$DIR_ACTUAL/$args" ]; then
                DIR_ACTUAL="$DIR_ACTUAL/$args"
                echo "Cambiando al directorio: $DIR_ACTUAL"
            elif [ -d "$HOME_DIR/$args" ]; then
                DIR_ACTUAL="$HOME_DIR/$args"
                echo "Cambiando al directorio: $DIR_ACTUAL"
            else
                echo "Error: El directorio '$args' no existe"
            fi
            ;;
        "pwd" | "donde")
            echo "Directorio actual: $DIR_ACTUAL"
            ;;
        "borrar" | "eliminar")
            if [ -z "$args" ]; then
                echo "Uso: borrar <nombre_del_directorio>"
            else
                nombre_limpio=$(limpiar_nombre_directorio "$args")
                if [ -d "$DIR_ACTUAL/$nombre_limpio" ]; then
                    rmdir "$DIR_ACTUAL/$nombre_limpio" 2>/dev/null || echo "Error: El directorio no está vacío o no se pudo eliminar."
                    echo "El directorio '$nombre_limpio' ha sido eliminado."
                else
                    echo "Error: El directorio '$nombre_limpio' no existe en el directorio actual."
                fi
            fi
            ;;
        "robot")
            echo "                    _____ "
            echo "                   |     | "
            echo "                   | | | | "
            echo "                   |_____| "
            echo "             ____ ___|_|___ ____ "
            echo "            ()___)         ()___) "
            echo "            // /|           |\ \\ "
            echo "           // / |           | \ \\ "
            echo "          (___) |___________| (___) "
            echo "          (___)   (_______)   (___) "
            echo "          (___)     (___)     (___) "
            echo "          (___)      |_|      (___) "
            echo "          (___)  ___/___\___   | | "
            echo "           | |  |           |  | | "
            echo "           | |  |___________| /__ \  "
            echo "          /___\   |||    ||| //   \\ "
            echo "         //    \\  |||    ||| \\   // "
            echo "         \\    //  |||    |||  \\ // "
            echo "          \\  //  ()__)  (__() "
            echo "                 ///       \\\ "
            echo "                ///         \\\ "
            echo "              _///___     ___\\\_   "
            echo "             |_______|   |_______|     "
            ;;
        *)
            echo "Ejecutando comando en Bash: $comando $args"
            bash -c "$comando $args"
            ;;
    esac
done
echo "Salida realizada con éxito"
fi
