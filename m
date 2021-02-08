Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283AA313D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhBHSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:22:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234118AbhBHPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:45:28 -0500
IronPort-SDR: vfGEzhnnLCvX0J4uzU+nu+6y9TiyrAiQjwO3e7B8eqQQQ9yAwS6zhdMR7W6/vt9zCriaJggUAB
 jmHRB4MGMNUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180952045"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180952045"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:36 -0800
IronPort-SDR: Ynh3p6Wg355GnbjZEodKzkDRNON3zNkG5/zADujRs6pcN1jN6VTdu4t8FQxHYpeTi1zzXyDKep
 V3jNfnD3/3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820873"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 29/49] perf pmu: Add hybrid helper functions
Date:   Mon,  8 Feb 2021 07:25:26 -0800
Message-Id: <1612797946-18784-30-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The functions perf_pmu__is_hybrid and perf_pmu__find_hybrid_pmu
can be used to identify the hybrid platform and return the found
hybrid cpu pmu. All the detected hybrid pmus have been saved in
'perf_pmu__hybrid_pmus' list. So we just need to search this list
for a pmu name.

perf_pmu__hybrid_type_to_pmu converts the user specified string
to hybrid pmu name. This is used to support the '--cputype' option
in next patches.

perf_pmu__hybrid_exist checks if hybrid pmus exist.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e97b121..04447f5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1842,3 +1842,43 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	return nr_caps;
 }
+
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+{
+	struct perf_pmu *pmu;
+
+	if (!name)
+		return NULL;
+
+	perf_pmu__for_each_hybrid_pmus(pmu) {
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
+	 * The pmus may be not scanned yet, so check the sysfs.
+	 */
+	if (pmu_is_hybrid(pmu_name))
+		return pmu_name;
+
+	free(pmu_name);
+	return NULL;;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 99bdb5d..bb74595 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -131,4 +131,15 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu);
 #define perf_pmu__for_each_hybrid_pmus(pmu)	\
 	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
 
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
 #endif /* __PMU_H */
-- 
2.7.4

