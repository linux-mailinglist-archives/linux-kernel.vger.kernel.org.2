Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2D36BFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhD0HFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:54968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhD0HEv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:51 -0400
IronPort-SDR: Ak839hzma2lsZ2Dr/nrkM4zIAfTwgbyH/F5Jbve3gR/I82DfwSNhYRbbMj+Z1nkn+QWweEuSaJ
 Vk8YAaZQrnQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573069"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573069"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:08 -0700
IronPort-SDR: x602GOg4hDkrckXjIrTsPdWIlGym91N8kKKan0yh3yYUbuUuZd156IlSWdIZLujKsh1xBi/U+L
 +3Cl9nogjNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447507017"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:06 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 22/26] perf tests: Support 'Parse and process metrics' test for hybrid
Date:   Tue, 27 Apr 2021 15:01:35 +0800
Message-Id: <20210427070139.25256-23-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some events are not supported. Only pick up some cases for hybrid.

  # ./perf test 68
  68: Parse and process metrics                                       : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

v5:
 - Remove the perf_pmu_scan() since it's called in
   perf_pmu__has_hybrid() yet.

 tools/perf/tests/parse-metric.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 4968c4106254..4f6f4904e852 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -11,6 +11,7 @@
 #include "debug.h"
 #include "expr.h"
 #include "stat.h"
+#include "pmu.h"
 
 static struct pmu_event pme_test[] = {
 {
@@ -372,10 +373,13 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
 {
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

