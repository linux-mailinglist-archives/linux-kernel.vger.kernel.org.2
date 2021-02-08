Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67F313CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhBHSMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:12:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:27981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234064AbhBHPl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:41:26 -0500
IronPort-SDR: hhTPaeCd0tXdRACES16VUwrg7cLx5Jw04Nkeyea3XVdHcAT7N2PN3qstR2syl6tJ5+gOv03VYZ
 AYvoFfTyHilQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874628"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: cANF1ZVAa3/zpoNZWWGIDF4YZd0MAnw8Q6+/v5Tk8MnsbwGBPGZL7gK0fHYRfJtfl6OYipAdtf
 0KtV9XGBqpeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820915"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 41/49] perf stat: Support metrics with hybrid events
Date:   Mon,  8 Feb 2021 07:25:38 -0800
Message-Id: <1612797946-18784-42-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

One metric such as 'Kernel_Utilization' may be from different PMUs and
consists of different events.

For core,
Kernel_Utilization = cpu_clk_unhalted.thread:k / cpu_clk_unhalted.thread

For atom,
Kernel_Utilization = cpu_clk_unhalted.core:k / cpu_clk_unhalted.core

The metric group string is:
"{cpu_clk_unhalted.thread:k,cpu_clk_unhalted.thread}:W,{cpu_clk_unhalted.core:k,cpu_clk_unhalted.core}:W"

It's internally expanded to:
"{cpu_clk_unhalted.thread:k,cpu_clk_unhalted.thread}:W#cpu_core,{cpu_clk_unhalted.core:k,cpu_clk_unhalted.core}:W#cpu_atom"

That means the group "{cpu_clk_unhalted.thread:k,cpu_clk_unhalted.thread}:W"
is from cpu_core PMU and the group "{cpu_clk_unhalted.core:k,cpu_clk_unhalted.core}"
is from cpu_atom PMU. And then next, checks if the events in group are
valid on that PMU. If one event is not valid on that PMU, the associated
group would be removed internally.

In this example, cpu_clk_unhalted.thread is valid on cpu_core and
cpu_clk_unhalted.core is valid on cpu_atom. So the checks for these two
groups are passed.

Now it reports:

root@otcpl-adl-s-2:~# ./perf stat -M Kernel_Utilization -a -- sleep 1

 Performance counter stats for 'system wide':

        15,302,356      cpu_clk_unhalted.thread:k #     0.96 Kernel_Utilization
        16,016,529      cpu_clk_unhalted.thread
         3,865,478      cpu_clk_unhalted.core:k   #     0.82 Kernel_Utilization
         4,699,692      cpu_clk_unhalted.core

       1.002409000 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/metricgroup.c  | 220 ++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/stat-display.c |   5 +-
 2 files changed, 213 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index df05134..36f2035 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -122,6 +122,7 @@ struct metric {
 	const char *metric_name;
 	const char *metric_expr;
 	const char *metric_unit;
+	const char *pmu_name;
 	struct list_head metric_refs;
 	int metric_refs_cnt;
 	int runtime;
@@ -185,7 +186,8 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      bool metric_no_merge,
 				      bool has_constraint,
 				      struct evsel **metric_events,
-				      unsigned long *evlist_used)
+				      unsigned long *evlist_used,
+				      const char *pmu_name)
 {
 	struct evsel *ev, *current_leader = NULL;
 	struct expr_id_data *val_ptr;
@@ -234,8 +236,13 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (contains_event(metric_events, matched_events, ev->name))
 			continue;
 		/* Does this event belong to the parse context? */
-		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
+		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
+			if (evsel__is_hybrid_event(ev) && pmu_name &&
+			    strcmp(pmu_name, ev->pmu_name)) {
+				continue;
+                        }
 			metric_events[matched_events++] = ev;
+		}
 
 		if (matched_events == events_to_match)
 			break;
@@ -323,7 +330,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 		evsel = find_evsel_group(perf_evlist, &m->pctx,
 					 metric_no_merge,
 					 m->has_constraint, metric_events,
-					 evlist_used);
+					 evlist_used, m->pmu_name);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					m->metric_name, m->metric_expr);
@@ -684,7 +691,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 }
 
 static void metricgroup__add_metric_weak_group(struct strbuf *events,
-					       struct expr_parse_ctx *ctx)
+					       struct expr_parse_ctx *ctx,
+					       const char *pmu_name)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -708,6 +716,8 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 	}
 	if (!no_group) {
 		strbuf_addf(events, "}:W");
+		if (pmu_name)
+			strbuf_addf(events, "#%s", pmu_name);
 		if (has_duration)
 			strbuf_addf(events, ",duration_time");
 	} else if (has_duration)
@@ -801,6 +811,7 @@ static int __add_metric(struct list_head *metric_list,
 		m->metric_name = pe->metric_name;
 		m->metric_expr = pe->metric_expr;
 		m->metric_unit = pe->unit;
+		m->pmu_name = pe->pmu;
 		m->runtime = runtime;
 		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 		INIT_LIST_HEAD(&m->metric_refs);
@@ -1084,7 +1095,8 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *metric_list,
-				   struct pmu_events_map *map)
+				   struct pmu_events_map *map,
+				   const char *pmu_name)
 {
 	struct expr_ids ids = { .cnt = 0, };
 	struct pmu_event *pe;
@@ -1097,6 +1109,9 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		has_match = true;
 		m = NULL;
 
+		if (pmu_name && pe->pmu && strcmp(pmu_name, pe->pmu))
+			continue;
+
 		ret = add_metric(&list, pe, metric_no_group, &m, NULL, &ids);
 		if (ret)
 			goto out;
@@ -1142,7 +1157,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 							  &m->pctx);
 		} else {
 			metricgroup__add_metric_weak_group(events,
-							   &m->pctx);
+							   &m->pctx,
+							   m->pmu_name);
 		}
 	}
 
@@ -1159,7 +1175,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
 					struct list_head *metric_list,
-					struct pmu_events_map *map)
+					struct pmu_events_map *map,
+					const char *pmu_name)
 {
 	char *llist, *nlist, *p;
 	int ret = -EINVAL;
@@ -1174,7 +1191,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      metric_list, map);
+					      metric_list, map, pmu_name);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -1211,6 +1228,172 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
 	}
 }
 
+static char *get_metric_pmus(char *ostr, struct strbuf *metrc_pmus,
+			     bool *pmus_inited)
+{
+	char *llist, *nlist, *p1, *p2, *new_str;
+	struct strbuf new_events;
+
+	*pmus_inited = false;
+	if (!strchr(ostr, '#')) {
+		/*
+		 * pmu name is added after '#'. If no '#' found,
+		 * don't need to process pmu.
+		 */
+		return strdup(ostr);
+	}
+
+	nlist = strdup(ostr);
+	if (!nlist)
+		return NULL;
+
+	strbuf_init(&new_events, 100);
+	strbuf_addf(&new_events, "%s", "");
+
+	strbuf_init(metrc_pmus, 100);
+	strbuf_addf(metrc_pmus, "%s", "");
+	*pmus_inited = true;
+
+	llist = nlist;
+	while ((p1 = strsep(&llist, ",")) != NULL) {
+		p2 = strchr(p1, '#');
+		if (p2) {
+			*p2 = 0;
+			strbuf_addf(&new_events, "%s,", p1);
+			strbuf_addf(metrc_pmus, "%s,", p2 + 1);
+		} else {
+			strbuf_addf(&new_events, "%s,", p1);
+		}
+	}
+
+	new_str = strdup(new_events.buf);
+	if (new_str) {
+		/* Remove last ',' */
+		new_str[strlen(new_str) - 1] = 0;
+	}
+
+	free(nlist);
+	strbuf_release(&new_events);
+	return new_str;
+}
+
+static void set_pmu_unmatched_events(struct evlist *evlist, int group_idx,
+				     char *pmu_name,
+				     unsigned long *evlist_removed)
+{
+	struct evsel *evsel, *pos;
+	int i = 0, j = 0;
+
+	/*
+	 * Move to the first evsel of a given group
+	 */
+	evlist__for_each_entry (evlist, evsel) {
+		if (evsel__is_group_leader(evsel) &&
+		    evsel->core.nr_members >= 1) {
+			if (i < group_idx) {
+				j += evsel->core.nr_members;
+				i++;
+				continue;
+			} else
+				break;
+		}
+	}
+
+	i = 0;
+	evlist__for_each_entry (evlist, evsel) {
+		if (i < j) {
+			i++;
+			continue;
+		}
+
+		/*
+		 * Now we are at the first evsel in the group
+		 */
+		for_each_group_evsel(pos, evsel) {
+			if (evsel__is_hybrid_event(pos) &&
+			    strcmp(pos->pmu_name, pmu_name)) {
+				set_bit(pos->idx, evlist_removed);
+			}
+		}
+		break;
+	}
+}
+
+static void remove_pmu_umatched_events(struct evlist *evlist, char *metric_pmus)
+{
+	struct evsel *evsel, *tmp, *new_leader = NULL;
+	unsigned long *evlist_removed;
+	char *llist, *nlist, *p1;
+	bool need_new_leader = false;
+	int i = 0, new_nr_members = 0;
+
+	nlist = strdup(metric_pmus);
+	if (!nlist)
+		return;
+
+	evlist_removed = bitmap_alloc(evlist->core.nr_entries);
+	if (!evlist_removed) {
+		free(nlist);
+		return;
+	}
+
+	llist = nlist;
+	while ((p1 = strsep(&llist, ",")) != NULL) {
+		if (strlen(p1) > 0) {
+			/*
+			 * p1 points to the string of pmu name, e.g. "cpu_atom".
+			 * The metric group string has pmu suffixes, e.g.
+			 * "{inst_retired.any,cpu_clk_unhalted.thread}:W#cpu_core,
+			 *  {cpu_clk_unhalted.core,inst_retired.any_p}:W#cpu_atom"
+			 * By counting the pmu name, we can know the index of
+			 * group.
+			 */
+			set_pmu_unmatched_events(evlist, i++, p1, evlist_removed);
+		}
+	}
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (test_bit(evsel->idx, evlist_removed)) {
+			if (!evsel__is_group_leader(evsel)) {
+				if (!need_new_leader) {
+					if (new_leader)
+						new_leader->leader->core.nr_members--;
+					else
+						evsel->leader->core.nr_members--;
+				} else
+					new_nr_members--;
+			} else {
+				/*
+				 * If group leader is to remove, we need to
+				 * prepare a new leader and adjust all group
+				 * members.
+				 */
+				need_new_leader = true;
+				new_nr_members = evsel->leader->core.nr_members - 1;
+			}
+
+			evlist__remove(evlist, evsel);
+			evsel__delete(evsel);
+		} else {
+			if (!evsel__is_group_leader(evsel)) {
+				if (need_new_leader) {
+					need_new_leader = false;
+					new_leader = evsel;
+					new_leader->leader = new_leader;
+					new_leader->core.nr_members = new_nr_members;
+				} else if (new_leader)
+					evsel->leader = new_leader;
+			} else {
+				need_new_leader = false;
+				new_leader = NULL;
+			}
+		}
+	}
+
+	bitmap_free(evlist_removed);
+	free(nlist);
+}
+
 static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
@@ -1219,28 +1402,43 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			struct pmu_events_map *map)
 {
 	struct parse_events_error parse_error;
-	struct strbuf extra_events;
+	struct strbuf extra_events, metric_pmus;
 	LIST_HEAD(metric_list);
 	int ret;
+	char *nlist;
+	bool pmus_inited = false;
 
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &metric_list, map);
+					   &extra_events, &metric_list, map,
+					   perf_evlist->pmu_name);
 	if (ret)
 		goto out;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
+	nlist = get_metric_pmus(extra_events.buf, &metric_pmus, &pmus_inited);
+	if (!nlist)
+		return -1;
+
+	ret = __parse_events(perf_evlist, nlist, &parse_error, fake_pmu);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
+		free(nlist);
 		goto out;
 	}
+
+        if (pmus_inited)
+                remove_pmu_umatched_events(perf_evlist, metric_pmus.buf);
+
+	free(nlist);
 	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
 	metricgroup__free_metrics(&metric_list);
 	strbuf_release(&extra_events);
+	if (pmus_inited)
+		strbuf_release(&metric_pmus);
 	return ret;
 }
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 583ae4f..961d5ac 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -565,7 +565,10 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
 		    evsel__is_clock(alias) != evsel__is_clock(counter) ||
-		    !strcmp(alias->pmu_name, counter->pmu_name))
+		    !strcmp(alias->pmu_name, counter->pmu_name) ||
+		    (evsel__is_hybrid_event(alias) &&
+		     evsel__is_hybrid_event(counter) &&
+		     strcmp(alias->pmu_name, counter->pmu_name)))
 			break;
 		alias->merged_stat = true;
 		cb(config, alias, data, false);
-- 
2.7.4

