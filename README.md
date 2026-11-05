# Script pós-instalação (v2026)

Este repositório contém um script para automatizar tarefas comuns logo após a instalação do Arch Linux.

## O que o script faz?

1. Edita o arquivo de configuração do `pacman`
2. Atualiza o sistema
3. Ativa amplificação nativa de áudio (GNOME)
4. Instala plugins, codecs e VLC
5. Instala drivers Intel
6. Instala drivers NVIDIA
7. Instala AUR (`yay`)
8. Instala Flatpak
9. Instala fontes essenciais
10. Otimiza a bateria (TLP)
11. Atualiza o firmware
12. Define o Bash como shell padrão
13. Instala o Fish e define como shell padrão
14. Instala o oh-my-posh
15. Instalar Cloudflare WARP
16. Instalar Zed Editor
17. Instalar Zapfast(Whatsapp Client feito em Rust)
18. Instalar Spotifast(Spotify Client feito em Rust)

## Como usar

```bash
chmod +x arch-post-install.sh
./arch-post-install.sh
```

## Observações

- O script requer privilégios administrativos para algumas etapas.
- Revise o conteúdo antes de executar e ajuste conforme seu hardware (ex.: drivers).
