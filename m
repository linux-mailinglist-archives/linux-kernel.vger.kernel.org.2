Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56E3C16D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGHQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:07:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:22879 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhGHQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:07:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209575786"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="209575786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 09:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="492164779"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2021 09:04:20 -0700
From:   kan.liang@intel.com
To:     acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf stat: Add Topdown metrics L2 events as default events
Date:   Thu,  8 Jul 2021 09:02:49 -0700
Message-Id: <1625760169-18396-1-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Topdown Microarchitecture Analysis (TMA) Method is a structured
analysis methodology to identify critical performance bottlenecks in
out-of-order processors. The Topdown metrics L1 event was added as
default events in the commit 42641d6f4d15 ("perf stat: Add Topdown
metrics events as default events"). From the Sapphire Rapids server and
later platforms, the same dedicated "metrics" register is extended to
support both L1 and L2 events. Add both L1 and L2 Topdown metrics events
as default events to enrich the default measuring information, if the
new measurement register is available. On legacy systems there is no
change to avoid extra multiplexing.

The topdown_level indicates the max metrics level for the top-down
statistics. Set it to 2 to display all L1 and L2 Topdown metrics events.

With the patch:

 $ perf stat sleep 1

 Performance counter stats for 'sleep 1':

              0.59 msec task-clock                #    0.001 CPUs utilized
                 1      context-switches          #    1.687 K/sec
                 0      cpu-migrations            #    0.000 /sec
                76      page-faults               #  128.198 K/sec
         1,405,318      cycles                    #    2.371 GHz
         1,471,136      instructions              #    1.05  insn per cycle
           310,132      branches                  #  523.136 M/sec
            10,435      branch-misses             #    3.36% of all branches
         8,431,908      slots                     #   14.223 G/sec
         1,554,116      topdown-retiring          #     18.4% retiring
         1,289,585      topdown-bad-spec          #     15.2% bad speculation
         2,810,636      topdown-fe-bound          #     33.2% frontend bound
         2,810,636      topdown-be-bound          #     33.2% backend bound
           231,464      topdown-heavy-ops         #      2.7% heavy operations       #     15.6% light operations
         1,223,453      topdown-br-mispredict     #     14.5% branch mispredict      #      0.8% machine clears
         1,884,779      topdown-fetch-lat         #     22.3% fetch latency          #     10.9% fetch bandwidth
         1,454,917      topdown-mem-bound         #     17.2% memory bound           #     16.0% Core bound

       1.001179699 seconds time elapsed

       0.000000000 seconds user
       0.001238000 seconds sys

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 6 +++++-
 tools/perf/builtin-stat.c         | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 8c6732c..0b09510 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -5,11 +5,15 @@
 #include "util/parse-events.h"
 
 #define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
+#define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
 
 int arch_evlist__add_default_attrs(struct evlist *evlist)
 {
 	if (!pmu_have_event("cpu", "slots"))
 		return 0;
 
-	return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
+	if (pmu_have_event("cpu", "topdown-heavy-ops"))
+		return parse_events(evlist, TOPDOWN_L2_EVENTS, NULL);
+	else
+		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
 }
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5a830ae..a5e93d4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -154,6 +154,8 @@ static const char *topdown_metric_L2_attrs[] = {
 	NULL,
 };
 
+#define TOPDOWN_MAX_LEVEL			2
+
 static const char *smi_cost_attrs = {
 	"{"
 	"msr/aperf/,"
@@ -1924,6 +1926,7 @@ static int add_default_attributes(void)
 		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
 			return -1;
 
+		stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
 		if (arch_evlist__add_default_attrs(evsel_list) < 0)
 			return -1;
 	}
-- 
2.7.4

