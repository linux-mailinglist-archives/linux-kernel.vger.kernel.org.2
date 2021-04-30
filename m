Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6A36F620
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhD3HEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:04:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:34066 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhD3HD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:59 -0400
IronPort-SDR: +VA+D8y6XsXvSbFBN/iB3HbcrjQUy67v3If5pC82zf2zv7nmJyEkQXcGO8oCl4Ok10xOFKwzmc
 nQorq8tDZHsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312457"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:03:12 -0700
IronPort-SDR: F62JJjaNYOC5LbS7C2W162kBoxC5AC1eJPE+oEbzcghiOoyOcIIpRXLcIyIwrGOzGFpYE3iYJA
 qiP25f6lg9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492355"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:03:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/12] perf intel-pt: Add VM Time Correlation to decoder
Date:   Fri, 30 Apr 2021 10:03:08 +0300
Message-Id: <20210430070309.17624-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM Time Correlation means determining if each TSC packet belongs to a VM
Guest or the Host. When the trace is "in context" that is indicated by
the NR flag in the PIP packet. However, when tracing kernel-only,
userspace only, or using address filters, the trace can be "out of context"
in which case timing packets are produced but not PIP packets.

Nevertheless, it is very unlikely the VM Guest timestamps will be in
the same range as the Host timestamps. Host time ranges are established
by a starting side-band event timestamp, and subsequently by the buffer
timestamp, written when the buffer is copied to the perf.data file.

This patch supports updating the VM Guest timestamp packets, assuming an
unchanging (during perf record) VMX TSC Offset and no VMX TSC scaling.

Furthermore, it is possible to determine what the VMX TSC Offset is,
although not necessarily at the start. The dry-run option lets that
information be determined so that the user can pass it to a subsequent
run. For more detail, refer to the example in the Intel PT documentation
in a subsequent patch.

VM Time Correlation is also performed on the TSC value in PEBs-via-PT
records.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 689 ++++++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.h  |   2 +
 .../perf/util/intel-pt-decoder/intel-pt-log.h |   5 +
 3 files changed, 696 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index c4044bc2fb86..0db5f948801f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -35,6 +35,10 @@
 
 #define BIT63 (((uint64_t)1 << 63))
 
+#define SEVEN_BYTES 0xffffffffffffffULL
+
+#define NO_VMCS 0xffffffffffULL
+
 #define INTEL_PT_RETURN 1
 
 /* Maximum number of loops with no packets consumed i.e. stuck in a loop */
@@ -51,6 +55,11 @@ struct intel_pt_stack {
 	int pos;
 };
 
+enum intel_pt_p_once {
+	INTEL_PT_PRT_ONCE_UNK_VMCS,
+	INTEL_PT_PRT_ONCE_ERANGE,
+};
+
 enum intel_pt_pkt_state {
 	INTEL_PT_STATE_NO_PSB,
 	INTEL_PT_STATE_NO_IP,
@@ -64,6 +73,7 @@ enum intel_pt_pkt_state {
 	INTEL_PT_STATE_FUP_NO_TIP,
 	INTEL_PT_STATE_FUP_IN_PSB,
 	INTEL_PT_STATE_RESAMPLE,
+	INTEL_PT_STATE_VM_TIME_CORRELATION,
 };
 
 static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
@@ -75,6 +85,7 @@ static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
 	case INTEL_PT_STATE_IN_SYNC:
 	case INTEL_PT_STATE_TNT_CONT:
 	case INTEL_PT_STATE_RESAMPLE:
+	case INTEL_PT_STATE_VM_TIME_CORRELATION:
 		return true;
 	case INTEL_PT_STATE_TNT:
 	case INTEL_PT_STATE_TIP:
@@ -123,6 +134,11 @@ struct intel_pt_decoder {
 	bool in_psb;
 	bool hop;
 	bool leap;
+	bool vm_time_correlation;
+	bool vm_tm_corr_dry_run;
+	bool vm_tm_corr_reliable;
+	bool vm_tm_corr_same_buf;
+	bool vm_tm_corr_continuous;
 	bool nr;
 	bool next_nr;
 	enum intel_pt_param_flags flags;
@@ -141,6 +157,10 @@ struct intel_pt_decoder {
 	uint64_t cycle_cnt;
 	uint64_t cyc_ref_timestamp;
 	uint64_t first_timestamp;
+	uint64_t last_reliable_timestamp;
+	uint64_t vmcs;
+	uint64_t print_once;
+	uint64_t last_ctc;
 	uint32_t last_mtc;
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
@@ -219,6 +239,31 @@ static uint64_t intel_pt_lower_power_of_2(uint64_t x)
 	return x << i;
 }
 
+__printf(1, 2)
+static void p_log(const char *fmt, ...)
+{
+	char buf[512];
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	fprintf(stderr, "%s\n", buf);
+	intel_pt_log("%s\n", buf);
+}
+
+static bool intel_pt_print_once(struct intel_pt_decoder *decoder,
+				enum intel_pt_p_once id)
+{
+	uint64_t bit = 1ULL << id;
+
+	if (decoder->print_once & bit)
+		return false;
+	decoder->print_once |= bit;
+	return true;
+}
+
 static uint64_t intel_pt_cyc_threshold(uint64_t ctl)
 {
 	if (!(ctl & INTEL_PT_CYC_ENABLE))
@@ -266,7 +311,10 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->branch_enable      = params->branch_enable;
 	decoder->hop                = params->quick >= 1;
 	decoder->leap               = params->quick >= 2;
+	decoder->vm_time_correlation = params->vm_time_correlation;
+	decoder->vm_tm_corr_dry_run = params->vm_tm_corr_dry_run;
 	decoder->first_timestamp    = params->first_timestamp;
+	decoder->last_reliable_timestamp = params->first_timestamp;
 
 	decoder->flags              = params->flags;
 
@@ -587,6 +635,7 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder, bool reposition)
 		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
 		decoder->state.trace_nr = buffer.trace_nr;
+		decoder->vm_tm_corr_same_buf = false;
 		intel_pt_log("Reference timestamp 0x%" PRIx64 "\n",
 			     decoder->ref_timestamp);
 		return -ENOLINK;
@@ -1475,9 +1524,24 @@ static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
 	return timestamp;
 }
 
+/* For use only when decoder->vm_time_correlation is true */
+static bool intel_pt_time_in_range(struct intel_pt_decoder *decoder,
+				   uint64_t timestamp)
+{
+	uint64_t max_timestamp = decoder->buf_timestamp;
+
+	if (!max_timestamp) {
+		max_timestamp = decoder->last_reliable_timestamp +
+				0x400000000ULL;
+	}
+	return timestamp >= decoder->last_reliable_timestamp &&
+	       timestamp < decoder->buf_timestamp;
+}
+
 static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 {
 	uint64_t timestamp;
+	bool bad = false;
 
 	decoder->have_tma = false;
 
@@ -1507,8 +1571,13 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 			} else {
 				intel_pt_log_to("Suppressing bad timestamp", timestamp);
 				timestamp = decoder->timestamp;
+				bad = true;
 			}
 		}
+		if (decoder->vm_time_correlation &&
+		    (bad || !intel_pt_time_in_range(decoder, timestamp)) &&
+		    intel_pt_print_once(decoder, INTEL_PT_PRT_ONCE_ERANGE))
+			p_log("Timestamp out of range");
 		decoder->timestamp = timestamp;
 		decoder->timestamp_insn_cnt = 0;
 	}
@@ -1585,6 +1654,7 @@ static void intel_pt_calc_tma(struct intel_pt_decoder *decoder)
 		intel_pt_mtc_cyc_cnt_upd(decoder);
 
 	decoder->last_mtc = (ctc >> decoder->mtc_shift) & 0xff;
+	decoder->last_ctc = ctc - ctc_rem;
 	decoder->ctc_timestamp = decoder->tsc_timestamp - fc;
 	if (decoder->tsc_ctc_mult) {
 		decoder->ctc_timestamp -= ctc_rem * decoder->tsc_ctc_mult;
@@ -1969,6 +2039,613 @@ static int intel_pt_resample(struct intel_pt_decoder *decoder)
 	return 0;
 }
 
+struct intel_pt_vm_tsc_info {
+	struct intel_pt_pkt pip_packet;
+	struct intel_pt_pkt vmcs_packet;
+	struct intel_pt_pkt tma_packet;
+	bool tsc, pip, vmcs, tma, psbend;
+	uint64_t ctc_delta;
+	uint64_t last_ctc;
+	int max_lookahead;
+};
+
+/* Lookahead and get the PIP, VMCS and TMA packets from PSB+ */
+static int intel_pt_vm_psb_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
+{
+	struct intel_pt_vm_tsc_info *data = pkt_info->data;
+
+	switch (pkt_info->packet.type) {
+	case INTEL_PT_PAD:
+	case INTEL_PT_MNT:
+	case INTEL_PT_MODE_EXEC:
+	case INTEL_PT_MODE_TSX:
+	case INTEL_PT_MTC:
+	case INTEL_PT_FUP:
+	case INTEL_PT_CYC:
+	case INTEL_PT_CBR:
+		break;
+
+	case INTEL_PT_TSC:
+		data->tsc = true;
+		break;
+
+	case INTEL_PT_TMA:
+		data->tma_packet = pkt_info->packet;
+		data->tma = true;
+		break;
+
+	case INTEL_PT_PIP:
+		data->pip_packet = pkt_info->packet;
+		data->pip = true;
+		break;
+
+	case INTEL_PT_VMCS:
+		data->vmcs_packet = pkt_info->packet;
+		data->vmcs = true;
+		break;
+
+	case INTEL_PT_PSBEND:
+		data->psbend = true;
+		return 1;
+
+	case INTEL_PT_TIP_PGE:
+	case INTEL_PT_PTWRITE:
+	case INTEL_PT_PTWRITE_IP:
+	case INTEL_PT_EXSTOP:
+	case INTEL_PT_EXSTOP_IP:
+	case INTEL_PT_MWAIT:
+	case INTEL_PT_PWRE:
+	case INTEL_PT_PWRX:
+	case INTEL_PT_BBP:
+	case INTEL_PT_BIP:
+	case INTEL_PT_BEP:
+	case INTEL_PT_BEP_IP:
+	case INTEL_PT_OVF:
+	case INTEL_PT_BAD:
+	case INTEL_PT_TNT:
+	case INTEL_PT_TIP_PGD:
+	case INTEL_PT_TIP:
+	case INTEL_PT_PSB:
+	case INTEL_PT_TRACESTOP:
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+struct intel_pt_ovf_fup_info {
+	int max_lookahead;
+	bool found;
+};
+
+/* Lookahead to detect a FUP packet after OVF */
+static int intel_pt_ovf_fup_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
+{
+	struct intel_pt_ovf_fup_info *data = pkt_info->data;
+
+	if (pkt_info->packet.type == INTEL_PT_CYC ||
+	    pkt_info->packet.type == INTEL_PT_MTC ||
+	    pkt_info->packet.type == INTEL_PT_TSC)
+		return !--(data->max_lookahead);
+	data->found = pkt_info->packet.type == INTEL_PT_FUP;
+	return 1;
+}
+
+static bool intel_pt_ovf_fup_lookahead(struct intel_pt_decoder *decoder)
+{
+	struct intel_pt_ovf_fup_info data = {
+		.max_lookahead = 16,
+		.found = false,
+	};
+
+	intel_pt_pkt_lookahead(decoder, intel_pt_ovf_fup_lookahead_cb, &data);
+	return data.found;
+}
+
+/* Lookahead and get the TMA packet after TSC */
+static int intel_pt_tma_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
+{
+	struct intel_pt_vm_tsc_info *data = pkt_info->data;
+
+	if (pkt_info->packet.type == INTEL_PT_CYC ||
+	    pkt_info->packet.type == INTEL_PT_MTC)
+		return !--(data->max_lookahead);
+
+	if (pkt_info->packet.type == INTEL_PT_TMA) {
+		data->tma_packet = pkt_info->packet;
+		data->tma = true;
+	}
+	return 1;
+}
+
+static uint64_t intel_pt_ctc_to_tsc(struct intel_pt_decoder *decoder, uint64_t ctc)
+{
+	if (decoder->tsc_ctc_mult)
+		return ctc * decoder->tsc_ctc_mult;
+	else
+		return multdiv(ctc, decoder->tsc_ctc_ratio_n, decoder->tsc_ctc_ratio_d);
+}
+
+static uint64_t intel_pt_calc_expected_tsc(struct intel_pt_decoder *decoder,
+					   uint32_t ctc,
+					   uint32_t fc,
+					   uint64_t last_ctc_timestamp,
+					   uint64_t ctc_delta,
+					   uint32_t last_ctc)
+{
+	/* Number of CTC ticks from last_ctc_timestamp to last_mtc */
+	uint64_t last_mtc_ctc = last_ctc + ctc_delta;
+	/*
+	 * Number of CTC ticks from there until current TMA packet. We would
+	 * expect last_mtc_ctc to be before ctc, but the TSC packet can slip
+	 * past an MTC, so a sign-extended value is used.
+	 */
+	uint64_t delta = (int16_t)((uint16_t)ctc - (uint16_t)last_mtc_ctc);
+	/* Total CTC ticks from last_ctc_timestamp to current TMA packet */
+	uint64_t new_ctc_delta = ctc_delta + delta;
+	uint64_t expected_tsc;
+
+	/*
+	 * Convert CTC ticks to TSC ticks, add the starting point
+	 * (last_ctc_timestamp) and the fast counter from the TMA packet.
+	 */
+	expected_tsc = last_ctc_timestamp + intel_pt_ctc_to_tsc(decoder, new_ctc_delta) + fc;
+
+	if (intel_pt_enable_logging) {
+		intel_pt_log_x64(last_mtc_ctc);
+		intel_pt_log_x32(last_ctc);
+		intel_pt_log_x64(ctc_delta);
+		intel_pt_log_x64(delta);
+		intel_pt_log_x32(ctc);
+		intel_pt_log_x64(new_ctc_delta);
+		intel_pt_log_x64(last_ctc_timestamp);
+		intel_pt_log_x32(fc);
+		intel_pt_log_x64(intel_pt_ctc_to_tsc(decoder, new_ctc_delta));
+		intel_pt_log_x64(expected_tsc);
+	}
+
+	return expected_tsc;
+}
+
+static uint64_t intel_pt_expected_tsc(struct intel_pt_decoder *decoder,
+				      struct intel_pt_vm_tsc_info *data)
+{
+	uint32_t ctc = data->tma_packet.payload;
+	uint32_t fc = data->tma_packet.count;
+
+	return intel_pt_calc_expected_tsc(decoder, ctc, fc,
+					  decoder->ctc_timestamp,
+					  data->ctc_delta, data->last_ctc);
+}
+
+static void intel_pt_translate_vm_tsc(struct intel_pt_decoder *decoder,
+				      struct intel_pt_vmcs_info *vmcs_info)
+{
+	uint64_t payload = decoder->packet.payload;
+
+	/* VMX adds the TSC Offset, so subtract to get host TSC */
+	decoder->packet.payload -= vmcs_info->tsc_offset;
+	/* TSC packet has only 7 bytes */
+	decoder->packet.payload &= SEVEN_BYTES;
+
+	/*
+	 * The buffer is mmapped from the data file, so this also updates the
+	 * data file.
+	 */
+	if (!decoder->vm_tm_corr_dry_run)
+		memcpy((void *)decoder->buf + 1, &decoder->packet.payload, 7);
+
+	intel_pt_log("Translated VM TSC %#" PRIx64 " -> %#" PRIx64
+		     "    VMCS %#" PRIx64 "    TSC Offset %#" PRIx64 "\n",
+		     payload, decoder->packet.payload, vmcs_info->vmcs,
+		     vmcs_info->tsc_offset);
+}
+
+static void intel_pt_translate_vm_tsc_offset(struct intel_pt_decoder *decoder,
+					     uint64_t tsc_offset)
+{
+	struct intel_pt_vmcs_info vmcs_info = {
+		.vmcs = NO_VMCS,
+		.tsc_offset = tsc_offset
+	};
+
+	intel_pt_translate_vm_tsc(decoder, &vmcs_info);
+}
+
+static inline bool in_vm(uint64_t pip_payload)
+{
+	return pip_payload & 1;
+}
+
+static inline bool pip_in_vm(struct intel_pt_pkt *pip_packet)
+{
+	return pip_packet->payload & 1;
+}
+
+static void intel_pt_print_vmcs_info(struct intel_pt_vmcs_info *vmcs_info)
+{
+	p_log("VMCS: %#" PRIx64 "  TSC Offset %#" PRIx64,
+	      vmcs_info->vmcs, vmcs_info->tsc_offset);
+}
+
+static void intel_pt_vm_tm_corr_psb(struct intel_pt_decoder *decoder,
+				    struct intel_pt_vm_tsc_info *data)
+{
+	memset(data, 0, sizeof(*data));
+	data->ctc_delta = decoder->ctc_delta;
+	data->last_ctc = decoder->last_ctc;
+	intel_pt_pkt_lookahead(decoder, intel_pt_vm_psb_lookahead_cb, data);
+	if (data->tsc && !data->psbend)
+		p_log("ERROR: PSB without PSBEND");
+	decoder->in_psb = data->psbend;
+}
+
+static void intel_pt_vm_tm_corr_first_tsc(struct intel_pt_decoder *decoder,
+					  struct intel_pt_vm_tsc_info *data,
+					  struct intel_pt_vmcs_info *vmcs_info,
+					  uint64_t host_tsc)
+{
+	if (!decoder->in_psb) {
+		/* Can't happen */
+		p_log("ERROR: First TSC is not in PSB+");
+	}
+
+	if (data->pip) {
+		if (pip_in_vm(&data->pip_packet)) { /* Guest */
+			if (vmcs_info && vmcs_info->tsc_offset) {
+				intel_pt_translate_vm_tsc(decoder, vmcs_info);
+				decoder->vm_tm_corr_reliable = true;
+			} else {
+				p_log("ERROR: First TSC, unknown TSC Offset");
+			}
+		} else { /* Host */
+			decoder->vm_tm_corr_reliable = true;
+		}
+	} else { /* Host or Guest */
+		decoder->vm_tm_corr_reliable = false;
+		if (intel_pt_time_in_range(decoder, host_tsc)) {
+			/* Assume Host */
+		} else {
+			/* Assume Guest */
+			if (vmcs_info && vmcs_info->tsc_offset)
+				intel_pt_translate_vm_tsc(decoder, vmcs_info);
+			else
+				p_log("ERROR: First TSC, no PIP, unknown TSC Offset");
+		}
+	}
+}
+
+static void intel_pt_vm_tm_corr_tsc(struct intel_pt_decoder *decoder,
+				    struct intel_pt_vm_tsc_info *data)
+{
+	struct intel_pt_vmcs_info *vmcs_info;
+	uint64_t tsc_offset = 0;
+	uint64_t vmcs;
+	bool reliable = true;
+	uint64_t expected_tsc;
+	uint64_t host_tsc;
+	uint64_t ref_timestamp;
+
+	bool assign = false;
+	bool assign_reliable = false;
+
+	/* Already have 'data' for the in_psb case */
+	if (!decoder->in_psb) {
+		memset(data, 0, sizeof(*data));
+		data->ctc_delta = decoder->ctc_delta;
+		data->last_ctc = decoder->last_ctc;
+		data->max_lookahead = 16;
+		intel_pt_pkt_lookahead(decoder, intel_pt_tma_lookahead_cb, data);
+		if (decoder->pge) {
+			data->pip = true;
+			data->pip_packet.payload = decoder->pip_payload;
+		}
+	}
+
+	/* Calculations depend on having TMA packets */
+	if (!data->tma) {
+		p_log("ERROR: TSC without TMA");
+		return;
+	}
+
+	vmcs = data->vmcs ? data->vmcs_packet.payload : decoder->vmcs;
+	if (vmcs == NO_VMCS)
+		vmcs = 0;
+
+	vmcs_info = decoder->findnew_vmcs_info(decoder->data, vmcs);
+
+	ref_timestamp = decoder->timestamp ? decoder->timestamp : decoder->buf_timestamp;
+	host_tsc = intel_pt_8b_tsc(decoder->packet.payload, ref_timestamp);
+
+	if (!decoder->ctc_timestamp) {
+		intel_pt_vm_tm_corr_first_tsc(decoder, data, vmcs_info, host_tsc);
+		return;
+	}
+
+	expected_tsc = intel_pt_expected_tsc(decoder, data);
+
+	tsc_offset = host_tsc - expected_tsc;
+
+	/* Determine if TSC is from Host or Guest */
+	if (data->pip) {
+		if (pip_in_vm(&data->pip_packet)) { /* Guest */
+			if (!vmcs_info) {
+				/* PIP NR=1 without VMCS cannot happen */
+				p_log("ERROR: Missing VMCS");
+				intel_pt_translate_vm_tsc_offset(decoder, tsc_offset);
+				decoder->vm_tm_corr_reliable = false;
+				return;
+			}
+		} else { /* Host */
+			decoder->last_reliable_timestamp = host_tsc;
+			decoder->vm_tm_corr_reliable = true;
+			return;
+		}
+	} else { /* Host or Guest */
+		reliable = false; /* Host/Guest is a guess, so not reliable */
+		if (decoder->in_psb) {
+			if (!tsc_offset)
+				return; /* Zero TSC Offset, assume Host */
+			/*
+			 * TSC packet has only 7 bytes of TSC. We have no
+			 * information about the Guest's 8th byte, but it
+			 * doesn't matter because we only need 7 bytes.
+			 * Here, since the 8th byte is unreliable and
+			 * irrelevant, compare only 7 byes.
+			 */
+			if (vmcs_info &&
+			    (tsc_offset & SEVEN_BYTES) ==
+			    (vmcs_info->tsc_offset & SEVEN_BYTES)) {
+				/* Same TSC Offset as last VMCS, assume Guest */
+				goto guest;
+			}
+		}
+		/*
+		 * Check if the host_tsc is within the expected range.
+		 * Note, we could narrow the range more by looking ahead for
+		 * the next host TSC in the same buffer, but we don't bother to
+		 * do that because this is probably good enough.
+		 */
+		if (host_tsc >= expected_tsc && intel_pt_time_in_range(decoder, host_tsc)) {
+			/* Within expected range for Host TSC, assume Host */
+			decoder->vm_tm_corr_reliable = false;
+			return;
+		}
+	}
+
+guest: /* Assuming Guest */
+
+	/* Determine whether to assign TSC Offset */
+	if (vmcs_info && vmcs_info->vmcs) {
+		if (vmcs_info->tsc_offset && vmcs_info->reliable) {
+			assign = false;
+		} else if (decoder->in_psb && data->pip && decoder->vm_tm_corr_reliable &&
+			   decoder->vm_tm_corr_continuous && decoder->vm_tm_corr_same_buf) {
+			/* Continuous tracing, TSC in a PSB is not a time loss */
+			assign = true;
+			assign_reliable = true;
+		} else if (decoder->in_psb && data->pip && decoder->vm_tm_corr_same_buf) {
+			/*
+			 * Unlikely to be a time loss TSC in a PSB which is not
+			 * at the start of a buffer.
+			 */
+			assign = true;
+			assign_reliable = false;
+		}
+	}
+
+	/* Record VMCS TSC Offset */
+	if (assign && (vmcs_info->tsc_offset != tsc_offset ||
+		       vmcs_info->reliable != assign_reliable)) {
+		bool print = vmcs_info->tsc_offset != tsc_offset;
+
+		vmcs_info->tsc_offset = tsc_offset;
+		vmcs_info->reliable = assign_reliable;
+		if (print)
+			intel_pt_print_vmcs_info(vmcs_info);
+	}
+
+	/* Determine what TSC Offset to use */
+	if (vmcs_info && vmcs_info->tsc_offset) {
+		if (!vmcs_info->reliable)
+			reliable = false;
+		intel_pt_translate_vm_tsc(decoder, vmcs_info);
+	} else {
+		reliable = false;
+		if (vmcs_info) {
+			if (!vmcs_info->error_printed) {
+				p_log("ERROR: Unknown TSC Offset for VMCS %#" PRIx64,
+				      vmcs_info->vmcs);
+				vmcs_info->error_printed = true;
+			}
+		} else {
+			if (intel_pt_print_once(decoder, INTEL_PT_PRT_ONCE_UNK_VMCS))
+				p_log("ERROR: Unknown VMCS");
+		}
+		intel_pt_translate_vm_tsc_offset(decoder, tsc_offset);
+	}
+
+	decoder->vm_tm_corr_reliable = reliable;
+}
+
+static void intel_pt_vm_tm_corr_pebs_tsc(struct intel_pt_decoder *decoder)
+{
+	uint64_t host_tsc = decoder->packet.payload;
+	uint64_t guest_tsc = decoder->packet.payload;
+	struct intel_pt_vmcs_info *vmcs_info;
+	uint64_t vmcs;
+
+	vmcs = decoder->vmcs;
+	if (vmcs == NO_VMCS)
+		vmcs = 0;
+
+	vmcs_info = decoder->findnew_vmcs_info(decoder->data, vmcs);
+
+	if (decoder->pge) {
+		if (in_vm(decoder->pip_payload)) { /* Guest */
+			if (!vmcs_info) {
+				/* PIP NR=1 without VMCS cannot happen */
+				p_log("ERROR: Missing VMCS");
+			}
+		} else { /* Host */
+			return;
+		}
+	} else { /* Host or Guest */
+		if (intel_pt_time_in_range(decoder, host_tsc)) {
+			/* Within expected range for Host TSC, assume Host */
+			return;
+		}
+	}
+
+	if (vmcs_info) {
+		/* Translate Guest TSC to Host TSC */
+		host_tsc = ((guest_tsc & SEVEN_BYTES) - vmcs_info->tsc_offset) & SEVEN_BYTES;
+		host_tsc = intel_pt_8b_tsc(host_tsc, decoder->timestamp);
+		intel_pt_log("Translated VM TSC %#" PRIx64 " -> %#" PRIx64
+			     "    VMCS %#" PRIx64 "    TSC Offset %#" PRIx64 "\n",
+			     guest_tsc, host_tsc, vmcs_info->vmcs,
+			     vmcs_info->tsc_offset);
+		if (!intel_pt_time_in_range(decoder, host_tsc) &&
+		    intel_pt_print_once(decoder, INTEL_PT_PRT_ONCE_ERANGE))
+			p_log("Timestamp out of range");
+	} else {
+		if (intel_pt_print_once(decoder, INTEL_PT_PRT_ONCE_UNK_VMCS))
+			p_log("ERROR: Unknown VMCS");
+		host_tsc = decoder->timestamp;
+	}
+
+	decoder->packet.payload = host_tsc;
+
+	if (!decoder->vm_tm_corr_dry_run)
+		memcpy((void *)decoder->buf + 1, &host_tsc, 8);
+}
+
+static int intel_pt_vm_time_correlation(struct intel_pt_decoder *decoder)
+{
+	struct intel_pt_vm_tsc_info data = { .psbend = false };
+	bool pge;
+	int err;
+
+	if (decoder->in_psb)
+		intel_pt_vm_tm_corr_psb(decoder, &data);
+
+	while (1) {
+		err = intel_pt_get_next_packet(decoder);
+		if (err == -ENOLINK)
+			continue;
+		if (err)
+			break;
+
+		switch (decoder->packet.type) {
+		case INTEL_PT_TIP_PGD:
+			decoder->pge = false;
+			decoder->vm_tm_corr_continuous = false;
+			break;
+
+		case INTEL_PT_TNT:
+		case INTEL_PT_TIP:
+		case INTEL_PT_TIP_PGE:
+			decoder->pge = true;
+			break;
+
+		case INTEL_PT_OVF:
+			decoder->in_psb = false;
+			pge = decoder->pge;
+			decoder->pge = intel_pt_ovf_fup_lookahead(decoder);
+			if (pge != decoder->pge)
+				intel_pt_log("Surprising PGE change in OVF!");
+			if (!decoder->pge)
+				decoder->vm_tm_corr_continuous = false;
+			break;
+
+		case INTEL_PT_FUP:
+			if (decoder->in_psb)
+				decoder->pge = true;
+			break;
+
+		case INTEL_PT_TRACESTOP:
+			decoder->pge = false;
+			decoder->vm_tm_corr_continuous = false;
+			decoder->have_tma = false;
+			break;
+
+		case INTEL_PT_PSB:
+			intel_pt_vm_tm_corr_psb(decoder, &data);
+			break;
+
+		case INTEL_PT_PIP:
+			decoder->pip_payload = decoder->packet.payload;
+			break;
+
+		case INTEL_PT_MTC:
+			intel_pt_calc_mtc_timestamp(decoder);
+			break;
+
+		case INTEL_PT_TSC:
+			intel_pt_vm_tm_corr_tsc(decoder, &data);
+			intel_pt_calc_tsc_timestamp(decoder);
+			decoder->vm_tm_corr_same_buf = true;
+			decoder->vm_tm_corr_continuous = decoder->pge;
+			break;
+
+		case INTEL_PT_TMA:
+			intel_pt_calc_tma(decoder);
+			break;
+
+		case INTEL_PT_CYC:
+			intel_pt_calc_cyc_timestamp(decoder);
+			break;
+
+		case INTEL_PT_CBR:
+			intel_pt_calc_cbr(decoder);
+			break;
+
+		case INTEL_PT_PSBEND:
+			decoder->in_psb = false;
+			data.psbend = false;
+			break;
+
+		case INTEL_PT_VMCS:
+			if (decoder->packet.payload != NO_VMCS)
+				decoder->vmcs = decoder->packet.payload;
+			break;
+
+		case INTEL_PT_BBP:
+			decoder->blk_type = decoder->packet.payload;
+			break;
+
+		case INTEL_PT_BIP:
+			if (decoder->blk_type == INTEL_PT_PEBS_BASIC &&
+			    decoder->packet.count == 2)
+				intel_pt_vm_tm_corr_pebs_tsc(decoder);
+			break;
+
+		case INTEL_PT_BEP:
+		case INTEL_PT_BEP_IP:
+			decoder->blk_type = 0;
+			break;
+
+		case INTEL_PT_MODE_EXEC:
+		case INTEL_PT_MODE_TSX:
+		case INTEL_PT_MNT:
+		case INTEL_PT_PAD:
+		case INTEL_PT_PTWRITE_IP:
+		case INTEL_PT_PTWRITE:
+		case INTEL_PT_MWAIT:
+		case INTEL_PT_PWRE:
+		case INTEL_PT_EXSTOP_IP:
+		case INTEL_PT_EXSTOP:
+		case INTEL_PT_PWRX:
+		case INTEL_PT_BAD: /* Does not happen */
+		default:
+			break;
+		}
+	}
+
+	return err;
+}
+
 #define HOP_PROCESS	0
 #define HOP_IGNORE	1
 #define HOP_RETURN	2
@@ -2910,6 +3587,15 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 	if (err)
 		return err;
 
+	if (decoder->vm_time_correlation) {
+		decoder->in_psb = true;
+		if (!decoder->timestamp)
+			decoder->timestamp = 1;
+		decoder->state.type = 0;
+		decoder->pkt_state = INTEL_PT_STATE_VM_TIME_CORRELATION;
+		return 0;
+	}
+
 	decoder->have_last_ip = true;
 	decoder->pkt_state = INTEL_PT_STATE_NO_IP;
 
@@ -2997,6 +3683,9 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		case INTEL_PT_STATE_RESAMPLE:
 			err = intel_pt_resample(decoder);
 			break;
+		case INTEL_PT_STATE_VM_TIME_CORRELATION:
+			err = intel_pt_vm_time_correlation(decoder);
+			break;
 		default:
 			err = intel_pt_bug(decoder);
 			break;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 4d78a8c35e2a..714c475808c0 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -258,6 +258,8 @@ struct intel_pt_params {
 	void *data;
 	bool return_compression;
 	bool branch_enable;
+	bool vm_time_correlation;
+	bool vm_tm_corr_dry_run;
 	uint64_t first_timestamp;
 	uint64_t ctl;
 	uint64_t period;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.h b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
index 388661f89c44..d900aab24b21 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
@@ -67,4 +67,9 @@ static inline void intel_pt_log_to(const char *msg, uint64_t u)
 	intel_pt_log("%s to " x64_fmt "\n", msg, u);
 }
 
+#define intel_pt_log_var(var, fmt) intel_pt_log("%s: " #var " " fmt "\n", __func__, var)
+
+#define intel_pt_log_x32(var) intel_pt_log_var(var, "%#x")
+#define intel_pt_log_x64(var) intel_pt_log_var(var, "%#" PRIx64)
+
 #endif
-- 
2.25.1

