Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235D392904
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhE0H5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:57:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:39420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhE0H4k (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:40 -0400
IronPort-SDR: wRPCPgorUCYToH49lNFppkgXugya8/G3aRltqPIubvblk6eHUP0oqr8RqP/DdrfipEoLv+2e/E
 QZr6vtRmG/6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262841"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262841"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:42 -0700
IronPort-SDR: jFTyJHvV9NNK2t7jOCyRQrcUyzyNmd582ZaIK65oPXHFeyYePu3IQaFPDye2avSMrpaLiAK5vD
 za/cfDPIXMeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586557"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/8] perf tools: Check if mem_events is supported for hybrid platform
Date:   Thu, 27 May 2021 08:16:06 +0800
Message-Id: <20210527001610.10553-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
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
v2:
 - Use 'e->supported |= perf_mem_event__supported(mnt, sysfs_name);'

 tools/perf/util/mem-events.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c736eaded06c..69dcac730ada 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -12,6 +12,8 @@
 #include "mem-events.h"
 #include "debug.h"
 #include "symbol.h"
+#include "pmu.h"
+#include "pmu-hybrid.h"
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
@@ -100,6 +102,15 @@ int perf_mem_events__parse(const char *str)
 	return -1;
 }
 
+static bool perf_mem_event__supported(const char *mnt, char *sysfs_name)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
+	return !stat(path, &st);
+}
+
 int perf_mem_events__init(void)
 {
 	const char *mnt = sysfs__mount();
@@ -110,9 +121,9 @@ int perf_mem_events__init(void)
 		return -ENOENT;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		char path[PATH_MAX];
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
-		struct stat st;
+		struct perf_pmu *pmu;
+		char sysfs_name[100];
 
 		/*
 		 * If the event entry isn't valid, skip initialization
@@ -121,11 +132,20 @@ int perf_mem_events__init(void)
 		if (!e->tag)
 			continue;
 
-		scnprintf(path, PATH_MAX, "%s/devices/%s",
-			  mnt, e->sysfs_name);
+		if (!perf_pmu__has_hybrid()) {
+			scnprintf(sysfs_name, sizeof(sysfs_name),
+				  e->sysfs_name, "cpu");
+			e->supported = perf_mem_event__supported(mnt, sysfs_name);
+		} else {
+			perf_pmu__for_each_hybrid_pmu(pmu) {
+				scnprintf(sysfs_name, sizeof(sysfs_name),
+					  e->sysfs_name, pmu->name);
+				e->supported |= perf_mem_event__supported(mnt, sysfs_name);
+			}
+		}
 
-		if (!stat(path, &st))
-			e->supported = found = true;
+		if (e->supported)
+			found = true;
 	}
 
 	return found ? 0 : -ENOENT;
-- 
2.17.1

