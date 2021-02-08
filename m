Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB4313D29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhBHSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:21:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:62811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234110AbhBHPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:28 -0500
IronPort-SDR: lusZoTzLGUpwNl7WCen3xubBP4HwRI/hx6Nn9Xx0BHMhxfWM67gz/smw1S9SxzZoakiDx1Raql
 ZjVUSyVVStsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952047"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:36 -0800
IronPort-SDR: dKTQbW3z7KCkq4eFoLyPIDxa1rlsaA58H67iVLWdu8qR3fb9OwVReWgAMpPhFhA1TSMPR1bft0
 CxV1OE5lk8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820880"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 31/49] perf stat: Hybrid evsel uses its own cpus
Date:   Mon,  8 Feb 2021 07:25:28 -0800
Message-Id: <1612797946-18784-32-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

On hybrid platform, atom events can be only enabled on atom CPUs. Core
events can be only enabled on core CPUs. So for a hybrid event, it can
be only enabled on it's own CPUs.

But what the problem for current perf is, the cpus for evsel
(via PMU sysfs) have been merged to evsel_list->core.all_cpus.
It might be all CPUs.

So we need to figure out one way to let the hybrid event only use it's
own CPUs.

The idea is to create a new evlist__invalidate_all_cpus to invalidate
the evsel_list->core.all_cpus then evlist__for_each_cpu returns cpu -1
for hybrid evsel. If cpu is -1, hybrid evsel will use it's own cpus.

We will see following code piece in patch.

if (cpu == -1 && !evlist->thread_mode)
        evsel__enable_cpus(pos);

It lets the event be only enabled on event's own cpus.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 37 ++++++++++++++++++++++--
 tools/perf/util/evlist.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/evlist.h  |  4 +++
 tools/perf/util/evsel.h   |  8 ++++++
 4 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bc84b31..afb8789 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -392,6 +392,18 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 	return 0;
 }
 
+static int read_counter_cpus(struct evsel *counter, struct timespec *rs)
+{
+	int cpu, nr_cpus, err = 0;
+	struct perf_cpu_map *cpus = evsel__cpus(counter);
+
+	nr_cpus = cpus ? cpus->nr : 1;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		err = read_counter_cpu(counter, rs, cpu);
+
+	return err;
+}
+
 static int read_affinity_counters(struct timespec *rs)
 {
 	struct evsel *counter;
@@ -413,8 +425,14 @@ static int read_affinity_counters(struct timespec *rs)
 			if (evsel__cpu_iter_skip(counter, cpu))
 				continue;
 			if (!counter->err) {
-				counter->err = read_counter_cpu(counter, rs,
-								counter->cpu_iter - 1);
+				if (cpu == -1 && !evsel_list->thread_mode) {
+					counter->err = read_counter_cpus(counter, rs);
+				} else if (evsel_list->thread_mode) {
+					counter->err = read_counter_cpu(counter, rs, 0);
+				} else {
+					counter->err = read_counter_cpu(counter, rs,
+									counter->cpu_iter - 1);
+				}
 			}
 		}
 	}
@@ -747,6 +765,21 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (group)
 		evlist__set_leader(evsel_list);
 
+	/*
+	 * On hybrid platform, the cpus for evsel (via PMU sysfs) have been
+	 * merged to evsel_list->core.all_cpus. We use evlist__invalidate_all_cpus
+	 * to invalidate the evsel_list->core.all_cpus then evlist__for_each_cpu
+	 * returns cpu -1 for hybrid evsel. If cpu is -1, hybrid evsel will
+	 * use it's own cpus.
+	 */
+	if (evlist__has_hybrid_events(evsel_list)) {
+		evlist__invalidate_all_cpus(evsel_list);
+		if (!target__has_cpu(&target) ||
+		    target__has_per_thread(&target)) {
+			evsel_list->thread_mode = true;
+		}
+	}
+
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05363a7..626a0e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -375,7 +375,8 @@ bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
 bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 {
 	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
-		ev->cpu_iter++;
+		if (cpu != -1)
+			ev->cpu_iter++;
 		return false;
 	}
 	return true;
@@ -404,6 +405,16 @@ static int evlist__is_enabled(struct evlist *evlist)
 	return false;
 }
 
+static void evsel__disable_cpus(struct evsel *evsel)
+{
+	int cpu, nr_cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
+
+	nr_cpus = cpus ? cpus->nr : 1;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		evsel__disable_cpu(evsel, cpu);
+}
+
 static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
@@ -430,7 +441,12 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
 					has_imm = true;
 				if (pos->immediate != imm)
 					continue;
-				evsel__disable_cpu(pos, pos->cpu_iter - 1);
+				if (cpu == -1 && !evlist->thread_mode)
+					evsel__disable_cpus(pos);
+				else if (evlist->thread_mode)
+					evsel__disable_cpu(pos, 0);
+				else
+					evsel__disable_cpu(pos, pos->cpu_iter - 1);
 			}
 		}
 		if (!has_imm)
@@ -466,6 +482,15 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 	__evlist__disable(evlist, evsel_name);
 }
 
+static void evsel__enable_cpus(struct evsel *evsel)
+{
+	int cpu, nr_cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
+
+	nr_cpus = cpus ? cpus->nr : 1;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		evsel__enable_cpu(evsel, cpu);
+}
 static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 {
 	struct evsel *pos;
@@ -485,7 +510,12 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
 				continue;
 			if (!evsel__is_group_leader(pos) || !pos->core.fd)
 				continue;
-			evsel__enable_cpu(pos, pos->cpu_iter - 1);
+                        if (cpu == -1 && !evlist->thread_mode)
+                                evsel__enable_cpus(pos);
+                        else if (evlist->thread_mode)
+                                evsel__enable_cpu(pos, 0);
+                        else
+                                evsel__enable_cpu(pos, pos->cpu_iter - 1);
 		}
 	}
 	affinity__cleanup(&affinity);
@@ -1260,6 +1290,16 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel)
 	evlist->selected = evsel;
 }
 
+static void evsel__close_cpus(struct evsel *evsel)
+{
+	int cpu, nr_cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
+
+	nr_cpus = cpus ? cpus->nr : 1;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		perf_evsel__close_cpu(&evsel->core, cpu);
+}
+
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -1284,7 +1324,13 @@ void evlist__close(struct evlist *evlist)
 		evlist__for_each_entry_reverse(evlist, evsel) {
 			if (evsel__cpu_iter_skip(evsel, cpu))
 			    continue;
-			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
+
+			if (cpu == -1 && !evlist->thread_mode)
+				evsel__close_cpus(evsel);
+			else if (evlist->thread_mode)
+				perf_evsel__close_cpu(&evsel->core, 0);
+			else
+				perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
 		}
 	}
 	affinity__cleanup(&affinity);
@@ -2010,3 +2056,21 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	}
 	return NULL;
 }
+
+bool evlist__has_hybrid_events(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_hybrid_event(evsel))
+			return true;
+	}
+
+	return false;
+}
+
+void evlist__invalidate_all_cpus(struct evlist *evlist)
+{
+	perf_cpu_map__put(evlist->core.all_cpus);
+	evlist->core.all_cpus = perf_cpu_map__empty_new(1);
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae758..9741df4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -52,6 +52,7 @@ struct evlist {
 	struct perf_evlist core;
 	int		 nr_groups;
 	bool		 enabled;
+	bool		 thread_mode;
 	int		 id_pos;
 	int		 is_pos;
 	u64		 combined_sample_type;
@@ -353,4 +354,7 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
+void evlist__invalidate_all_cpus(struct evlist *evlist);
+
+bool evlist__has_hybrid_events(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5c161a2..4eb054a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -7,9 +7,11 @@
 #include <sys/types.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <string.h>
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
+#include "pmu.h"
 #include <internal/cpumap.h>
 
 struct bpf_object;
@@ -427,4 +429,10 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 struct perf_env *evsel__env(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+
+static inline bool evsel__is_hybrid_event(struct evsel *evsel)
+{
+	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
+}
+
 #endif /* __PERF_EVSEL_H */
-- 
2.7.4

