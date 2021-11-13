Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8418844F1FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhKMHTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 02:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKMHSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 02:18:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8BFC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 23:15:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d9-20020a251d09000000b005c208092922so18386686ybd.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9oeCdIbb0ChQ0ccTxxKgUNT90EB+1NVnPZJWSCLoDCg=;
        b=Q4nPPeDQEwBQzlLPs6cvF0Pq7yWZfNs9NM4+SUndkl++DYth+Z6CB9MpWDIU65nbHG
         He3+VG20vEcvYhk3GM0ql64FoJopt1Ww1w22Gs0SVH3nEVvh95T95p8Omj/zCXs/9AdE
         xfUkP54Jz2BSYs9JO9TBRCmsWsZvB/uQ3H4wfNguAfjPBEe4PfBf6VLoAu3BdzbXUCpI
         X5NsnE1N8QYJ5fKCKj1/rcWu6Gf3O7mpjgXrjDKretWmNG0saksRJ2HqkRo7XjP5aSP3
         G8r+65B9jpwkgHMvcdbkgPXJ9KmSsi3upeBThHVZP2g2K5R3snoCo0ldbgkjMzw0y9sN
         r0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9oeCdIbb0ChQ0ccTxxKgUNT90EB+1NVnPZJWSCLoDCg=;
        b=oONYG7VlZhyGkhjAz+y9/T5qWW5/qhhTPjejoni3eadGS1eaFsvIpUjKszroqM7mtI
         vNhL0gY/tPh3q4zaqyFoZjfrF7UJPe6vbN/L6/vhJSzbDgxlzhpHeqcfogUf0KudKxXv
         1d32XNb9nEBy2onhoIYr9o4/lkHjUXl/2QXymnQ434UBgnxEHYf4niyXWmbxrZow/dV+
         fmK/Dz29TG87/2kPLSrkzvYZvfXz/pfeG56fuHnBNnPurRWFXWLT69E/fW/s332lUlE8
         hirUGjtObL3iaWh9oQdtAGnXADEaXZX+6+sSJz7vzhSFkCWnM7p97KXNUBoZBkU8z2bt
         aWXQ==
X-Gm-Message-State: AOAM532NiOkHlPiLHQVsaoV5zMI4eYp6mXD1A5vBadSfKF7VpBgUk394
        zHJ7gkCoa9ZhWdoHyP7EidWpJwkLEaqy
X-Google-Smtp-Source: ABdhPJxH/qqHn0qagbpbT52hxeFtOfwO/JTXSSEhEUdCc62dL0DZzLdc/R3Rl0f+WTkLsLb0ouSZShRVWgXF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7363:ca3f:1032:5f2d])
 (user=irogers job=sendgmr) by 2002:a25:2493:: with SMTP id
 k141mr22438807ybk.387.1636787755420; Fri, 12 Nov 2021 23:15:55 -0800 (PST)
Date:   Fri, 12 Nov 2021 23:15:48 -0800
In-Reply-To: <20211113071548.372572-1-irogers@google.com>
Message-Id: <20211113071548.372572-2-irogers@google.com>
Mime-Version: 1.0
References: <20211113071548.372572-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 2/2] perf parse-events: Architecture specific leader override
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently topdown events must appear after a slots event:

$ perf stat -e '{slots,topdown-fe-bound}' /bin/true

 Performance counter stats for '/bin/true':

         3,183,090      slots
           986,133      topdown-fe-bound

Reversing the events yields:

$ perf stat -e '{topdown-fe-bound,slots}' /bin/true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).

For metrics the order of events is determined by iterating over a
hashmap, and so slots isn't guaranteed to be first which can yield this
error.

Change the set_leader in parse-events, called when a group is closed, so
that rather than always making the first event the leader, if the slots
event exists then it is made the leader. It is then moved to the head of
the evlist otherwise it won't be opened in the correct order.

The result is:

$ perf stat -e '{topdown-fe-bound,slots}' /bin/true

 Performance counter stats for '/bin/true':

         3,274,795      slots
         1,001,702      topdown-fe-bound

A problem with this approach is the slots event is identified by name,
names can be overwritten like 'cpu/slots,name=foo/' and this causes the
leader change to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
 tools/perf/util/evlist.h          |  1 +
 tools/perf/util/parse-events.c    | 16 +++++++++++-----
 tools/perf/util/parse-events.h    |  4 ++--
 tools/perf/util/parse-events.y    | 12 ++++++++----
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 0b0951030a2f..1624372b2da2 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
 	else
 		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
 }
+
+struct evsel *arch_evlist__leader(struct list_head *list)
+{
+	struct evsel *evsel, *first;
+
+	first = list_entry(list->next, struct evsel, core.node);
+
+	if (!pmu_have_event("cpu", "slots"))
+		return first;
+
+	__evlist__for_each_entry(list, evsel) {
+		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
+			evsel->name && strstr(evsel->name, "slots"))
+			return evsel;
+	}
+	return first;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..993437ffe429 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
 	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
 
 int arch_evlist__add_default_attrs(struct evlist *evlist);
+struct evsel *arch_evlist__leader(struct list_head *list);
 
 int evlist__add_dummy(struct evlist *evlist);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6308ba739d19..a2f4c086986f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1821,22 +1821,28 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	return ret;
 }
 
-void parse_events__set_leader(char *name, struct list_head *list,
-			      struct parse_events_state *parse_state)
+__weak struct evsel *arch_evlist__leader(struct list_head *list)
+{
+	return list_entry(list->next, struct evsel, core.node);
+}
+
+struct list_head *parse_events__set_leader(char *name, struct list_head *list,
+					struct parse_events_state *parse_state)
 {
 	struct evsel *leader;
 
 	if (list_empty(list)) {
 		WARN_ONCE(true, "WARNING: failed to set leader: empty list");
-		return;
+		return NULL;
 	}
 
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
-		return;
+		return NULL;
 
-	leader = list_entry(list->next, struct evsel, core.node);
+	leader = arch_evlist__leader(list);
 	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
+	return &leader->core.node;
 }
 
 /* list_event is assumed to point to malloc'ed memory */
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c7fc93f54577..8a6e6b4d5cbe 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -211,8 +211,8 @@ int parse_events_copy_term_list(struct list_head *old,
 
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
-void parse_events__set_leader(char *name, struct list_head *list,
-			      struct parse_events_state *parse_state);
+struct list_head *parse_events__set_leader(char *name, struct list_head *list,
+					struct parse_events_state *parse_state);
 void parse_events_update_lists(struct list_head *list_event,
 			       struct list_head *list_all);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 174158982fae..5358c400f938 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -199,20 +199,24 @@ group_def
 group_def:
 PE_NAME '{' events '}'
 {
-	struct list_head *list = $3;
+	struct list_head *new_head, *list = $3;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader($1, list, _parse_state);
+	new_head = parse_events__set_leader($1, list, _parse_state);
+	if (new_head)
+		list_move(new_head, list);
 	free($1);
 	$$ = list;
 }
 |
 '{' events '}'
 {
-	struct list_head *list = $2;
+	struct list_head *new_head, *list = $2;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader(NULL, list, _parse_state);
+	new_head = parse_events__set_leader(NULL, list, _parse_state);
+	if (new_head)
+		list_move(new_head, list);
 	$$ = list;
 }
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

