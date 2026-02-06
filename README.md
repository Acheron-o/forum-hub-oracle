# 🚀 ForumHub API - Challenge Alura


![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
## 📋 Descrição
API REST completa para gerenciamento de fórum de discussões, desenvolvida com Spring Boot 3, Spring Security e autenticação JWT.



**Challenge:** Oracle Next Education (ONE) - Alura Back-End

## 🏗️ Arquitetura

### Estrutura do Projeto:
```
forumhub/
├── src/main/java/com/forumhub/
│   ├── ForumHubApplication.java       # Main application
│   ├── model/
│   │   ├── User.java                  # Entity Usuário (UserDetails)
│   │   ├── Topic.java                 # Entity Tópico
│   │   └── Course.java                # Entity Curso
│   ├── dto/
│   │   ├── LoginRequest.java          # DTO para login
│   │   ├── TokenResponse.java         # DTO resposta do token
│   │   ├── TopicCreateRequest.java    # DTO criar tópico
│   │   ├── TopicUpdateRequest.java    # DTO atualizar tópico
│   │   └── TopicResponse.java         # DTO resposta tópico
│   ├── repository/
│   │   ├── UserRepository.java        # JPA Repository usuários
│   │   ├── TopicRepository.java       # JPA Repository tópicos
│   │   └── CourseRepository.java      # JPA Repository cursos
│   ├── service/
│   │   ├── AuthenticationService.java # UserDetailsService
│   │   ├── TokenService.java          # JWT generation/validation
│   │   └── TopicService.java          # Business logic tópicos
│   ├── controller/
│   │   ├── AuthenticationController.java # /auth endpoints
│   │   └── TopicController.java          # /topicos CRUD
│   ├── security/
│   │   ├── SecurityConfiguration.java # Spring Security config
│   │   └── SecurityFilter.java        # JWT filter
│   └── exception/
│       └── GlobalExceptionHandler.java # Error handling
├── src/main/resources/
│   └── application.properties         # Configuration
├── pom.xml                            # Maven dependencies
└── init.sql                           # Database initialization
```

## 🔐 Funcionalidades

### Autenticação:
- ✅ Login com JWT token
- ✅ Token Bearer para todas requisições protegidas
- ✅ Validação automática de token

### CRUD Completo de Tópicos:
- ✅ **CREATE** - Criar novo tópico (autenticado)
- ✅ **READ** - Listar todos os tópicos (público)
- ✅ **READ** - Buscar tópico por ID (público)
- ✅ **UPDATE** - Atualizar tópico (apenas autor)
- ✅ **DELETE** - Deletar tópico (apenas autor)

### Regras de Negócio:
- ✅ Não permite tópicos duplicados (mesmo título + mensagem)
- ✅ Apenas usuários autenticados podem criar tópicos
- ✅ Apenas o autor pode atualizar/deletar seu tópico
- ✅ Data de criação automática
- ✅ Status do tópico (NAO_RESPONDIDO, NAO_SOLUCIONADO, SOLUCIONADO, FECHADO)

## 🛠️ Tecnologias

- **Java 17**
- **Spring Boot 3.2.3**
- **Spring Security** (JWT Authentication)
- **Spring Data JPA** (Hibernate)
- **PostgreSQL**
- **Lombok**
- **Bean Validation**
- **Auth0 JWT**
- **Maven**

## 📦 Pré-requisitos

- ✅ Java JDK 17+
- ✅ Maven 4+
- ✅ PostgreSQL 16+
- ✅ Postman ou Insomnia (para testar API)
- ✅ IntelliJ IDEA (recomendado)

## 🔧 Configuração e Execução

### Passo 1: Criar Database
```sql
-- No PostgreSQL
CREATE DATABASE forumhub;
```

### Passo 2: Configurar application.properties
Edite `src/main/resources/application.properties`:
```properties
spring.datasource.password=YOUR_PASSWORD_HERE
```

### Passo 3: Inicializar Dados de Teste
Execute o script `init.sql` no PostgreSQL:
```bash
psql -U postgres -d forumhub -f init.sql
```

Isso cria 3 usuários de teste:
- **Login:** `admin` | **Senha:** `123456`
- **Login:** `maria` | **Senha:** `123456`
- **Login:** `joao` | **Senha:** `123456`

### Passo 4: Executar Aplicação

**Via IntelliJ:**
1. Abra o projeto
2. Aguarde Maven baixar dependências
3. Run `ForumHubApplication.java`

**Via Linha de Comando:**
```bash
cd forumhub
mvn clean install
mvn spring-boot:run
```

**Servidor roda em:** `http://localhost:8080`

## 📡 Endpoints da API

### 🔑 Autenticação

#### POST /auth/login
Fazer login e receber token JWT

**Request:**
```json
{
  "login": "admin",
  "senha": "123456"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

### 📚 Tópicos

#### POST /topicos
Criar novo tópico (🔒 Requer autenticação)

**Headers:**
```
Authorization: Bearer {seu_token_aqui}
```

**Request:**
```json
{
  "titulo": "Como usar Spring Security?",
  "mensagem": "Estou com dúvida sobre configuração do Spring Security com JWT",
  "nomeCurso": "Spring Boot"
}
```

**Response (201 CREATED):**
```json
{
  "id": 1,
  "titulo": "Como usar Spring Security?",
  "mensagem": "Estou com dúvida sobre configuração do Spring Security com JWT",
  "dataCriacao": "2024-02-05T10:30:00",
  "status": "NAO_RESPONDIDO",
  "autor": "Administrador",
  "curso": "Spring Boot"
}
```

---

#### GET /topicos
Listar todos os tópicos (público)

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "titulo": "Como usar Spring Security?",
    "mensagem": "Estou com dúvida...",
    "dataCriacao": "2024-02-05T10:30:00",
    "status": "NAO_RESPONDIDO",
    "autor": "Administrador",
    "curso": "Spring Boot"
  }
]
```

---

#### GET /topicos/{id}
Buscar tópico específico (público)

**Response (200 OK):**
```json
{
  "id": 1,
  "titulo": "Como usar Spring Security?",
  "mensagem": "Estou com dúvida...",
  "dataCriacao": "2024-02-05T10:30:00",
  "status": "NAO_RESPONDIDO",
  "autor": "Administrador",
  "curso": "Spring Boot"
}
```

---

#### PUT /topicos/{id}
Atualizar tópico (🔒 Apenas o autor)

**Headers:**
```
Authorization: Bearer {seu_token_aqui}
```

**Request:**
```json
{
  "titulo": "Dúvida resolvida!",
  "mensagem": "Consegui configurar o Spring Security",
  "status": "SOLUCIONADO"
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "titulo": "Dúvida resolvida!",
  "mensagem": "Consegui configurar o Spring Security",
  "dataCriacao": "2024-02-05T10:30:00",
  "status": "SOLUCIONADO",
  "autor": "Administrador",
  "curso": "Spring Boot"
}
```

---

#### DELETE /topicos/{id}
Deletar tópico (🔒 Apenas o autor)

**Headers:**
```
Authorization: Bearer {seu_token_aqui}
```

**Response (200 OK):**
```
(sem corpo)
```

---

## 🧪 Testando com Postman/Insomnia

### 1. Fazer Login
```
POST http://localhost:8080/auth/login
Body (JSON):
{
  "login": "admin",
  "senha": "123456"
}
```
**Copie o token recebido!**

### 2. Criar Tópico
```
POST http://localhost:8080/topicos
Headers:
  Authorization: Bearer {cole_o_token_aqui}
Body (JSON):
{
  "titulo": "Meu primeiro tópico",
  "mensagem": "Testando a API",
  "nomeCurso": "Java"
}
```

### 3. Listar Tópicos
```
GET http://localhost:8080/topicos
(não precisa de token)
```

### 4. Atualizar Tópico
```
PUT http://localhost:8080/topicos/1
Headers:
  Authorization: Bearer {cole_o_token_aqui}
Body (JSON):
{
  "titulo": "Tópico atualizado",
  "status": "SOLUCIONADO"
}
```

### 5. Deletar Tópico
```
DELETE http://localhost:8080/topicos/1
Headers:
  Authorization: Bearer {cole_o_token_aqui}
```

---

## ⚠️ Códigos de Status HTTP

| Código | Significado |
|--------|-------------|
| 200 OK | Requisição bem-sucedida |
| 201 CREATED | Recurso criado com sucesso |
| 400 BAD REQUEST | Dados inválidos (validação falhou) |
| 401 UNAUTHORIZED | Token inválido ou expirado |
| 403 FORBIDDEN | Sem permissão (ex: tentar deletar tópico de outro usuário) |
| 404 NOT FOUND | Recurso não encontrado |
| 500 INTERNAL SERVER ERROR | Erro no servidor |

---

## 🗄️ Estrutura do Banco de Dados

### Tabela: usuarios
```sql
id       BIGSERIAL PRIMARY KEY
login    VARCHAR(255) UNIQUE NOT NULL
senha    VARCHAR(255) NOT NULL
nome     VARCHAR(255)
email    VARCHAR(255) UNIQUE
```

### Tabela: cursos
```sql
id         BIGSERIAL PRIMARY KEY
nome       VARCHAR(255) UNIQUE NOT NULL
categoria  VARCHAR(255)
```

### Tabela: topicos
```sql
id             BIGSERIAL PRIMARY KEY
titulo         VARCHAR(255) NOT NULL
mensagem       TEXT NOT NULL
data_criacao   TIMESTAMP NOT NULL
status         VARCHAR(50) NOT NULL
autor_id       BIGINT REFERENCES usuarios(id)
curso_id       BIGINT REFERENCES cursos(id)
```

**Relacionamentos:**
- Um usuário tem muitos tópicos (1:N)
- Um curso tem muitos tópicos (1:N)

---

## 🐛 Solução de Problemas

### Erro: "Unable to connect to database"
✅ Verificar PostgreSQL rodando  
✅ Database `forumhub` existe  
✅ Senha correta em `application.properties`

### Erro: "401 Unauthorized"
✅ Verificar se token está no header `Authorization`  
✅ Token deve ter prefixo `Bearer `  
✅ Token pode ter expirado (validade: 1 hora)

### Erro: "403 Forbidden"
✅ Verificar se usuário é o autor do tópico (UPDATE/DELETE)  
✅ Endpoint requer autenticação?

### Erro: "Já existe um tópico com este título e mensagem"
✅ Regra de negócio: não permite duplicatas  
✅ Mude o título ou mensagem

---

## 🎯 Checklist do Challenge

- ✅ CRUD completo de tópicos
- ✅ Validações de negócio
- ✅ Autenticação JWT
- ✅ Autorização (apenas autor pode modificar)
- ✅ Banco de dados relacional (PostgreSQL)
- ✅ REST API seguindo padrões
- ✅ Tratamento de erros
- ✅ README bem documentado
- ✅ Código organizado (camadas)

---

## 🚀 Melhorias Futuras (Opcional)

- [ ] Paginação de resultados
- [ ] Filtros de busca (por curso, status, autor)
- [ ] Respostas aos tópicos
- [ ] Sistema de likes/votos
- [ ] Documentação Swagger/OpenAPI
- [ ] Testes unitários

---

## 📄 Licença
MIT - Projeto educacional - Oracle Next Education (ONE) - Alura

---

**Desenvolvido para o Challenge ForumHub**  
