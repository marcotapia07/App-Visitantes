
# 🏢 App Visitas — Registro de Visitantes en Flutter 🚪📋

¡Bienvenido a **App Visitas**!  
Una app hecha en Flutter que permite **registrar y gestionar visitantes de una oficina** en tiempo real usando **Firebase**.

---

## ✨ Funcionalidades principales

🔐 **Login y Registro con Firebase Authentication**  
- Los usuarios pueden registrarse e iniciar sesión con correo y contraseña.  
- Los datos del usuario se guardan en Firestore (`usuarios/`).

📋 **Pantalla principal con visitantes registrados**  
- Lista actualizada en tiempo real desde Firebase Firestore.  
- Muestra: nombre, motivo y hora de visita.

➕ **Formulario para agregar visitantes**  
- Nombre del visitante  
- Motivo de la visita  
- Fecha/hora (automática o elegida con DatePicker)  
- Foto (tomada desde la cámara o subida, compatible con Web y Móvil)

📸 **Subida de imagen a Firebase Storage**  
- Cada visitante puede tener su propia foto asociada.  
- Compatible con Flutter Web y Mobile (`Image.memory` / `Image.file`).

---

## 🧑‍💻 Tecnologías utilizadas

- Flutter (Multiplataforma)
- Firebase Auth (login/registro)
- Cloud Firestore (datos en tiempo real)
- Firebase Storage (imágenes)
- `image_picker` y `intl`

---

## 🚀 Cómo correr el proyecto

1. Clona este repositorio:

bash
git clone https://github.com/marcotapia07/App-Visitantes/edit/main/README.md
cd App-Visitantes
`

2. Instala los paquetes:

bash
flutter pub get


3. Asegúrate de tener Firebase configurado en tu proyecto:
   (web, android, ios) → sin usar `firebase_options.dart`.

4. Ejecuta en emulador o navegador:

bash
flutter run


---

## 📦 Estructura del proyecto


lib/
├── main.dart            # Punto de entrada
├── login.dart           # Pantalla de login/registro
├── home.dart            # Lista de visitantes
└── add_visitor.dart     # Formulario para nuevo visitante


---

## 🧠 Ideas futuras

* Escaneo de código QR para visitantes frecuentes.
* Filtro por fecha/motivo.
* Dashboard web de estadísticas.
* Notificaciones push cuando alguien llega.

---

## 🙌 Autor

Desarrollado por \Marco Tapia — apasionado por Flutter y la automatización del mundo real 🚀
