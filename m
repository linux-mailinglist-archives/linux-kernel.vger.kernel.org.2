Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F70313CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhBHSMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:12:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:27842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234056AbhBHPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:41:24 -0500
IronPort-SDR: 4RzMb57twMA/9yikAZTfjdHxbL3IIJn4xj/bmUQdrYPyuFRRA6pKaCaTMCnCIUg8J3+Qltda42
 HO27SzL6VvYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874626"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: oZr26J/VutFPvm9TxRsFijX0qhEyWqACRmLpsp5RBKe5M/ADK67kIl+f0plsJ9BnIdAx2eoFDF
 Z7ej0q2BZCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820912"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 40/49] perf stat: Support --cputype option for hybrid events
Date:   Mon,  8 Feb 2021 07:25:37 -0800
Message-Id: <1612797946-18784-41-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In previous patch, we have supported the syntax which enables
the event on a specified pmu, such as:

cpu_core/<event>/
cpu_atom/<event>/

While this syntax is not very easy for applying on a set of
events or applying on a group. In following example, we have to
explicitly assign the pmu prefix.

root@otcpl-adl-s-2:~# ./perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -- sleep 1

 Performance counter stats for 'sleep 1':

         1,660,562      cycles
           944,537      instructions

       1.001678000 seconds time elapsed

A much easier way is:

root@otcpl-adl-s-2:~# ./perf stat --cputype core -e '{cycles,instructions}' -- sleep 1

 Performance counter stats for 'sleep 1':

           887,232      cycles
           877,314      instructions

       1.002520551 seconds time elapsed

The '--cputype' enables the events from specified pmu (cpu_core).

If '--cputype' conflicts with pmu prefix, '--cputype' is ignored and
a warning is displayed.

root@otcpl-adl-s-2:~# ./perf stat --cputype atom -e '{cpu_core/cycles/}' -- sleep 1
WARNING: cputype (cpu_atom) conflicts with event pmu (cpu_core), use event pmu (cpu_core)

 Performance counter stats for 'sleep 1':

         1,441,979      cycles

       1.001177738 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 24 +++++++++++++++++++
 tools/perf/util/evlist.h               |  1 +
 tools/perf/util/parse-events.c         | 43 +++++++++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h         |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 796772c..b0e357d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -450,6 +450,10 @@ convenient for post processing.
 --summary::
 Print summary for interval mode (-I).
 
+--cputype::
+Only enable events on applying cpu with this type for hybrid platform
+(e.g. core or atom)"
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index afb8789..44d1a5f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1117,6 +1117,26 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
+static int parse_hybrid_type(const struct option *opt,
+			     const char *str,
+			     int unset __maybe_unused)
+{
+	struct evlist *evlist = *(struct evlist **)opt->value;
+
+	if (!list_empty(&evlist->core.entries)) {
+		fprintf(stderr, "Must define cputype before events/metrics\n");
+		return -1;
+	}
+
+	evlist->pmu_name = perf_pmu__hybrid_type_to_pmu(str);
+	if (!evlist->pmu_name) {
+		fprintf(stderr, "--cputype %s is not supported!\n", str);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1221,6 +1241,10 @@ static struct option stat_options[] = {
 		       "print summary for interval mode"),
 	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
 			"don't print output (useful with record)"),
+	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
+		     "Only enable events on applying cpu with this type "
+		     "for hybrid platform (e.g. core or atom)",
+		     parse_hybrid_type),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 9741df4..c06b9ff 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -66,6 +66,7 @@ struct evlist {
 	struct evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
+	const char *pmu_name;
 	void (*trace_event_sample_raw)(struct evlist *evlist,
 				       union perf_event *event,
 				       struct perf_sample *sample);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6d7a2ce..8cdabaa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -498,7 +498,13 @@ static int add_hybrid_cache(struct list_head *list, int *idx,
 	*hybrid = false;
 	perf_pmu__for_each_hybrid_pmus(pmu) {
 		*hybrid = true;
-		 if (parse_state->pmu_name &&
+
+		if (parse_state->evlist && parse_state->evlist->pmu_name &&
+		    strcmp(parse_state->evlist->pmu_name, pmu->name)) {
+			continue;
+		}
+
+		if (parse_state->pmu_name &&
 		     strcmp(parse_state->pmu_name, pmu->name)) {
 			continue;
 		}
@@ -512,6 +518,19 @@ static int add_hybrid_cache(struct list_head *list, int *idx,
 	return 0;
 }
 
+static void warn_pmu_conflict(struct parse_events_state *parse_state)
+{
+	if (parse_state->evlist2 && parse_state->evlist2->pmu_name &&
+	    parse_state->pmu_name &&
+	    strcmp(parse_state->evlist2->pmu_name, parse_state->pmu_name)) {
+		WARN_ONCE(1, "WARNING: cputype (%s) conflicts with event "
+			  "pmu (%s), use event pmu (%s)\n",
+			  parse_state->evlist2->pmu_name,
+			  parse_state->pmu_name,
+			  parse_state->pmu_name);
+	}
+}
+
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *err,
@@ -588,6 +607,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 	if (!perf_pmu__hybrid_exist())
 		perf_pmu__scan(NULL);
 
+	warn_pmu_conflict(parse_state);
+
 	ret = add_hybrid_cache(list, idx, &attr, config_name ? : name,
 			       &config_terms, &hybrid, parse_state);
 	if (hybrid)
@@ -1519,6 +1540,12 @@ static int add_hybrid_numeric(struct parse_events_state *parse_state,
 	*hybrid = false;
 	perf_pmu__for_each_hybrid_pmus(pmu) {
 		*hybrid = true;
+
+		if (parse_state->evlist && parse_state->evlist->pmu_name &&
+		    strcmp(parse_state->evlist->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		if (parse_state->pmu_name &&
 		    strcmp(parse_state->pmu_name, pmu->name)) {
 			continue;
@@ -1566,6 +1593,12 @@ static int add_hybrid_raw(struct parse_events_state *parse_state,
 	*hybrid = false;
 	perf_pmu__for_each_hybrid_pmus(pmu) {
 		*hybrid = true;
+
+		if (parse_state->evlist && parse_state->evlist->pmu_name &&
+		    strcmp(parse_state->evlist->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		if (parse_state->pmu_name &&
 		    strcmp(parse_state->pmu_name, pmu->name)) {
 			continue;
@@ -1604,6 +1637,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			return -ENOMEM;
 	}
 
+	warn_pmu_conflict(parse_state);
+
 	/*
 	 * Skip the software dummy event.
 	 */
@@ -1702,6 +1737,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
+	if (parse_state->evlist->pmu_name && perf_pmu__is_hybrid(name) &&
+	    strcmp(parse_state->evlist->pmu_name, name)) {
+		return -EINVAL;
+	}
+
 	if (pmu->default_config) {
 		memcpy(&attr, pmu->default_config,
 		       sizeof(struct perf_event_attr));
@@ -2397,6 +2437,7 @@ static int parse_events_with_hybrid_pmu(struct parse_events_state *parse_state,
 		.stoken		= PE_START_EVENTS,
 		.pmu_name	= pmu_name,
 		.idx		= parse_state->idx,
+		.evlist2	= parse_state->evlist,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 6c91abc..c0d8a16 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -139,6 +139,7 @@ struct parse_events_state {
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
 	char			  *pmu_name;
+	struct evlist		  *evlist2;
 };
 
 void parse_events__handle_error(struct parse_events_error *err, int idx,
-- 
2.7.4

