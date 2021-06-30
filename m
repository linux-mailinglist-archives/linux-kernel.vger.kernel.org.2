Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977B3B81B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhF3MNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:13:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:52431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234414AbhF3MNQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:13:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208375721"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="208375721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455235634"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2021 05:10:27 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/2] perf pmu: Add pmu name wildcards matching function
Date:   Wed, 30 Jun 2021 20:09:11 +0800
Message-Id: <20210630120912.6998-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wildcards is supported on pmu name for dynamic pmu events
(e.g. uncore events). Now move the pmu name wildcards matching
to a new function perf_pmu__pattern_match().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.y |  7 +------
 tools/perf/util/pmu.c          | 16 ++++++++++++++++
 tools/perf/util/pmu.h          |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index aba12a4d488e..6d467ce745d8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -311,12 +311,7 @@ event_pmu_name opt_pmu_config
 			CLEANUP_YYABORT;
 
 		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-			char *name = pmu->name;
-
-			if (!strncmp(name, "uncore_", 7) &&
-			    strncmp($1, "uncore_", 7))
-				name += 7;
-			if (!fnmatch(pattern, name, 0)) {
+			if (!perf_pmu__pattern_match(pmu, pattern, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 88c8ecdc60b0..96f5ff9b5440 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -17,6 +17,7 @@
 #include <locale.h>
 #include <regex.h>
 #include <perf/cpumap.h>
+#include <fnmatch.h>
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
@@ -1872,3 +1873,18 @@ bool perf_pmu__has_hybrid(void)
 
 	return !list_empty(&perf_pmu__hybrid_pmus);
 }
+
+int perf_pmu__pattern_match(struct perf_pmu *pmu, char *pattern, char *tok)
+{
+	char *name = pmu->name;
+
+	if (!strncmp(name, "uncore_", 7) &&
+	    strncmp(tok, "uncore_", 7)) {
+		name += 7;
+	}
+
+	if (fnmatch(pattern, name, 0))
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a790ef758171..1b08e706d6e9 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   char *name);
 
 bool perf_pmu__has_hybrid(void);
+int perf_pmu__pattern_match(struct perf_pmu *pmu, char *pattern, char *tok);
 
 #endif /* __PMU_H */
-- 
2.17.1

