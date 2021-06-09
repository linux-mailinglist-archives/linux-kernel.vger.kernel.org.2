Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511013A0BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFIFAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:00:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:24557 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFIFAe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:00:34 -0400
IronPort-SDR: 4BRBdw8GXfMuYpmcVIEpt3O0GG0uZAwQwlZ879WE0vDHJJmWazbIcJzCvf7CTJMvRFEjzJZBM9
 JLPO+F6MEOow==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192111653"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192111653"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:58:40 -0700
IronPort-SDR: kymJqfXxEZAvsDP2HquRRN4m+j4rcSiU+QfQenxQ593h845nNfs1PxI1/eTFlFO6ZTDhIL8S1Y
 zkrwmlpu6RoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="476843351"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2021 21:58:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1] perf tools: Fix pattern matching for same substring used in different pmu type
Date:   Wed,  9 Jun 2021 12:57:38 +0800
Message-Id: <20210609045738.1051-1-yao.jin@linux.intel.com>
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

Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.y |  2 ++
 tools/perf/util/pmu.c          | 25 ++++++++++++++++++++++++-
 tools/perf/util/pmu.h          |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index aba12a4d488e..7a694c7f7f1a 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -317,6 +317,8 @@ event_pmu_name opt_pmu_config
 			    strncmp($1, "uncore_", 7))
 				name += 7;
 			if (!fnmatch(pattern, name, 0)) {
+				if (!perf_pmu__valid_suffix($1, name))
+					continue;
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc60b0..78af01959830 100644
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
@@ -768,7 +769,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	 */
 	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
 		name = strstr(name, tok);
-		if (!name) {
+		if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
 			res = false;
 			goto out;
 		}
@@ -1872,3 +1873,25 @@ bool perf_pmu__has_hybrid(void)
 
 	return !list_empty(&perf_pmu__hybrid_pmus);
 }
+
+bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
+{
+	char *p;
+
+	/*
+	 * The pmu_name has substring tok. If the format of
+	 * pmu_name is <tok> or <tok>_<digit>, return true.
+	 */
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
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a790ef758171..ebfd2b71532b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   char *name);
 
 bool perf_pmu__has_hybrid(void);
+bool perf_pmu__valid_suffix(char *tok, char *pmu_name);
 
 #endif /* __PMU_H */
-- 
2.17.1

