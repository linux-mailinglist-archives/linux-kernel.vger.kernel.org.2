Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4E36BFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhD0HFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237008AbhD0HEs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:48 -0400
IronPort-SDR: 0rOixs04guEL4cRGzeEmQJGNCst4eYNxAcmE5vFWcLFa9zfSjy1PcD2iVBSk9U6SyvkJsKqYx6
 b9TvO2ShKBdQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573067"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:05 -0700
IronPort-SDR: SXmW2T7Pzm3oPrhXFJpMYvKDfVMi5W3DoIKhL2Aaxfp6y/vQqDW45AopiXFoJcTFBa8K2SsGYt
 ghVItpKxwVLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447507005"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:03 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 21/26] perf tests: Support 'Track with sched_switch' test for hybrid
Date:   Tue, 27 Apr 2021 15:01:34 +0800
Message-Id: <20210427070139.25256-22-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
 - No change.

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

