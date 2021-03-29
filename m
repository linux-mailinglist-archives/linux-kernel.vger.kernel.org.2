Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9D34C475
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2HCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:52628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhC2HCN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:13 -0400
IronPort-SDR: ny4cunWyT5yUpeGEYG6w1qcHOVbyP5UmfkijTZfxdrewJxvb11j4VLhouI1RWQMLhMJ19CJbKM
 S4HFWePGi4qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="171505713"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="171505713"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:13 -0700
IronPort-SDR: CQgSrReunLKSVBJD5JX9/G2dKWJivJLJ6pcOF1yYXbnjMAGbN4jkueJnQweylEU4XryjKgasdM
 P4o2BQK7388g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677467"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 12/27] perf parse-events: Support no alias assigned event inside hybrid PMU
Date:   Mon, 29 Mar 2021 15:00:31 +0800
Message-Id: <20210329070046.8815-13-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, similar to hardware event, user may want
to enable other events only on one PMU. So following syntax
should be supported:

cpu_core/<event>/
cpu_atom/<event>/

But the syntax doesn't work for some events, such as cache
event.

Before:

  # perf stat -e cpu_core/LLC-loads/ -a -- sleep 1
  event syntax error: 'cpu_core/LLC-loads/'
                                \___ unknown term 'LLC-loads' for pmu 'cpu_core'

Cache events are much more complex than hardware events, so
we can't create aliases for them. We use another solution.
For example, if we use "cpu_core/LLC-loads/", in parse_events_add_pmu(),
term->config is "LLC-loads".

We create a new "parse_events_state" with the pmu_name and use
parse_events__scanner to scan the term->config ("LLC-loads" in
this example). The parse_events_add_cache() would be called during
parsing. The parse_state->pmu_name is used to identify the pmu
where the event should be enabled on.

After:

  # ./perf stat -e cpu_core/LLC-loads/ -a -- sleep 1

   Performance counter stats for 'system wide':

              24,593      cpu_core/LLC-loads/

         1.003911601 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Rename the patch:
   'perf parse-events: Support hardware events inside PMU' -->
   'perf parse-events: Support no alias assigned event inside hybrid PMU'

 - Major code is moved to parse-events-hybrid.c.
 - Refine the code.

 tools/perf/util/parse-events-hybrid.c | 18 +++++-
 tools/perf/util/parse-events-hybrid.h |  3 +-
 tools/perf/util/parse-events.c        | 80 +++++++++++++++++++++++++--
 tools/perf/util/parse-events.h        |  4 +-
 tools/perf/util/parse-events.y        |  9 ++-
 tools/perf/util/pmu.c                 |  4 +-
 tools/perf/util/pmu.h                 |  2 +-
 7 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
index 8a630cbab8f3..5bf176b55573 100644
--- a/tools/perf/util/parse-events-hybrid.c
+++ b/tools/perf/util/parse-events-hybrid.c
@@ -64,6 +64,11 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
 	int ret;
 
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (parse_state->pmu_name &&
+		    strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		ret = create_event_hybrid(PERF_TYPE_HARDWARE_PMU,
 					  &parse_state->idx, list, attr, name,
 					  config_terms, pmu);
@@ -100,6 +105,11 @@ static int add_raw_hybrid(struct parse_events_state *parse_state,
 	int ret;
 
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (parse_state->pmu_name &&
+		    strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		ret = create_raw_event_hybrid(&parse_state->idx, list, attr,
 					      name, config_terms, pmu);
 		if (ret)
@@ -137,7 +147,8 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 				   struct perf_event_attr *attr, char *name,
 				   struct list_head *config_terms,
-				   bool *hybrid)
+				   bool *hybrid,
+				   struct parse_events_state *parse_state)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -148,6 +159,11 @@ int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 
 	*hybrid = true;
 	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (parse_state->pmu_name &&
+		    strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		ret = create_event_hybrid(PERF_TYPE_HW_CACHE_PMU, idx, list,
 					  attr, name, config_terms, pmu);
 		if (ret)
diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/parse-events-hybrid.h
index 9ad33cd0cef4..f33bd67aa851 100644
--- a/tools/perf/util/parse-events-hybrid.h
+++ b/tools/perf/util/parse-events-hybrid.h
@@ -17,6 +17,7 @@ int parse_events__add_numeric_hybrid(struct parse_events_state *parse_state,
 int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
 				   struct perf_event_attr *attr, char *name,
 				   struct list_head *config_terms,
-				   bool *hybrid);
+				   bool *hybrid,
+				   struct parse_events_state *parse_state);
 
 #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3692fa3c964a..020c785be742 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -38,6 +38,7 @@
 #include "util/event.h"
 #include "util/pfm.h"
 #include "util/parse-events-hybrid.h"
+#include "util/pmu-hybrid.h"
 #include "perf.h"
 
 #define MAX_NAME_LEN 100
@@ -48,6 +49,9 @@ extern int parse_events_debug;
 int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
+static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
+					 const char *str, char *pmu_name,
+					 bool *found, struct list_head *list);
 
 static struct perf_pmu_event_symbol *perf_pmu_events_list;
 /*
@@ -450,7 +454,8 @@ static int config_attr(struct perf_event_attr *attr,
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *err,
-			   struct list_head *head_config)
+			   struct list_head *head_config,
+			   struct parse_events_state *parse_state)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -521,7 +526,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 
 	i = parse_events__add_cache_hybrid(list, idx, &attr,
 					   config_name ? : name, &config_terms,
-					   &hybrid);
+					   &hybrid, parse_state);
 	if (hybrid)
 		return i;
 
@@ -1481,7 +1486,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	bool use_uncore_alias;
+	bool use_uncore_alias, found = false;
 	LIST_HEAD(config_terms);
 
 	if (verbose > 1) {
@@ -1530,8 +1535,28 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		}
 	}
 
-	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
+	if (!parse_state->fake_pmu &&
+	    perf_pmu__check_alias(pmu, head_config, &info, &found)) {
 		return -EINVAL;
+	}
+
+	if (!parse_state->fake_pmu && head_config && !found &&
+	    perf_pmu__is_hybrid(name)) {
+		struct parse_events_term *term;
+		int ret;
+
+		list_for_each_entry(term, head_config, list) {
+			if (!term->config)
+				continue;
+
+			ret = parse_events__with_hybrid_pmu(parse_state,
+							    term->config,
+							    name, &found,
+							    list);
+			if (found)
+				return ret;
+		}
+	}
 
 	if (verbose > 1) {
 		fprintf(stderr, "After aliases, add event pmu '%s' with '",
@@ -1605,6 +1630,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu = NULL;
 	int ok = 0;
 
+	if (parse_state->pmu_name) {
+		list = malloc(sizeof(struct list_head));
+		if (!list)
+			return -1;
+		INIT_LIST_HEAD(list);
+		*listp = list;
+		return 0;
+	}
+
 	*listp = NULL;
 	/* Add it for all PMUs that support the alias */
 	list = malloc(sizeof(struct list_head));
@@ -2176,6 +2210,44 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
+static int list_entries_nr(struct list_head *list)
+{
+	struct list_head *pos;
+	int n = 0;
+
+	list_for_each(pos, list)
+		n++;
+
+	return n;
+}
+
+static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
+					 const char *str, char *pmu_name,
+					 bool *found, struct list_head *list)
+{
+	struct parse_events_state ps = {
+		.list           = LIST_HEAD_INIT(ps.list),
+		.stoken         = PE_START_EVENTS,
+		.pmu_name       = pmu_name,
+		.idx            = parse_state->idx,
+	};
+	int ret;
+
+	*found = false;
+	ret = parse_events__scanner(str, &ps);
+	perf_pmu__parse_cleanup();
+
+	if (!ret) {
+		if (!list_empty(&ps.list)) {
+			*found = true;
+			list_splice(&ps.list, list);
+			parse_state->idx = list_entries_nr(list);
+		}
+	}
+
+	return ret;
+}
+
 int __parse_events(struct evlist *evlist, const char *str,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c4f2f96304ce..f9d8e8e41c38 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -138,6 +138,7 @@ struct parse_events_state {
 	struct list_head	  *terms;
 	int			   stoken;
 	struct perf_pmu		  *fake_pmu;
+	char			  *pmu_name;
 };
 
 void parse_events__handle_error(struct parse_events_error *err, int idx,
@@ -188,7 +189,8 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *error,
-			   struct list_head *head_config);
+			   struct list_head *head_config,
+			   struct parse_events_state *parse_state);
 int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				u64 addr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d57ac86ce7ca..aba12a4d488e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -454,7 +454,8 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6,
+				     parse_state);
 	parse_events_terms__delete($6);
 	free($1);
 	free($3);
@@ -475,7 +476,8 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4,
+				     parse_state);
 	parse_events_terms__delete($4);
 	free($1);
 	free($3);
@@ -495,7 +497,8 @@ PE_NAME_CACHE_TYPE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2,
+				     parse_state);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 72e5ae5e868e..7167ae88e0db 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1412,7 +1412,7 @@ static int check_info_data(struct perf_pmu_alias *alias,
  * defined for the alias
  */
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info)
+			  struct perf_pmu_info *info, bool *found)
 {
 	struct parse_events_term *term, *h;
 	struct perf_pmu_alias *alias;
@@ -1430,6 +1430,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 	info->metric_expr = NULL;
 	info->metric_name = NULL;
 
+	*found = false;
 	list_for_each_entry_safe(term, h, head_terms, list) {
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
@@ -1438,6 +1439,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 		if (ret)
 			return ret;
 
+		*found = true;
 		ret = check_info_data(alias, info);
 		if (ret)
 			return ret;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5ed2abab7fe0..381a2e94fbba 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -91,7 +91,7 @@ int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats,
 __u64 perf_pmu__format_bits(struct list_head *formats, const char *name);
 int perf_pmu__format_type(struct list_head *formats, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
-			  struct perf_pmu_info *info);
+			  struct perf_pmu_info *info, bool *found);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
 void perf_pmu_error(struct list_head *list, char *name, char const *msg);
-- 
2.17.1

