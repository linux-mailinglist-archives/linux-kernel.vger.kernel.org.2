Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB13B95B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGARxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:53:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:27809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhGARxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:53:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230241818"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="230241818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 10:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="558735639"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2021 10:51:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf intel-pt: Add a config for max loops without consuming a packet
Date:   Thu,  1 Jul 2021 20:51:32 +0300
Message-Id: <20210701175132.3977-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel PT decoder limits the number of unconditional branches (e.g.
jmps) decoded without consuming any trace packets. Generally, a loop
needs a conditional branch which generates a TNT packet, whereas a
"ret" instruction will generate a TIP or TNT packet. So exceeding
the limit is assumed to be a never-ending loop, which can happen if
there has been a decoding error putting the decoder at the wrong place in
the code.

Up until now, the limit of 10000 has been enough but some analytic
purposes have been reported to exceed that.

Increase the limit to 100000, and make it configurable via perf config
intel-pt.max-loops. Also amend the "Never-ending loop" message to
mention the configuration entry.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-config.txt            |  6 ++++++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 +++++++++----
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |  1 +
 tools/perf/util/intel-pt.c                          |  5 +++++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index b0872c801866..3bb75c1f25e8 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -706,6 +706,12 @@ intel-pt.*::
 		If set, Intel PT decoder will set the mispred flag on all
 		branches.
 
+	intel-pt.max-loops::
+		If set and non-zero, the maximum number of unconditional
+		branches decoded without consuming any trace packets. If
+		the maximum is exceeded there will be a "Never-ending loop"
+		error. The default is 100000.
+
 auxtrace.*::
 
 	auxtrace.dumpdir::
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index cb2520abf261..5ab631702769 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -41,8 +41,11 @@
 
 #define INTEL_PT_RETURN 1
 
-/* Maximum number of loops with no packets consumed i.e. stuck in a loop */
-#define INTEL_PT_MAX_LOOPS 10000
+/*
+ * Default maximum number of loops with no packets consumed i.e. stuck in a
+ * loop.
+ */
+#define INTEL_PT_MAX_LOOPS 100000
 
 struct intel_pt_blk {
 	struct intel_pt_blk *prev;
@@ -220,6 +223,7 @@ struct intel_pt_decoder {
 	uint64_t timestamp_insn_cnt;
 	uint64_t sample_insn_cnt;
 	uint64_t stuck_ip;
+	int max_loops;
 	int no_progress;
 	int stuck_ip_prd;
 	int stuck_ip_cnt;
@@ -315,6 +319,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->vm_tm_corr_dry_run = params->vm_tm_corr_dry_run;
 	decoder->first_timestamp    = params->first_timestamp;
 	decoder->last_reliable_timestamp = params->first_timestamp;
+	decoder->max_loops          = params->max_loops ? params->max_loops : INTEL_PT_MAX_LOOPS;
 
 	decoder->flags              = params->flags;
 
@@ -483,7 +488,7 @@ static const char *intel_pt_err_msgs[] = {
 	[INTEL_PT_ERR_OVR]    = "Overflow packet",
 	[INTEL_PT_ERR_LOST]   = "Lost trace data",
 	[INTEL_PT_ERR_UNK]    = "Unknown error!",
-	[INTEL_PT_ERR_NELOOP] = "Never-ending loop",
+	[INTEL_PT_ERR_NELOOP] = "Never-ending loop (refer perf config intel-pt.max-loops)",
 };
 
 int intel_pt__strerror(int code, char *buf, size_t buflen)
@@ -1168,7 +1173,7 @@ static int intel_pt_walk_insn(struct intel_pt_decoder *decoder,
 				decoder->stuck_ip = decoder->state.to_ip;
 				decoder->stuck_ip_prd = 1;
 				decoder->stuck_ip_cnt = 1;
-			} else if (cnt > INTEL_PT_MAX_LOOPS ||
+			} else if (cnt > decoder->max_loops ||
 				   decoder->state.to_ip == decoder->stuck_ip) {
 				intel_pt_log_at("ERROR: Never-ending loop",
 						decoder->state.to_ip);
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 714c475808c0..4b5e79fcf557 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -270,6 +270,7 @@ struct intel_pt_params {
 	uint32_t tsc_ctc_ratio_d;
 	enum intel_pt_param_flags flags;
 	unsigned int quick;
+	int max_loops;
 };
 
 struct intel_pt_decoder;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9e0539d3a79c..1073c56a512c 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -124,6 +124,7 @@ struct intel_pt {
 	u64 noretcomp_bit;
 	unsigned max_non_turbo_ratio;
 	unsigned cbr2khz;
+	int max_loops;
 
 	unsigned long num_events;
 
@@ -1210,6 +1211,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.vm_time_correlation = pt->synth_opts.vm_time_correlation;
 	params.vm_tm_corr_dry_run = pt->synth_opts.vm_tm_corr_dry_run;
 	params.first_timestamp = pt->first_timestamp;
+	params.max_loops = pt->max_loops;
 
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
@@ -3508,6 +3510,9 @@ static int intel_pt_perf_config(const char *var, const char *value, void *data)
 	if (!strcmp(var, "intel-pt.mispred-all"))
 		pt->mispred_all = perf_config_bool(var, value);
 
+	if (!strcmp(var, "intel-pt.max-loops"))
+		perf_config_int(&pt->max_loops, var, value);
+
 	return 0;
 }
 
-- 
2.17.1

