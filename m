Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB745655D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKRWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhKRWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:09:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:06:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z3-20020a170903018300b0014224dca4a1so3656010plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bPMPgZzyhDtannpbp/itJXQHsFdPQT97DYPC6FjJqDE=;
        b=IrYK7nDdhdHRuX7dxzYGzNkNKzZ6RXZ7gOErHcf38Hwl7kTRZXT7wNicTi7hGjQyns
         C83SbJUkT8drQXkNgxXOUhhSrNTASMA/1xm9fmkvKE+II89SIwWU7hPSWak5xw5Iu0mD
         euS+ktyORqvWbhMP40+Aqk/fpNsBEUgNMP111ue0lvla+qXY7bifxJlHiiIZcjwGcsFZ
         +37dpSYlYeHfONT/Uq+nkjDxk9KpabhdREMvRWUi0bfMPThfMLdAPJKzlumMtFPKEzX9
         jRbLxc4Vq7tCv1kkq2x6UjNzSlaDmjweXuS1uUtyNjr00qvWeN9+os+AMbtkf0i3gH61
         k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bPMPgZzyhDtannpbp/itJXQHsFdPQT97DYPC6FjJqDE=;
        b=GSzZCNHc3Px9RWn0rYq3XRcT/6Zs094hzsAtJai8O05317Moj17j8cIkrQ0oigHP/Q
         3rlM6yrXDt7+LrAkYcZfs9Iz/9Tg0zbLLSO/Adz1xkJ+1JQwPKg2Bbz1qrejBua7h8rn
         4qZIi4o0pDf8ubDLmoyPlH3RSnMJS+3AXZmIpDXfRwowkt4FmNkceW6z9SyfRxG+UESY
         nK6NO5yrCiuIr2CB7j8GACYJR8V/ZybrkDv5qn49d+JyvghBc6lijfUk2X6lQyKAk145
         BCiAuhR91tWrKebU95w9L7QKa1kSXu6RGD0vWKGVkJgK5rbz0/RdTOSZqXGpOwBCP20n
         Uz3g==
X-Gm-Message-State: AOAM532KCc/Y4kIz0325JdEHcno+li2l+vJE6ltGx/6AYRT9TKopKakT
        kvDTxsHaHH15X2PoEC+EVrpifcSz4Yet
X-Google-Smtp-Source: ABdhPJxmNmmgb0mBdEemGyrSaIXpTYTPoI4yq88XcxPpDGxzzKj1HKzoKhiq3AgVYpMnJKRZIu+GWPWilHsf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3908:af20:80e3:e47])
 (user=irogers job=sendgmr) by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr69556088plb.4.1637273212657; Thu, 18
 Nov 2021 14:06:52 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:06:46 -0800
Message-Id: <20211118220647.2355999-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/2] perf evlist: Allow setting arbitrary leader
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

The leader of a group is the first, but allow it to be an arbitrary
list member so that for Intel topdown events slots may always be the
group leader.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 15 +++++++++------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/parse-events.c           |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e37dfad31383..974da341b8b0 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
 
-void __perf_evlist__set_leader(struct list_head *list)
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *evsel, *leader;
+	struct perf_evsel *first, *last, *evsel;
 
-	leader = list_entry(list->next, struct perf_evsel, node);
-	evsel = list_entry(list->prev, struct perf_evsel, node);
+	first = list_entry(list->next, struct perf_evsel, node);
+	last = list_entry(list->prev, struct perf_evsel, node);
 
-	leader->nr_members = evsel->idx - leader->idx + 1;
+	leader->nr_members = last->idx - first->idx + 1;
 
 	__perf_evlist__for_each_entry(list, evsel)
 		evsel->leader = leader;
@@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
 void perf_evlist__set_leader(struct perf_evlist *evlist)
 {
 	if (evlist->nr_entries) {
+		struct perf_evsel *first = list_entry(evlist->entries.next,
+						struct perf_evsel, node);
+
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f366dbad6a88..6f74269a3ad4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
-void __perf_evlist__set_leader(struct list_head *list);
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..6308ba739d19 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
+	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

