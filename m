Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0B41598A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhIWHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbhIWHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:28 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02071C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:57 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a15-20020a0ce34f000000b0037a944f655dso19473084qvm.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ckzNFSPhfMA1t2Vi+glRHyKBCNdGUUQPx2P62c7a3Pk=;
        b=YaQdZt3YA1jM/y5clFFzJ7uNaeJZAWRwrKJksSH2O73boqL6fSsuUVSvqsZOZImsE1
         qtu79uerhUGvUkMFaPVMY/s8q9I3vR8wYCp/eIsgYP6nzlCg50FBZ/07Z9L9TrSc7fdH
         +NsznAlMiWf36ypoFY/c1QAcAJv08q2IrRs5ixF58R4SQu+u3dlxRfofDSvT3O5zMDmY
         OZb59WF2zAiurNspoLXGyREPZ7z8PIYar47Lg9rL8qhveVPVwJKNdzJ51E2j4krOXLd0
         4Oagub7FFfRF3AU4vO9548Say8c5DsYcuew9pPppJBhA052Tt2yc2H1NN2azEwbt7PsX
         TWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ckzNFSPhfMA1t2Vi+glRHyKBCNdGUUQPx2P62c7a3Pk=;
        b=0akbRupd2754/do2wJJSqVKE0H2VlmlxVXPTRFniiyFxaNcFXohAo1YXrimTYYpwtK
         KRDSeWUHrBkGCWkXPxanpeddtw8K1dROaxXNcRxdqKfWVKjEiNhkcSu8zJGD5tqlN3ot
         qJ7KIRAVYPggaCocL59HvnLqhNloypEn7fTe4KISVlLHNdV/cRKD4G/jHXqzVgwaVOyh
         aNgbS1ti6XaG/lQ3mct8xQ0hHD16QNLLt6Z0Hnmw6h9VCs7HBp7xlbGPN3m3njTRsQqz
         P91rRNTPAMoIIWjTQk/TcBp+1WyW66D/hgclPzGEJ4jbdZs4p/kSPMPsuTw+JrpUwMsZ
         xG/g==
X-Gm-Message-State: AOAM532CqihNVtkP/2DlrKLAEoGmGpgp6hsDA2C3iwHXRzVxaO/tKqY2
        1wiT1h1f6o+HbmZBJat4hm7h33v6L++2
X-Google-Smtp-Source: ABdhPJyukwSMjGlIX3tj0oeFm+6PzQNv6WaTMWrH51CZpJ0d1Mj+sLFI9jj113EccQEN2HnZKunhsVRocdjJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:6148:: with SMTP id
 v69mr3894156ybb.151.1632383216120; Thu, 23 Sep 2021 00:46:56 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:12 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-10-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 09/13] perf metric: Allow metrics with no events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric may be a constant value, for example, some SMT metrics are
constant 0 if #smt_on is 0. If we eliminate all the events then there is
no printing. Fix this by forcing metrics like this to have a
duration_time tool event, previously the metric would fail when parsing
the events with a parse error.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 109 ++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 046fb3fe1700..34956977e907 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -198,65 +198,69 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	struct evsel *ev, *current_leader = NULL;
 	struct expr_id_data *val_ptr;
 	int i = 0, matched_events = 0, events_to_match;
-	const int idnum = (int)hashmap__size(pctx->ids);
+	int idnum = (int)hashmap__size(pctx->ids);
 
-	/*
-	 * duration_time is always grouped separately, when events are grouped
-	 * (ie has_constraint is false) then ignore it in the matching loop and
-	 * add it to metric_events at the end.
-	 */
-	if (!has_constraint &&
-	    hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
-		events_to_match = idnum - 1;
-	else
-		events_to_match = idnum;
-
-	evlist__for_each_entry (perf_evlist, ev) {
+	if (idnum != 0) {
 		/*
-		 * Events with a constraint aren't grouped and match the first
-		 * events available.
+		 * duration_time is always grouped separately, when events are
+		 * grouped (ie has_constraint is false) then ignore it in the
+		 * matching loop and add it to metric_events at the end.
 		 */
-		if (has_constraint && ev->weak_group)
-			continue;
-		/* Ignore event if already used and merging is disabled. */
-		if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
-			continue;
-		if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
+		events_to_match = idnum;
+		if (!has_constraint && hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
+			events_to_match--;
+
+		evlist__for_each_entry(perf_evlist, ev) {
+			/*
+			 * Events with a constraint aren't grouped and match the
+			 * first events available.
+			 */
+			if (has_constraint && ev->weak_group)
+				continue;
+			/* Ignore event if already used and merging is disabled. */
+			if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
+				continue;
+			if (!has_constraint && !evsel__has_leader(ev, current_leader)) {
+				/*
+				 * Start of a new group, discard the whole match
+				 * and start again.
+				 */
+				matched_events = 0;
+				memset(metric_events, 0, sizeof(struct evsel *) * idnum);
+				current_leader = evsel__leader(ev);
+			}
 			/*
-			 * Start of a new group, discard the whole match and
-			 * start again.
+			 * Check for duplicate events with the same name. For
+			 * example, uncore_imc/cas_count_read/ will turn into 6
+			 * events per socket on skylakex. Only the first such
+			 * event is placed in metric_events. If events aren't
+			 * grouped then this also ensures that the same event in
+			 * different sibling groups aren't both added to
+			 * metric_events.
 			 */
-			matched_events = 0;
-			memset(metric_events, 0,
-				sizeof(struct evsel *) * idnum);
-			current_leader = evsel__leader(ev);
+			if (contains_event(metric_events, matched_events, ev->name))
+				continue;
+			/* Does this event belong to the parse context? */
+			if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
+				metric_events[matched_events++] = ev;
+
+			if (matched_events == events_to_match)
+				break;
 		}
+	} else {
 		/*
-		 * Check for duplicate events with the same name. For example,
-		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
-		 * on skylakex. Only the first such event is placed in
-		 * metric_events. If events aren't grouped then this also
-		 * ensures that the same event in different sibling groups
-		 * aren't both added to metric_events.
+		 * There are no events to match, but we need to associate the
+		 * metric with an event for printing. A duration_time event was
+		 * parsed for this.
 		 */
-		if (contains_event(metric_events, matched_events, ev->name))
-			continue;
-		/* Does this event belong to the parse context? */
-		if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
-			metric_events[matched_events++] = ev;
-
-		if (matched_events == events_to_match)
-			break;
+		idnum = 1;
+		events_to_match = 0;
 	}
-
 	if (events_to_match != idnum) {
 		/* Add the first duration_time. */
-		evlist__for_each_entry(perf_evlist, ev) {
-			if (!strcmp(ev->name, "duration_time")) {
-				metric_events[matched_events++] = ev;
-				break;
-			}
-		}
+		ev = evlist__find_evsel_by_str(perf_evlist, "duration_time");
+		if (ev)
+			metric_events[matched_events++] = ev;
 	}
 
 	if (matched_events != idnum) {
@@ -320,9 +324,10 @@ static int metricgroup__setup_events(struct list_head *groups,
 	list_for_each_entry (m, groups, nd) {
 		struct evsel **metric_events;
 		struct metric_ref *metric_refs = NULL;
+		const size_t ids_size = hashmap__size(m->pctx->ids);
 
 		metric_events = calloc(sizeof(void *),
-				hashmap__size(m->pctx->ids) + 1);
+				ids_size == 0 ? 2 : ids_size + 1);
 		if (!metric_events) {
 			ret = -ENOMEM;
 			break;
@@ -1240,7 +1245,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		goto out;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
+	ret = __parse_events(perf_evlist,
+			extra_events.len > 0
+			? extra_events.buf
+			: "duration_time",
+			&parse_error, fake_pmu);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
-- 
2.33.0.464.g1972c5931b-goog

