Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5D336CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhCKHI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:08:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhCKHI1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:27 -0500
IronPort-SDR: y5WbVO4gJLtKeePWf8OYHLgMONrj2ZZpm4wE7nO2JUxOMVSiXCMT2g6Pw3vO/oKuWVDxtTfVm4
 pTfnZTF1TiDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246015"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:27 -0800
IronPort-SDR: jDQcB7XC1jpWy5IBslzOT+24KKgotw5c6eqo8tJP5WuSQsEwc0zpaOmW+bp8tyuyAffzuOPuNZ
 F9fz72pWJh6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937819"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:24 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 03/27] perf pmu: Simplify arguments of __perf_pmu__new_alias
Date:   Thu, 11 Mar 2021 15:07:18 +0800
Message-Id: <20210311070742.9318-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the arguments of __perf_pmu__new_alias() by passing
the whole 'struct pme_event' pointer.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 44ef28302fc7..54e586bf19a5 100644
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

