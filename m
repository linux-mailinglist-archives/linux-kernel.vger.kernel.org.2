Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA1336CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhCKHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhCKHIe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:08:34 -0500
IronPort-SDR: +k8sGaAzHZiZoEp8iE+d7ncheu51n0BvqfNS6RDCSG++jcY6qpsa4O/ShO+tlfrEFwShuwaQqc
 gBaX+RdBVE+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246030"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:08:34 -0800
IronPort-SDR: DPZ8EG+76amI39tJ21/j8E8NMSp67yUDSWJGgU55Wss9FAmvA/dqFWkwdrBLGx1qpPKXTWiU0x
 /8N4aq4mlz3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509937852"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:08:31 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 06/27] perf pmu: Add hybrid helper functions
Date:   Thu, 11 Mar 2021 15:07:21 +0800
Message-Id: <20210311070742.9318-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions perf_pmu__is_hybrid and perf_pmu__find_hybrid_pmu
can be used to identify the hybrid platform and return the found
hybrid cpu pmu. All the detected hybrid pmus have been saved in
'perf_pmu__hybrid_pmus' list. So we just need to search this list.

perf_pmu__hybrid_type_to_pmu converts the user specified string
to hybrid pmu name. This is used to support the '--cputype' option
in next patches.

perf_pmu__hybrid_exist checks the existing of hybrid pmu.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu-hybrid.c | 40 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu-hybrid.h | 11 ++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index 7316bf46e54b..86ba84d9469c 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -33,3 +33,43 @@ bool perf_pmu__hybrid_mounted(const char *name)
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
 	return file_available(path);
 }
+
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+{
+	struct perf_pmu *pmu;
+
+	if (!name)
+		return NULL;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		if (!strcmp(name, pmu->name))
+			return pmu;
+	}
+
+	return NULL;
+}
+
+bool perf_pmu__is_hybrid(const char *name)
+{
+	return perf_pmu__find_hybrid_pmu(name) != NULL;
+}
+
+char *perf_pmu__hybrid_type_to_pmu(const char *type)
+{
+	char *pmu_name = NULL;
+
+	if (asprintf(&pmu_name, "cpu_%s", type) < 0)
+		return NULL;
+
+	if (perf_pmu__is_hybrid(pmu_name))
+		return pmu_name;
+
+	/*
+	 * pmu may be not scanned, check the sysfs.
+	 */
+	if (perf_pmu__hybrid_mounted(pmu_name))
+		return pmu_name;
+
+	free(pmu_name);
+	return NULL;
+}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 35bed3714438..7fb2246e939a 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -15,4 +15,15 @@ extern struct list_head perf_pmu__hybrid_pmus;
 
 bool perf_pmu__hybrid_mounted(const char *name);
 
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
+
+bool perf_pmu__is_hybrid(const char *name);
+
+char *perf_pmu__hybrid_type_to_pmu(const char *type);
+
+static inline bool perf_pmu__hybrid_exist(void)
+{
+	return !list_empty(&perf_pmu__hybrid_pmus);
+}
+
 #endif /* __PMU_HYBRID_H */
-- 
2.17.1

