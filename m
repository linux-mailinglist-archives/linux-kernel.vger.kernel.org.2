Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12931E91A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhBRLQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:16:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:58029 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhBRKJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:09:12 -0500
IronPort-SDR: Ia1/qv9iiafkP1+b1wzZtSRUrSJ2iY5jZE3581thlW281FA551ZqZ+bljgsJK1aVCBiy+MFPIv
 4hfvLlaL0u5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127943"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:19 -0800
IronPort-SDR: 0FHn26u9HhyODkgtzAMZiK/trIPqW0x2YAMMsoyKy82LJUiHIVJkV1i6HmfRWeRSFQAIYvbRON
 CFlmUmeYKsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427683"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:17 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] perf intel-pt: Support decoding of guest kernel
Date:   Thu, 18 Feb 2021 11:57:57 +0200
Message-Id: <20210218095801.19576-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest kernel can be found from any guest thread belonging to the guest
machine. The guest machine is associated with the current host process pid.
An idle thread (pid=tid=0) is created as a vehicle from which to find the
guest kernel map.

Decoding guest user space is not supported.

Synthesized samples just need the cpumode set for the guest.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 81 ++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ddb8e6c3ffb0..29d871718995 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -163,6 +163,9 @@ struct intel_pt_queue {
 	int switch_state;
 	pid_t next_tid;
 	struct thread *thread;
+	struct machine *guest_machine;
+	struct thread *unknown_guest_thread;
+	pid_t guest_machine_pid;
 	bool exclude_kernel;
 	bool have_sample;
 	u64 time;
@@ -550,13 +553,59 @@ static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
 	auxtrace_cache__remove(dso->auxtrace_cache, offset);
 }
 
-static inline u8 intel_pt_cpumode(struct intel_pt *pt, uint64_t ip)
+static inline bool intel_pt_guest_kernel_ip(uint64_t ip)
 {
-	return ip >= pt->kernel_start ?
+	/* Assumes 64-bit kernel */
+	return ip & (1ULL << 63);
+}
+
+static inline u8 intel_pt_nr_cpumode(struct intel_pt_queue *ptq, uint64_t ip, bool nr)
+{
+	if (nr) {
+		return intel_pt_guest_kernel_ip(ip) ?
+		       PERF_RECORD_MISC_GUEST_KERNEL :
+		       PERF_RECORD_MISC_GUEST_USER;
+	}
+
+	return ip >= ptq->pt->kernel_start ?
 	       PERF_RECORD_MISC_KERNEL :
 	       PERF_RECORD_MISC_USER;
 }
 
+static inline u8 intel_pt_cpumode(struct intel_pt_queue *ptq, uint64_t from_ip, uint64_t to_ip)
+{
+	/* No support for non-zero CS base */
+	if (from_ip)
+		return intel_pt_nr_cpumode(ptq, from_ip, ptq->state->from_nr);
+	return intel_pt_nr_cpumode(ptq, to_ip, ptq->state->to_nr);
+}
+
+static int intel_pt_get_guest(struct intel_pt_queue *ptq)
+{
+	struct machines *machines = &ptq->pt->session->machines;
+	struct machine *machine;
+	pid_t pid = ptq->pid <= 0 ? DEFAULT_GUEST_KERNEL_ID : ptq->pid;
+
+	if (ptq->guest_machine && pid == ptq->guest_machine_pid)
+		return 0;
+
+	ptq->guest_machine = NULL;
+	thread__zput(ptq->unknown_guest_thread);
+
+	machine = machines__find_guest(machines, pid);
+	if (!machine)
+		return -1;
+
+	ptq->unknown_guest_thread = machine__idle_thread(machine);
+	if (!ptq->unknown_guest_thread)
+		return -1;
+
+	ptq->guest_machine = machine;
+	ptq->guest_machine_pid = pid;
+
+	return 0;
+}
+
 static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				   uint64_t *insn_cnt_ptr, uint64_t *ip,
 				   uint64_t to_ip, uint64_t max_insn_cnt,
@@ -573,19 +622,29 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	u64 offset, start_offset, start_ip;
 	u64 insn_cnt = 0;
 	bool one_map = true;
+	bool nr;
 
 	intel_pt_insn->length = 0;
 
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
 
-	cpumode = intel_pt_cpumode(ptq->pt, *ip);
+	nr = ptq->state->to_nr;
+	cpumode = intel_pt_nr_cpumode(ptq, *ip, nr);
 
-	thread = ptq->thread;
-	if (!thread) {
-		if (cpumode != PERF_RECORD_MISC_KERNEL)
+	if (nr) {
+		if (cpumode != PERF_RECORD_MISC_GUEST_KERNEL ||
+		    intel_pt_get_guest(ptq))
 			return -EINVAL;
-		thread = ptq->pt->unknown_thread;
+		machine = ptq->guest_machine;
+		thread = ptq->unknown_guest_thread;
+	} else {
+		thread = ptq->thread;
+		if (!thread) {
+			if (cpumode != PERF_RECORD_MISC_KERNEL)
+				return -EINVAL;
+			thread = ptq->pt->unknown_thread;
+		}
 	}
 
 	while (1) {
@@ -1101,6 +1160,7 @@ static void intel_pt_free_queue(void *priv)
 	if (!ptq)
 		return;
 	thread__zput(ptq->thread);
+	thread__zput(ptq->unknown_guest_thread);
 	intel_pt_decoder_free(ptq->decoder);
 	zfree(&ptq->event_buf);
 	zfree(&ptq->last_branch);
@@ -1315,8 +1375,8 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
 	sample->ip = ptq->state->from_ip;
-	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
 	sample->addr = ptq->state->to_ip;
+	sample->cpumode = intel_pt_cpumode(ptq, sample->ip, sample->addr);
 	sample->period = 1;
 	sample->flags = ptq->flags;
 
@@ -1833,10 +1893,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	else
 		sample.ip = ptq->state->from_ip;
 
-	/* No support for guest mode at this time */
-	cpumode = sample.ip < ptq->pt->kernel_start ?
-		  PERF_RECORD_MISC_USER :
-		  PERF_RECORD_MISC_KERNEL;
+	cpumode = intel_pt_cpumode(ptq, sample.ip, 0);
 
 	event->sample.header.misc = cpumode | PERF_RECORD_MISC_EXACT_IP;
 
-- 
2.17.1

