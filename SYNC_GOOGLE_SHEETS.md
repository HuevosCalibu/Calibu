# Sincronizar Google Sheets ↔ Calibú ERP

## Opción A (recomendada): ERP como única fuente de verdad
A partir de ahora cargas ventas/compras/producción **directo en la app Calibú**.
El Excel/Sheets queda como histórico. Esto es lo más limpio.

## Opción B: Google Sheets → Supabase (sync 1 vía)
Si quieres seguir usando tu Sheet:

### 1. Apps Script en el Sheet
En tu Google Sheet → Extensiones → Apps Script → pegar:

```js
const SUPABASE_URL = 'https://ierotxehalveoeylcxvn.supabase.co';
const SUPABASE_ANON = 'TU_ANON_KEY';

function syncVentas() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Ventas Detalle');
  const data = sheet.getDataRange().getValues();
  const headers = data[0];
  const rows = data.slice(1).map(r => {
    const obj = {};
    headers.forEach((h, i) => obj[h] = r[i]);
    return {
      fecha: obj.Fecha,
      total: Number(obj.Total) || 0,
      canal: obj.Canal,
      // ... mapear los campos
    };
  }).filter(r => r.fecha);

  UrlFetchApp.fetch(SUPABASE_URL + '/rest/v1/ventas?on_conflict=fecha,cliente_id', {
    method: 'POST',
    headers: {
      'apikey': SUPABASE_ANON,
      'Authorization': 'Bearer ' + SUPABASE_ANON,
      'Content-Type': 'application/json',
      'Prefer': 'resolution=merge-duplicates'
    },
    payload: JSON.stringify(rows)
  });
}

// Trigger: ejecutar cada hora
function setupTrigger() {
  ScriptApp.newTrigger('syncVentas').timeBased().everyHours(1).create();
}
```

### 2. Limitaciones
- Solo sincroniza datos del Sheet → Supabase, no al revés
- Si editas un registro en la app, el Sheet lo pisa
- Recomendable solo para fase de transición

## Opción C: Supabase → Sheets (espejo, recomendado para contadora)
ERP es la fuente, Sheet es solo vista. Se hace con Apps Script tirando GET de Supabase REST API cada hora.
