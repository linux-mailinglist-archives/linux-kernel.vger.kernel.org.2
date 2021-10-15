Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8706742FA02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhJORYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242203AbhJORYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B368C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so11972834yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=67hrvxKmrEDoqY7ODAkkr1wTsxlPv5mHbdDtZjdw+GU=;
        b=f8kHxmedhO1R0K+9i6GOG0nuTd/sZDlgQIJvloglT6tyhgWNOkF4XCKl0L5LgHvCPb
         yKPW1UewXpabhw6SOgCWOteyOFuZ4V+r2U1k2eQVlDBRm+PHMFdNpb3WxZu8VH2QGgOz
         knifoARFvFbQJ0LDrglIAzxXRHsrA01fIa+Dn6nZ3BA0W1n4/4j0UWDKRquFbfrHhpdX
         GNci2yp7yy834uaJY7SR2bXmaaFMOUys5lDt3r2TXNKPvsSmoPgN1Yet9BQTm2FtGXI+
         pYnkr+s5Nxhu0HQYu5D/tKpL95ZACuY8NR+AtunmHHemCCxgd1EofVkRGQnNXSApjhWQ
         8THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=67hrvxKmrEDoqY7ODAkkr1wTsxlPv5mHbdDtZjdw+GU=;
        b=T/PwDCqC4uj1QZV2f/+ySBC/SB9TglD4b5GWQGoEn3EItG/3uL0DQdG+MB6YX/Rcqd
         vgG1lNf6jRuKFwanpJZ4iK/nrIGc9ur4dVdRwQbqnkTjTh6iWANJSAcm5csOcn+h07pG
         p719+Xig/x1+ukosiK/jH/Tw2K5O0O3Y8pYI1+4rahf7U1fnvQc55HcAcP7yB6aYZLNL
         lmoGnYUD+YDiSRuP69mRsnv4tPUYf/4LGz+nhPvyhaKSIBt800GY0nNRbHPpX4itf1yq
         vcWF+dY3wQgt3WAiDEbR8TLfIxKFGbNaNKEhOwQQ+23dWFHeRTWUE8PC1PYTxrHrQ3Uj
         tQTw==
X-Gm-Message-State: AOAM531aVXuT1xSCp9v7rMjCNggmvR8gAscAeCIqOgm4mNQzQtQlysgh
        O8s/Qvr1A6m7NHgTMcUPS8zPSZyftTFm
X-Google-Smtp-Source: ABdhPJxVuaFBPGvUhQX3ywGL8Ota2VOz2dm/cwh9fgnnj0a24LL+KC6Pvk5+bJ1e2kvpmK19vj2La9Hz6zn8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:c907:: with SMTP id
 z7mr15292249ybf.172.1634318512696; Fri, 15 Oct 2021 10:21:52 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:17 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-7-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 06/21] perf metric: Add documentation and rename a variable.
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

Documentation to make current functionality clearer. Rename a variable
called 'metric' to 'metric_name' as it can be ambiguous as to whether a
string is the name of a metric or the expression.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 59 ++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 139f4a793f92..3e5f02938452 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -776,13 +776,27 @@ int __weak arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused)
 
 struct metricgroup_add_iter_data {
 	struct list_head *metric_list;
-	const char *metric;
+	const char *metric_name;
 	struct expr_ids *ids;
 	int *ret;
 	bool *has_match;
 	bool metric_no_group;
 };
 
+/**
+ * __add_metric - Add a metric to metric_list.
+ * @metric_list: The list the metric is added to.
+ * @pe: The pmu_event containing the metric to be added.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @runtime: A special argument for the parser only known at runtime.
+ * @mp: The pointer to a location holding the first metric added to metric
+ *      list. It is initialized here if this is the first metric.
+ * @parent: The last entry in a linked list of metrics being
+ *          added/resolved. This is maintained to detect recursion.
+ * @ids: Storage for parent list.
+ */
 static int __add_metric(struct list_head *metric_list,
 			const struct pmu_event *pe,
 			bool metric_no_group,
@@ -1076,7 +1090,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	struct metric *m = NULL;
 	int ret;
 
-	if (!match_pe_metric(pe, d->metric))
+	if (!match_pe_metric(pe, d->metric_name))
 		return 0;
 
 	ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
@@ -1095,7 +1109,22 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 	return ret;
 }
 
-static int metricgroup__add_metric(const char *metric, bool metric_no_group,
+/**
+ * metricgroup__add_metric - Find and add a metric, or a metric group.
+ * @metric_name: The name of the metric or metric group. For example, "IPC"
+ *               could be the name of a metric and "TopDownL1" the name of a
+ *               metric group.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @events: an out argument string of events that need to be parsed and
+ *          associated with the metric. For example, the metric "IPC" would
+ *          create an events string like "{instructions,cycles}:W".
+ * @metric_list: The list that the metric or metric group are added to.
+ * @map: The map that is searched for metrics, most commonly the table for the
+ *       architecture perf is running upon.
+ */
+static int metricgroup__add_metric(const char *metric_name, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *metric_list,
 				   const struct pmu_events_map *map)
@@ -1107,7 +1136,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	int i, ret;
 	bool has_match = false;
 
-	map_for_each_metric(pe, i, map, metric) {
+	/*
+	 * Iterate over all metrics seeing if metric matches either the name or
+	 * group. When it does add the metric to the list.
+	 */
+	map_for_each_metric(pe, i, map, metric_name) {
 		has_match = true;
 		m = NULL;
 
@@ -1130,7 +1163,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 			.fn = metricgroup__add_metric_sys_event_iter,
 			.data = (void *) &(struct metricgroup_add_iter_data) {
 				.metric_list = &list,
-				.metric = metric,
+				.metric_name = metric_name,
 				.metric_no_group = metric_no_group,
 				.ids = &ids,
 				.has_match = &has_match,
@@ -1169,6 +1202,22 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	return ret;
 }
 
+/**
+ * metricgroup__add_metric_list - Find and add metrics, or metric groups,
+ *                                specified in a list.
+ * @list: the list of metrics or metric groups. For example, "IPC,CPI,TopDownL1"
+ *        would match the IPC and CPI metrics, and TopDownL1 would match all
+ *        the metrics in the TopDownL1 group.
+ * @metric_no_group: Should events written to events be grouped "{}" or
+ *                   global. Grouping is the default but due to multiplexing the
+ *                   user may override.
+ * @events: an out argument string of events that need to be parsed and
+ *          associated with the metric. For example, the metric "IPC" would
+ *          create an events string like "{instructions,cycles}:W".
+ * @metric_list: The list that metrics are added to.
+ * @map: The map that is searched for metrics, most commonly the table for the
+ *       architecture perf is running upon.
+ */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
 					struct list_head *metric_list,
-- 
2.33.0.1079.g6e70778dc9-goog

