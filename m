Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140E389E94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhETHDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:03:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:53040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhETHDi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:03:38 -0400
IronPort-SDR: pO24zgEBxdNL/xg/o7dmURGISaU9tOlYKkh4IOFQZ42kjyf7IF7g+BWJlHTuL024qD/WC4M67D
 z0cQjx2QDo0w==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286691074"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286691074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:02:17 -0700
IronPort-SDR: gJ18iSheBGtxdrVlC0gqsqOle0u4CpiiIB50yMdhowyIB3fkAOqLNz0bcW7eWgLGQoFu1Vhb2n
 LQ61Dd6oNnlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543206925"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2021 00:02:15 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 5/5] perf c2c: Support record for hybrid platform
Date:   Thu, 20 May 2021 15:00:40 +0800
Message-Id: <20210520070040.710-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520070040.710-1-yao.jin@linux.intel.com>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
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
 tools/perf/builtin-c2c.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a4fd375acdd1..70804ad9017a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2907,8 +2907,9 @@ static const char * const *record_mem_usage = __usage_record;
 
 static int perf_c2c__record(int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, rec_nr = 0;
 	const char **rec_argv;
+	char **rec_tmp;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
@@ -2932,11 +2933,17 @@ static int perf_c2c__record(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	rec_argc = argc + 11; /* max number of arguments */
+	rec_argc = argc + 64; /* max number of arguments */
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
@@ -2964,21 +2971,9 @@ static int perf_c2c__record(int argc, const char **argv)
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
+	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &rec_nr);
+	if (ret)
+		goto out;
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
@@ -3002,6 +2997,13 @@ static int perf_c2c__record(int argc, const char **argv)
 	}
 
 	ret = cmd_record(i, rec_argv);
+out:
+	for (i = 0; i < rec_nr; i++) {
+		if (rec_tmp[i])
+			free(rec_tmp[i]);
+	}
+
+	free(rec_tmp);
 	free(rec_argv);
 	return ret;
 }
-- 
2.17.1

