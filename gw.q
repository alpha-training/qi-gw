/ Gateway process for querying rdb(s) / hdb(s)
/ .conf.GW_MODE can be
/ 1) `seamless (free form queries)
/ 2) `sync (query and wait for result)
/ 3) `async (requires a gwresponse callback to be defined on the caller)

\d .gw

if[not .qi.isproc;'"A gateway must be started as a process e.g. gw1"];
if[not(MODE:.qi.tosym .conf.GW_MODE)in`seamless`sync`asyc;'"Unrecognized .conf.GW_MODE"];

.qi.frompkg[`gw;MODE]

init:{
  if[not count DB::$[count db:.proc.self.options`point_to;(),`$db;exec name from .proc.self.mystack where pkg in`hdb`rdb];
    '"A gateway must be part of a stack with at least one rdb/hdb"];
  }

dconns:{$[count n:where null c:DB!.ipc.conn each DB;'"Could not connect to ",","sv string n;c]}