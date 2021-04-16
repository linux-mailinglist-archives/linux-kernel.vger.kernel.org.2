Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D643621AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhDPOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:06:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:11215 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236059AbhDPOGq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:06:46 -0400
IronPort-SDR: +tqf7Bfvjxbj3I8RjkqGerv0reIofiP8vgnymTp/T0YgPvpBe4MHanYzz9Rp1cvxOI/ox+HHYT
 f7CEcDythwIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256358340"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="256358340"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:21 -0700
IronPort-SDR: nooAr+D8yk/YziMeemgVQRkpktl37u1z/8GddsQjbONgtOh6PuSAVR6XyzmKQF/BTjv9p0Au39
 3l9V8x+SBA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766631"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 03/25] perf pmu: Simplify arguments of __perf_pmu__new_alias
Date:   Fri, 16 Apr 2021 22:04:55 +0800
Message-Id: <20210416140517.18206-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the arguments of __perf_pmu__new_alias() by passing
the whole 'struct pme_event' pointer.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 - No change.

 tools/perf/util/pmu.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 286d5e415bdc..8214def7b0f0 100644
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
@@ -798,11 +804,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
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
 
@@ -869,13 +871,7 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
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

