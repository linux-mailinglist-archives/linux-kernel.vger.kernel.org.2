Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791663AACE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:03:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:13853 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQHDy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:03:54 -0400
IronPort-SDR: TOAY1J5n09qSIwfDEZT3G2AvIeVCfkAjZlg95jIcIRVUwQfCKjzDkcO8HozBlgy/Sc+9phq/qJ
 0eHyYkvj70lA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="193626443"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193626443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:01:27 -0700
IronPort-SDR: ZcgPJKy4oUKavEkfM6it3kc2olRV4FPnFbI60Ni3LMwX6rpzyVtvsiCVyPX/mQ/LhMdGvjXJvr
 cG/jChFVPdCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="555118030"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2021 00:01:24 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf tools: Enable on a list of CPUs for hybrid
Date:   Thu, 17 Jun 2021 15:00:26 +0800
Message-Id: <20210617070026.14475-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-record and perf-stat have supported the option '-C/--cpus'
to count or collect only on the list of CPUs provided. This option
needs to be supported for hybrid as well.

For hybrid support, it needs to check that the CPUs are available on
hybrid PMU. On AlderLake, for example, 'cpu_core' has CPU0-CPU15,
and 'cpu_atom' has CPU16-CPU23.

Before:

  # perf stat -e cpu_core/cycles/ -C16 true

   Performance counter stats for 'CPU(s) 16':

     <not supported>      cpu_core/cycles/

The perf-stat silently returned "<not supported>" without any helpful
information. It should error out that CPU16 was not available on
'cpu_core'.

After:

  # perf stat -e cpu_core/cycles/ -C16 true
  'cpu_core' doesn't have cpu 16
  failed to use cpu list 16

It also supports to count only on a given CPU.

  # perf stat -e cpu_core/cycles/ -C15 -vv true

  ------------------------------------------------------------
  perf_event_attr:
    size                             128
    config                           0x400000000
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 3
  cycles: 0: 103287 569776 569776
  cycles: 103287 569776 569776

   Performance counter stats for 'CPU(s) 15':

             103,287      cpu_core/cycles/

         0.000566813 seconds time elapsed

Collect the counts of 'cycles' on CPU15 (CPU15 is in 'cpu_core').

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-record.c     |  6 +++++
 tools/perf/builtin-stat.c       |  5 ++++
 tools/perf/util/evlist-hybrid.c | 43 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h |  1 +
 tools/perf/util/evlist.c        |  1 +
 tools/perf/util/pmu.c           | 23 ++++++++++++++++++
 tools/perf/util/pmu.h           |  3 +++
 7 files changed, 82 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bc3dd379eb67..bd39d4260549 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2877,6 +2877,12 @@ int cmd_record(int argc, const char **argv)
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
+	if (evlist__use_cpu_list(rec->evlist, rec->opts.target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n",
+		       rec->opts.target.cpu_list);
+		goto out;
+	}
+
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f9f74a514315..9c27c90d069f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2427,6 +2427,11 @@ int cmd_stat(int argc, const char **argv)
 	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
 		target.per_thread = true;
 
+	if (evlist__use_cpu_list(evsel_list, target.cpu_list)) {
+		pr_err("failed to use cpu list %s\n", target.cpu_list);
+		goto out;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index db3f5fbdebe1..e8fdd98aed3f 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -86,3 +86,46 @@ bool evlist__has_hybrid(struct evlist *evlist)
 
 	return false;
 }
+
+int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *evsel;
+	struct perf_pmu *pmu;
+	int ret;
+
+	if (!perf_pmu__has_hybrid() || !cpu_list)
+		return 0;
+
+	cpus = perf_cpu_map__new(cpu_list);
+	if (!cpus)
+		return -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		bool exact_match;
+
+		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
+		if (!pmu)
+			continue;
+
+		if (!perf_pmu__cpus_matched(pmu, cpus, &exact_match)) {
+			ret = -1;
+			goto out;
+		}
+
+		if (!exact_match) {
+			/*
+			 * Use the cpus in cpu_list.
+			 */
+			perf_cpu_map__put(evsel->core.cpus);
+			perf_cpu_map__put(evsel->core.own_cpus);
+			evsel->core.cpus = perf_cpu_map__get(cpus);
+			evsel->core.own_cpus = perf_cpu_map__get(cpus);
+		}
+	}
+
+	ret = 0;
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
index 6ba9664089bd..e8a0f95f7f47 100644
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
index 88c8ecdc60b0..0e3a19a6736d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1872,3 +1872,26 @@ bool perf_pmu__has_hybrid(void)
 
 	return !list_empty(&perf_pmu__hybrid_pmus);
 }
+
+bool perf_pmu__cpus_matched(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			    bool *exact_match)
+{
+	struct perf_cpu_map *pmu_cpus = pmu->cpus;
+	int cpu;
+
+	*exact_match = false;
+
+	for (int i = 0; i < cpus->nr; i++) {
+		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
+		if (cpu == -1) {
+			pr_err("'%s' doesn't have cpu %d\n",
+			       pmu->name, cpus->map[i]);
+			return false;
+		}
+	}
+
+	if (cpus->nr == pmu_cpus->nr)
+		*exact_match = true;
+
+	return true;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a790ef758171..1cca48e02b5d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -11,6 +11,7 @@
 #include "pmu-events/pmu-events.h"
 
 struct evsel_config_term;
+struct perf_cpu_map;
 
 enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
@@ -133,5 +134,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   char *name);
 
 bool perf_pmu__has_hybrid(void);
+bool perf_pmu__cpus_matched(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
+			    bool *exact_match);
 
 #endif /* __PMU_H */
-- 
2.17.1

