Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB923928F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhE0H4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:56:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:39416 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234926AbhE0H4K (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:56:10 -0400
IronPort-SDR: gZh1eSiuI09Mk3bdYa4UpjQtlRlvJgr0p3gQIVP817uNjOWvnc/zl3Z/oSjxSBmegdvIWIWKiG
 S1zKEV0sHuJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262825"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:37 -0700
IronPort-SDR: KpPw9+NyvpJ+cVfui9Gvz6pCMIQg3jUEOml36LrtGHYBjYzzHPPq++wqS7FuItGGJLw1FGE0Vn
 k9Ra/cmFdkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586521"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:34 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/8] perf tools: Support pmu prefix for mem-load event
Date:   Thu, 27 May 2021 08:16:04 +0800
Message-Id: <20210527001610.10553-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_mem_events__name() can generate the mem-load event name.
It uses a variable 'mem_loads_name__init' to avoid generating the
event name every time (because perf_pmu__scan takes some time).

The perf_mem_events__name() assumes the pmu is "cpu" but it's not
correct for hybrid platform. For Alderlake, the pmu is "cpu_core" or
"cpu_atom"

Introduce a new parameter 'pmu_name' in perf_mem_events__name
to let the caller specify a pmu name.

Considering such event name is x86 specific, so move
perf_mem_events[] to arch/x86/util/mem-events.c.

We still keep the variable 'mem_loads_name__init' but it's only
used when pmu_name is NULL (compatible for original behavior). When
pmu_name is not NULL (e.g. "cpu_core"), this patch doesn't have
optimization. That can be implemented in follow up patch.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - Move perf_mem_events[] to x86 specific file.
 - Create x86 specific perf_mem_events__ptr().
 - Use mem_loads_name__init for keeping original behavior
   on non-hybrid platform.

 tools/perf/arch/arm64/util/mem-events.c   |  2 +-
 tools/perf/arch/powerpc/util/mem-events.c |  2 +-
 tools/perf/arch/x86/util/mem-events.c     | 35 ++++++++++++++++++-----
 tools/perf/builtin-c2c.c                  |  4 +--
 tools/perf/builtin-mem.c                  |  4 +--
 tools/perf/util/mem-events.c              |  4 +--
 tools/perf/util/mem-events.h              |  2 +-
 7 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index 2a2497372671..be41721b9aa1 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -20,7 +20,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 	return &perf_mem_events[i];
 }
 
-char *perf_mem_events__name(int i)
+char *perf_mem_events__name(int i, char *pmu_name __maybe_unused)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index 07fb5e049488..4120fafe0be4 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -3,7 +3,7 @@
 #include "mem-events.h"
 
 /* PowerPC does not support 'ldlat' parameter. */
-char *perf_mem_events__name(int i)
+char *perf_mem_events__name(int i, char *pmu_name __maybe_unused)
 {
 	if (i == PERF_MEM_EVENTS__LOAD)
 		return (char *) "cpu/mem-loads/";
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index e79232e3f2a0..f9e444a4fe70 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -7,7 +7,23 @@ static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
 #define MEM_LOADS_AUX		0x8203
-#define MEM_LOADS_AUX_NAME	"{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
+#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
+
+#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+
+static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
+	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E(NULL,			NULL,				NULL),
+};
+
+struct perf_mem_event *perf_mem_events__ptr(int i)
+{
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	return &perf_mem_events[i];
+}
 
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
@@ -22,7 +38,7 @@ bool is_mem_loads_aux_event(struct evsel *leader)
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
 
-char *perf_mem_events__name(int i)
+char *perf_mem_events__name(int i, char *pmu_name)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
@@ -30,17 +46,22 @@ char *perf_mem_events__name(int i)
 		return NULL;
 
 	if (i == PERF_MEM_EVENTS__LOAD) {
-		if (mem_loads_name__init)
+		if (mem_loads_name__init && !pmu_name)
 			return mem_loads_name;
 
-		mem_loads_name__init = true;
+		if (!pmu_name) {
+			mem_loads_name__init = true;
+			pmu_name = (char *)"cpu";
+		}
 
-		if (pmu_have_event("cpu", "mem-loads-aux")) {
+		if (pmu_have_event(pmu_name, "mem-loads-aux")) {
 			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
+				  MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
+				  perf_mem_events__loads_ldlat);
 		} else {
 			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  e->name, perf_mem_events__loads_ldlat);
+				  e->name, pmu_name,
+				  perf_mem_events__loads_ldlat);
 		}
 		return mem_loads_name;
 	}
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e3b9d63077ef..a4fd375acdd1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2971,13 +2971,13 @@ static int perf_c2c__record(int argc, const char **argv)
 
 		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events__name(j));
+			       perf_mem_events__name(j, NULL));
 			free(rec_argv);
 			return -1;
 		}
 
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = perf_mem_events__name(j);
+		rec_argv[i++] = perf_mem_events__name(j, NULL);
 	}
 
 	if (all_user)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index cdd2b9f643f6..03795bf49d51 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -135,13 +135,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events__name(j));
+			       perf_mem_events__name(j, NULL));
 			free(rec_argv);
 			return -1;
 		}
 
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = perf_mem_events__name(j);
+		rec_argv[i++] = perf_mem_events__name(j, NULL);
 	}
 
 	if (all_user)
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f93a852ad838..c736eaded06c 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -37,7 +37,7 @@ struct perf_mem_event * __weak perf_mem_events__ptr(int i)
 	return &perf_mem_events[i];
 }
 
-char * __weak perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i, char *pmu_name  __maybe_unused)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
@@ -141,7 +141,7 @@ void perf_mem_events__list(void)
 		fprintf(stderr, "%-13s%-*s%s\n",
 			e->tag ?: "",
 			verbose > 0 ? 25 : 0,
-			verbose > 0 ? perf_mem_events__name(j) : "",
+			verbose > 0 ? perf_mem_events__name(j, NULL) : "",
 			e->supported ? ": available" : "");
 	}
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index cacdebd65b8a..a3fa19093fd2 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -38,7 +38,7 @@ extern unsigned int perf_mem_events__loads_ldlat;
 int perf_mem_events__parse(const char *str);
 int perf_mem_events__init(void);
 
-char *perf_mem_events__name(int i);
+char *perf_mem_events__name(int i, char *pmu_name);
 struct perf_mem_event *perf_mem_events__ptr(int i);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
-- 
2.17.1

