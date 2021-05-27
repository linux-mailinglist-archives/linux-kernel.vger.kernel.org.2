Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B02239290B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhE0H5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:57:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:39423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235114AbhE0H5M (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:57:12 -0400
IronPort-SDR: 3xaUHKIpK67nrAyA3zxn7MNxS4JO6MsxEhvx1N/sJSJLSnzCQuyFbZGyKTC1oNrbLwKckREmt7
 FUMHkpfniCiw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262857"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262857"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:52 -0700
IronPort-SDR: KILY9+EQ/1nTzgMKEPk3nS6q84zn6AVYFZvz/lXHXQ7L85eLlUaSTCVs/uvAc5FlGunFM+dBWZ
 TVere13ufnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586621"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:50 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 8/8] perf c2c: Support record for hybrid platform
Date:   Thu, 27 May 2021 08:16:10 +0800
Message-Id: <20210527001610.10553-9-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support 'perf c2c record' for hybrid platform. On hybrid platform,
such as Alderlake, when executing 'perf c2c record', it actually calls:

record -W -d --phys-data --sample-cpu
-e {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}:P
-e cpu_atom/mem-loads,ldlat=30/P
-e cpu_core/mem-stores/P
-e cpu_atom/mem-stores/P

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - For hybrid, rec_argc = argc + 11 * perf_pmu__hybrid_pmu_num().
 - Directly 'free(rec_tmp[i])', don't need to check NULL.

 tools/perf/builtin-c2c.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a4fd375acdd1..6dea37f141b2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -42,6 +42,8 @@
 #include "ui/ui.h"
 #include "ui/progress.h"
 #include "../perf.h"
+#include "pmu.h"
+#include "pmu-hybrid.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -2907,8 +2909,9 @@ static const char * const *record_mem_usage = __usage_record;
 
 static int perf_c2c__record(int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, rec_tmp_nr = 0;
 	const char **rec_argv;
+	char **rec_tmp;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
@@ -2932,11 +2935,21 @@ static int perf_c2c__record(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	rec_argc = argc + 11; /* max number of arguments */
+	if (!perf_pmu__has_hybrid())
+		rec_argc = argc + 11; /* max number of arguments */
+	else
+		rec_argc = argc + 11 * perf_pmu__hybrid_pmu_num();
+
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -1;
 
+	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_tmp) {
+		free(rec_argv);
+		return -1;
+	}
+
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
@@ -2964,21 +2977,9 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
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
+	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &rec_tmp_nr);
+	if (ret)
+		goto out;
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
@@ -3002,6 +3003,11 @@ static int perf_c2c__record(int argc, const char **argv)
 	}
 
 	ret = cmd_record(i, rec_argv);
+out:
+	for (i = 0; i < rec_tmp_nr; i++)
+		free(rec_tmp[i]);
+
+	free(rec_tmp);
 	free(rec_argv);
 	return ret;
 }
-- 
2.17.1

