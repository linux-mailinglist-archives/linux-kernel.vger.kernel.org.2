Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472A24055FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359248AbhIINQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:16:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:22220 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350321AbhIINBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:01:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306348697"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="306348697"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 05:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="479645342"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2021 05:54:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Factor out copy_config_terms() and free_config_terms()
Date:   Thu,  9 Sep 2021 15:55:07 +0300
Message-Id: <20210909125508.28693-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909125508.28693-1-adrian.hunter@intel.com>
References: <20210909125508.28693-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out copy_config_terms() and free_config_terms() so that they can
be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evsel.c        | 20 +++++++++++++++-----
 tools/perf/util/evsel.h        |  3 +++
 tools/perf/util/parse-events.c |  9 +--------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 54d251327b5b..dbfeceb2546c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -333,11 +333,11 @@ struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config)
 	goto out;
 }
 
-static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
+int copy_config_terms(struct list_head *dst, struct list_head *src)
 {
 	struct evsel_config_term *pos, *tmp;
 
-	list_for_each_entry(pos, &src->config_terms, list) {
+	list_for_each_entry(pos, src, list) {
 		tmp = malloc(sizeof(*tmp));
 		if (tmp == NULL)
 			return -ENOMEM;
@@ -350,11 +350,16 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
 				return -ENOMEM;
 			}
 		}
-		list_add_tail(&tmp->list, &dst->config_terms);
+		list_add_tail(&tmp->list, dst);
 	}
 	return 0;
 }
 
+static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
+{
+	return copy_config_terms(&dst->config_terms, &src->config_terms);
+}
+
 /**
  * evsel__clone - create a new evsel copied from @orig
  * @orig: original evsel
@@ -1385,11 +1390,11 @@ int evsel__disable(struct evsel *evsel)
 	return err;
 }
 
-static void evsel__free_config_terms(struct evsel *evsel)
+void free_config_terms(struct list_head *config_terms)
 {
 	struct evsel_config_term *term, *h;
 
-	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
+	list_for_each_entry_safe(term, h, config_terms, list) {
 		list_del_init(&term->list);
 		if (term->free_str)
 			zfree(&term->val.str);
@@ -1397,6 +1402,11 @@ static void evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
+static void evsel__free_config_terms(struct evsel *evsel)
+{
+	free_config_terms(&evsel->config_terms);
+}
+
 void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1b3eeab5f188..1f7edfa8568a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -213,6 +213,9 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 struct evsel *evsel__clone(struct evsel *orig);
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
 
+int copy_config_terms(struct list_head *dst, struct list_head *src);
+void free_config_terms(struct list_head *config_terms);
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e5eae23cfceb..ded5808798f9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1608,14 +1608,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	}
 
 	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
-		struct evsel_config_term *pos, *tmp;
-
-		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
-			list_del_init(&pos->list);
-			if (pos->free_str)
-				zfree(&pos->val.str);
-			free(pos);
-		}
+		free_config_terms(&config_terms);
 		return -EINVAL;
 	}
 
-- 
2.17.1

