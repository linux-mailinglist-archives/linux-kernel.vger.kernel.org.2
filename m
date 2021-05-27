Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CA392905
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhE0H5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:57:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:39423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234982AbhE0H4n (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:43 -0400
IronPort-SDR: D3eys4N80uXKo/KPZxX3NOpTRwONsye+UGyZD8jJaCfhGN34Ems0dscP/kQaxTjF94uU4uqDwK
 kKzJoGY1CByw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262847"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:45 -0700
IronPort-SDR: wmHIhyGUhueZBvVXInu4C5Kf8FwilchSKs/sp57qvkJqsHfkkPQEfCLEXJMIPEqIlsPo1eTPh8
 wv7Jm+Ru3jSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586574"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:42 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 5/8] perf mem: Support record for hybrid platform
Date:   Thu, 27 May 2021 08:16:07 +0800
Message-Id: <20210527001610.10553-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support 'perf mem record' for hybrid platform. On hybrid platform,
such as Alderlake, when executing 'perf mem record', it actually calls:

record -e {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}:P
       -e cpu_atom/mem-loads,ldlat=30/P
       -e cpu_core/mem-stores/P
       -e cpu_atom/mem-stores/P

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - For hybrid, rec_argc = argc + 9 * perf_pmu__hybrid_pmu_num().
 - Directly 'free(rec_tmp[i])', don't need to check NULL.
  
 tools/perf/builtin-mem.c     | 43 ++++++++++++++----------
 tools/perf/util/mem-events.c | 65 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/mem-events.h |  2 ++
 3 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 03795bf49d51..6b633df458c2 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -18,6 +18,8 @@
 #include "util/dso.h"
 #include "util/map.h"
 #include "util/symbol.h"
+#include "util/pmu.h"
+#include "util/pmu-hybrid.h"
 #include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
@@ -62,8 +64,9 @@ static const char * const *record_mem_usage = __usage;
 
 static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, tmp_nr = 0;
 	const char **rec_argv;
+	char **rec_tmp;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	struct perf_mem_event *e;
@@ -87,11 +90,24 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	rec_argc = argc + 9; /* max number of arguments */
+	if (!perf_pmu__has_hybrid())
+		rec_argc = argc + 9; /* max number of arguments */
+	else
+		rec_argc = argc + 9 * perf_pmu__hybrid_pmu_num();
+
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -1;
 
+	/*
+	 * Save the allocated event name strings.
+	 */
+	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_tmp) {
+		free(rec_argv);
+		return -1;
+	}
+
 	rec_argv[i++] = "record";
 
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
@@ -128,21 +144,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->data_page_size)
 		rec_argv[i++] = "--data-page-size";
 
-	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		e = perf_mem_events__ptr(j);
-		if (!e->record)
-			continue;
-
-		if (!e->supported) {
-			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events__name(j, NULL));
-			free(rec_argv);
-			return -1;
-		}
-
-		rec_argv[i++] = "-e";
-		rec_argv[i++] = perf_mem_events__name(j, NULL);
-	}
+	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
+	if (ret)
+		goto out;
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
@@ -164,6 +168,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	}
 
 	ret = cmd_record(i, rec_argv);
+out:
+	for (i = 0; i < tmp_nr; i++)
+		free(rec_tmp[i]);
+
+	free(rec_tmp);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 69dcac730ada..f38c0da9e698 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -166,6 +166,71 @@ void perf_mem_events__list(void)
 	}
 }
 
+static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
+						    int idx)
+{
+	const char *mnt = sysfs__mount();
+	char sysfs_name[100];
+	struct perf_pmu *pmu;
+
+	perf_pmu__for_each_hybrid_pmu(pmu) {
+		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
+			  pmu->name);
+		if (!perf_mem_event__supported(mnt, sysfs_name)) {
+			pr_err("failed: event '%s' not supported\n",
+			       perf_mem_events__name(idx, pmu->name));
+		}
+	}
+}
+
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
+				 char **rec_tmp, int *tmp_nr)
+{
+	int i = *argv_nr, k = 0;
+	struct perf_mem_event *e;
+	struct perf_pmu *pmu;
+	char *s;
+
+	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		e = perf_mem_events__ptr(j);
+		if (!e->record)
+			continue;
+
+		if (!perf_pmu__has_hybrid()) {
+			if (!e->supported) {
+				pr_err("failed: event '%s' not supported\n",
+				       perf_mem_events__name(j, NULL));
+				return -1;
+			}
+
+			rec_argv[i++] = "-e";
+			rec_argv[i++] = perf_mem_events__name(j, NULL);
+		} else {
+			if (!e->supported) {
+				perf_mem_events__print_unsupport_hybrid(e, j);
+				return -1;
+			}
+
+			perf_pmu__for_each_hybrid_pmu(pmu) {
+				rec_argv[i++] = "-e";
+				s = perf_mem_events__name(j, pmu->name);
+				if (s) {
+					s = strdup(s);
+					if (!s)
+						return -1;
+
+					rec_argv[i++] = s;
+					rec_tmp[k++] = s;
+				}
+			}
+		}
+	}
+
+	*argv_nr = i;
+	*tmp_nr = k;
+	return 0;
+}
+
 static const char * const tlb_access[] = {
 	"N/A",
 	"HIT",
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index a3fa19093fd2..916242f8020a 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -43,6 +43,8 @@ struct perf_mem_event *perf_mem_events__ptr(int i);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_mem_events__list(void);
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
+				 char **rec_tmp, int *tmp_nr);
 
 int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-- 
2.17.1

