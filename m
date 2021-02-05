Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D945310F48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhBEQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:16:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:14369 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhBEQMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:12:12 -0500
IronPort-SDR: /QgKe81SYnRLYzCQ+CG4BuZbq5OqroA63glbNCOkA3XuIVCqBUj/bXAgUFnpwdZ+zhpofmnddT
 kWdaurJ7b3Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180690065"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180690065"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:53:52 -0800
IronPort-SDR: ynvTxF/LxicUa3np6mwAmj/blA1F7JXPBxN1iFzFzayZcN1er13sSL4nSZQuI49ymbhQZ1zs+W
 eh1w4EkbfveA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583856331"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 09:53:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf intel-pt: Fix premature IPC
Date:   Fri,  5 Feb 2021 19:53:48 +0200
Message-Id: <20210205175350.23817-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205175350.23817-1-adrian.hunter@intel.com>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code assumed a change in cycle count means accurate IPC. That is not
correct, for example when sampling both branches and instructions, or at
a FUP packet (which is not CYC-eligible) address. Fix by using an explicit
flag to indicate when IPC can be sampled.

Fixes: 5b1dc0fd1da06 ("perf intel-pt: Add support for samples to contain IPC ratio")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c     | 11 ++++++++++-
 .../util/intel-pt-decoder/intel-pt-decoder.h     |  1 +
 tools/perf/util/intel-pt.c                       | 16 ++++++----------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 91cba0582736..ef29f6b25e60 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2814,9 +2814,18 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		}
 		if (intel_pt_sample_time(decoder->pkt_state)) {
 			intel_pt_update_sample_time(decoder);
-			if (decoder->sample_cyc)
+			if (decoder->sample_cyc) {
 				decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
+				decoder->state.flags |= INTEL_PT_SAMPLE_IPC;
+				decoder->sample_cyc = false;
+			}
 		}
+		/*
+		 * When using only TSC/MTC to compute cycles, IPC can be
+		 * sampled as soon as the cycle count changes.
+		 */
+		if (!decoder->have_cyc)
+			decoder->state.flags |= INTEL_PT_SAMPLE_IPC;
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 8645fc265481..b52937b03c8c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -17,6 +17,7 @@
 #define INTEL_PT_ABORT_TX	(1 << 1)
 #define INTEL_PT_ASYNC		(1 << 2)
 #define INTEL_PT_FUP_IP		(1 << 3)
+#define INTEL_PT_SAMPLE_IPC	(1 << 4)
 
 enum intel_pt_sample_type {
 	INTEL_PT_BRANCH		= 1 << 0,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 60214de42f31..d6d93ee03019 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1381,7 +1381,8 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		sample.branch_stack = (struct branch_stack *)&dummy_bs;
 	}
 
-	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
+	if (ptq->state->flags & INTEL_PT_SAMPLE_IPC)
+		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_br_insn_cnt;
 		ptq->last_br_insn_cnt = ptq->ipc_insn_cnt;
@@ -1431,7 +1432,8 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	else
 		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
-	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
+	if (ptq->state->flags & INTEL_PT_SAMPLE_IPC)
+		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
 		ptq->last_in_insn_cnt = ptq->ipc_insn_cnt;
@@ -1966,14 +1968,8 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	ptq->have_sample = false;
 
-	if (ptq->state->tot_cyc_cnt > ptq->ipc_cyc_cnt) {
-		/*
-		 * Cycle count and instruction count only go together to create
-		 * a valid IPC ratio when the cycle count changes.
-		 */
-		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
-		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
-	}
+	ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+	ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
 
 	/*
 	 * Do PEBS first to allow for the possibility that the PEBS timestamp
-- 
2.17.1

