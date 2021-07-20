Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD53CFE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbhGTPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:11:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3438 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhGTOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:34:33 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GThmp1tPJz6J7Cw;
        Tue, 20 Jul 2021 23:03:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 17:15:06 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 16:15:02 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <yao.jin@linux.intel.com>, <kjain@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <irogers@google.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] perf pmu: Fix alias matching
Date:   Tue, 20 Jul 2021 23:10:19 +0800
Message-ID: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c47a5599eda32 ("perf tools: Fix pattern matching for same substring
in different PMU type"), may have fixed some alias matching, but has broken
some others.

Firstly it cannot handle the simple scenario of PMU name in form
pmu_name{digits} - it can only handle pmu_name_{digits}.

Secondly it cannot handle more complex matching in the case where we have
multiple tokens. In this scenario, the code failed to realise that we
may examine multiple substrings in the PMU name.

Fix in two ways:
- Change perf_pmu__valid_suffix() to accept a PMU name without '_' in the
  suffix
- Only pay attention to perf_pmu__valid_suffix() for the final token

Also add const qualifiers as necessary to avoid casting.

Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same substring in different PMU type")
Signed-off-by: John Garry <john.garry@huawei.com>
---
@Jin Yao, please test for your scenarios

Note:
About any effect in perf_pmu__match() -> perf_pmu__valid_suffix()
callchain, this seems to be called for wildcard in PMU names in metric
expressions. We don't have any metrics for arm64 which use feature.
However, I hacked an existing metric to use a wildcard and it looks ok.
Also the "DRAM_BW_Use" metric on my broadwell uses this feature, and it
looks ok.

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a1bd7007a8b4..fc683bc41715 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -742,9 +742,13 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
 	return perf_pmu__find_map(NULL);
 }
 
-static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
+/*
+ * Suffix must be in form tok_{digits}, or tok{digits}, or same as pmu_name
+ * to be valid.
+ */
+static bool perf_pmu__valid_suffix(const char *pmu_name, char *tok)
 {
-	char *p;
+	const char *p;
 
 	if (strncmp(pmu_name, tok, strlen(tok)))
 		return false;
@@ -753,12 +757,16 @@ static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
 	if (*p == 0)
 		return true;
 
-	if (*p != '_')
-		return false;
+	if (*p == '_')
+		++p;
 
-	++p;
-	if (*p == 0 || !isdigit(*p))
-		return false;
+	/* Ensure we end in a number */
+	while (1) {
+		if (!isdigit(*p))
+			return false;
+		if (*(++p) == 0)
+			break;
+	}
 
 	return true;
 }
@@ -789,12 +797,19 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
 	 *	    "pmunameY".
 	 */
-	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
+	while (1) {
+		char *next_tok = strtok_r(NULL, ",", &tmp);
+
 		name = strstr(name, tok);
-		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
+		if (!name ||
+		    (!next_tok && !perf_pmu__valid_suffix(name, tok))) {
 			res = false;
 			goto out;
 		}
+		if (!next_tok)
+			break;
+		tok = next_tok;
+		name += strlen(tok);
 	}
 
 	res = true;
-- 
2.26.2

