Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9F45655E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKRWJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhKRWJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:09:55 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:06:55 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y68-20020a627d47000000b004a2f6a1551cso4373488pfc.23
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=15vK3w6kVsi35qUgo9TnyNCHCk/lhrs5f4fJYNnqTrA=;
        b=mtF5Ibzr4JLin4CBGfDSu8JrQgbYhOvkhd9D4XmvCYqCqWQOAFTdKva2et7OooSpdW
         lX99NfB3cOa3k8xp7KzIXuq9ru19OYsZw8cn6gNrsrSdb8WgDarVXAoQV03ssnGczhcC
         ngVIq2hhK6iLoyE6wwXdMlRFZCeJZMn5i7fYYp7QjoTVgQXBukS0vqHq9FB0aDEW76XY
         LgAevxmJAwUUMQSzT5X2vPEtUFcAvSgWbtsh/EACeJL4mC5PtDdn8eTUi54s1UXooXo7
         1IwFgwvcQdku10V9GxdX74xnTQNk+1tEDUS4LmMqDocHX9Pm3N0zSksSg5S7X7KHe7Nb
         pt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=15vK3w6kVsi35qUgo9TnyNCHCk/lhrs5f4fJYNnqTrA=;
        b=TSNGi3cwK4hi+U9ARACyqh7tF3RztKqWJJN3P96Oi6lG0THNiu/57EY2UeIZ7JWrfj
         riBmj0dSvylFXK9uTOue3LhdO12rnpaAsUBN2mCYydt7sfpGVyfsJhYrMRfm/YsxRP1c
         E0RQ4keBgudbiDUq1lE/hhDHt52U0lo/s3Qs5Qs0LcoKE610eepMfxj45dekY2ukvjDL
         tNOUlFoWCRgoZUVXyo67e8lTG1iXXcqMFbwn/6QvdQF/BmGudrqdGi/asGkU7nzF/0Ee
         Jd6n+2veCXLE5E5+oJC18lRtSa2WV/h84RRpsF8gXmO7x6+hX9Ob9jZ4yDU5JftnttwW
         XXtg==
X-Gm-Message-State: AOAM531RofxoOaf7F6/2BRGDFuDVuTLTBJEGHiAYvbInstTOTqcXXlt5
        xctIF5Earb2bNhqRSvI3VL8J6fxI0Ly8
X-Google-Smtp-Source: ABdhPJzIO84r0IPlTSl+DanDRIyhWJNUHxaFviOiKc0vnq1F3X4h1rPCApHEGRZt0O8e1g3hW9Mi4l+iansO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3908:af20:80e3:e47])
 (user=irogers job=sendgmr) by 2002:a17:902:d28a:b0:142:61ce:ae4c with SMTP id
 t10-20020a170902d28a00b0014261ceae4cmr69930101plc.35.1637273214703; Thu, 18
 Nov 2021 14:06:54 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:06:47 -0800
In-Reply-To: <20211118220647.2355999-1-irogers@google.com>
Message-Id: <20211118220647.2355999-2-irogers@google.com>
Mime-Version: 1.0
References: <20211118220647.2355999-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 2/2] perf parse-events: Architecture specific leader override
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>
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

The change also modifies and fixes mixed groups like, with the change:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

        5574985410      slots
         971981616      instructions
        1348461887      topdown-fe-bound

       2.001263120 seconds time elapsed

Without the change:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2

 Performance counter stats for 'system wide':

     <not counted>      instructions
     <not counted>      slots
   <not supported>      topdown-fe-bound

       2.006247990 seconds time elapsed

Something that may be undesirable here is that the events are reordered
in the output.

v2. Move the list_move operation into parse_events__set_leader as
    suggested by Jiri Olsa <jolsa@redhat.com>.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
 tools/perf/util/evlist.h          |  1 +
 tools/perf/util/parse-events.c    |  8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index 6308ba739d19..774c163eae9c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1821,6 +1821,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	return ret;
 }
 
+__weak struct evsel *arch_evlist__leader(struct list_head *list)
+{
+	return list_entry(list->next, struct evsel, core.node);
+}
+
 void parse_events__set_leader(char *name, struct list_head *list,
 			      struct parse_events_state *parse_state)
 {
@@ -1834,9 +1839,10 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	leader = list_entry(list->next, struct evsel, core.node);
+	leader = arch_evlist__leader(list);
 	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
+	list_move(&leader->core.node, list);
 }
 
 /* list_event is assumed to point to malloc'ed memory */
-- 
2.34.0.rc2.393.gf8c9666880-goog

