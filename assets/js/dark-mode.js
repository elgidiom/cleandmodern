const root = document.documentElement;
const toggle = document.getElementById('dark-mode-toggle');

// Ver si el usuario ya había guardado su preferencia
let savedTheme = localStorage.getItem('theme');

if (savedTheme) {
  // Si está guardado en localStorage:
  root.classList.toggle('dark', savedTheme === 'dark');
} else {
  // Si no hay preferencia guardada, usamos la del sistema
  if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
    root.classList.add('dark');
  }
}

// Función que actualiza el ícono
function updateIcon() {
  const isDark = root.classList.contains('dark');
  toggle.innerHTML = isDark
    ? '<i data-feather="moon"></i>'
    : '<i data-feather="sun"></i>';
  feather.replace();
}

updateIcon();

// Al hacer click, alternar clase y guardar preferencia
toggle.addEventListener('click', () => {
  root.classList.toggle('dark');
  updateIcon();

  const newTheme = root.classList.contains('dark') ? 'dark' : 'light';
  localStorage.setItem('theme', newTheme);
});
