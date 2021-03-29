Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F934C482
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhC2HDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhC2HCo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:44 -0400
IronPort-SDR: R0nhXkfB5razwptt6irDctuvaVbLveVTXo2DPtV3eip6fuj0YIMO8XqPF9cH/xVqu2Kl31X0Bo
 b/mrJTIPSUhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956321"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:44 -0700
IronPort-SDR: SXcw+sxxyV19EsqFbPezJxVVT5+LGwUJ8eQ5r1tJGCGqAN/uabQdcH+n5p3sfK7DDItQ0lBDU9
 UM+7AAKqNHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677643"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 23/27] perf tests: Support 'Parse and process metrics' test for hybrid
Date:   Mon, 29 Mar 2021 15:00:42 +0800
Message-Id: <20210329070046.8815-24-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some events are not supported. Only pick up some cases for hybrid.

  # ./perf test 67
  67: Parse and process metrics                                       : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/tests/parse-metric.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 4968c4106254..24e5ddff515e 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -11,6 +11,7 @@
 #include "debug.h"
 #include "expr.h"
 #include "stat.h"
+#include "pmu.h"
 
 static struct pmu_event pme_test[] = {
 {
@@ -370,12 +371,17 @@ static int test_metric_group(void)
 
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
+	perf_pmu__scan(NULL);
+
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
 	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
-	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
 	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
 	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
-	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
 	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
+
+	if (!perf_pmu__has_hybrid()) {
+		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
+		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
+	}
 	return 0;
 }
-- 
2.17.1

