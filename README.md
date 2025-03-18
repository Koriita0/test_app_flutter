# Colors App

## Descripción
Este es un proyecto de Flutter que consume una API y muestra los datos obtenidos en tarjetas dentro de una interfaz de usuario. La aplicación permite visualizar detalles de cada elemento en una nueva pantalla de tipo FullScreen.

---

## Estructura del Proyecto
### 1. `main.dart`
Este archivo contiene toda la lógica de la aplicación, desde la obtención de datos hasta la construcción de la interfaz gráfica.

### 2. `MyApp`
```dart
class MyApp extends StatelessWidget
```
#### **Descripción:**
- Configura la aplicación Flutter.
- Define el tema y la pantalla principal (`MyHomePage`).

### 3. `MyHomePage`
```dart
class MyHomePage extends StatefulWidget
```
#### **Descripción:**
- Es la pantalla principal de la aplicación.
- Muestra una lista de tarjetas con datos obtenidos de la API.
- Es un `StatefulWidget` para manejar el estado de los datos y poder variar los mismos sin reiniciar la app.

### 4. `_MyHomePageState`
```dart
class _MyHomePageState extends State<MyHomePage>
```
#### **Descripción:**
- Maneja el estado de `MyHomePage`.
- Obtiene datos desde la API con `fetchData()`.
- Construye la interfaz con `build()`.

#### **Funciones:**
##### 🔹 `initState()`
```dart
@override
void initState() {
  super.initState();
  fetchData();
}
```
- Se ejecuta cuando el widget es creado.
- Llama a `fetchData()` para obtener datos.

##### 🔹 `fetchData()`
```dart
Future<void> fetchData() async
```
- Obtiene datos desde `https://jsonplaceholder.typicode.com/posts`.
- Convierte la respuesta en una lista y la almacena en `cardData`.
- Si la petición falla, lanza una excepción.

##### 🔹 `build()`
```dart
@override
Widget build(BuildContext context)
```
- Construye la interfaz gráfica.
- Usa `SingleChildScrollView` para permitir desplazamiento.
- Muestra las tarjetas con datos obtenidos.

### 5. `FullScreenComponent`
```dart
class FullScreenComponent extends StatelessWidget
```
#### **Descripción:**
- Muestra los detalles de un elemento cuando se toca una tarjeta.

### 6. `NoDataComponent`
```dart
class NoDataComponent extends StatelessWidget
```
#### **Descripción:**
- Se muestra cuando no hay datos disponibles.

### 7. `_buildCard()`
```dart
Widget _buildCard(BuildContext context, String title, String description, [Widget? link])
```
#### **Descripción:**
- Genera una tarjeta con título, descripción y un botón para ver más detalles.
- Si `link` es nulo, se muestra `NoDataComponent`.

---

## API Consumida
Se obtienen datos de la API:
```sh
https://jsonplaceholder.typicode.com/posts
```

