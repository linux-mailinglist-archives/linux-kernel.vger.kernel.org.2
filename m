Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697C3BF3A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhGHBlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:41:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:38895 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhGHBlJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:41:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270538748"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270538748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 18:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="457708836"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2021 18:38:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/4] perf tests: Fix 'Parse event definition strings' on core-only system
Date:   Thu,  8 Jul 2021 09:36:59 +0800
Message-Id: <20210708013701.20347-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708013701.20347-1-yao.jin@linux.intel.com>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the atom CPUs are offlined, the 'cpu_atom' is not valid.
We don't need the test case for 'cpu_atom'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/parse-events.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0f113b2b36a3..3ca515fb141f 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -6,6 +6,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
+#include "pmu-hybrid.h"
 #include <dirent.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -1596,6 +1597,13 @@ static int test__hybrid_raw1(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
+	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
+		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+		return 0;
+	}
+
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
@@ -1620,13 +1628,9 @@ static int test__hybrid_cache_event(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
-
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", 0x10002 == (evsel->core.attr.config & 0xffffffff));
 	return 0;
 }
 
@@ -2028,7 +2032,7 @@ static struct evlist_test test__hybrid_events[] = {
 		.id    = 7,
 	},
 	{
-		.name  = "cpu_core/LLC-loads/,cpu_atom/LLC-load-misses/",
+		.name  = "cpu_core/LLC-loads/",
 		.check = test__hybrid_cache_event,
 		.id    = 8,
 	},
-- 
2.17.1

