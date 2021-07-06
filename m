Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146333BD9F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhGFPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232741AbhGFPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOpmQlI5h4Fk2I5eFc58+NXtZElRb7F5uumjvKfZx3U=;
        b=AqRMRJ2SUdPjB1480qVwSeTjJwS/WhDGK5rvNiGJJEq4Y6lXMtqgR2YaT61eOGFYp7DWFs
        uNY/xXZs7uGHLRePRFoiiuGjHivMyZxuDlsReObMDHWiK+ZKP+bG6nn6Mf9QSL1RCE/axf
        Y2GClgY+piJsY63J85K8JrcecmuLHcc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-kYfdQf_yMQaHjmRxfbQJEw-1; Tue, 06 Jul 2021 11:17:44 -0400
X-MC-Unique: kYfdQf_yMQaHjmRxfbQJEw-1
Received: by mail-wr1-f72.google.com with SMTP id z2-20020a5d4d020000b0290130e19b0ddbso3657009wrt.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOpmQlI5h4Fk2I5eFc58+NXtZElRb7F5uumjvKfZx3U=;
        b=n0zIPJMBiDX5BAXgaswPuQzJjV+HhzepttY7q4eBTmDRm6PDnUnvqM5eb81pMFwp38
         26tBbBnqOkLpN95DWwx3+NmqDbmcUqARfNgmSbvWFNZXiXktvSDJ/1ZmQiP31Vl1+kzA
         W6gQ5TeRJq0+rEfTyAYXXewQNUBHhfUZ/dN2JvcS028skArpac/64Ja9X1UlxWYoW95X
         AmXnLXTiWvfDAlZ5eLSPwsrK0cAGMVZquEq4SJk76Dla7bXQn8GY+flzPWDBKLtC3j5D
         ZUalljlBgFgAEmD0/STXUQlXCUv7Z60cuig6VxuDJIVI3++8/lZ6Gd+/jKiT/fjnKv/F
         lOsA==
X-Gm-Message-State: AOAM533w6zkovGBn6uCn65sFvpOVGGHZYjKUQrdcCp1wUhKH1ihZB/ta
        ErQS/d4dompOtokzg/+6BT30sTpOVMhRLriOF/jH6Zk7LVI89vA4CeyH/Ee7jngw7Fd6zJ/h36c
        tcS5pmGhfwMuW4rlP6qxr7+yU
X-Received: by 2002:adf:b605:: with SMTP id f5mr22556352wre.419.1625584663831;
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7QwnyWtDGr1euiYitV0KsusQCfpn9O/KHd8Nc1oxvOHqwOetCq9HmAYhF9E0dn4ELzf9cQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr22556334wre.419.1625584663684;
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id d24sm3151612wmb.42.2021.07.06.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/7] libperf: Add perf_evlist__set_leader function
Date:   Tue,  6 Jul 2021 17:17:02 +0200
Message-Id: <20210706151704.73662-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the implementation of evlist__set_leader under
the new libperf perf_evlist__set_leader function with
the same functionality and as exported API.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evlist.c                  | 21 +++++++++++++++++++++
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/lib/perf/include/perf/evlist.h     |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/perf/util/evlist.c                 | 19 +------------------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/parse-events.c           |  2 +-
 7 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 68b90bbf0ffb..e37dfad31383 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -642,3 +642,24 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
+
+void __perf_evlist__set_leader(struct list_head *list)
+{
+	struct perf_evsel *evsel, *leader;
+
+	leader = list_entry(list->next, struct perf_evsel, node);
+	evsel = list_entry(list->prev, struct perf_evsel, node);
+
+	leader->nr_members = evsel->idx - leader->idx + 1;
+
+	__perf_evlist__for_each_entry(list, evsel)
+		evsel->leader = leader;
+}
+
+void perf_evlist__set_leader(struct perf_evlist *evlist)
+{
+	if (evlist->nr_entries) {
+		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
+		__perf_evlist__set_leader(&evlist->entries);
+	}
+}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f16fa9877d27..f366dbad6a88 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,4 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
+void __perf_evlist__set_leader(struct list_head *list);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 0a7479dc13bf..9ca399d49bb4 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -46,4 +46,5 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) != NULL;						\
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
+LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index c0c7ceb11060..71468606e8a7 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -45,6 +45,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
 		perf_evlist__next_mmap;
+		perf_evlist__set_leader;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 752f64afd622..47581a237c7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -223,26 +223,9 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	return err;
 }
 
-void __evlist__set_leader(struct list_head *list)
-{
-	struct evsel *evsel, *leader;
-
-	leader = list_entry(list->next, struct evsel, core.node);
-	evsel = list_entry(list->prev, struct evsel, core.node);
-
-	leader->core.nr_members = evsel->core.idx - leader->core.idx + 1;
-
-	__evlist__for_each_entry(list, evsel) {
-		evsel->core.leader = &leader->core;
-	}
-}
-
 void evlist__set_leader(struct evlist *evlist)
 {
-	if (evlist->core.nr_entries) {
-		evlist->core.nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
-		__evlist__set_leader(&evlist->core.entries);
-	}
+	perf_evlist__set_leader(&evlist->core);
 }
 
 int __evlist__add_default(struct evlist *evlist, bool precise)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cb2bf5f4866a..5c22383489ae 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -201,7 +201,6 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 int evlist__create_maps(struct evlist *evlist, struct target *target);
 int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
-void __evlist__set_leader(struct list_head *list);
 void evlist__set_leader(struct evlist *evlist);
 
 u64 __evlist__combined_sample_type(struct evlist *evlist);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f6d77cb44007..e5eae23cfceb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1833,7 +1833,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__evlist__set_leader(list);
+	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
 	leader->group_name = name ? strdup(name) : NULL;
 }
-- 
2.31.1

