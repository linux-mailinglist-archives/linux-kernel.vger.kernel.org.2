Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520B83C5303
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbhGLHv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:51:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:47480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239159AbhGLHRT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:17:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209751816"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209751816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 00:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="464160945"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2021 00:14:04 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/3] perf tools: Enable on a list of CPUs for hybrid
Date:   Mon, 12 Jul 2021 15:12:35 +0800
Message-Id: <20210712071235.28533-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712071235.28533-1-yao.jin@linux.intel.com>
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-record and perf-stat have supported the option '-C/--cpus'
to count or collect only on the list of CPUs provided. This option
needs to be supported for hybrid as well.

For hybrid support, it needs to check that the CPUs are available on
hybrid PMU. One example for AlderLake, cpu0-7 is 'cpu_core', cpu8-11
is 'cpu_atom'.

Before:

  # perf stat -e cpu_core/cycles/ -C11 -- sleep 1

   Performance counter stats for 'CPU(s) 11':

     <not supported>      cpu_core/cycles/

         1.006179431 seconds time elapsed

The perf-stat silently returned "<not supported>" without any helpful
information. It should error out that cpu11 was not 'cpu_core'.

After:

  # perf stat -e cpu_core/cycles/ -C11 -- sleep 1
  WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)
  failed to use cpu list 11

We also need to support the events without pmu prefix specified.

  # perf stat -e cycles -C11 -- sleep 1
  WARNING: 11 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-7)

   Performance counter stats for 'CPU(s) 11':

           1,067,373      cpu_atom/cycles/

         1.005544738 seconds time elapsed

The perf tool creates two cycles events automatically, cpu_core/cycles/ and
cpu_atom/cycles/. It checks that cpu11 is not 'cpu_core', then shows a warning
for cpu_core/cycles/ and only count the cpu_atom/cycles/.

If part of cpus are 'cpu_core' and part of cpus are 'cpu_atom', the example,

  # perf stat -e cycles -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           1,914,704      cpu_core/cycles/
           2,036,983      cpu_atom/cycles/

         1.005815641 seconds time elapsed

It now automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
cpu_atom/cycles/, and output with some warnings.

Some more complex examples,

  # perf stat -e cycles,instructions -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
  WARNING: use 0 in 'cpu_core' for 'instructions', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'instructions', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           2,780,387      cpu_core/cycles/
           1,583,432      cpu_atom/cycles/
           3,957,277      cpu_core/instructions/
           1,167,089      cpu_atom/instructions/

         1.006005124 seconds time elapsed

  # perf stat -e cycles,cpu_atom/instructions/ -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cpu_atom/instructions/', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           3,290,301      cpu_core/cycles/
           1,953,073      cpu_atom/cycles/
           1,407,869      cpu_atom/instructions/

         1.006260912 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Rebase to perf/core.
 - No functional change.

v2:
 - Automatically map to hybrid pmu.

 tools/perf/builtin-record.c     |  7 ++++
 tools/perf/builtin-stat.c       |  6 +++
 tools/perf/util/evlist-hybrid.c | 65 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h |  1 +
 tools/perf/util/evlist.c        |  1 +
 tools/perf/util/pmu.c           | 35 ++++++++++++++++++
 tools/perf/util/pmu.h           |  4 ++
 7 files changed, 119 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 671a21c9ee4d..9518b028b850 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2884,6 +2884,13 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
+	if (evlist__use_cpu_list(rec->evlist, rec->opts.target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n",
+		       rec->opts.target.cpu_list);
+		goto out;
+	}
+
+	rec->opts.target.hybrid = perf_pmu__has_hybrid();
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d25cb8088e8c..f7067587008f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2430,6 +2430,12 @@ int cmd_stat(int argc, const char **argv)
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
 		target.per_thread = true;
 
+	if (evlist__use_cpu_list(evsel_list, target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n", target.cpu_list);
+		goto out;
+	}
+
+	target.hybrid = perf_pmu__has_hybrid();
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index db3f5fbdebe1..13c9f3063dda 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -86,3 +86,68 @@ bool evlist__has_hybrid(struct evlist *evlist)
 
 	return false;
 }
+
+int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *evsel, *tmp;
+	struct perf_pmu *pmu;
+	int ret, unmatched_count = 0, events_nr = 0;
+
+	if (!perf_pmu__has_hybrid() || !cpu_list)
+		return 0;
+
+	cpus = perf_cpu_map__new(cpu_list);
+	if (!cpus)
+		return -1;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
+		char buf1[128], buf2[128];
+
+		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
+		if (!pmu)
+			continue;
+
+		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
+					   &unmatched_cpus);
+		if (ret)
+			goto out;
+
+		events_nr++;
+
+		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
+		    matched_cpus->nr < cpus->nr ||
+		    matched_cpus->nr < pmu->cpus->nr)) {
+			perf_cpu_map__put(evsel->core.cpus);
+			perf_cpu_map__put(evsel->core.own_cpus);
+			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
+			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
+
+			if (unmatched_cpus->nr > 0) {
+				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
+				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
+					   buf1, pmu->name, evsel->name);
+			}
+		}
+
+		if (matched_cpus->nr == 0) {
+			evlist__remove(evlist, evsel);
+			evsel__delete(evsel);
+
+			cpu_map__snprint(cpus, buf1, sizeof(buf1));
+			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
+			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
+				   buf1, pmu->name, pmu->name, buf2);
+			unmatched_count++;
+		}
+
+		perf_cpu_map__put(matched_cpus);
+		perf_cpu_map__put(unmatched_cpus);
+	}
+
+	ret = (unmatched_count == events_nr) ? -1 : 0;
+out:
+	perf_cpu_map__put(cpus);
+	return ret;
+}
diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
index 19f74b4c340a..f33a4e8443a1 100644
--- a/tools/perf/util/evlist-hybrid.h
+++ b/tools/perf/util/evlist-hybrid.h
@@ -10,5 +10,6 @@
 int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
 void evlist__warn_hybrid_group(struct evlist *evlist);
 bool evlist__has_hybrid(struct evlist *evlist);
+int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list);
 
 #endif /* __PERF_EVLIST_HYBRID_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 06f8890816c3..5f92319ce258 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -27,6 +27,7 @@
 #include "util/perf_api_probe.h"
 #include "util/evsel_fprintf.h"
 #include "util/evlist-hybrid.h"
+#include "util/pmu.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44b90d638ad5..229cb975c5d7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1906,3 +1906,38 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 
 	return 0;
 }
+
+int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			 struct perf_cpu_map **mcpus_ptr,
+			 struct perf_cpu_map **ucpus_ptr)
+{
+	struct perf_cpu_map *pmu_cpus = pmu->cpus;
+	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
+	int matched_nr = 0, unmatched_nr = 0;
+
+	matched_cpus = perf_cpu_map__default_new();
+	if (!matched_cpus)
+		return -1;
+
+	unmatched_cpus = perf_cpu_map__default_new();
+	if (!unmatched_cpus) {
+		perf_cpu_map__put(matched_cpus);
+		return -1;
+	}
+
+	for (int i = 0; i < cpus->nr; i++) {
+		int cpu;
+
+		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
+		if (cpu == -1)
+			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
+		else
+			matched_cpus->map[matched_nr++] = cpus->map[i];
+	}
+
+	unmatched_cpus->nr = unmatched_nr;
+	matched_cpus->nr = matched_nr;
+	*mcpus_ptr = matched_cpus;
+	*ucpus_ptr = unmatched_cpus;
+	return 0;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 926da483a141..e05ee1906f65 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -11,6 +11,7 @@
 #include "pmu-events/pmu-events.h"
 
 struct evsel_config_term;
+struct perf_cpu_map;
 
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
@@ -135,4 +136,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
+int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			 struct perf_cpu_map **mcpus_ptr,
+			 struct perf_cpu_map **ucpus_ptr);
 #endif /* __PMU_H */
-- 
2.17.1

