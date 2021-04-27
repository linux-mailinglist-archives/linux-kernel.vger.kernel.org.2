Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C79936BFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhD0HEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:3176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234696AbhD0HEB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:01 -0400
IronPort-SDR: CQ8YveKy1S6GDi5stPR9JHLuYVPSQkSnAQLza3tWa6b3pife9d/3vX6gV3ZdJwxUFl2P4iELwT
 s5g+RGL4Xujw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944165"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944165"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:18 -0700
IronPort-SDR: /Fif7bqtX7ejJj6HRRNvhK3Bv8Yaq8b1P8Ci2ZiNBL8pzlRVM3cQde5+uqfCEuwsW/NxVvf7qa
 bluPGFfNWrkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506613"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 04/26] perf pmu: Save pmu name
Date:   Tue, 27 Apr 2021 15:01:17 +0800
Message-Id: <20210427070139.25256-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, one event is available on one pmu
(such as, available on cpu_core or on cpu_atom).

This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
Then next we can know the pmu which the event can be enabled on.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4 - v6:
 - No change.

v3:
 - Change pmu to pmu_name in struct perf_pmu_alias.

 tools/perf/util/pmu.c | 10 +++++++++-
 tools/perf/util/pmu.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8214def7b0f0..44225838eb03 100644
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
index 1f1749ba830f..4f100768c264 100644
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

