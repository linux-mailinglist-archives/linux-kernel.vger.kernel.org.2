Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7641C89E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbhI2Poo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:44:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:27517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345157AbhI2Pol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:44:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205117303"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="205117303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 08:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="617567214"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2021 08:43:00 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, jmario@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf script: Support instruction latency
Date:   Wed, 29 Sep 2021 08:38:14 -0700
Message-Id: <1632929894-102778-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The instruction latency information can be recorded on
some platforms, e.g., the Intel Sapphire Rapids server. With both memory
latency (weight) and the new instruction latency information, users can
easily locate the expensive load instructions, and also understand the time
spent in different stages. The users can optimize their applications in
different pipeline stages.

Add a new field "ins_lat" to filter the instruction latency information,
which is available with sample type PERF_SAMPLE_WEIGHT_STRUCT.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index c805152..b007071 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -130,7 +130,7 @@ OPTIONS
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
-        metric, misc, srccode, ipc, data_page_size, code_page_size.
+        metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9f62ac6..4ac47e3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -122,6 +122,7 @@ enum perf_output_field {
 	PERF_OUTPUT_TOD             = 1ULL << 32,
 	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 33,
 	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 34,
+	PERF_OUTPUT_INS_LAT         = 1ULL << 35,
 };
 
 struct perf_script {
@@ -188,6 +189,7 @@ struct output_option {
 	{.str = "tod", .field = PERF_OUTPUT_TOD},
 	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
 	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
+	{.str = "ins_lat", .field = PERF_OUTPUT_INS_LAT},
 };
 
 enum {
@@ -262,7 +264,8 @@ static struct {
 			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
-			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE,
+			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE |
+			      PERF_OUTPUT_INS_LAT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -522,6 +525,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	    evsel__check_stype(evsel, PERF_SAMPLE_CODE_PAGE_SIZE, "CODE_PAGE_SIZE", PERF_OUTPUT_CODE_PAGE_SIZE))
 		return -EINVAL;
 
+	if (PRINT_FIELD(INS_LAT) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_STRUCT, "WEIGHT_STRUCT", PERF_OUTPUT_INS_LAT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2039,6 +2046,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(WEIGHT))
 		fprintf(fp, "%16" PRIu64, sample->weight);
 
+	if (PRINT_FIELD(INS_LAT))
+		fprintf(fp, "%16" PRIu16, sample->ins_lat);
+
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
@@ -3715,7 +3725,7 @@ int cmd_script(int argc, const char **argv)
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
 		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
-		     "data_page_size,code_page_size",
+		     "data_page_size,code_page_size,ins_lat",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.7.4

