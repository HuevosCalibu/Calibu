# Calibú ERP v4.5

Sistema de gestión interna para **Huevos Calibú** — avícola familiar de libre pastoreo, Valdivia, Chile.

## Módulos

- 🥚 **Producción diaria** — registro de recolección por lote
- 🐔 **Lotes y Galpones** — plantel activo, curvas de postura, mortalidades, historial
- 💰 **Ventas** — venta directa, mayoristas y suscripciones
- 🔁 **Suscripciones** — planes activos y calendario de entregas
- 👥 **RRHH** — empleados, liquidaciones, horas extra, vacaciones, anticipos, finiquitos
- 📋 **Registro de asistencia** — marcajes entrada/salida para Inspección del Trabajo
- ✅ **Checklist operativo** — cumplimiento diario por empleado (admin + portal trabajadora)
- 🏪 **Compras y stock** — insumos y gastos
- 📊 **Finanzas y costos** — márgenes y flujo
- 📦 **Guías de despacho**
- 🖥️ **Kiosk** — pantalla de marcaje autónomo (kiosk.html)

## Stack

- **Frontend:** HTML + CSS + JavaScript ES Modules (sin frameworks, sin build step)
- **Backend / DB:** [Supabase](https://supabase.com) (PostgreSQL + Auth + RLS)
- **Hosting:** [Netlify](https://netlify.com)

## Deploy

1. Conecta este repositorio en Netlify (o arrastra la carpeta al panel)
2. No se necesita build command — es HTML estático puro
3. El `netlify.toml` ya tiene la configuración de caché y redirects

## Configuración Supabase

Edita `src/lib/supabase.js` con tu URL y anon key de Supabase.

Los scripts SQL están en la carpeta `sql/` — ejecutar en orden:
1. `01-schema.sql` — tablas y triggers
2. `02-rls-policies.sql` — políticas de seguridad
3. `03-seeds.sql` — datos base (planes, etc.)
4. `08-karen-monsalve.sql` — agregar empleada (completar RUT y datos reales)

## Licencia

Uso interno Calibú — todos los derechos reservados.
