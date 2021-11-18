Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF67455749
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhKRIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbhKRIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:50:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D4C061764
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:47:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso8552779ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pCS4krbp8/9ryX5JXUbnLD3SMSAP/4yh89FdAPAwBV4=;
        b=PLn1UCXJ/rEZ2BwAsP/Vtu9NEH4ZhjC/sDX+ZInIrsefXPFi/IjGJm/ZlRFj//tghB
         oJq+pp1iRUXJF2/FwdJmL5jfaurgBlU3QLPKH+RasVgq8atyO0+vepj5ifgGvzHfVlyc
         NtWrgo5Hzs/l/cj3wICv+7fl/UxsfUlO0J9A8UvxjdwNGUfK6WN3xvKr8JpBOXJS+WRd
         8liFD31R3ih7wQp+m2sMtT+tFtep1s6dGzxMLV/P9BM2qwFwG24UZEMrlTimZqrqzYJt
         6wl3PK/3WSEXVL4j2SFzuY3JuRGKCmNdV/tBTfhQq5K7/oWozqozbdVyDmDp8f4oFqoF
         jPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pCS4krbp8/9ryX5JXUbnLD3SMSAP/4yh89FdAPAwBV4=;
        b=xU3J9vW9kLjUYdjWz1kGFgQojBP1lYo+gf/9pg+Dg3jKV3cVbkXhtUpuWaTDcQcvG5
         3mcwU5ugbOQVkAk860f4l5RddjGy5D5JMPPU2wauMT8iL8nKBpA9+6gNRr9OSFEmqd71
         EjwSHgHgBvZSW+f0wyxGSi/nBAfsst613jtMnDVFbOxF8UBdhGvciutYJlj0PI9BfxeX
         OO5A3ouBBb6hfJXObT4ytfimuoI9vBt8ngq4I4XbrEvuLutyWiHGLoeU2icp2xs/w4sr
         n+sS7vR8fXC5DCkG1v5qsrU/lBWotnOILyXah4o0YUcqVInxiQWFcdmI9vHCIlwk3Zb+
         4KiQ==
X-Gm-Message-State: AOAM5309bs8XpwmQb2YxED34Geb6CilxRj+C0TiwlusKRjFbY0z8BjfW
        ZXKIRA4nWgSIdTLBObVLBd8JGb/X0TwF
X-Google-Smtp-Source: ABdhPJxXlZxDGG5aR72qlruiig9cf6+euWqg+b8nuX/f9NUvlH4QWB1p2701GKPi6fLzZ4UU0M1bil/Jcz7P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b539:25b3:faf2:d1b3])
 (user=irogers job=sendgmr) by 2002:a25:2503:: with SMTP id
 l3mr19973658ybl.42.1637225276422; Thu, 18 Nov 2021 00:47:56 -0800 (PST)
Date:   Thu, 18 Nov 2021 00:47:49 -0800
Message-Id: <20211118084749.2191447-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] perf evsel: Fix memory leaks relating to unit
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unit may have a strdup pointer or be to a literal, consequently memory
assocciated with it isn't freed. Change it so the unit is always strdup
and so the memory can be safely freed. Fix related issue in
perf_event__process_event_update for name and own_cpus. Leaks were
spotted by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c |  5 ++---
 tools/perf/util/evsel.c         | 18 +++++++++---------
 tools/perf/util/header.c        |  8 +++++---
 tools/perf/util/parse-events.c  |  9 ++++++---
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index fbb68deba59f..d01532d40acb 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -88,7 +88,6 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	struct evsel *evsel;
 	struct event_name tmp;
 	struct evlist *evlist = evlist__new_default();
-	char *unit = strdup("KRAVA");
 
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
@@ -99,7 +98,8 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 
 	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
 
-	evsel->unit = unit;
+	free((char *)evsel->unit);
+	evsel->unit = strdup("KRAVA");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update unit",
 			!perf_event__synthesize_event_update_unit(NULL, evsel, process_event_unit));
@@ -119,7 +119,6 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	free(unit);
 	evlist__delete(evlist);
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a59fb2ecb84e..ac0127be0459 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -241,7 +241,7 @@ void evsel__init(struct evsel *evsel,
 {
 	perf_evsel__init(&evsel->core, attr, idx);
 	evsel->tracking	   = !idx;
-	evsel->unit	   = "";
+	evsel->unit	   = strdup("");
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
@@ -276,13 +276,8 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
 	}
 
 	if (evsel__is_clock(evsel)) {
-		/*
-		 * The evsel->unit points to static alias->unit
-		 * so it's ok to use static string in here.
-		 */
-		static const char *unit = "msec";
-
-		evsel->unit = unit;
+		free((char *)evsel->unit);
+		evsel->unit = strdup("msec");
 		evsel->scale = 1e-6;
 	}
 
@@ -420,7 +415,11 @@ struct evsel *evsel__clone(struct evsel *orig)
 
 	evsel->max_events = orig->max_events;
 	evsel->tool_event = orig->tool_event;
-	evsel->unit = orig->unit;
+	free((char *)evsel->unit);
+	evsel->unit = strdup(orig->unit);
+	if (evsel->unit == NULL)
+		goto out_err;
+
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
@@ -1441,6 +1440,7 @@ void evsel__exit(struct evsel *evsel)
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
 	zfree(&evsel->pmu_name);
+	zfree(&evsel->unit);
 	zfree(&evsel->metric_id);
 	evsel__zero_per_pkg(evsel);
 	hashmap__free(evsel->per_pkg_mask);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fda8d14c891f..79cce216727e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4257,9 +4257,11 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__UNIT:
+		free((char *)evsel->unit);
 		evsel->unit = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__NAME:
+		free(evsel->name);
 		evsel->name = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__SCALE:
@@ -4268,11 +4270,11 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 		break;
 	case PERF_EVENT_UPDATE__CPUS:
 		ev_cpus = (struct perf_record_event_update_cpus *)ev->data;
-
 		map = cpu_map__new_data(&ev_cpus->cpus);
-		if (map)
+		if (map) {
+			perf_cpu_map__put(evsel->core.own_cpus);
 			evsel->core.own_cpus = map;
-		else
+		} else
 			pr_err("failed to get event_update cpus\n");
 	default:
 		break;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a2f4c086986f..12d925a6d27f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -402,8 +402,10 @@ static int add_event_tool(struct list_head *list, int *idx,
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
-	if (tool_event == PERF_TOOL_DURATION_TIME)
-		evsel->unit = "ns";
+	if (tool_event == PERF_TOOL_DURATION_TIME) {
+		free((char *)evsel->unit);
+		evsel->unit = strdup("ns");
+	}
 	return 0;
 }
 
@@ -1630,7 +1632,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (parse_state->fake_pmu)
 		return 0;
 
-	evsel->unit = info.unit;
+	free((char *)evsel->unit);
+	evsel->unit = strdup(info.unit);
 	evsel->scale = info.scale;
 	evsel->per_pkg = info.per_pkg;
 	evsel->snapshot = info.snapshot;
-- 
2.34.0.rc1.387.gb447b232ab-goog

