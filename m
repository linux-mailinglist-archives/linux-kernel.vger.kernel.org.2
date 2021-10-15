Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48C42FA13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhJORZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbhJORYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FDC0613E7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v203-20020a25c5d4000000b005bb21580411so11814288ybe.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q/S0JVGUICICnfv2fQSNRmB1yL1ms/A11060L45Gr9I=;
        b=MhFmZ/Uts6khamxHzAgWL1Ouya3zz3MsCNKqeEBs29kx75cISBLRfBUXrIuqoLvkQ8
         8Y8b5//JHmms/HbM77kMSzSAyoq7T4Ml7sSvv00HZrUctwGeScmlDPzXwRJcg9H3VQYj
         9JtlGGiqhQnZOAbMafM0UkILgvaUY4OPbWCuSvVtlhgwWxRH8gCClAgEzUio4mnre/OQ
         PLTLsgoL7ob397o0ST7C8d6Y9g6ItZTfyGDnbIjbKqUS5ToyDPn0LxfEoTd2eWlBJLi7
         xEh7RD4RzOfVUEJBKOBxSj7WXwrnQ02e6QXYU04qPJbUHjxSQLP5DUEl1XnclMH8Ux3M
         9ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q/S0JVGUICICnfv2fQSNRmB1yL1ms/A11060L45Gr9I=;
        b=YZuLne5nS/19gIVqUdncVBWV5pRk2R5lW7XZCL9rPjwfV02mGFHApZwDqUxMbpoeNa
         th5+1OoCtFGvF3b2ecYbCIw1BuJhS7htnR5ADYhjQxqP0fz4FvVpkS7YXRigZY7YhmXf
         xtTeOw/XHkvG7MDQUCdzHlnvUr8b1pRxNiEHWsxOxDbw87oTMQFN/5i6wvohMKKDQrjG
         jhCUi7WiWyoUHflLeAaKouk/juNxWW9pwg5q0eTLpLp+kpMu5cqpk0TlvhDvVARS6mxA
         iFjMbjzUm3R3rdBGC8wmJ7F/rI2/MSUY6TRXvmK8zLI8gtP6AekuCQtBqQERv+1hzu+x
         kUoA==
X-Gm-Message-State: AOAM530yLcs/uyrVNEPKl7VTNjTtSnLErTS2DFcRkOKbtVNXI/rwELbt
        ySwzW3jgyfAc2wHKuaNirt2YupSQNtJM
X-Google-Smtp-Source: ABdhPJykeLI5+ox3zeU+CgovHasIpsssuNMTu+7F5exTIW0lsQsQhJY0wMgatp7s4EqwU1kpRKBV/aDEpDcp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:81c5:: with SMTP id
 n5mr13959950ybm.276.1634318541293; Fri, 15 Oct 2021 10:22:21 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:29 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-19-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 18/21] perf metrics: Modify setup and deduplication
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously find_evsel_group was trying to share events while
mark-sweeping to eliminate unused events, this was complicated and had
issues around uncore events and grouped sharing. This was further
complicated by the event string being created while metrics and metric
groups were being added, with the string affecting the evlist order.
This change moves deduplication before event parsing. Ungrouped events
are placed in a single combined set. Groups are checked to see if an
earlier (larger) group can support their events. As the deduplication
and sharing detection is done on metric IDs before parsing, wildcard
expansion problems with uncore events are avoided. Overall the code is
simpler while working better.

An example of failing to deduplicate can be seen with a list of metrics
like the following, where in the after case multiplexing has been
avoided:

Before:
$ perf stat -M Bad_Speculation,Backend_Bound,Frontend_Bound,Retiring -a sleep 2

 Performance counter stats for 'system wide':

       959,620,872      uops_issued.any           #     0.06 Bad_Speculation          (50.03%)
     2,163,072,261      cycles
                                                  #     0.09 Retiring                 (50.03%)
       735,827,436      uops_retired.retire_slots                                     (50.03%)
        74,676,484      int_misc.recovery_cycles                                      (50.03%)
       987,062,794      uops_issued.any           #     0.50 Backend_Bound            (49.97%)
     2,203,734,187      cycles
                                                  #     0.35 Frontend_Bound           (49.97%)
     3,085,016,091      idq_uops_not_delivered.core                                     (49.97%)
       758,599,232      uops_retired.retire_slots                                     (49.97%)
        75,807,526      int_misc.recovery_cycles                                      (49.97%)

       2.002103760 seconds time elapsed

After:
$ sudo perf stat -M Bad_Speculation,Backend_Bound,Frontend_Bound,Retiring -a sleep 2

 Performance counter stats for 'system wide':

       769,694,676      uops_issued.any           #     0.08 Bad_Speculation
                                                  #     0.41 Backend_Bound
     1,087,548,633      cycles
                                                  #     0.38 Frontend_Bound
                                                  #     0.14 Retiring
     1,642,085,777      idq_uops_not_delivered.core
       603,112,590      uops_retired.retire_slots
        43,787,854      int_misc.recovery_cycles

       2.003844383 seconds time elapsed

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 513 +++++++++++++++++-----------------
 1 file changed, 262 insertions(+), 251 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9c16a956fd2c..988f9e95dded 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -144,6 +144,12 @@ struct metric {
 	 * events won't be grouped.
 	 */
 	bool has_constraint;
+	/**
+	 * Parsed events for the metric. Optional as events may be taken from a
+	 * different metric whose group contains all the IDs necessary for this
+	 * one.
+	 */
+	struct evlist *evlist;
 };
 
 static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
@@ -201,6 +207,7 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	m->pctx->runtime = runtime;
 	m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 	m->metric_refs = NULL;
+	m->evlist = NULL;
 
 	return m;
 }
@@ -224,222 +231,82 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
 	return false;
 }
 
-static bool evsel_same_pmu_or_none(struct evsel *ev1, struct evsel *ev2)
-{
-	if (!ev1->pmu_name || !ev2->pmu_name)
-		return true;
-
-	return !strcmp(ev1->pmu_name, ev2->pmu_name);
-}
-
 /**
- * Find a group of events in perf_evlist that correspond to those from a parsed
- * metric expression. Note, as find_evsel_group is called in the same order as
- * perf_evlist was constructed, metric_no_merge doesn't need to test for
- * underfilling a group.
- * @perf_evlist: a list of events something like: {metric1 leader, metric1
- * sibling, metric1 sibling}:W,duration_time,{metric2 leader, metric2 sibling,
- * metric2 sibling}:W,duration_time
- * @pctx: the parse context for the metric expression.
- * @metric_no_merge: don't attempt to share events for the metric with other
- * metrics.
- * @has_constraint: is there a constraint on the group of events? In which case
- * the events won't be grouped.
- * @metric_events: out argument, null terminated array of evsel's associated
- * with the metric.
- * @evlist_used: in/out argument, bitmap tracking which evlist events are used.
- * @return the first metric event or NULL on failure.
+ * setup_metric_events - Find a group of events in metric_evlist that correspond
+ *                       to the IDs from a parsed metric expression.
+ * @ids: the metric IDs to match.
+ * @metric_evlist: the list of perf events.
+ * @out_metric_events: holds the created metric events array.
  */
-static struct evsel *find_evsel_group(struct evlist *perf_evlist,
-				      struct expr_parse_ctx *pctx,
-				      bool metric_no_merge,
-				      bool has_constraint,
-				      struct evsel **metric_events,
-				      unsigned long *evlist_used)
+static int setup_metric_events(struct hashmap *ids,
+			       struct evlist *metric_evlist,
+			       struct evsel ***out_metric_events)
 {
-	struct evsel *ev, *current_leader = NULL;
-	struct expr_id_data *val_ptr;
+	struct evsel **metric_events;
 	const char *metric_id;
-	int i = 0, matched_events = 0, events_to_match;
-	int idnum = (int)hashmap__size(pctx->ids);
+	struct evsel *ev;
+	size_t ids_size, matched_events, i;
 
-	if (idnum != 0) {
-		/*
-		 * duration_time is always grouped separately, when events are
-		 * grouped (ie has_constraint is false) then ignore it in the
-		 * matching loop and add it to metric_events at the end.
-		 */
-		events_to_match = idnum;
-		if (!has_constraint && hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
-			events_to_match--;
+	*out_metric_events = NULL;
+	ids_size = hashmap__size(ids);
 
-		evlist__for_each_entry(perf_evlist, ev) {
-			/*
-			 * Events with a constraint aren't grouped and match the
-			 * first events available.
-			 */
-			if (has_constraint && ev->weak_group)
-				continue;
-			/* Ignore event if already used and merging is disabled. */
-			if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
-				continue;
-			if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
-				/*
-				 * Start of a new group, discard the whole match
-				 * and start again.
-				 */
-				matched_events = 0;
-				memset(metric_events, 0, sizeof(struct evsel *) * idnum);
-				current_leader = evsel__leader(ev);
-			}
-			/*
-			 * Check for duplicate events with the same name. For
-			 * example, uncore_imc/cas_count_read/ will turn into 6
-			 * events per socket on skylakex. Only the first such
-			 * event is placed in metric_events. If events aren't
-			 * grouped then this also ensures that the same event in
-			 * different sibling groups aren't both added to
-			 * metric_events.
-			 */
-			metric_id = evsel__metric_id(ev);
-			if (contains_metric_id(metric_events, matched_events, metric_id))
-				continue;
-			/* Does this event belong to the parse context? */
-			if (hashmap__find(pctx->ids, metric_id, (void **)&val_ptr))
-				metric_events[matched_events++] = ev;
+	metric_events = calloc(sizeof(void *), ids_size + 1);
+	if (!metric_events)
+		return -ENOMEM;
+
+	matched_events = 0;
+	evlist__for_each_entry(metric_evlist, ev) {
+		struct expr_id_data *val_ptr;
 
-			if (matched_events == events_to_match)
-				break;
-		}
-	} else {
 		/*
-		 * There are no events to match, but we need to associate the
-		 * metric with an event for printing. A duration_time event was
-		 * parsed for this.
+		 * Check for duplicate events with the same name. For
+		 * example, uncore_imc/cas_count_read/ will turn into 6
+		 * events per socket on skylakex. Only the first such
+		 * event is placed in metric_events.
 		 */
-		idnum = 1;
-		events_to_match = 0;
-	}
-	if (events_to_match != idnum) {
-		/* Add the first duration_time. */
-		ev = evlist__find_evsel_by_str(perf_evlist, "duration_time");
-		if (ev)
+		metric_id = evsel__metric_id(ev);
+		if (contains_metric_id(metric_events, matched_events, metric_id))
+			continue;
+		/*
+		 * Does this event belong to the parse context? For
+		 * combined or shared groups, this metric may not care
+		 * about this event.
+		 */
+		if (hashmap__find(ids, metric_id, (void **)&val_ptr)) {
 			metric_events[matched_events++] = ev;
-	}
 
-	if (matched_events != idnum) {
-		/* Not a whole match */
-		return NULL;
+			if (matched_events >= ids_size)
+				break;
+		}
 	}
-
-	metric_events[idnum] = NULL;
-
-	for (i = 0; i < idnum; i++) {
+	if (matched_events < ids_size) {
+		free(metric_events);
+		return -EINVAL;
+	}
+	for (i = 0; i < ids_size; i++) {
 		ev = metric_events[i];
-		/* Don't free the used events. */
-		set_bit(ev->core.idx, evlist_used);
+		ev->collect_stat = true;
+
 		/*
-		 * The metric leader points to the identically named event in
-		 * metric_events.
+		 * The metric leader points to the identically named
+		 * event in metric_events.
 		 */
 		ev->metric_leader = ev;
 		/*
-		 * Mark two events with identical names in the same group (or
-		 * globally) as being in use as uncore events may be duplicated
-		 * for each pmu. Set the metric leader of such events to be the
-		 * event that appears in metric_events.
+		 * Mark two events with identical names in the same
+		 * group (or globally) as being in use as uncore events
+		 * may be duplicated for each pmu. Set the metric leader
+		 * of such events to be the event that appears in
+		 * metric_events.
 		 */
 		metric_id = evsel__metric_id(ev);
-		evlist__for_each_entry_continue(perf_evlist, ev) {
-			/*
-			 * If events are grouped then the search can terminate
-			 * when then group is left.
-			 */
-			if (!has_constraint &&
-			    ev->core.leader != metric_events[i]->core.leader &&
-			    evsel_same_pmu_or_none(evsel__leader(ev), evsel__leader(metric_events[i])))
-				break;
-			if (!strcmp(evsel__metric_id(metric_events[i]), metric_id)) {
-				set_bit(ev->core.idx, evlist_used);
+		evlist__for_each_entry_continue(metric_evlist, ev) {
+			if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
 				ev->metric_leader = metric_events[i];
-			}
-		}
-	}
-
-	return metric_events[0];
-}
-
-static int metricgroup__setup_events(struct list_head *groups,
-				     bool metric_no_merge,
-				     struct evlist *perf_evlist,
-				     struct rblist *metric_events_list)
-{
-	struct metric_event *me;
-	struct metric_expr *expr;
-	int i = 0;
-	int ret = 0;
-	struct metric *m;
-	struct evsel *evsel, *tmp;
-	unsigned long *evlist_used;
-
-	evlist_used = bitmap_zalloc(perf_evlist->core.nr_entries);
-	if (!evlist_used)
-		return -ENOMEM;
-
-	list_for_each_entry (m, groups, nd) {
-		struct evsel **metric_events;
-		const size_t ids_size = hashmap__size(m->pctx->ids);
-
-		metric_events = calloc(sizeof(void *),
-				ids_size == 0 ? 2 : ids_size + 1);
-		if (!metric_events) {
-			ret = -ENOMEM;
-			break;
-		}
-		evsel = find_evsel_group(perf_evlist, m->pctx,
-					 metric_no_merge,
-					 m->has_constraint, metric_events,
-					 evlist_used);
-		if (!evsel) {
-			pr_debug("Cannot resolve %s: %s\n",
-					m->metric_name, m->metric_expr);
-			free(metric_events);
-			continue;
-		}
-		for (i = 0; metric_events[i]; i++)
-			metric_events[i]->collect_stat = true;
-		me = metricgroup__lookup(metric_events_list, evsel, true);
-		if (!me) {
-			ret = -ENOMEM;
-			free(metric_events);
-			break;
-		}
-		expr = malloc(sizeof(struct metric_expr));
-		if (!expr) {
-			ret = -ENOMEM;
-			free(metric_events);
-			break;
-		}
-
-		expr->metric_refs = m->metric_refs;
-		m->metric_refs = NULL;
-		expr->metric_expr = m->metric_expr;
-		expr->metric_name = m->metric_name;
-		expr->metric_unit = m->metric_unit;
-		expr->metric_events = metric_events;
-		expr->runtime = m->pctx->runtime;
-		list_add(&expr->nd, &me->head);
-	}
-
-	evlist__for_each_entry_safe(perf_evlist, tmp, evsel) {
-		if (!test_bit(evsel->core.idx, evlist_used)) {
-			evlist__remove(perf_evlist, evsel);
-			evsel__delete(evsel);
 		}
 	}
-	bitmap_free(evlist_used);
-
-	return ret;
+	*out_metric_events = metric_events;
+	return 0;
 }
 
 static bool match_metric(const char *n, const char *list)
@@ -1222,20 +1089,15 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
- * @events: an out argument string of events that need to be parsed and
- *          associated with the metric. For example, the metric "IPC" would
- *          create an events string like "{instructions,cycles}:W".
  * @metric_list: The list that the metric or metric group are added to.
  * @map: The map that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int metricgroup__add_metric(const char *metric_name, bool metric_no_group,
-				   struct strbuf *events,
 				   struct list_head *metric_list,
 				   const struct pmu_events_map *map)
 {
 	const struct pmu_event *pe;
-	struct metric *m;
 	LIST_HEAD(list);
 	int i, ret;
 	bool has_match = false;
@@ -1269,27 +1131,8 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
 		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
 	}
 	/* End of pmu events. */
-	if (!has_match) {
+	if (!has_match)
 		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Sort metrics from largest to smallest. */
-	list_sort(NULL,  &list, metric_list_cmp);
-
-	list_for_each_entry(m, &list, nd) {
-		if (events->len > 0) {
-			ret = strbuf_addf(events, ",");
-			if (ret)
-				break;
-		}
-
-		ret = metricgroup__build_event_string(events,
-						m->pctx,
-						m->has_constraint);
-		if (ret)
-			break;
-	}
 
 out:
 	/*
@@ -1297,9 +1140,6 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
 	 * even if it's failed
 	 */
 	list_splice(&list, metric_list);
-
-	/* Sort metrics from largest to smallest. */
-	list_sort(NULL, metric_list, metric_list_cmp);
 	return ret;
 }
 
@@ -1312,15 +1152,11 @@ static int metricgroup__add_metric(const char *metric_name, bool metric_no_group
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
- * @events: an out argument string of events that need to be parsed and
- *          associated with the metric. For example, the metric "IPC" would
- *          create an events string like "{instructions,cycles}:W".
  * @metric_list: The list that metrics are added to.
  * @map: The map that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
-					struct strbuf *events,
 					struct list_head *metric_list,
 					const struct pmu_events_map *map)
 {
@@ -1332,13 +1168,9 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 		return -ENOMEM;
 	llist = nlist;
 
-	ret = strbuf_init(events, 100);
-	if (ret)
-		return ret;
-
 	while ((p = strsep(&llist, ",")) != NULL) {
-		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      metric_list, map);
+		ret = metricgroup__add_metric(p, metric_no_group, metric_list,
+					      map);
 		if (ret == -EINVAL)
 			fprintf(stderr, "Cannot find metric or group `%s'\n", p);
 
@@ -1372,41 +1204,220 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
 	}
 }
 
+/**
+ * build_combined_expr_ctx - Make an expr_parse_ctx with all has_constraint
+ *                           metric IDs, as the IDs are held in a set,
+ *                           duplicates will be removed.
+ * @metric_list: List to take metrics from.
+ * @combined: Out argument for result.
+ */
+static int build_combined_expr_ctx(const struct list_head *metric_list,
+				   struct expr_parse_ctx **combined)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+	struct metric *m;
+	char *dup;
+	int ret;
+
+	*combined = expr__ctx_new();
+	if (!*combined)
+		return -ENOMEM;
+
+	list_for_each_entry(m, metric_list, nd) {
+		if (m->has_constraint) {
+			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
+				dup = strdup(cur->key);
+				if (!dup) {
+					ret = -ENOMEM;
+					goto err_out;
+				}
+				ret = expr__add_id(*combined, dup);
+				if (ret)
+					goto err_out;
+			}
+		}
+	}
+	return 0;
+err_out:
+	expr__ctx_free(*combined);
+	*combined = NULL;
+	return ret;
+}
+
+/**
+ * parse_ids - Build the event string for the ids and parse them creating an
+ *             evlist. The encoded metric_ids are decoded.
+ * @fake_pmu: used when testing metrics not supported by the current CPU.
+ * @ids: the event identifiers parsed from a metric.
+ * @has_constraint: false if events should be placed in a weak group.
+ * @out_evlist: the created list of events.
+ */
+static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
+		     bool has_constraint, struct evlist **out_evlist)
+{
+	struct parse_events_error parse_error;
+	struct evlist *parsed_evlist;
+	struct strbuf events = STRBUF_INIT;
+	int ret;
+
+	*out_evlist = NULL;
+	if (hashmap__size(ids->ids) == 0) {
+		char *tmp;
+		/*
+		 * No ids/events in the expression parsing context. Events may
+		 * have been removed because of constant evaluation, e.g.:
+		 *  event1 if #smt_on else 0
+		 * Add a duration_time event to avoid a parse error on an empty
+		 * string.
+		 */
+		tmp = strdup("duration_time");
+		if (!tmp)
+			return -ENOMEM;
+
+		ids__insert(ids->ids, tmp);
+	}
+	ret = metricgroup__build_event_string(&events, ids, has_constraint);
+	if (ret)
+		return ret;
+
+	parsed_evlist = evlist__new();
+	if (!parsed_evlist) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	pr_debug("Parsing metric events '%s'\n", events.buf);
+	bzero(&parse_error, sizeof(parse_error));
+	ret = __parse_events(parsed_evlist, events.buf, &parse_error, fake_pmu);
+	if (ret) {
+		parse_events_print_error(&parse_error, events.buf);
+		goto err_out;
+	}
+	ret = decode_all_metric_ids(parsed_evlist);
+	if (ret)
+		goto err_out;
+
+	*out_evlist = parsed_evlist;
+	parsed_evlist = NULL;
+err_out:
+	evlist__delete(parsed_evlist);
+	strbuf_release(&events);
+	return ret;
+}
+
 static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
 			struct perf_pmu *fake_pmu,
-			struct rblist *metric_events,
+			struct rblist *metric_events_list,
 			const struct pmu_events_map *map)
 {
-	struct parse_events_error parse_error;
-	struct strbuf extra_events;
+	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
+	struct metric *m;
 	int ret;
 
-	if (metric_events->nr_entries == 0)
-		metricgroup__rblist_init(metric_events);
+	if (metric_events_list->nr_entries == 0)
+		metricgroup__rblist_init(metric_events_list);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &metric_list, map);
+					   &metric_list, map);
 	if (ret)
 		goto out;
-	pr_debug("adding %s\n", extra_events.buf);
-	bzero(&parse_error, sizeof(parse_error));
-	ret = __parse_events(perf_evlist, extra_events.len > 0 ? extra_events.buf : "duration_time",
-			     &parse_error, fake_pmu);
-	if (ret) {
-		parse_events_print_error(&parse_error, extra_events.buf);
-		goto out;
+
+	/* Sort metrics from largest to smallest. */
+	list_sort(NULL, &metric_list, metric_list_cmp);
+
+	if (!metric_no_merge) {
+		struct expr_parse_ctx *combined = NULL;
+
+		ret = build_combined_expr_ctx(&metric_list, &combined);
+
+		if (!ret && combined && hashmap__size(combined->ids)) {
+			ret = parse_ids(fake_pmu, combined, /*has_constraint=*/true,
+					&combined_evlist);
+		}
+		if (combined)
+			expr__ctx_free(combined);
+
+		if (ret)
+			goto out;
+	}
+
+	list_for_each_entry(m, &metric_list, nd) {
+		struct metric_event *me;
+		struct evsel **metric_events;
+		struct evlist *metric_evlist = NULL;
+		struct metric *n;
+		struct metric_expr *expr;
+
+		if (combined_evlist && m->has_constraint) {
+			metric_evlist = combined_evlist;
+		} else if (!metric_no_merge) {
+			/*
+			 * See if the IDs for this metric are a subset of an
+			 * earlier metric.
+			 */
+			list_for_each_entry(n, &metric_list, nd) {
+				if (m == n)
+					break;
+
+				if (n->evlist == NULL)
+					continue;
+
+				if (expr__subset_of_ids(n->pctx, m->pctx)) {
+					pr_debug("Events in '%s' fully contained within '%s'\n",
+						 m->metric_name, n->metric_name);
+					metric_evlist = n->evlist;
+					break;
+				}
+
+			}
+		}
+		if (!metric_evlist) {
+			ret = parse_ids(fake_pmu, m->pctx, m->has_constraint,
+					&m->evlist);
+			if (ret)
+				goto out;
+
+			metric_evlist = m->evlist;
+		}
+		ret = setup_metric_events(m->pctx->ids, metric_evlist, &metric_events);
+		if (ret) {
+			pr_debug("Cannot resolve IDs for %s: %s\n",
+				m->metric_name, m->metric_expr);
+			goto out;
+		}
+
+		me = metricgroup__lookup(metric_events_list, metric_events[0], true);
+
+		expr = malloc(sizeof(struct metric_expr));
+		if (!expr) {
+			ret = -ENOMEM;
+			free(metric_events);
+			goto out;
+		}
+
+		expr->metric_refs = m->metric_refs;
+		m->metric_refs = NULL;
+		expr->metric_expr = m->metric_expr;
+		expr->metric_name = m->metric_name;
+		expr->metric_unit = m->metric_unit;
+		expr->metric_events = metric_events;
+		expr->runtime = m->pctx->runtime;
+		list_add(&expr->nd, &me->head);
+	}
+
+
+	if (combined_evlist)
+		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
+
+	list_for_each_entry(m, &metric_list, nd) {
+		if (m->evlist)
+			evlist__splice_list_tail(perf_evlist, &m->evlist->core.entries);
 	}
-	ret = decode_all_metric_ids(perf_evlist);
-	if (ret)
-		goto out;
 
-	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
-					perf_evlist, metric_events);
 out:
 	metricgroup__free_metrics(&metric_list);
-	strbuf_release(&extra_events);
 	return ret;
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

