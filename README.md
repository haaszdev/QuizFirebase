# Quiz App

Este é um aplicativo de quiz simples desenvolvido com **Flutter** e **Firebase Realtime Database**. O app busca questões de um banco de dados no Firebase e permite que o usuário responda a perguntas, veja o placar e reinicie o quiz.

<img width="497" alt="image" src="https://github.com/user-attachments/assets/46fa61dc-5328-424e-bc65-f419ddf28813" />

---

## Funcionalidades

- Carregamento dinâmico de perguntas do Firebase.
- Respostas múltiplas com escolha única.
- Exibição de pontuação ao final do quiz.
- Reinício do quiz após o término.

---

## Pré-requisitos

- Flutter instalado em sua máquina.
- Conta no Firebase e projeto configurado.
- Dependências do Flutter instaladas.

---

## Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/quiz-app.git
```

## 2. Instale as dependências

Dentro da pasta do projeto, execute:

```bash
flutter pub get
```

## 3. Configure o Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Adicione seu aplicativo Flutter ao Firebase e obtenha as credenciais.
3. Adicione as credenciais do Firebase no código (substituindo os valores do `apiKey`, `appId`, etc., no arquivo `main.dart`).

---

## 4. Execute o aplicativo

Conecte um dispositivo ou inicie um emulador e execute o aplicativo com o comando:

```bash
flutter run
```
## Estrutura do Banco de Dados (Firebase)

O banco de dados do Firebase deve ter a seguinte estrutura para as perguntas:

```json
{
  "questions": {
    "question1": {
      "question": "Qual é a capital do Brasil?",
      "options": ["Rio de Janeiro", "Brasília", "São Paulo", "Salvador"],
      "answer": 1
    },
```

<img width="516" alt="image" src="https://github.com/user-attachments/assets/e6f39f42-fb0d-4e17-bb93-1374fb6262f6" />
