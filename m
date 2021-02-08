Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96840313CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhBHSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:08:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:27981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhBHPip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:38:45 -0500
IronPort-SDR: JcGsBgEHaoimFJkCy0dkkhzEg4MLkCk9NMQVk8xkEr1im4d4eFRg+CpWiVYcD9tp2KeZ0bruDF
 NvPDz5Ljh5iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874621"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: vYmSmSlM/NcColDNsO9jUGqkJFmcItmje13AgxGQOixyFGg54viSJSuu4BLll2q14sKdTSySjb
 c9uDXumpCmSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820902"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 37/49] perf parse-events: Support hardware events inside PMU
Date:   Mon,  8 Feb 2021 07:25:34 -0800
Message-Id: <1612797946-18784-38-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

On hybrid platform, some hardware cache events are only available
on a specific pmu. For example, 'L1-dcache-load-misses' is only
available on 'cpu_core' pmu. And even for the event which can be
available on both pmus, the user also may want to just enable
one event. So now following syntax is supported:

cpu_core/<hardware event>/
cpu_core/<hardware cache event>/
cpu_core/<pmu event>/

cpu_atom/<hardware event>/
cpu_atom/<hardware cache event>/
cpu_atom/<pmu event>/

It limits the event to be enabled only on a specified pmu.

The patch uses this idea, for example, if we use "cpu_core/LLC-loads/",
in parse_events_add_pmu(), term->config is "LLC-loads".

We create a new "parse_events_state" with the pmu_name and use
parse_events__scanner to scan the term->config (the string "LLC-loads"
in this example). The parse_events_add_cache() will be called during
parsing. The parse_state->pmu_name is used to identify the pmu
where the event is enabled.

For example,

root@otcpl-adl-s-2:~# ./perf stat -e cpu_core/cycles/,cpu_core/LLC-loads/ -vv -- ./triad_loop
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0x400000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 29207  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             120
  config                           0x400000002
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 29207  cpu -1  group_fd -1  flags 0x8 = 4
cycles: 0: 401363820 101974864 101974864
LLC-loads: 0: 2577 101974864 101974864
cycles: 401363820 101974864 101974864
LLC-loads: 2577 101974864 101974864

 Performance counter stats for './triad_loop':

       401,363,820      cycles
             2,577      LLC-loads

       0.102416870 seconds time elapsed

root@otcpl-adl-s-2:~# ./perf stat -e cpu_atom/cycles/,cpu_atom/LLC-loads/ -vv -- taskset -c 16 ./triad_loop
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             6
  size                             120
  config                           0xa00000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 29212  cpu -1  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  type                             7
  size                             120
  config                           0xa00000002
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 29212  cpu -1  group_fd -1  flags 0x8 = 4
cycles: 0: 602052607 201353578 200990459
LLC-loads: 0: 4428 201353578 200990459
cycles: 603140304 201353578 200990459
LLC-loads: 4435 201353578 200990459

 Performance counter stats for 'taskset -c 16 ./triad_loop':

       603,140,304      cycles                                                        (99.82%)
             4,435      LLC-loads                                                     (99.82%)

       0.203948454 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 100 ++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/parse-events.h |   6 ++-
 tools/perf/util/parse-events.y |  21 +++------
 3 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 28d356e..bba7db3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -489,7 +489,8 @@ static int create_hybrid_cache_event(struct list_head *list, int *idx,
 static int add_hybrid_cache(struct list_head *list, int *idx,
 			    struct perf_event_attr *attr, char *name,
 			    struct list_head *config_terms,
-			    bool *hybrid)
+			    bool *hybrid,
+			    struct parse_events_state *parse_state)
 {
 	struct perf_pmu *pmu;
 	int ret;
@@ -497,6 +498,11 @@ static int add_hybrid_cache(struct list_head *list, int *idx,
 	*hybrid = false;
 	perf_pmu__for_each_hybrid_pmus(pmu) {
 		*hybrid = true;
+		 if (parse_state->pmu_name &&
+		     strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		ret = create_hybrid_cache_event(list, idx, attr, name,
 						config_terms, pmu);
 		if (ret)
@@ -509,7 +515,8 @@ static int add_hybrid_cache(struct list_head *list, int *idx,
 int parse_events_add_cache(struct list_head *list, int *idx,
 			   char *type, char *op_result1, char *op_result2,
 			   struct parse_events_error *err,
-			   struct list_head *head_config)
+			   struct list_head *head_config,
+			   struct parse_events_state *parse_state)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -582,7 +589,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 		perf_pmu__scan(NULL);
 
 	ret = add_hybrid_cache(list, idx, &attr, config_name ? : name,
-			       &config_terms, &hybrid);
+			       &config_terms, &hybrid, parse_state);
 	if (hybrid)
 		return ret;
 
@@ -1512,6 +1519,11 @@ static int add_hybrid_numeric(struct parse_events_state *parse_state,
 	*hybrid = false;
 	perf_pmu__for_each_hybrid_pmus(pmu) {
 		*hybrid = true;
+		if (parse_state->pmu_name &&
+		    strcmp(parse_state->pmu_name, pmu->name)) {
+			continue;
+		}
+
 		ret = create_hybrid_hw_event(parse_state, list, attr, pmu);
 		if (ret)
 			return ret;
@@ -1578,6 +1590,10 @@ static bool config_term_percore(struct list_head *config_terms)
 	return false;
 }
 
+static int parse_events_with_hybrid_pmu(struct parse_events_state *parse_state,
+			      const char *str, char *name, bool *found,
+			      struct list_head *list);
+
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
@@ -1589,7 +1605,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	bool use_uncore_alias;
+	bool use_uncore_alias, found;
 	LIST_HEAD(config_terms);
 
 	if (verbose > 1) {
@@ -1605,6 +1621,22 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		fprintf(stderr, "' that may result in non-fatal errors\n");
 	}
 
+	if (head_config && perf_pmu__is_hybrid(name)) {
+		struct parse_events_term *term;
+		int ret;
+
+		list_for_each_entry(term, head_config, list) {
+			if (!term->config)
+				continue;
+			ret = parse_events_with_hybrid_pmu(parse_state,
+							   term->config,
+							   name, &found,
+							   list);
+			if (found)
+				return ret;
+		}
+	}
+
 	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
 	if (!pmu) {
 		char *err_str;
@@ -1713,12 +1745,19 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu = NULL;
 	int ok = 0;
 
+        if (parse_state->pmu_name) {
+                list = alloc_list();
+                if (!list)
+                        return -1;
+                *listp = list;
+                return 0;
+        }
+
 	*listp = NULL;
 	/* Add it for all PMUs that support the alias */
-	list = malloc(sizeof(struct list_head));
+	list = alloc_list();
 	if (!list)
 		return -1;
-	INIT_LIST_HEAD(list);
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct perf_pmu_alias *alias;
 
@@ -2284,6 +2323,44 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	return ret;
 }
 
+static int list_num(struct list_head *list)
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
+static int parse_events_with_hybrid_pmu(struct parse_events_state *parse_state,
+					const char *str, char *pmu_name,
+					bool *found, struct list_head *list)
+{
+	struct parse_events_state ps = {
+		.list		= LIST_HEAD_INIT(ps.list),
+		.stoken		= PE_START_EVENTS,
+		.pmu_name	= pmu_name,
+		.idx		= parse_state->idx,
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
+			parse_state->idx = list_num(list);
+		}
+	}
+
+	return ret;
+}
+
 int __parse_events(struct evlist *evlist, const char *str,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
 {
@@ -3309,3 +3386,14 @@ char *parse_events_formats_error_string(char *additional_terms)
 fail:
 	return NULL;
 }
+
+struct list_head *alloc_list(void)
+{
+	struct list_head *list = malloc(sizeof(*list));
+
+	if (!list)
+		return NULL;
+
+	INIT_LIST_HEAD(list);
+	return list;
+}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b875485..6c91abc 100644
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
@@ -243,6 +245,8 @@ char *parse_events_formats_error_string(char *additional_terms);
 void parse_events_print_error(struct parse_events_error *err,
 			      const char *event);
 
+struct list_head *alloc_list(void);
+
 #ifdef HAVE_LIBELF_SUPPORT
 /*
  * If the probe point starts with '%',
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d5b6aff..137c7fa 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -26,18 +26,6 @@ do { \
 		YYABORT; \
 } while (0)
 
-static struct list_head* alloc_list(void)
-{
-	struct list_head *list;
-
-	list = malloc(sizeof(*list));
-	if (!list)
-		return NULL;
-
-	INIT_LIST_HEAD(list);
-	return list;
-}
-
 static void free_list_evsel(struct list_head* list_evsel)
 {
 	struct evsel *evsel, *tmp;
@@ -450,7 +438,8 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6,
+				parse_state);
 	parse_events_terms__delete($6);
 	free($1);
 	free($3);
@@ -471,7 +460,8 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4,
+				parse_state);
 	parse_events_terms__delete($4);
 	free($1);
 	free($3);
@@ -491,7 +481,8 @@ PE_NAME_CACHE_TYPE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2,
+				parse_state);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
-- 
2.7.4

