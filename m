Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1C34C46D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhC2HCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2HBu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:01:50 -0400
IronPort-SDR: I2WdJsPUkyi2rkPzhp7r9QkWtNQhCO9iWzxcDrkkv9OQQcwrQnLCcfqZJSGpnAAGuYGk9phA7J
 P4kp21OnG9Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590354"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590354"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:01:50 -0700
IronPort-SDR: t7XjU1dwBVXYSRgln6QMxhp9dxrn0GHLgaKWbvhZuCyspehB/knJ9q99GGiIh0IABR8xGc5Ofp
 QC+q8ltwhmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677279"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:47 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 03/27] perf pmu: Simplify arguments of __perf_pmu__new_alias
Date:   Mon, 29 Mar 2021 15:00:22 +0800
Message-Id: <20210329070046.8815-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the arguments of __perf_pmu__new_alias() by passing
the whole 'struct pme_event' pointer.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No change.

 tools/perf/util/pmu.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88da5cf6aee8..9ed9a6a8b2d2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -306,18 +306,25 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val,
-				 char *long_desc, char *topic,
-				 char *unit, char *perpkg,
-				 char *metric_expr,
-				 char *metric_name,
-				 char *deprecated)
+				 char *desc, char *val, struct pmu_event *pe)
 {
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
 	int num;
 	char newval[256];
+	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
+	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL;
+
+	if (pe) {
+		long_desc = (char *)pe->long_desc;
+		topic = (char *)pe->topic;
+		unit = (char *)pe->unit;
+		perpkg = (char *)pe->perpkg;
+		metric_expr = (char *)pe->metric_expr;
+		metric_name = (char *)pe->metric_name;
+		deprecated = (char *)pe->deprecated;
+	}
 
 	alias = malloc(sizeof(*alias));
 	if (!alias)
@@ -406,8 +413,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	/* Remove trailing newline from sysfs file */
 	strim(buf);
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
-				     NULL, NULL, NULL, NULL);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -793,11 +799,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
-				(char *)pe->long_desc, (char *)pe->topic,
-				(char *)pe->unit, (char *)pe->perpkg,
-				(char *)pe->metric_expr,
-				(char *)pe->metric_name,
-				(char *)pe->deprecated);
+				pe);
 	}
 }
 
@@ -864,13 +866,7 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
 				      (char *)pe->name,
 				      (char *)pe->desc,
 				      (char *)pe->event,
-				      (char *)pe->long_desc,
-				      (char *)pe->topic,
-				      (char *)pe->unit,
-				      (char *)pe->perpkg,
-				      (char *)pe->metric_expr,
-				      (char *)pe->metric_name,
-				      (char *)pe->deprecated);
+				      pe);
 	}
 
 	return 0;
-- 
2.17.1

