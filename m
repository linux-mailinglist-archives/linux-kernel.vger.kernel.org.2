Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2746631F546
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:02:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:1624 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSHCg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:02:36 -0500
IronPort-SDR: Msa6xTfY7DKziBWH/YG7OVR4fGYYW2hZmcJdZijhC4atSrtLb7dbjcqTw8WooKFd6K+gyJ6HDi
 HeB1IBmkl8tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="182969067"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="182969067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 23:00:46 -0800
IronPort-SDR: OoSkKFpDMCjVy7J1iY8HyeFHTwXDMeO2oOHxvszqtkrkFvuDAItXSnMmGi8tMi2WTnqDfqJ8gV
 jx1JsxDyHnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="419864899"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2021 23:00:41 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Create option to disable raw event ordering
Date:   Fri, 19 Feb 2021 15:00:05 +0800
Message-Id: <20210219070005.12397-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning "dso not found" is reported when using "perf report -D".

 66702781413407 0x32c0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x2): 28177/28177: 0x55e493e00563 period: 106578 addr: 0
  ... thread: perf:28177
  ...... dso: <not found>

 66702727832429 0x9dd8 [0x38]: PERF_RECORD_COMM exec: triad_loop:28177/28177

The PERF_RECORD_SAMPLE event (timestamp: 66702781413407) should be after the
PERF_RECORD_COMM event (timestamp: 66702727832429), but it's early processed.

So for most of cases, it makes sense to keep the event ordered even for dump
mode. But it would be also useful to disable ordered_events for reporting raw
dump to see events as they are stored in the perf.data file.

So now, set ordered_events by default to true and add a new option
'disable-order' to disable it. For example,

perf report -D --disable-order

Fixes: 977f739b7126b ("perf report: Disable ordered_events for raw dump")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt | 3 +++
 tools/perf/builtin-report.c              | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index f546b5e9db05..87112e8d904e 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -224,6 +224,9 @@ OPTIONS
 --dump-raw-trace::
         Dump raw trace in ASCII.
 
+--disable-order::
+	Disable raw trace ordering.
+
 -g::
 --call-graph=<print_type,threshold[,print_limit],order,sort_key[,branch],value>::
         Display call chains using type, min percent threshold, print limit,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..0d65c98794a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -84,6 +84,7 @@ struct report {
 	bool			nonany_branch_mode;
 	bool			group_set;
 	bool			stitch_lbr;
+	bool			disable_order;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	struct annotation_options annotation_opts;
@@ -1296,6 +1297,8 @@ int cmd_report(int argc, const char **argv)
 	OPTS_EVSWITCH(&report.evswitch),
 	OPT_BOOLEAN(0, "total-cycles", &report.total_cycles_mode,
 		    "Sort all blocks by 'Sampled Cycles%'"),
+	OPT_BOOLEAN(0, "disable-order", &report.disable_order,
+		    "Disable raw trace ordering"),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1329,7 +1332,7 @@ int cmd_report(int argc, const char **argv)
 	if (report.mmaps_mode)
 		report.tasks_mode = true;
 
-	if (dump_trace)
+	if (dump_trace && report.disable_order)
 		report.tool.ordered_events = false;
 
 	if (quiet)
-- 
2.17.1

