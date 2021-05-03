Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B83711B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhECGm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 02:42:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:3237 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhECGm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 02:42:56 -0400
IronPort-SDR: jvLsiMMZMJvMW4KKN67E0NmYGBjtYRRX4zvfqiGyRzml55ese3B3NE6/53kjbllONONXhC5Yu4
 DgIvj1EJLUcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9972"; a="195619563"
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="195619563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2021 23:42:02 -0700
IronPort-SDR: wj53SVAvvDWZ367WTI7NPQMy2RaQlNT/gF1X89rWZ6REVbCOOutNwkdH40EbpBlUCI6301Nmej
 zTMsYKHntxDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="427319054"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2021 23:42:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf record: Set timestamp boundary for AUX area events
Date:   Mon,  3 May 2021 09:42:22 +0300
Message-Id: <20210503064222.5319-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX area data is not processed by 'perf record' and consequently the
 --timestamp-boundary option may result in no values for "time of first
sample" and "time of last sample". However there are non-sample events
that can be used instead, namely 'itrace_start' and 'aux'.
'itrace_start' is issued before tracing starts, and 'aux' is issued
every time data is ready.

Implement tool callbacks for those two for 'perf record', to update the
timestamp boundary.

Example:

 $ perf record -e intel_pt//u --timestamp-boundary uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.022 MB perf.data ]
 $ perf script --header-only | grep "time of"
 # time of first sample : 4574.835541
 # time of last sample : 4574.835907
 $ perf script --itrace=be -F-ip | head -1
           uname 13752 [001]  4574.835589:          1 branches:uH:
 $ perf script --itrace=be -F-ip | tail -1
           uname 13752 [001]  4574.835867:          1 branches:uH:
 $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5fb9665a2ec2..78e6c9e48379 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -967,6 +967,15 @@ static int record__open(struct record *rec)
 	return rc;
 }
 
+static void set_timestamp_boundary(struct record *rec, u64 sample_time)
+{
+	if (rec->evlist->first_sample_time == 0)
+		rec->evlist->first_sample_time = sample_time;
+
+	if (sample_time)
+		rec->evlist->last_sample_time = sample_time;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -975,10 +984,7 @@ static int process_sample_event(struct perf_tool *tool,
 {
 	struct record *rec = container_of(tool, struct record, tool);
 
-	if (rec->evlist->first_sample_time == 0)
-		rec->evlist->first_sample_time = sample->time;
-
-	rec->evlist->last_sample_time = sample->time;
+	set_timestamp_boundary(rec, sample->time);
 
 	if (rec->buildid_all)
 		return 0;
@@ -2372,6 +2378,17 @@ static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *eve
 	return perf_event__process_mmap2(tool, event, sample, machine);
 }
 
+static int process_timestamp_boundary(struct perf_tool *tool,
+				      union perf_event *event __maybe_unused,
+				      struct perf_sample *sample,
+				      struct machine *machine __maybe_unused)
+{
+	struct record *rec = container_of(tool, struct record, tool);
+
+	set_timestamp_boundary(rec, sample->time);
+	return 0;
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2406,6 +2423,8 @@ static struct record record = {
 		.namespaces	= perf_event__process_namespaces,
 		.mmap		= build_id__process_mmap,
 		.mmap2		= build_id__process_mmap2,
+		.itrace_start	= process_timestamp_boundary,
+		.aux		= process_timestamp_boundary,
 		.ordered_events	= true,
 	},
 };
-- 
2.17.1

