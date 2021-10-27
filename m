Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5046243C498
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbhJ0IGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:06:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:24465 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236073AbhJ0IGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229960778"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="229960778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465644330"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 01:03:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/6] perf intel-pt: Support itrace A option to approximate IPC
Date:   Wed, 27 Oct 2021 11:03:31 +0300
Message-Id: <20211027080334.365596-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027080334.365596-1-adrian.hunter@intel.com>
References: <20211027080334.365596-1-adrian.hunter@intel.com>
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
every change of timestamp, but at the expense of accuracy. Due to the
granularity of timestamps, the actual number of cycles increases even
though the cycles reported does not. The number of instructions is known,
but if IPC is reported, cycles can be too low and so IPC is too high. Note
that inaccuracy decreases as the period of sampling increases i.e. if the
number of cycles is too low by a small amount, that becomes less
significant if the number of cycles is large.

Furthermore, it can be used in conjunction with dlfilter-show-cycles.so
to provide higher granularity cycle information.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt       | 10 ++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.c     |  1 +
 .../util/intel-pt-decoder/intel-pt-decoder.h     |  1 +
 tools/perf/util/intel-pt.c                       | 16 ++++++++++++----
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 184ba62420f0..c7457b31f7c9 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -157,6 +157,15 @@ of instructions and number of cycles since the last update, and thus represent
 the average IPC since the last IPC for that event type.  Note IPC for "branches"
 events is calculated separately from IPC for "instructions" events.
 
+Even with the 'cyc' config term, it is possible to produce IPC information for
+every change of timestamp, but at the expense of accuracy.  That is selected by
+specifying the itrace 'A' option.  Due to the granularity of timestamps, the
+actual number of cycles increases even though the cycles reported does not.
+The number of instructions is known, but if IPC is reported, cycles can be too
+low and so IPC is too high.  Note that inaccuracy decreases as the period of
+sampling increases i.e. if the number of cycles is too low by a small amount,
+that becomes less significant if the number of cycles is large.
+
 Also note that the IPC instruction count may or may not include the current
 instruction.  If the cycle count is associated with an asynchronous branch
 (e.g. page fault or interrupt), then the instruction count does not include the
@@ -873,6 +882,7 @@ The letters are:
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

