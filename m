Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC74389E92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhETHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:03:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:53040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhETHDd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:03:33 -0400
IronPort-SDR: +PhqzdgUXobWYz557etFn8uAmCeqzMnR3OpJTd50UMlPlCjmYszeggh1xgNwCP3r1d5ZICQOQT
 FR0yIFwgDlcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286691058"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286691058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:02:12 -0700
IronPort-SDR: sMvuZsY5gIdAu6YZXzJuBLFO4A/HJfFx2dhv0Cvnl54IG3/eVgmCXDG0+iKRBTlaGzTVaEHjxI
 TzrOA1SkOCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543206891"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2021 00:02:10 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 3/5] perf tools: Check if mem_events is supported for hybrid
Date:   Thu, 20 May 2021 15:00:38 +0800
Message-Id: <20210520070040.710-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520070040.710-1-yao.jin@linux.intel.com>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the mem_events ('mem-loads' and 'mem-stores') exist
in the sysfs path.

For Alderlake, the hybrid cpu pmu are "cpu_core" and "cpu_atom".
Check the existing of following paths:
/sys/devices/cpu_atom/events/mem-loads
/sys/devices/cpu_atom/events/mem-stores
/sys/devices/cpu_core/events/mem-loads
/sys/devices/cpu_core/events/mem-stores

If the patch exists, the mem_event is supported.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/mem-events.c | 43 +++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c736eaded06c..e8f6e745eaf0 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -12,14 +12,16 @@
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
+#include "pmu.h"
+#include "pmu-hybrid.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
+	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 #undef E
@@ -100,6 +102,18 @@ int perf_mem_events__parse(const char *str)
 	return -1;
 }
 
+static bool perf_mem_events__supported(const char *mnt, char *sysfs_name)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
+	if (!stat(path, &st))
+		return true;
+
+	return false;
+}
+
 int perf_mem_events__init(void)
 {
 	const char *mnt = sysfs__mount();
@@ -110,9 +124,10 @@ int perf_mem_events__init(void)
 		return -ENOENT;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		char path[PATH_MAX];
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
-		struct stat st;
+		struct perf_pmu *pmu;
+		char sysfs_name[100];
+		int unsupported = 0;
 
 		/*
 		 * If the event entry isn't valid, skip initialization
@@ -121,11 +136,23 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		scnprintf(path, PATH_MAX, "%s/devices/%s",
-			  mnt, e->sysfs_name);
+		if (!perf_pmu__has_hybrid()) {
+			scnprintf(sysfs_name, sizeof(sysfs_name),
+				  e->sysfs_name, "cpu");
+			e->supported = perf_mem_events__supported(mnt, sysfs_name);
+		} else {
+			perf_pmu__for_each_hybrid_pmu(pmu) {
+				scnprintf(sysfs_name, sizeof(sysfs_name),
+					  e->sysfs_name, pmu->name);
+				if (!perf_mem_events__supported(mnt, sysfs_name))
+					unsupported++;
+			}
+
+			e->supported = (unsupported == 0) ? true : false;
+		}
 
-		if (!stat(path, &st))
-			e->supported = found = true;
+		if (e->supported)
+			found = true;
 	}
 
 	return found ? 0 : -ENOENT;
-- 
2.17.1

