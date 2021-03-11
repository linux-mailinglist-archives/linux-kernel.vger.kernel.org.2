Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33EC336CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCKHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhCKHJP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:15 -0500
IronPort-SDR: jk/ZFEvFJPvR2QgrUTNID9Sx1Cj8GIsb1YOBzcau9mKyAL1hRXD6dcSpC8vFhw+n7rv6Xn51wf
 WFkuk+aAkqzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246122"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:15 -0800
IronPort-SDR: vV+YanEh9LKqg+gp0E3bsxYV14vgjAtt5YMMvuonP5IOT3ThpBavsMRYyb5O7SXoX0h5kELGv2
 bKHQey+5f0hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938020"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:13 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 23/27] perf tests: Support 'Parse and process metrics' test for hybrid
Date:   Thu, 11 Mar 2021 15:07:38 +0800
Message-Id: <20210311070742.9318-24-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some events are not supported. Only pick up some cases for hybrid.

root@otcpl-adl-s-2:~# ./perf test 67
67: Parse and process metrics                                       : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/parse-metric.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 55bf52e588be..149b18f1f96a 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -370,12 +370,17 @@ static int test_metric_group(void)
 
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
-	return 0;
+
+	if (!perf_pmu__hybrid_exist()) {
+		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
+		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
+	}
+        return 0;
 }
-- 
2.17.1

