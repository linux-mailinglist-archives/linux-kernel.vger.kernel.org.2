Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F913B8DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhGAGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:46:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:65503 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhGAGqg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:46:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="272336957"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="272336957"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 23:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="641970762"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2021 23:44:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3] perf tools: Fix pattern matching for same substring in different pmu type
Date:   Thu,  1 Jul 2021 14:42:53 +0800
Message-Id: <20210701064253.1175-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some different pmu types may have same substring. For example,
on Icelake server, we have pmu types "uncore_imc" and
"uncore_imc_free_running". Both pmu types have substring "uncore_imc".
But the parser would wrongly think they are the same pmu type.

We enable an imc event,
perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1

Perf actually expands the event to:
uncore_imc_0/event=0xe3/
uncore_imc_1/event=0xe3/
uncore_imc_2/event=0xe3/
uncore_imc_3/event=0xe3/
uncore_imc_4/event=0xe3/
uncore_imc_5/event=0xe3/
uncore_imc_6/event=0xe3/
uncore_imc_7/event=0xe3/
uncore_imc_free_running_0/event=0xe3/
uncore_imc_free_running_1/event=0xe3/
uncore_imc_free_running_3/event=0xe3/
uncore_imc_free_running_4/event=0xe3/

That's because the "uncore_imc_free_running" matches the
pattern "uncore_imc*".

Now we check that the last characters of pmu name is
'_<digit>'.

For example, for pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
but "uncore_imc_free_running_0" would be failed.

Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.y |  2 +-
 tools/perf/util/pmu.c          | 36 +++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu.h          |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index aba12a4d488e..9321bd0e2f76 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -316,7 +316,7 @@ event_pmu_name opt_pmu_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!fnmatch(pattern, name, 0)) {
+			if (!perf_pmu__match(pattern, name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc60b0..44b90d638ad5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3,6 +3,7 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <linux/ctype.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <errno.h>
@@ -17,6 +18,7 @@
 #include <locale.h>
 #include <regex.h>
 #include <perf/cpumap.h>
+#include <fnmatch.h>
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
@@ -740,6 +742,27 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
 	return perf_pmu__find_map(NULL);
 }
 
+static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
+{
+	char *p;
+
+	if (strncmp(pmu_name, tok, strlen(tok)))
+		return false;
+
+	p = pmu_name + strlen(tok);
+	if (*p == 0)
+		return true;
+
+	if (*p != '_')
+		return false;
+
+	++p;
+	if (*p == 0 || !isdigit(*p))
+		return false;
+
+	return true;
+}
+
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
@@ -768,7 +791,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	 */
 	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
 		name = strstr(name, tok);
-		if (!name) {
+		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
 			res = false;
 			goto out;
 		}
@@ -1872,3 +1895,14 @@ bool perf_pmu__has_hybrid(void)
 
 	return !list_empty(&perf_pmu__hybrid_pmus);
 }
+
+int perf_pmu__match(char *pattern, char *name, char *tok)
+{
+	if (fnmatch(pattern, name, 0))
+		return -1;
+
+	if (tok && !perf_pmu__valid_suffix(name, tok))
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a790ef758171..926da483a141 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   char *name);
 
 bool perf_pmu__has_hybrid(void);
+int perf_pmu__match(char *pattern, char *name, char *tok);
 
 #endif /* __PMU_H */
-- 
2.17.1

