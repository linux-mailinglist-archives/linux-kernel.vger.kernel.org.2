Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20F6368CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbhDWFic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:9354 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240759AbhDWFiL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:11 -0400
IronPort-SDR: G9drFC5vFKw6J+PBMU2NhsElB4Z9aS4tEg6jXTB2UOG5nePaVcPLLLn0Uue7QHc/aq6Q5hkq9A
 YawX/8t+++5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501870"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501870"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:35 -0700
IronPort-SDR: 8pBXP2fIo44QoJcyHkzwt345Ev1lYQvYFHH9QmgT5pd65Li3lPCHvgQjx20GNqqQNTW8ap70aU
 tzQQuva9+rlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293752"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 21/26] perf tests: Support 'Track with sched_switch' test for hybrid
Date:   Fri, 23 Apr 2021 13:35:36 +0800
Message-Id: <20210423053541.12521-22-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
v5:
 - Drop the variable 'hybrid' and use 'if (perf_pmu__has_hybrid())'
   directly.

 tools/perf/tests/switch-tracking.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3ebaa758df77..62c0ec21aaa8 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -18,6 +18,7 @@
 #include "record.h"
 #include "tests.h"
 #include "util/mmap.h"
+#include "pmu.h"
 
 static int spin_sleep(void)
 {
@@ -371,7 +372,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
-	err = parse_events(evlist, "cycles:u", NULL);
+	if (perf_pmu__has_hybrid())
+		err = parse_events(evlist, "cpu_core/cycles/u", NULL);
+	else
+		err = parse_events(evlist, "cycles:u", NULL);
 	if (err) {
 		pr_debug("Failed to parse event cycles:u\n");
 		goto out_err;
-- 
2.17.1

