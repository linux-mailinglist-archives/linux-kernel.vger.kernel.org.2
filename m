Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69F3621C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhDPOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:23099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241981AbhDPOIH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:08:07 -0400
IronPort-SDR: 9bi+ZV6Rn5aWaZp3r5TDgHYH/qY+uS2yE1E09Eo9RyiJRJG8WnwLFJ6jDJBgoQLPbxozCTsLny
 Tar7DcxOKSfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854411"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:22 -0700
IronPort-SDR: tJRshybsdz8G9E9jotllid3kQIWeDI7FMxR8aStIeMZnoN6fXN3ioj9Ip/Ay6D/RbwZNBx8FJG
 khBYMiD+46jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766932"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 21/25] perf tests: Support 'Track with sched_switch' test for hybrid
Date:   Fri, 16 Apr 2021 22:05:13 +0800
Message-Id: <20210416140517.18206-22-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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

