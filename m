Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99D3621CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhDPOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:23099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244276AbhDPOJJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:09:09 -0400
IronPort-SDR: gDteCWV7xFGHkJEqgD7v+zTLAPt+1QP9QQTvldfmr2o7Wqqbt4Gs/i8nbhuzS2BWggug0zxfX2
 RrgjLeDzvKfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854445"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854445"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:32 -0700
IronPort-SDR: GQlMfAQ5qySTzdPwGNPd9Jfv99dx7H6as2/vjCVvVXoCIHhRFRz04lnx4hsg3bISlN8vQTsuhf
 urqivcQBc3GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766999"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:29 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 24/25] perf tests: Support 'Convert perf time to TSC' test for hybrid
Date:   Fri, 16 Apr 2021 22:05:16 +0800
Message-Id: <20210416140517.18206-25-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for "cycles:u' on hybrid platform, it creates two "cycles".
So the second evsel in evlist also needs initialization.

With this patch,

  # ./perf test 71
  71: Convert perf time to TSC                                        : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 680c3cffb128..72f268c6cc5d 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -20,6 +20,7 @@
 #include "tsc.h"
 #include "mmap.h"
 #include "tests.h"
+#include "pmu.h"
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
@@ -66,6 +67,10 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct mmap *md;
+	bool hybrid = false;
+
+	if (perf_pmu__has_hybrid())
+		hybrid = true;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -88,6 +93,17 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evsel->core.attr.disabled = 1;
 	evsel->core.attr.enable_on_exec = 0;
 
+	/*
+	 * For hybrid "cycles:u", it creates two events.
+	 * Init the second evsel here.
+	 */
+	if (hybrid) {
+		evsel = evsel__next(evsel);
+		evsel->core.attr.comm = 1;
+		evsel->core.attr.disabled = 1;
+		evsel->core.attr.enable_on_exec = 0;
+	}
+
 	CHECK__(evlist__open(evlist));
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
-- 
2.17.1

