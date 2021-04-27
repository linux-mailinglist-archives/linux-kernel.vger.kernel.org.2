Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1DC36BFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhD0HEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236142AbhD0HEf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:35 -0400
IronPort-SDR: aR+Wi0J9rdmVP3UqAs00orLhSobJ4Hme2SsgADvX4/5CwBAT/GVp4kmMLmunCN/900haxS/jW9
 D+tH3JH+VmKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573026"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573026"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:52 -0700
IronPort-SDR: C8htJxx22F+C4qxzANN3tRlbUMeSu96Z/YSZRncUT4ZSLfQ3Kr6M8IN8CEzFtZT0P/VumxqX7p
 N30ucoVgFyGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506928"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:49 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 16/26] perf stat: Warn group events from different hybrid PMU
Date:   Tue, 27 Apr 2021 15:01:29 +0800
Message-Id: <20210427070139.25256-17-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a group has events which are from different hybrid PMUs,
shows a warning:

"WARNING: events in group from different hybrid PMUs!"

This is to remind the user not to put the core event and atom
event into one group.

Next, just disable grouping.

  # perf stat -e "{cpu_core/cycles/,cpu_atom/cycles/}" -a -- sleep 1
  WARNING: events in group from different hybrid PMUs!
  WARNING: grouped events cpus do not match, disabling group:
    anon group { cpu_core/cycles/, cpu_atom/cycles/ }

   Performance counter stats for 'system wide':

           5,438,125      cpu_core/cycles/
           3,914,586      cpu_atom/cycles/

         1.004250966 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4 - v6:
 - No change.

 tools/perf/builtin-stat.c          |  4 +++
 tools/perf/util/evlist-hybrid.c    | 47 ++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h    |  2 ++
 tools/perf/util/evsel.c            |  6 ++++
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/python-ext-sources |  2 ++
 6 files changed, 62 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 42e60764ad8d..5a830ae09418 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -48,6 +48,7 @@
 #include "util/pmu.h"
 #include "util/event.h"
 #include "util/evlist.h"
+#include "util/evlist-hybrid.h"
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/color.h"
@@ -243,6 +244,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
 	struct evsel *evsel, *pos, *leader;
 	char buf[1024];
 
+	if (evlist__has_hybrid(evlist))
+		evlist__warn_hybrid_group(evlist);
+
 	evlist__for_each_entry(evlist, evsel) {
 		leader = evsel->leader;
 
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index e11998526f2e..db3f5fbdebe1 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -7,6 +7,7 @@
 #include "../perf.h"
 #include "util/pmu-hybrid.h"
 #include "util/evlist-hybrid.h"
+#include "debug.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <linux/err.h>
@@ -39,3 +40,49 @@ int evlist__add_default_hybrid(struct evlist *evlist, bool precise)
 
 	return 0;
 }
+
+static bool group_hybrid_conflict(struct evsel *leader)
+{
+	struct evsel *pos, *prev = NULL;
+
+	for_each_group_evsel(pos, leader) {
+		if (!evsel__is_hybrid(pos))
+			continue;
+
+		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
+			return true;
+
+		prev = pos;
+	}
+
+	return false;
+}
+
+void evlist__warn_hybrid_group(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_group_leader(evsel) &&
+		    evsel->core.nr_members > 1 &&
+		    group_hybrid_conflict(evsel)) {
+			pr_warning("WARNING: events in group from "
+				   "different hybrid PMUs!\n");
+			return;
+		}
+	}
+}
+
+bool evlist__has_hybrid(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->pmu_name &&
+		    perf_pmu__is_hybrid(evsel->pmu_name)) {
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index e25861649d8f..19f74b4c340a 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -8,5 +8,7 @@
 #include <unistd.h>
 
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
+void evlist__warn_hybrid_group(struct evlist *evlist);
+bool evlist__has_hybrid(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0fc9555a2ac4..4a3cd1b5bb33 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -47,6 +47,7 @@
 #include "memswap.h"
 #include "util.h"
 #include "hashmap.h"
+#include "pmu-hybrid.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
@@ -2819,3 +2820,8 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 		hashmap__clear(evsel->per_pkg_mask);
 	}
 }
+
+bool evsel__is_hybrid(struct evsel *evsel)
+{
+	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a9cc9563ac59..75cf5dbfe208 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -462,4 +462,5 @@ struct perf_env *evsel__env(struct evsel *evsel);
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
 void evsel__zero_per_pkg(struct evsel *evsel);
+bool evsel__is_hybrid(struct evsel *evsel);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 845dd46e3c61..d7c976671e3a 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -37,3 +37,5 @@ util/units.c
 util/affinity.c
 util/rwsem.c
 util/hashmap.c
+util/pmu-hybrid.c
+util/fncache.c
-- 
2.17.1

