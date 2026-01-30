# Script pós-instalação (v2026)

Este repositório contém um script para automatizar tarefas comuns logo após a instalação do Arch Linux.

## O que o script faz?

1. Edita o arquivo de configuração do `pacman`
2. Atualiza o sistema
3. Ativa amplificação nativa de áudio (GNOME)
4. Instala plugins, codecs e VLC
5. Instala drivers Intel
6. Instala drivers NVIDIA
7. Instala AUR (`yay`) e Flatpak
8. Instala fontes essenciais
9. Otimiza a bateria (TLP)
10. Atualiza o firmware
11. Instala o Fish shell
12. Define o Fish como shell padrão
13. Instala o oh-my-posh

## Como usar

```bash
chmod +x arch-post-install.sh
./arch-post-install.sh
```

## Observações

- O script requer privilégios administrativos para algumas etapas.
- Revise o conteúdo antes de executar e ajuste conforme seu hardware (ex.: drivers).
