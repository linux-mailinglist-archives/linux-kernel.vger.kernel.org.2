Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AC368CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhDWFiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:9351 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240787AbhDWFiE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:04 -0400
IronPort-SDR: oXo/7AKsV/CELZjtjDx6n+uDyQgPNPtri/KeJ9jDVgjBIXlHTbsGm61tHqk5U2Lfs8joQzZOnq
 kuqsQ9XV53aA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501858"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501858"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:28 -0700
IronPort-SDR: ruBGwSAR+IZrgvy+3CJQHYjhv//Z3laupWx0sGo2UuZemjNL06bnzPiEQryA2F0qFJyQ16UzA2
 k/EziG2Iiz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293718"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 19/26] perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
Date:   Fri, 23 Apr 2021 13:35:34 +0800
Message-Id: <20210423053541.12521-20-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for one hw event, two hybrid events are created.

For example,

evsel->idx      evsel__name(evsel)
0               cycles
1               cycles
2               instructions
3               instructions
...

So for comparing the evsel name on hybrid, the evsel->idx
needs to be divided by 2.

  # ./perf test 14
  14: Roundtrip evsel->name                                           : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - No change.

 tools/perf/tests/evsel-roundtrip-name.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f7f3e5b4c180..b74cf80d1f10 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -4,6 +4,7 @@
 #include "parse-events.h"
 #include "tests.h"
 #include "debug.h"
+#include "pmu.h"
 #include <errno.h>
 #include <linux/kernel.h>
 
@@ -62,7 +63,8 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	return ret;
 }
 
-static int __perf_evsel__name_array_test(const char *names[], int nr_names)
+static int __perf_evsel__name_array_test(const char *names[], int nr_names,
+					 int distance)
 {
 	int i, err;
 	struct evsel *evsel;
@@ -82,9 +84,9 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel__name(evsel), names[evsel->idx])) {
+		if (strcmp(evsel__name(evsel), names[evsel->idx / distance])) {
 			--err;
-			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx]);
+			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx / distance]);
 		}
 	}
 
@@ -93,18 +95,21 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 	return err;
 }
 
-#define perf_evsel__name_array_test(names) \
-	__perf_evsel__name_array_test(names, ARRAY_SIZE(names))
+#define perf_evsel__name_array_test(names, distance) \
+	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
 
 int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = 0, ret = 0;
 
-	err = perf_evsel__name_array_test(evsel__hw_names);
+	if (perf_pmu__has_hybrid())
+		return perf_evsel__name_array_test(evsel__hw_names, 2);
+
+	err = perf_evsel__name_array_test(evsel__hw_names, 1);
 	if (err)
 		ret = err;
 
-	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1);
+	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1, 1);
 	if (err)
 		ret = err;
 
-- 
2.17.1

