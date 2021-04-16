Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983F3621BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhDPOIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:08:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:23091 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhDPOH3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:07:29 -0400
IronPort-SDR: 0IYk5rKi7ZwPCJl+kwKyB7uSN3SueFwSg4a8RafqM2wWUFGjEMLQeqfrC7pLgwE4dwvV0hrM/R
 c++5CsuxnJ+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854348"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:04 -0700
IronPort-SDR: q2/IZM4JinhIc5I+CidRHaRW3ZROQb/Qn5AHseB2YSZsBLappXBjfgqh2+QfkuXuFMXFVZhpJ7
 Gzq3wS3mnm+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766843"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 16/25] perf stat: Warn group events from different hybrid PMU
Date:   Fri, 16 Apr 2021 22:05:08 +0800
Message-Id: <20210416140517.18206-17-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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
v4:
 - No change.

 tools/perf/builtin-stat.c          |  4 +++
 tools/perf/util/evlist-hybrid.c    | 47 ++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h    |  2 ++
 tools/perf/util/evsel.c            |  6 ++++
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/python-ext-sources |  2 ++
 6 files changed, 62 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0351b99d17a7..c429aae6eeb6 100644
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
@@ -240,6 +241,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
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
index 0ba4daa09453..0f64a32ea9c5 100644
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
@@ -2797,3 +2798,8 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 		hashmap__clear(evsel->per_pkg_mask);
 	}
 }
+
+bool evsel__is_hybrid(struct evsel *evsel)
+{
+	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ff89196281bd..f6f90f68381b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -453,4 +453,5 @@ struct perf_env *evsel__env(struct evsel *evsel);
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

