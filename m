Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9B36F61F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhD3HEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:04:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:34057 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhD3HD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:56 -0400
IronPort-SDR: e7YnprjpRd4NU8vC2wtGHBtWRninkqOwyYZzS6YQKcd2Dive7KRv7rQ55aX2ddyzGjrOQxzUjc
 qEyf8S7phIYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312447"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:03:08 -0700
IronPort-SDR: 7ZBq/KGVzmP9Tqb7GPIovqHS5JVfguW4lj8NIMzf0nXnxgtNwSlksG4aKpGjqpUCq1oHoEL+ua
 7VgC4RtevJ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492335"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:03:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/12] perf intel-pt: Pass the first timestamp to the decoder
Date:   Fri, 30 Apr 2021 10:03:06 +0300
Message-Id: <20210430070309.17624-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM Time Correlation will use time ranges to determine whether a TSC packet
belongs to the Host or Guest. To start, the first non-zero timestamp is
needed. Pass that to the decoder.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  |  8 ++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.h  |  4 ++++
 tools/perf/util/intel-pt.c                    | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index c12e4a39b790..7c93ae2bd56c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -140,6 +140,7 @@ struct intel_pt_decoder {
 	uint64_t ctc_delta;
 	uint64_t cycle_cnt;
 	uint64_t cyc_ref_timestamp;
+	uint64_t first_timestamp;
 	uint32_t last_mtc;
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
@@ -265,6 +266,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->branch_enable      = params->branch_enable;
 	decoder->hop                = params->quick >= 1;
 	decoder->leap               = params->quick >= 2;
+	decoder->first_timestamp    = params->first_timestamp;
 
 	decoder->flags              = params->flags;
 
@@ -314,6 +316,12 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	return decoder;
 }
 
+void intel_pt_set_first_timestamp(struct intel_pt_decoder *decoder,
+				  uint64_t first_timestamp)
+{
+	decoder->first_timestamp = first_timestamp;
+}
+
 static void intel_pt_pop_blk(struct intel_pt_stack *stack)
 {
 	struct intel_pt_blk *blk = stack->blk;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index e6e782da45a4..4d78a8c35e2a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -258,6 +258,7 @@ struct intel_pt_params {
 	void *data;
 	bool return_compression;
 	bool branch_enable;
+	uint64_t first_timestamp;
 	uint64_t ctl;
 	uint64_t period;
 	enum intel_pt_period_type period_type;
@@ -285,4 +286,7 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 
 int intel_pt__strerror(int code, char *buf, size_t buflen);
 
+void intel_pt_set_first_timestamp(struct intel_pt_decoder *decoder,
+				  uint64_t first_timestamp);
+
 #endif
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8f6df8eec9b8..858b679d00be 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -78,6 +78,7 @@ struct intel_pt {
 	u64 kernel_start;
 	u64 switch_ip;
 	u64 ptss_ip;
+	u64 first_timestamp;
 
 	struct perf_tsc_conversion tc;
 	bool cap_user_time_zero;
@@ -1181,6 +1182,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.tsc_ctc_ratio_n = pt->tsc_ctc_ratio_n;
 	params.tsc_ctc_ratio_d = pt->tsc_ctc_ratio_d;
 	params.quick = pt->synth_opts.quick;
+	params.first_timestamp = pt->first_timestamp;
 
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
@@ -1245,6 +1247,21 @@ static void intel_pt_free_queue(void *priv)
 	free(ptq);
 }
 
+static void intel_pt_first_timestamp(struct intel_pt *pt, u64 timestamp)
+{
+	unsigned int i;
+
+	pt->first_timestamp = timestamp;
+
+	for (i = 0; i < pt->queues.nr_queues; i++) {
+		struct auxtrace_queue *queue = &pt->queues.queue_array[i];
+		struct intel_pt_queue *ptq = queue->priv;
+
+		if (ptq && ptq->decoder)
+			intel_pt_set_first_timestamp(ptq->decoder, timestamp);
+	}
+}
+
 static void intel_pt_set_pid_tid_cpu(struct intel_pt *pt,
 				     struct auxtrace_queue *queue)
 {
@@ -2947,6 +2964,8 @@ static int intel_pt_process_event(struct perf_session *session,
 							       sample->time);
 		}
 	} else if (timestamp) {
+		if (!pt->first_timestamp)
+			intel_pt_first_timestamp(pt, timestamp);
 		err = intel_pt_process_queues(pt, timestamp);
 	}
 	if (err)
-- 
2.25.1

