Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70BF34C481
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhC2HDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhC2HCl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:41 -0400
IronPort-SDR: WHtEzzciO97xgu37CtmF5vNkRS1PB9p1lhQQLhYOyFk4qII2GZeYO5J6xbH2jcYiuLnnAGLnE5
 hJJlz3J59TBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956317"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:41 -0700
IronPort-SDR: yHP1AEXo2xT066hfHyiv0W+yCvR47TFCH5zLMaqQENkhnNmcOMlKZ3Vc91M2yCrF3M1kVsE8TR
 kQzeVrdnqi/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677633"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:39 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 22/27] perf tests: Support 'Track with sched_switch' test for hybrid
Date:   Mon, 29 Mar 2021 15:00:41 +0800
Message-Id: <20210329070046.8815-23-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for "cycles:u' on hybrid platform, it creates two "cycles".
So the number of events in evlist is not expected in next test
steps. Now we just use one event "cpu_core/cycles:u/" for hybrid.

  # ./perf test 35
  35: Track with sched_switch                                         : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/tests/switch-tracking.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3ebaa758df77..3a12176f8c46 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -18,6 +18,7 @@
 #include "record.h"
 #include "tests.h"
 #include "util/mmap.h"
+#include "pmu.h"
 
 static int spin_sleep(void)
 {
@@ -340,6 +341,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	struct evsel *switch_evsel, *tracking_evsel;
 	const char *comm;
 	int err = -1;
+	bool hybrid = false;
+
+	if (perf_pmu__has_hybrid())
+		hybrid = true;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (!threads) {
@@ -371,7 +376,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
-	err = parse_events(evlist, "cycles:u", NULL);
+	if (!hybrid)
+		err = parse_events(evlist, "cycles:u", NULL);
+	else
+		err = parse_events(evlist, "cpu_core/cycles/u", NULL);
 	if (err) {
 		pr_debug("Failed to parse event cycles:u\n");
 		goto out_err;
-- 
2.17.1

