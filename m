Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6343AE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhJZJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:04:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:37214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhJZJEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:04:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210639812"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="210639812"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 02:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="723991233"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2021 02:01:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/6] perf intel-pt: Support itrace A option to approximate IPC
Date:   Tue, 26 Oct 2021 12:01:49 +0300
Message-Id: <20211026090152.357591-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026090152.357591-1-adrian.hunter@intel.com>
References: <20211026090152.357591-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, for cycle-acccurate mode, IPC values are an exact number of
instructions and cycles. Due to the granularity of timestamps, that happens
only when a CYC packet correlates to the event.

Support the itrace 'A' option, to use instead, the number of cycles
associated with the current timestamp. This provides IPC information for
every change of timestamp, but at the expense of accuracy.

Furthermore, it can be used in conjunction with dlfilter-show-cycles.so
to provide higher granularity cycle information.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt       |  5 +++++
 .../util/intel-pt-decoder/intel-pt-decoder.c     |  1 +
 .../util/intel-pt-decoder/intel-pt-decoder.h     |  1 +
 tools/perf/util/intel-pt.c                       | 16 ++++++++++++----
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 184ba62420f0..31f1f373c463 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -157,6 +157,10 @@ of instructions and number of cycles since the last update, and thus represent
 the average IPC since the last IPC for that event type.  Note IPC for "branches"
 events is calculated separately from IPC for "instructions" events.
 
+Even with the 'cyc' config term, it is possible to produce IPC information for
+every change of timestamp, but at the expense of accuracy.  That is selected by
+specifying the itrace 'A' option.
+
 Also note that the IPC instruction count may or may not include the current
 instruction.  If the cycle count is associated with an asynchronous branch
 (e.g. page fault or interrupt), then the instruction count does not include the
@@ -873,6 +877,7 @@ The letters are:
 	L	synthesize last branch entries on existing event records
 	s	skip initial number of events
 	q	quicker (less detailed) decoding
+	A	approximate IPC
 	Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
 "Instructions" events look like they were recorded by "perf record -e
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5ab631702769..5f83937bf8f3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -608,6 +608,7 @@ static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
 {
 	decoder->sample_timestamp = decoder->timestamp;
 	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+	decoder->state.cycles = decoder->tot_cyc_cnt;
 }
 
 static void intel_pt_reposition(struct intel_pt_decoder *decoder)
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 4b5e79fcf557..8fd68f7a0963 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -218,6 +218,7 @@ struct intel_pt_state {
 	uint64_t to_ip;
 	uint64_t tot_insn_cnt;
 	uint64_t tot_cyc_cnt;
+	uint64_t cycles;
 	uint64_t timestamp;
 	uint64_t est_timestamp;
 	uint64_t trace_nr;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6f852b305e92..57e49b23ad25 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -163,6 +163,7 @@ struct intel_pt_queue {
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
 	bool sync_switch;
+	bool sample_ipc;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -1571,7 +1572,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		sample.branch_stack = (struct branch_stack *)&dummy_bs;
 	}
 
-	if (ptq->state->flags & INTEL_PT_SAMPLE_IPC)
+	if (ptq->sample_ipc)
 		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_br_insn_cnt;
@@ -1622,7 +1623,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	else
 		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
-	if (ptq->state->flags & INTEL_PT_SAMPLE_IPC)
+	if (ptq->sample_ipc)
 		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
@@ -2198,8 +2199,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	ptq->have_sample = false;
 
-	ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
-	ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
+	if (pt->synth_opts.approx_ipc) {
+		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+		ptq->ipc_cyc_cnt = ptq->state->cycles;
+		ptq->sample_ipc = true;
+	} else {
+		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
+		ptq->sample_ipc = ptq->state->flags & INTEL_PT_SAMPLE_IPC;
+	}
 
 	/*
 	 * Do PEBS first to allow for the possibility that the PEBS timestamp
-- 
2.25.1

