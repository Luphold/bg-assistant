-- =============================================================================
-- YATZY SETUP (Board Game Assistant)
-- =============================================================================
-- Run this in your Supabase SQL Editor. Idempotent — safe to re-run.

CREATE TABLE IF NOT EXISTS yatzy_history (
  id          BIGSERIAL PRIMARY KEY,
  played_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  state       JSONB NOT NULL DEFAULT '{}',
  players     JSONB,
  winner      TEXT,
  is_draw     BOOLEAN NOT NULL DEFAULT FALSE,
  max_total   INT,
  min_total   INT
);

CREATE INDEX IF NOT EXISTS yatzy_history_played_at ON yatzy_history(played_at DESC);

ALTER TABLE yatzy_history ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "yatzy_history_select" ON yatzy_history;
DROP POLICY IF EXISTS "yatzy_history_insert" ON yatzy_history;
DROP POLICY IF EXISTS "yatzy_history_update" ON yatzy_history;
DROP POLICY IF EXISTS "yatzy_history_delete" ON yatzy_history;

CREATE POLICY "yatzy_history_select" ON yatzy_history FOR SELECT USING (true);
CREATE POLICY "yatzy_history_insert" ON yatzy_history FOR INSERT WITH CHECK (true);
CREATE POLICY "yatzy_history_update" ON yatzy_history FOR UPDATE USING (true);
CREATE POLICY "yatzy_history_delete" ON yatzy_history FOR DELETE USING (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON yatzy_history TO anon, authenticated, service_role;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;

NOTIFY pgrst, 'reload schema';
