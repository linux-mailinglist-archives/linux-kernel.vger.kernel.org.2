Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7767434C470
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC2HC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC2HB5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:01:57 -0400
IronPort-SDR: EGH8qeNIppFYKs6J2rwtUtbEL1XC1SmV7hvvGMaxgGurJNCz8fYatvI1rOMAI/9jgAA2NO3ETP
 BaOQ8Bxoy6qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590398"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590398"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:01:57 -0700
IronPort-SDR: yIeOt1qAuxfa6TVtV8dvSTFerNT0Rswek81M1gmegRgq5FY2LDr2N7//XEIHDNam13g+AfGX8i
 ZQZU6a0u/24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677323"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 06/27] perf pmu: Add hybrid helper functions
Date:   Mon, 29 Mar 2021 15:00:25 +0800
Message-Id: <20210329070046.8815-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
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
we have to define it in pmu.c (try to make pmu-hybrid.c no more
symbol dependency), otherwise perf test python would be failed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
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
index 35e9660c3904..beff29981101 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -40,6 +40,7 @@ int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
 static LIST_HEAD(pmus);
+static bool hybrid_scanned;
 
 /*
  * Parse & process all the sysfs attributes located under
@@ -1823,3 +1824,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 
 	return nr_caps;
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
index 29289e7c2649..5ed2abab7fe0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -128,4 +128,6 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
+bool perf_pmu__has_hybrid(void);
+
 #endif /* __PMU_H */
-- 
2.17.1

