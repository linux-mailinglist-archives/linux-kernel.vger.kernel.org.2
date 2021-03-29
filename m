Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B334C46E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC2HCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhC2HBw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:01:52 -0400
IronPort-SDR: VkB5C0DigDQ2qConkdsx+tviLOEoOhIVzWRT3AvPCJn4Ij/ve1obH1xdmUA2wBgPN8gMExF0Ir
 FH9h+cSjW63Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590368"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:01:52 -0700
IronPort-SDR: UUc93x9SQhowlpCsZ6IzDLTYT0Pc6BByidqza/n0u44kG81IO7w97vuIRmfq/jx1Btj410Ufew
 9QZGo5jNRueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677302"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:50 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 04/27] perf pmu: Save pmu name
Date:   Mon, 29 Mar 2021 15:00:23 +0800
Message-Id: <20210329070046.8815-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, one event is available on one pmu
(such as, available on cpu_core or on cpu_atom).

This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
Then next we can know the pmu which the event can be enabled on.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Change pmu to pmu_name in struct perf_pmu_alias.

 tools/perf/util/pmu.c | 10 +++++++++-
 tools/perf/util/pmu.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9ed9a6a8b2d2..10709ec1cc3e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -283,6 +283,7 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 	zfree(&newalias->str);
 	zfree(&newalias->metric_expr);
 	zfree(&newalias->metric_name);
+	zfree(&newalias->pmu_name);
 	parse_events_terms__purge(&newalias->terms);
 	free(newalias);
 }
@@ -297,6 +298,10 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 
 	list_for_each_entry(a, alist, list) {
 		if (!strcasecmp(newalias->name, a->name)) {
+			if (newalias->pmu_name && a->pmu_name &&
+			    !strcasecmp(newalias->pmu_name, a->pmu_name)) {
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
+	     *pmu_name = NULL;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
@@ -324,6 +330,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		metric_expr = (char *)pe->metric_expr;
 		metric_name = (char *)pe->metric_name;
 		deprecated = (char *)pe->deprecated;
+		pmu_name = (char *)pe->pmu;
 	}
 
 	alias = malloc(sizeof(*alias));
@@ -389,6 +396,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
+	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
 	if (deprecated)
 		alias->deprecated = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8164388478c6..8493b1719e10 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,6 +72,7 @@ struct perf_pmu_alias {
 	bool deprecated;
 	char *metric_expr;
 	char *metric_name;
+	char *pmu_name;
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
-- 
2.17.1

