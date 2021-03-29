Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A567834C484
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhC2HDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:20038 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhC2HCt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:49 -0400
IronPort-SDR: aJL+auJtBEQiVgaWVrYcIjf3TTi4+ovnyHwl2Z+PfCngp3uqGM8sE3hCljlyTFOCfKsy8/nZbG
 TuAieczAP19w==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956327"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956327"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:49 -0700
IronPort-SDR: yGLUzK3GJnqQ2QCIOoFzW1kgLyoGxPlNSWIABsqw7H1n8QAZGoc4vgGCCrv6lLkEKxcjtv5mPA
 SUD+TiNAurmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677669"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:46 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 25/27] perf tests: Support 'Convert perf time to TSC' test for hybrid
Date:   Mon, 29 Mar 2021 15:00:44 +0800
Message-Id: <20210329070046.8815-26-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
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
v3:
 - No functional change.

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

