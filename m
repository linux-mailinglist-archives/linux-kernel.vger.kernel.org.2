Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4D36BFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhD0HEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:3195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhD0HEG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:06 -0400
IronPort-SDR: K332+4QnUYfNFJUQVxeH0QeabWRFzYkS+vohU5o3+hEnpJASnHeyosYxb01UVl0DqM04ysZzLb
 Hzqxeixt/kFg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944178"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:24 -0700
IronPort-SDR: LSrvPHjpYn1lPy0NdGixTQXZ1d6e9IDRx/xPb+qLPMzRL7IxKTDwKyaVJ/JthnbT87+x+DHu2E
 qnmofxblKyMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506635"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:21 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 06/26] perf pmu: Add hybrid helper functions
Date:   Tue, 27 Apr 2021 15:01:19 +0800
Message-Id: <20210427070139.25256-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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

perf_pmu__has_hybrid checks the existing of hybrid pmu. Note that,
we have to define it in pmu.c (make pmu-hybrid.c no more symbol
dependency), otherwise perf test python would be failed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4 - v6:
 - No change.

v3:
 - Move perf_pmu__has_hybrid from pmu-hybrid.c to pmu.c. We have to
   add pmu-hybrid.c to python-ext-sources to solve symbol dependency
   issue found in perf test python. For perf_pmu__has_hybrid, it calls
   perf_pmu__scan, which is defined in pmu.c. It's very hard to add
   pmu.c to python-ext-sources, too much symbol dependency here.

 tools/perf/util/pmu-hybrid.c | 40 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu-hybrid.h |  4 ++++
 tools/perf/util/pmu.c        | 11 ++++++++++
 tools/perf/util/pmu.h        |  2 ++
 4 files changed, 57 insertions(+)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index 8ed0e6e1776d..f51ccaac60ee 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -47,3 +47,43 @@ bool perf_pmu__hybrid_mounted(const char *name)
 
 	return true;
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
index 35bed3714438..d0fa7bc50a76 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -15,4 +15,8 @@ extern struct list_head perf_pmu__hybrid_pmus;
 
 bool perf_pmu__hybrid_mounted(const char *name);
 
+struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
+bool perf_pmu__is_hybrid(const char *name);
+char *perf_pmu__hybrid_type_to_pmu(const char *type);
+
 #endif /* __PMU_HYBRID_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6e49c7b8ad71..88c8ecdc60b0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -40,6 +40,7 @@ int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
 static LIST_HEAD(pmus);
+static bool hybrid_scanned;
 
 /*
  * Parse & process all the sysfs attributes located under
@@ -1861,3 +1862,13 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 		   "'%llx' not supported by kernel)!\n",
 		   name ?: "N/A", buf, config);
 }
+
+bool perf_pmu__has_hybrid(void)
+{
+	if (!hybrid_scanned) {
+		hybrid_scanned = true;
+		perf_pmu__scan(NULL);
+	}
+
+	return !list_empty(&perf_pmu__hybrid_pmus);
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9a2f89eeab6f..a790ef758171 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -132,4 +132,6 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu);
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   char *name);
 
+bool perf_pmu__has_hybrid(void);
+
 #endif /* __PMU_H */
-- 
2.17.1

