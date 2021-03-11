Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D54336CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhCKHJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhCKHJN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:13 -0500
IronPort-SDR: cK3/AVJez5JLjpwJl8bMiR4pepkFvxbnTTv9E3EW1/vNS6gxGPbHv8tHlBa41WHDehOKSZQSxd
 QQ78D3OZzBZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246113"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:13 -0800
IronPort-SDR: rVwHcjj8SMSBf/soIaJbMiDSM2mVLWlqgxEZZh26/il702Nvi0kRbYIRoF6y44KmpSrFKMvTNI
 KtHfAJLwahqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938016"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:10 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 22/27] perf tests: Support 'Track with sched_switch' test for hybrid
Date:   Thu, 11 Mar 2021 15:07:37 +0800
Message-Id: <20210311070742.9318-23-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for "cycles:u' on hybrid platform, it creates two "cycles".
So the number of events in evlist is not expected in next test
steps. Now we just use one event "cpu_core/cycles:u/" for hybrid.

root@otcpl-adl-s-2:~# ./perf test 35
35: Track with sched_switch                                         : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/switch-tracking.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 3ebaa758df77..13a11ce51a1a 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -340,6 +340,11 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	struct evsel *switch_evsel, *tracking_evsel;
 	const char *comm;
 	int err = -1;
+	bool hybrid = false;
+
+	perf_pmu__scan(NULL);
+	if (perf_pmu__hybrid_exist())
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
+		err = parse_events(evlist, "cpu_core/cycles:u/", NULL);
 	if (err) {
 		pr_debug("Failed to parse event cycles:u\n");
 		goto out_err;
-- 
2.17.1

