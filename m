Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC13621CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbhDPOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:23091 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241693AbhDPOIK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:08:10 -0400
IronPort-SDR: Vucg8TKtEqz0cdknpZG8RhdhQxSYj7LBqdYZvwRdZJTVZddr6Z6JKBajBTwMtyb/Pnf27/wSFZ
 tTkYngtWic5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854424"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854424"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:26 -0700
IronPort-SDR: +xyciJsLbn7XJbSDclVeJmdHOdd/w1CZLT3EEd8jINeb6QqE3GmDpC0h/Vycz+/EbXXKys0kw+
 QC8d3jJ6EKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766967"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 22/25] perf tests: Support 'Parse and process metrics' test for hybrid
Date:   Fri, 16 Apr 2021 22:05:14 +0800
Message-Id: <20210416140517.18206-23-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some events are not supported. Only pick up some cases for hybrid.

  # ./perf test 67
  67: Parse and process metrics                                       : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
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

