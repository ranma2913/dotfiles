#!/usr/bin/env sh
set -e;

_repo_root=$(git rev-parse --show-toplevel);
cd "$_repo_root";

# Rsync Files or Directories
rsync_file_to_repo() {
  _src_path=$(readlink -f "$1")
  _dest_path="$_repo_root/$(echo "$1" | sed "s|$HOME/||g")"
  _dest_dir=$(dirname "$_dest_path")
  mkdir -pv "$_dest_dir";
  rsync --one-file-system -avzP --itemize-changes "$_src_path" "$_dest_path";
}

rsync_file_to_repo "$HOME/.oh-my-zsh/custom/themes"
rsync_file_to_repo "$HOME/.zshenv"
rsync_file_to_repo "$HOME/.zshrc"

dust --invert-filter=.git --invert-filter=.idea;
