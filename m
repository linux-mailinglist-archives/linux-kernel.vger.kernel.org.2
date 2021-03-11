Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E49336CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhCKHI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:08:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhCKHI3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:29 -0500
IronPort-SDR: T+AMjx+fWq3qDl8LSr6JxNvuZ74+l+4UyplouRZZ50Hfq+Dny663L4lfXrdtdwoz7bl0uSiPYy
 NpPIRWnJQjag==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246023"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:29 -0800
IronPort-SDR: bfKadKmFQMDoWch046TEdIuMkOpxnHdhqFAeBLWbFgwaQxpPefrK4LvvGjQ+6e9rVNA/vXvSnG
 H1R/rjUH1F3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937829"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:26 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 04/27] perf pmu: Save pmu name
Date:   Thu, 11 Mar 2021 15:07:19 +0800
Message-Id: <20210311070742.9318-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, one event is available on one pmu
(such as, available on cpu_core or on cpu_atom).

This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
Then next we can know the pmu which the event can be available on.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 10 +++++++++-
 tools/perf/util/pmu.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 54e586bf19a5..45d8db1af8d2 100644
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
@@ -314,7 +319,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	int num;
 	char newval[256];
 	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
-	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL;
+	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL,
+	     *pmu = NULL;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
@@ -324,6 +330,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		metric_expr = (char *)pe->metric_expr;
 		metric_name = (char *)pe->metric_name;
 		deprecated = (char *)pe->deprecated;
+		pmu = (char *)pe->pmu;
 	}
 
 	alias = malloc(sizeof(*alias));
@@ -389,6 +396,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
+	alias->pmu = pmu ? strdup(pmu) : NULL;
 
 	if (deprecated)
 		alias->deprecated = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388478c6..0e724d5b84c6 100644
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
2.17.1

