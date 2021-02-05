Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98662310FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhBEQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:30:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:14363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233581AbhBEQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:14:24 -0500
IronPort-SDR: bVU/uxRNp5Gl47/bJJ90b5vuhNQhHXAAhzoYxHrtJtxxQC9dyiy1eL04ibymfAxrEuLO/5HRpm
 Wl3LHF7405HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180690071"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180690071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:53:54 -0800
IronPort-SDR: pemjcW/CHGVpcCkBpTMeC+sqHmYSVrmY4jDAaFspJe6gfSxNerucQ+MXbw+Az2PxtAnYze7f3+
 bYbuOr0vTV/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583856354"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 09:53:52 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf intel-pt: Fix IPC with CYC threshold
Date:   Fri,  5 Feb 2021 19:53:49 +0200
Message-Id: <20210205175350.23817-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205175350.23817-1-adrian.hunter@intel.com>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code assumed every CYC-eligible packet has a CYC packet, which is not
the case when CYC thresholds are used. Fix by checking if a CYC packet is
actually present in that case.

Fixes: 5b1dc0fd1da06 ("perf intel-pt: Add support for samples to contain IPC ratio")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 27 +++++++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
 tools/perf/util/intel-pt.c                    | 13 +++++++++
 3 files changed, 41 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ef29f6b25e60..197eb58a39cb 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -24,6 +24,13 @@
 #include "intel-pt-decoder.h"
 #include "intel-pt-log.h"
 
+#define BITULL(x) (1ULL << (x))
+
+/* IA32_RTIT_CTL MSR bits */
+#define INTEL_PT_CYC_ENABLE		BITULL(1)
+#define INTEL_PT_CYC_THRESHOLD		(BITULL(22) | BITULL(21) | BITULL(20) | BITULL(19))
+#define INTEL_PT_CYC_THRESHOLD_SHIFT	19
+
 #define INTEL_PT_BLK_SIZE 1024
 
 #define BIT63 (((uint64_t)1 << 63))
@@ -167,6 +174,8 @@ struct intel_pt_decoder {
 	uint64_t sample_tot_cyc_cnt;
 	uint64_t base_cyc_cnt;
 	uint64_t cyc_cnt_timestamp;
+	uint64_t ctl;
+	uint64_t cyc_threshold;
 	double tsc_to_cyc;
 	bool continuous_period;
 	bool overflow;
@@ -204,6 +213,14 @@ static uint64_t intel_pt_lower_power_of_2(uint64_t x)
 	return x << i;
 }
 
+static uint64_t intel_pt_cyc_threshold(uint64_t ctl)
+{
+	if (!(ctl & INTEL_PT_CYC_ENABLE))
+		return 0;
+
+	return (ctl & INTEL_PT_CYC_THRESHOLD) >> INTEL_PT_CYC_THRESHOLD_SHIFT;
+}
+
 static void intel_pt_setup_period(struct intel_pt_decoder *decoder)
 {
 	if (decoder->period_type == INTEL_PT_PERIOD_TICKS) {
@@ -245,12 +262,15 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 
 	decoder->flags              = params->flags;
 
+	decoder->ctl                = params->ctl;
 	decoder->period             = params->period;
 	decoder->period_type        = params->period_type;
 
 	decoder->max_non_turbo_ratio    = params->max_non_turbo_ratio;
 	decoder->max_non_turbo_ratio_fp = params->max_non_turbo_ratio;
 
+	decoder->cyc_threshold = intel_pt_cyc_threshold(decoder->ctl);
+
 	intel_pt_setup_period(decoder);
 
 	decoder->mtc_shift = params->mtc_period;
@@ -2017,6 +2037,7 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 
 static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 {
+	int last_packet_type = INTEL_PT_PAD;
 	bool no_tip = false;
 	int err;
 
@@ -2025,6 +2046,12 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 		if (err)
 			return err;
 next:
+		if (decoder->cyc_threshold) {
+			if (decoder->sample_cyc && last_packet_type != INTEL_PT_CYC)
+				decoder->sample_cyc = false;
+			last_packet_type = decoder->packet.type;
+		}
+
 		if (decoder->hop) {
 			switch (intel_pt_hop_trace(decoder, &no_tip, &err)) {
 			case HOP_IGNORE:
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index b52937b03c8c..48adaa78acfc 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -244,6 +244,7 @@ struct intel_pt_params {
 	void *data;
 	bool return_compression;
 	bool branch_enable;
+	uint64_t ctl;
 	uint64_t period;
 	enum intel_pt_period_type period_type;
 	unsigned max_non_turbo_ratio;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d6d93ee03019..2fff6f760457 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -893,6 +893,18 @@ static bool intel_pt_sampling_mode(struct intel_pt *pt)
 	return false;
 }
 
+static u64 intel_pt_ctl(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+	u64 config;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (intel_pt_get_config(pt, &evsel->core.attr, &config))
+			return config;
+	}
+	return 0;
+}
+
 static u64 intel_pt_ns_to_ticks(const struct intel_pt *pt, u64 ns)
 {
 	u64 quot, rem;
@@ -1026,6 +1038,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.data = ptq;
 	params.return_compression = intel_pt_return_compression(pt);
 	params.branch_enable = intel_pt_branch_enable(pt);
+	params.ctl = intel_pt_ctl(pt);
 	params.max_non_turbo_ratio = pt->max_non_turbo_ratio;
 	params.mtc_period = intel_pt_mtc_period(pt);
 	params.tsc_ctc_ratio_n = pt->tsc_ctc_ratio_n;
-- 
2.17.1

