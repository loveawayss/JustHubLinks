# Just Releases

Catálogo central de distribuição e metadados de atualização dos projetos Just.

## Estrutura do Repositório

- **`catalog.json`**: Índice oficial de produtos e canais de distribuição disponíveis.
- **`products/`**: Manifestos individuais por produto contendo versões, canais, URLs dos assets e hashes SHA-256:
  - `products/justhub.json`: Metadados do Just HUB.
  - `products/justcleaner.json`: Metadados do Just Cleaner.
  - `products/justprivate.json`: Metadados do JustPrivate.
  - `products/justprivate-update-manifest.json`: Manifesto assinado criptograficamente (`.sig`).
- **`update_info.json`**: Endpoint de verificação e download da versão estável mais recente do Just HUB.
- **`install.ps1`**: Script PowerShell para instalação e atualização automatizada via linha de comando.

## Hospedagem de Binários

Todos os executáveis e instaladores são hospedados exclusivamente na seção de [GitHub Releases](https://github.com/loveawayss/JustReleases/releases), mantendo o versionamento Git focado unicamente em texto e metadados.

## Verificação de Integridade

Cada artefato publicado possui seu hash SHA-256 declarado nos manifestos para validação pré-execução:

```powershell
(Get-FileHash -Path "arquivo.exe" -Algorithm SHA256).Hash.ToLowerInvariant()
```

## Validação Contínua (CI)

Todas as alterações em manifestos são auditadas via GitHub Actions (`.github/workflows/ci.yml`):
- Validação estrita de sintaxe e schemas JSON.
- Consistência de vínculos com as releases oficiais do GitHub.
- Verificação de formato e integridade dos hashes SHA-256.
- Validação criptográfica de assinaturas ECDSA P-256 para o JustPrivate.

