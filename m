Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC57C368CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhDWFh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:9279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240530AbhDWFhX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:23 -0400
IronPort-SDR: 7r8CwkAZiQsVyW8v4jKJp5nL+O0pShQIBJr89P5YGH/yqXLeKYRFqfxzsjv2YHN6C0fhJoG53P
 eYjd53YkhM8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501778"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501778"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:36:47 -0700
IronPort-SDR: 1v4qybUSBM1yRdEPgUXiOhtj9A/e6I7lh/8Ex4biI/IwKWBC43xt8bob2sqzai8DxGrBJj2eft
 dHrL/EQw6shg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293558"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:45 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 04/26] perf pmu: Save pmu name
Date:   Fri, 23 Apr 2021 13:35:19 +0800
Message-Id: <20210423053541.12521-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, one event is available on one pmu
(such as, available on cpu_core or on cpu_atom).

This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
Then next we can know the pmu which the event can be enabled on.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - No change.

v4:
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

