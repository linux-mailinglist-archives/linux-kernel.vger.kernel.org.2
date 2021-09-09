Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB94056A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355491AbhIINVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:21:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:22224 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354887AbhIINBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:01:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306348702"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="306348702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 05:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="479645356"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2021 05:54:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Fix hybrid config terms list corruption
Date:   Thu,  9 Sep 2021 15:55:08 +0300
Message-Id: <20210909125508.28693-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909125508.28693-1-adrian.hunter@intel.com>
References: <20210909125508.28693-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A config terms list was spliced twice, resulting in a never-ending loop
when the list was traversed. Fix by using list_splice_init() and copying
and freeing the lists as necessary.

This patch also depends on patch "perf tools: Factor out
copy_config_terms() and free_config_terms()"

Example on ADL:

 Before:

 # perf record -e '{intel_pt//,cycles/aux-sample-size=4096/pp}' uname &
 # jobs
 [1]+  Running                    perf record -e "{intel_pt//,cycles/aux-sample-size=4096/pp}" uname
 # perf top -E 10
   PerfTop:    4071 irqs/sec  kernel: 6.9%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles],  (all, 24 CPUs)
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    97.60%  perf           [.] __evsel__get_config_term
     0.25%  [kernel]       [k] kallsyms_expand_symbol.constprop.13
     0.24%  perf           [.] kallsyms__parse
     0.15%  [kernel]       [k] _raw_spin_lock
     0.14%  [kernel]       [k] number
     0.13%  [kernel]       [k] advance_transaction
     0.08%  [kernel]       [k] format_decode
     0.08%  perf           [.] map__process_kallsym_symbol
     0.08%  perf           [.] rb_insert_color
     0.08%  [kernel]       [k] vsnprintf
 exiting.
 # kill %1

After:

 # perf record -e '{intel_pt//,cycles/aux-sample-size=4096/pp}' uname &
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.060 MB perf.data ]
 # perf script | head
       perf-exec   604 [001]  1827.312293:                            psb:  psb offs: 0                       ffffffffb8415e87 pt_config_start+0x37 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a3bd event_sched_in.isra.133+0xfd ([kernel.kallsyms]) => ffffffffb856a9a0 perf_pmu_nop_void+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb856b10e merge_sched_in+0x26e ([kernel.kallsyms]) => ffffffffb856a2c0 event_sched_in.isra.133+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a45d event_sched_in.isra.133+0x19d ([kernel.kallsyms]) => ffffffffb8568b80 perf_event_set_state.part.61+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb8568b86 perf_event_set_state.part.61+0x6 ([kernel.kallsyms]) => ffffffffb85662a0 perf_event_update_time+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a35c event_sched_in.isra.133+0x9c ([kernel.kallsyms]) => ffffffffb8567610 perf_log_itrace_start+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb856a377 event_sched_in.isra.133+0xb7 ([kernel.kallsyms]) => ffffffffb8403b40 x86_pmu_add+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb8403b86 x86_pmu_add+0x46 ([kernel.kallsyms]) => ffffffffb8403940 collect_events+0x0 ([kernel.kallsyms])
       perf-exec   604  1827.312293:          1                       branches:  ffffffffb8403a7b collect_events+0x13b ([kernel.kallsyms]) => ffffffffb8402cd0 collect_event+0x0 ([kernel.kallsyms])

Fixes: 94da591b1c7913 ("perf parse-events: Create two hybrid raw events")
Fixes: 9cbfa2f64c04d9 ("perf parse-events: Create two hybrid hardware events")
Fixes: 30def61f64bac5 ("perf parse-events: Create two hybrid cache events")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events-hybrid.c | 18 +++++++++++++++---
 tools/perf/util/parse-events.c        | 18 ++++++++++++------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 10160ab126f9..b234d95fb10a 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -76,12 +76,16 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 	int ret;
 
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		LIST_HEAD(terms);
+
 		if (pmu_cmp(parse_state, pmu))
 			continue;
 
+		copy_config_terms(&terms, config_terms);
 		ret = create_event_hybrid(PERF_TYPE_HARDWARE,
 					  &parse_state->idx, list, attr, name,
-					  config_terms, pmu);
+					  &terms, pmu);
+		free_config_terms(&terms);
 		if (ret)
 			return ret;
 	}
@@ -115,11 +119,15 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 	int ret;
 
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		LIST_HEAD(terms);
+
 		if (pmu_cmp(parse_state, pmu))
 			continue;
 
+		copy_config_terms(&terms, config_terms);
 		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
-					      name, config_terms, pmu);
+					      name, &terms, pmu);
+		free_config_terms(&terms);
 		if (ret)
 			return ret;
 	}
@@ -165,11 +173,15 @@ int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 
 	*hybrid = true;
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		LIST_HEAD(terms);
+
 		if (pmu_cmp(parse_state, pmu))
 			continue;
 
+		copy_config_terms(&terms, config_terms);
 		ret = create_event_hybrid(PERF_TYPE_HW_CACHE, idx, list,
-					  attr, name, config_terms, pmu);
+					  attr, name, &terms, pmu);
+		free_config_terms(&terms);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ded5808798f9..51a2219df601 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -387,7 +387,7 @@ __add_event(struct list_head *list, int *idx,
 		evsel->name = strdup(name);
 
 	if (config_terms)
-		list_splice(config_terms, &evsel->config_terms);
+		list_splice_init(config_terms, &evsel->config_terms);
 
 	if (list)
 		list_add_tail(&evsel->core.node, list);
@@ -535,9 +535,12 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 					     config_name ? : name, &config_terms,
 					     &hybrid, parse_state);
 	if (hybrid)
-		return ret;
+		goto out_free_terms;
 
-	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
+	ret = add_event(list, idx, &attr, config_name ? : name, &config_terms);
+out_free_terms:
+	free_config_terms(&config_terms);
+	return ret;
 }
 
 static void tracepoint_error(struct parse_events_error *e, int err,
@@ -1457,10 +1460,13 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 					       get_config_name(head_config),
 					       &config_terms, &hybrid);
 	if (hybrid)
-		return ret;
+		goto out_free_terms;
 
-	return add_event(list, &parse_state->idx, &attr,
-			 get_config_name(head_config), &config_terms);
+	ret = add_event(list, &parse_state->idx, &attr,
+			get_config_name(head_config), &config_terms);
+out_free_terms:
+	free_config_terms(&config_terms);
+	return ret;
 }
 
 int parse_events_add_tool(struct parse_events_state *parse_state,
-- 
2.17.1

