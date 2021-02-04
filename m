Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94930CCF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBBUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:23:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:60315 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233239AbhBBUUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:20:53 -0500
IronPort-SDR: 4VF6KVSo4Q8D/Lx7f25M0m/KXEU+IX8ANJDqiuDU4LOBZvYvyF94iGNk4Tccbn8iifyrrWINoa
 /CJdoKaISLnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148821"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:14 -0800
IronPort-SDR: 6JlUofTq7kxE24a16dVsSBe1bzuMjENLLWtCLsVlOgRJnk4bTfvMGvIwPurVRaemHgJwqDbiD4
 h/toIsIlToLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442518"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:13 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 8/9] perf stat: Support L2 Topdown events
Date:   Tue,  2 Feb 2021 12:09:12 -0800
Message-Id: <1612296553-21962-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The TMA method level 2 metrics is supported from the Intel Sapphire
Rapids server, which expose four L2 Topdown metrics events to user
space. There are eight L2 events in total. The other four L2 Topdown
metrics events are calculated from the corresponding L1 and the exposed
L2 events.

Now, the --topdown prints the complete top-down metrics that supported
by the CPU. For the Intel Sapphire Rapids server, there are 4 L1 events
and 8 L2 events displyed in one line.

Add a new option, --td-level, to display the top-down statistics that
equal to or lower than the input level.

The L2 event is marked only when both its L1 parent event and itself
crosse the threshold.

Here is an example:

 $perf stat --topdown --td-level=2 --no-metric-only sleep 1
 Topdown accuracy may decrease when measuring long periods.
 Please print the result regularly, e.g. -I1000

 Performance counter stats for 'sleep 1':

        16,734,390      slots
         2,100,001      topdown-retiring          #     12.6% retiring
         2,034,376      topdown-bad-spec          #     12.3% bad
speculation
         4,003,128      topdown-fe-bound          #     24.1% frontend
bound
           328,125      topdown-heavy-ops         #      2.0% heavy
operations         #      10.6% light operations
         1,968,751      topdown-br-mispredict     #     11.9% branch
mispredict         #      0.4% machine clears
         2,953,127      topdown-fetch-lat         #     17.8% fetch
latency         #      6.3% fetch bandwidth
         5,906,255      topdown-mem-bound         #     35.6% memory
bound          #      15.4% core bound

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 14 +++++-
 tools/perf/builtin-stat.c              | 34 +++++++++++--
 tools/perf/util/stat-shadow.c          | 92 ++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.c                 |  4 ++
 tools/perf/util/stat.h                 |  9 ++++
 5 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 5d4a673d..796772c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -358,7 +358,7 @@ See perf list output for the possble metrics and metricgroups.
 Do not aggregate counts across all monitored CPUs.
 
 --topdown::
-Print top down level 1 metrics if supported by the CPU. This allows to
+Print complete top-down metrics supported by the CPU. This allows to
 determine bottle necks in the CPU pipeline for CPU bound workloads,
 by breaking the cycles consumed down into frontend bound, backend bound,
 bad speculation and retiring.
@@ -393,6 +393,18 @@ To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
 taskset.
 
+--td-level::
+Print the top-down statistics that equal to or lower than the input level.
+It allows users to print the interested top-down metrics level instead of
+the complete top-down metrics.
+
+The availability of the top-down metrics level depends on the hardware. For
+example, Ice Lake only supports L1 top-down metrics. The Sapphire Rapids
+supports both L1 and L2 top-down metrics.
+
+Default: 0 means the max level that the current hardware support.
+Error out if the input is higher than the supported max level.
+
 --no-merge::
 Do not merge results from same PMUs.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8cc2496..bc84b31 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -137,6 +137,19 @@ static const char *topdown_metric_attrs[] = {
 	NULL,
 };
 
+static const char *topdown_metric_L2_attrs[] = {
+	"slots",
+	"topdown-retiring",
+	"topdown-bad-spec",
+	"topdown-fe-bound",
+	"topdown-be-bound",
+	"topdown-heavy-ops",
+	"topdown-br-mispredict",
+	"topdown-fetch-lat",
+	"topdown-mem-bound",
+	NULL,
+};
+
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1153,7 +1166,9 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
-			"measure topdown level 1 statistics"),
+			"measure top-down statistics"),
+	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
+			"Set the metrics level for the top-down statistics (0: max level)"),
 	OPT_BOOLEAN(0, "smi-cost", &smi_cost,
 			"measure SMI cost"),
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
@@ -1706,17 +1721,30 @@ static int add_default_attributes(void)
 	}
 
 	if (topdown_run) {
+		const char **metric_attrs = topdown_metric_attrs;
+		unsigned int max_level = 1;
 		char *str = NULL;
 		bool warn = false;
 
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		if (topdown_filter_events(topdown_metric_attrs, &str, 1) < 0) {
+		if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
+			metric_attrs = topdown_metric_L2_attrs;
+			max_level = 2;
+		}
+
+		if (stat_config.topdown_level > max_level) {
+			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
+			return -1;
+		} else if (!stat_config.topdown_level)
+			stat_config.topdown_level = max_level;
+
+		if (topdown_filter_events(metric_attrs, &str, 1) < 0) {
 			pr_err("Out of memory\n");
 			return -1;
 		}
-		if (topdown_metric_attrs[0] && str) {
+		if (metric_attrs[0] && str) {
 			if (!stat_config.interval && !stat_config.metric_only) {
 				fprintf(stat_config.output,
 					"Topdown accuracy may decrease when measuring long periods.\n"
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 12eafd1..6ccf21a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -273,6 +273,18 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
 				    cpu, count, &rsd);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_HEAVY_OPS))
+		update_runtime_stat(st, STAT_TOPDOWN_HEAVY_OPS,
+				    cpu, count, &rsd);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_BR_MISPREDICT))
+		update_runtime_stat(st, STAT_TOPDOWN_BR_MISPREDICT,
+				    cpu, count, &rsd);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_LAT))
+		update_runtime_stat(st, STAT_TOPDOWN_FETCH_LAT,
+				    cpu, count, &rsd);
+	else if (perf_stat_evsel__is(counter, TOPDOWN_MEM_BOUND))
+		update_runtime_stat(st, STAT_TOPDOWN_MEM_BOUND,
+				    cpu, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    cpu, count, &rsd);
@@ -1174,6 +1186,86 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_HEAVY_OPS) &&
+			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
+		double retiring = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_RETIRING, st,
+						  &rsd);
+		double heavy_ops = td_metric_ratio(cpu,
+						   STAT_TOPDOWN_HEAVY_OPS, st,
+						   &rsd);
+		double light_ops = retiring - heavy_ops;
+
+		if (retiring > 0.7 && heavy_ops > 0.1)
+			color = PERF_COLOR_GREEN;
+		print_metric(config, ctxp, color, "%8.1f%%", "heavy operations",
+				heavy_ops * 100.);
+		if (retiring > 0.7 && light_ops > 0.6)
+			color = PERF_COLOR_GREEN;
+		else
+			color = NULL;
+		print_metric(config, ctxp, color, "%8.1f%%", "light operations",
+				light_ops * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BR_MISPREDICT) &&
+			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
+		double bad_spec = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_BAD_SPEC, st,
+						  &rsd);
+		double br_mis = td_metric_ratio(cpu,
+						STAT_TOPDOWN_BR_MISPREDICT, st,
+						&rsd);
+		double m_clears = bad_spec - br_mis;
+
+		if (bad_spec > 0.1 && br_mis > 0.05)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "branch mispredict",
+				br_mis * 100.);
+		if (bad_spec > 0.1 && m_clears > 0.05)
+			color = PERF_COLOR_RED;
+		else
+			color = NULL;
+		print_metric(config, ctxp, color, "%8.1f%%", "machine clears",
+				m_clears * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_LAT) &&
+			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
+		double fe_bound = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_FE_BOUND, st,
+						  &rsd);
+		double fetch_lat = td_metric_ratio(cpu,
+						   STAT_TOPDOWN_FETCH_LAT, st,
+						   &rsd);
+		double fetch_bw = fe_bound - fetch_lat;
+
+		if (fe_bound > 0.2 && fetch_lat > 0.15)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "fetch latency",
+				fetch_lat * 100.);
+		if (fe_bound > 0.2 && fetch_bw > 0.1)
+			color = PERF_COLOR_RED;
+		else
+			color = NULL;
+		print_metric(config, ctxp, color, "%8.1f%%", "fetch bandwidth",
+				fetch_bw * 100.);
+	} else if (perf_stat_evsel__is(evsel, TOPDOWN_MEM_BOUND) &&
+			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
+		double be_bound = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_BE_BOUND, st,
+						  &rsd);
+		double mem_bound = td_metric_ratio(cpu,
+						   STAT_TOPDOWN_MEM_BOUND, st,
+						   &rsd);
+		double core_bound = be_bound - mem_bound;
+
+		if (be_bound > 0.2 && mem_bound > 0.2)
+			color = PERF_COLOR_RED;
+		print_metric(config, ctxp, color, "%8.1f%%", "memory bound",
+				mem_bound * 100.);
+		if (be_bound > 0.2 && core_bound > 0.1)
+			color = PERF_COLOR_RED;
+		else
+			color = NULL;
+		print_metric(config, ctxp, color, "%8.1f%%", "Core bound",
+				core_bound * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ce1479..82c767b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -99,6 +99,10 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 	ID(TOPDOWN_BAD_SPEC, topdown-bad-spec),
 	ID(TOPDOWN_FE_BOUND, topdown-fe-bound),
 	ID(TOPDOWN_BE_BOUND, topdown-be-bound),
+	ID(TOPDOWN_HEAVY_OPS, topdown-heavy-ops),
+	ID(TOPDOWN_BR_MISPREDICT, topdown-br-mispredict),
+	ID(TOPDOWN_FETCH_LAT, topdown-fetch-lat),
+	ID(TOPDOWN_MEM_BOUND, topdown-mem-bound),
 	ID(SMI_NUM, msr/smi/),
 	ID(APERF, msr/aperf/),
 };
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b536973..d85c292 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -33,6 +33,10 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__TOPDOWN_BAD_SPEC,
 	PERF_STAT_EVSEL_ID__TOPDOWN_FE_BOUND,
 	PERF_STAT_EVSEL_ID__TOPDOWN_BE_BOUND,
+	PERF_STAT_EVSEL_ID__TOPDOWN_HEAVY_OPS,
+	PERF_STAT_EVSEL_ID__TOPDOWN_BR_MISPREDICT,
+	PERF_STAT_EVSEL_ID__TOPDOWN_FETCH_LAT,
+	PERF_STAT_EVSEL_ID__TOPDOWN_MEM_BOUND,
 	PERF_STAT_EVSEL_ID__SMI_NUM,
 	PERF_STAT_EVSEL_ID__APERF,
 	PERF_STAT_EVSEL_ID__MAX,
@@ -91,6 +95,10 @@ enum stat_type {
 	STAT_TOPDOWN_BAD_SPEC,
 	STAT_TOPDOWN_FE_BOUND,
 	STAT_TOPDOWN_BE_BOUND,
+	STAT_TOPDOWN_HEAVY_OPS,
+	STAT_TOPDOWN_BR_MISPREDICT,
+	STAT_TOPDOWN_FETCH_LAT,
+	STAT_TOPDOWN_MEM_BOUND,
 	STAT_SMI_NUM,
 	STAT_APERF,
 	STAT_MAX
@@ -148,6 +156,7 @@ struct perf_stat_config {
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
 	const char		*cgroup_list;
+	unsigned int		topdown_level;
 };
 
 void perf_stat__set_big_num(int set);
-- 
2.7.4

