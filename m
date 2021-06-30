Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FF3B81B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhF3MNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:13:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:52431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234309AbhF3MNP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:13:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208375724"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="208375724"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455235656"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2021 05:10:30 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf tools: Fix pattern matching for same substring in different pmu type
Date:   Wed, 30 Jun 2021 20:09:12 +0800
Message-Id: <20210630120912.6998-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630120912.6998-1-yao.jin@linux.intel.com>
References: <20210630120912.6998-1-yao.jin@linux.intel.com>
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

For pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
but "uncore_imc_free_running_0" is failed.

Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 96f5ff9b5440..9ee123d77e6d 100644
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
@@ -741,6 +742,28 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
 	return perf_pmu__find_map(NULL);
 }
 
+static bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
+{
+	char *p;
+
+	/*
+	 * The pmu_name has substring tok. If the format of
+	 * pmu_name is tok or tok_digit, return true.
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
+
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
@@ -769,7 +792,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	 */
 	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
 		name = strstr(name, tok);
-		if (!name) {
+		if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
 			res = false;
 			goto out;
 		}
@@ -1886,5 +1909,8 @@ int perf_pmu__pattern_match(struct perf_pmu *pmu, char *pattern, char *tok)
 	if (fnmatch(pattern, name, 0))
 		return -1;
 
+	if (!perf_pmu__valid_suffix(tok, name))
+		return -1;
+
 	return 0;
 }
-- 
2.17.1

