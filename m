Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD8313C24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhBHSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:02:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:34621 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhBHPgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:36:05 -0500
IronPort-SDR: nNs6q+4FTs40/c370FW0o9I+LXyBffilJ/ppqhOVteWP5hTPhoQS1ZP+vikPgN/avSFQlnaU94
 5UHXNeoqnVIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266561420"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="266561420"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:36 -0800
IronPort-SDR: NWkX9e3rYeHTbZOQR/YGlXMUwuYOwE62Xb9gdCNrTp8PTj0OHZC70rg2IZ/Z0tQEqd3Xm6BKrS
 V/+5HHn2IbMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820876"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 30/49] perf list: Support --cputype option to list hybrid pmu events
Date:   Mon,  8 Feb 2021 07:25:27 -0800
Message-Id: <1612797946-18784-31-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

This patch supports a new option '--cputype' to list core only
pmu events or atom only pmu events.

For example,

perf list --cputype atom
...
cache:
  core_reject_l2q.any
       [Counts the number of request that were not accepted into the L2Q because the L2Q is FULL. Unit: cpu_atom]
  dl1.dirty_eviction
       [Counts all L1D cacheline (dirty) evictions caused by miss, stores, and prefetches. Does not count evictions or dirty writebacks caused by snoops.
        Does not count a replacement unless a (dirty) line was written back. Unit: cpu_atom]
...

We can see "Unit: cpu_atom" is displayed in the brief description
section which indicate the event is atom event.

There are some duplicated events, e.g. inst_retired.any. This patch
lists them all.

perf list
  ...
  inst_retired.any
       [Fixed Counter: Counts the number of instructions retired. Unit: cpu_atom]
  inst_retired.any
       [Number of instructions retired. Fixed Counter - architectural event. Unit: cpu_core]

One "inst_retired.any" is available on cpu_atom, another "inst_retired.any" is
available on cpu_core.

Each hybrid pmu event has been assigned with a pmu, this patch just compares
the pmu name before listing the result.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-list.txt |  4 ++++
 tools/perf/builtin-list.c              | 42 ++++++++++++++++++++++++----------
 tools/perf/util/metricgroup.c          |  6 ++++-
 tools/perf/util/metricgroup.h          |  2 +-
 tools/perf/util/parse-events.c         |  8 ++++---
 tools/perf/util/parse-events.h         |  3 ++-
 tools/perf/util/pmu.c                  | 30 ++++++++++++++++++++----
 tools/perf/util/pmu.h                  |  2 +-
 8 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 4c7db1d..4dc8d0a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -39,6 +39,10 @@ any extra expressions computed by perf stat.
 --deprecated::
 Print deprecated events. By default the deprecated events are hidden.
 
+--cputype::
+Print events applying cpu with this type for hybrid platform
+(e.g. --cputype core or --cputype atom)
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 10ab5e4..5e4bef8 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -17,16 +17,19 @@
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <stdio.h>
+#include <asm/bug.h>
 
 static bool desc_flag = true;
 static bool details_flag;
+static const char *hybrid_type;
 
 int cmd_list(int argc, const char **argv)
 {
-	int i;
+	int i, ret = 0;
 	bool raw_dump = false;
 	bool long_desc_flag = false;
 	bool deprecated = false;
+	char *pmu_name = NULL;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_BOOLEAN('d', "desc", &desc_flag,
@@ -37,6 +40,9 @@ int cmd_list(int argc, const char **argv)
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_BOOLEAN(0, "deprecated", &deprecated,
 			    "Print deprecated events."),
+		OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
+			   "Print events applying cpu with this type for hybrid platform "
+			   "(e.g. core or atom)"),
 		OPT_INCR(0, "debug", &verbose,
 			     "Enable debugging output"),
 		OPT_END()
@@ -56,10 +62,16 @@ int cmd_list(int argc, const char **argv)
 	if (!raw_dump && pager_in_use())
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
+	if (hybrid_type) {
+		pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
+		if (!pmu_name)
+			 WARN_ONCE(1, "WARNING: hybrid cputype is not supported!\n");
+	}
+
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
-				details_flag, deprecated);
-		return 0;
+				details_flag, deprecated, pmu_name);
+		goto out;
 	}
 
 	for (i = 0; i < argc; ++i) {
@@ -82,25 +94,27 @@ int cmd_list(int argc, const char **argv)
 		else if (strcmp(argv[i], "pmu") == 0)
 			print_pmu_events(NULL, raw_dump, !desc_flag,
 						long_desc_flag, details_flag,
-						deprecated);
+						deprecated, pmu_name);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
-			metricgroup__print(true, false, NULL, raw_dump, details_flag);
+			metricgroup__print(true, false, NULL, raw_dump, details_flag, pmu_name);
 		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
-			metricgroup__print(false, true, NULL, raw_dump, details_flag);
+			metricgroup__print(false, true, NULL, raw_dump, details_flag, pmu_name);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			sep_idx = sep - argv[i];
 			s = strdup(argv[i]);
-			if (s == NULL)
-				return -1;
+			if (s == NULL) {
+				ret = -1;
+				goto out;
+			}
 
 			s[sep_idx] = '\0';
 			print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
 			print_sdt_events(s, s + sep_idx + 1, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
 			free(s);
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
@@ -116,12 +130,16 @@ int cmd_list(int argc, const char **argv)
 			print_pmu_events(s, raw_dump, !desc_flag,
 						long_desc_flag,
 						details_flag,
-						deprecated);
+						deprecated,
+						pmu_name);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
-			metricgroup__print(true, true, s, raw_dump, details_flag);
+			metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
 			free(s);
 		}
 	}
-	return 0;
+
+out:
+	free(pmu_name);
+	return ret;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee94d3e..df05134 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -609,7 +609,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
 }
 
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
-			bool raw, bool details)
+			bool raw, bool details, const char *pmu_name)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
@@ -635,6 +635,10 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			break;
 		if (!pe->metric_expr)
 			continue;
+		if (pmu_name && perf_pmu__is_hybrid(pe->pmu) &&
+		    strcmp(pmu_name, pe->pmu)) {
+			continue;
+		}
 		if (metricgroup__print_pmu_event(pe, metricgroups, filter,
 						 raw, details, &groups,
 						 metriclist) < 0)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ed1b939..b03111b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -53,7 +53,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct rblist *metric_events);
 
 void metricgroup__print(bool metrics, bool groups, char *filter,
-			bool raw, bool details);
+			bool raw, bool details, const char *pmu_name);
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84ad..81a6fce 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2893,7 +2893,8 @@ void print_symbol_events(const char *event_glob, unsigned type,
  * Print the help text for the event symbols:
  */
 void print_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated)
+			bool long_desc, bool details_flag, bool deprecated,
+			const char *pmu_name)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -2905,7 +2906,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 	print_hwcache_events(event_glob, name_only);
 
 	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
-			details_flag, deprecated);
+			details_flag, deprecated, pmu_name);
 
 	if (event_glob != NULL)
 		return;
@@ -2931,7 +2932,8 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_sdt_events(NULL, NULL, name_only);
 
-	metricgroup__print(true, true, NULL, name_only, details_flag);
+	metricgroup__print(true, true, NULL, name_only, details_flag,
+			   pmu_name);
 
 	print_libpfm_events(name_only, long_desc);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e80c9b7..b875485 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -217,7 +217,8 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
 void print_events(const char *event_glob, bool name_only, bool quiet,
-		  bool long_desc, bool details_flag, bool deprecated);
+		  bool long_desc, bool details_flag, bool deprecated,
+		  const char *pmu_name);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 04447f5..9a6c973 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1546,6 +1546,7 @@ static int cmp_sevent(const void *a, const void *b)
 {
 	const struct sevent *as = a;
 	const struct sevent *bs = b;
+	int ret;
 
 	/* Put extra events last */
 	if (!!as->desc != !!bs->desc)
@@ -1561,7 +1562,13 @@ static int cmp_sevent(const void *a, const void *b)
 	if (as->is_cpu != bs->is_cpu)
 		return bs->is_cpu - as->is_cpu;
 
-	return strcmp(as->name, bs->name);
+	ret = strcmp(as->name, bs->name);
+	if (!ret) {
+		if (as->pmu && bs->pmu)
+			return strcmp(as->pmu, bs->pmu);
+	}
+
+	return ret;
 }
 
 static void wordwrap(char *s, int start, int max, int corr)
@@ -1591,7 +1598,8 @@ bool is_pmu_core(const char *name)
 }
 
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
-			bool long_desc, bool details_flag, bool deprecated)
+			bool long_desc, bool details_flag, bool deprecated,
+			const char *pmu_name)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1617,10 +1625,16 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
+		    strcmp(pmu_name, pmu->name)) {
+			continue;
+		}
+
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			char *name = alias->desc ? alias->name :
 				format_alias(buf, sizeof(buf), pmu, alias);
-			bool is_cpu = is_pmu_core(pmu->name);
+			bool is_cpu = is_pmu_core(pmu->name) ||
+				      perf_pmu__is_hybrid(pmu->name);
 
 			if (alias->deprecated && !deprecated)
 				continue;
@@ -1653,6 +1667,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			aliases[j].metric_expr = alias->metric_expr;
 			aliases[j].metric_name = alias->metric_name;
 			aliases[j].is_cpu = is_cpu;
+			aliases[j].pmu = alias->pmu;
 			j++;
 		}
 		if (pmu->selectable &&
@@ -1668,8 +1683,13 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		/* Skip duplicates */
-		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
-			continue;
+		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
+			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
+			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
+				continue;
+			}
+		}
+
 		if (name_only) {
 			printf("%s ", aliases[j].name);
 			continue;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bb74595..5b727cf 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -107,7 +107,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 bool is_pmu_core(const char *name);
 void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
 		      bool long_desc, bool details_flag,
-		      bool deprecated);
+		      bool deprecated, const char *pmu_name);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
-- 
2.7.4

