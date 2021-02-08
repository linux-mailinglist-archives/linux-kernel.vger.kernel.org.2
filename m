Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC6313D19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBHSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:19:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:62778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhBHPot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:49 -0500
IronPort-SDR: 489zb5xI5TYL/5pv3JXwWhbx41gqzCQ+yNDCEbywx/FCPlsbGjyfSwKHqmxsA1s4D5ZemZYDxL
 zf/6hXTJsxvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952042"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:36 -0800
IronPort-SDR: xP2PoUCyI7KQPf9i6merdYAGoaPPmo2rtl2+D4KkJA6wk051TtA4mxjeHz37J/whmNc5N1R0GJ
 FpvXQy03SNnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820864"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:35 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 27/49] perf util: Save pmu name to struct perf_pmu_alias
Date:   Mon,  8 Feb 2021 07:25:24 -0800
Message-Id: <1612797946-18784-28-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

On hybrid platform, one event is available on one pmu
(such as, cpu_core or cpu_atom).

This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
Then next we can know the pmu where the event can be enabled.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 17 +++++++++++++----
 tools/perf/util/pmu.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef283..0c25457 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -283,6 +283,7 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 	zfree(&newalias->str);
 	zfree(&newalias->metric_expr);
 	zfree(&newalias->metric_name);
+	zfree(&newalias->pmu);
 	parse_events_terms__purge(&newalias->terms);
 	free(newalias);
 }
@@ -297,6 +298,10 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 
 	list_for_each_entry(a, alist, list) {
 		if (!strcasecmp(newalias->name, a->name)) {
+			if (newalias->pmu && a->pmu &&
+			    !strcasecmp(newalias->pmu, a->pmu)) {
+				continue;
+			}
 			perf_pmu_update_alias(a, newalias);
 			perf_pmu_free_alias(newalias);
 			return true;
@@ -311,7 +316,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *unit, char *perpkg,
 				 char *metric_expr,
 				 char *metric_name,
-				 char *deprecated)
+				 char *deprecated,
+				 char *pmu)
 {
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
@@ -382,6 +388,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
+	alias->pmu = pmu ? strdup(pmu) : NULL;
 
 	if (deprecated)
 		alias->deprecated = true;
@@ -407,7 +414,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	strim(buf);
 
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
-				     NULL, NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -797,7 +804,8 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 				(char *)pe->unit, (char *)pe->perpkg,
 				(char *)pe->metric_expr,
 				(char *)pe->metric_name,
-				(char *)pe->deprecated);
+				(char *)pe->deprecated,
+				(char *)pe->pmu);
 	}
 }
 
@@ -870,7 +878,8 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
 				      (char *)pe->perpkg,
 				      (char *)pe->metric_expr,
 				      (char *)pe->metric_name,
-				      (char *)pe->deprecated);
+				      (char *)pe->deprecated,
+				      NULL);
 	}
 
 	return 0;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388..0e724d5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ struct perf_pmu_alias {
 	bool deprecated;
 	char *metric_expr;
 	char *metric_name;
+	char *pmu;
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
-- 
2.7.4

