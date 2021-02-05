Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F3310F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhBEQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:30:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:14366 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233585AbhBEQOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:14:25 -0500
IronPort-SDR: UfCCRqOdOPc+KjK8cu5hVjd6OEWfJI8XaifARraLYQ02t4vc4vcjns6egLH1JPX+vnAlMWKWV9
 cSG8konuEkkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180690073"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180690073"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:53:56 -0800
IronPort-SDR: XpqzvQjwWknWOFH5Rgdzw6jqYARYwMU1ZMI6KQ0ultu2Z8OLcc6xnd0/euCajWyRzWAy0iAwio
 CWfES6s4Ftfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583856369"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 09:53:54 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf intel-pt: Add PSB events
Date:   Fri,  5 Feb 2021 19:53:50 +0200
Message-Id: <20210205175350.23817-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205175350.23817-1-adrian.hunter@intel.com>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emitting a PSB+ can cause a CPU a slight delay. When doing timing analysis
of code with Intel PT, it is useful to know if a timing bubble was caused
by Intel PT or not. Add reporting of PSB events via perf script. PSB
events are printed with the existing itrace 'p' option which also prints
power and frequency changes. The PSB event contains the trace offset at
which the PSB occurs, to allow easy reference back to the PSB+ packets.

The PSB event timestamp is always the timestamp from the PSB+ TSC
packet, and the ip is always the address from the PSB+ FUP packet.

The code changes are non-trivial because the decoder must walk to the
PSB+ FUP address before outputting the PSB event.

Example:

	$ perf record -e intel_pt/cyc,psb_period=0/u uname
	Linux
	[ perf record: Woken up 1 times to write data ]
	[ perf record: Captured and wrote 0.046 MB perf.data ]
	$ perf script --itrace=p --ns
            perf 17981 [006] 25617.510820383:                         psb:  psb offs: 0                                      0 [unknown] ([unknown])
            perf 17981 [006] 25617.510820383:                         cbr:  cbr: 42 freq: 4219 MHz (156%)                    0 [unknown] ([unknown])
           uname 17981 [006] 25617.510889753:                         psb:  psb offs: 0xb50                       7f78c12a212e __GI___tunables_init+0xee (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.510899162:                         psb:  psb offs: 0x12d0                      7f78c128af1c dl_main+0x93c (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.510939242:                         psb:  psb offs: 0x1a50                      7f78c128eefc _dl_map_object_from_fd+0x13c (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.510981274:                         psb:  psb offs: 0x21c8                      7f78c1296307 _dl_relocate_object+0x927 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.510993034:                         psb:  psb offs: 0x2948                      7f78c12940e4 _dl_lookup_symbol_x+0x14 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.511003871:                         psb:  psb offs: 0x30c8                      7f78c12937b3 do_lookup_x+0x2f3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.511019854:                         psb:  psb offs: 0x3850                      7f78c1295eed _dl_relocate_object+0x50d (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.511029015:                         psb:  psb offs: 0x4390                      7f78c12a855a strcmp+0xf6a (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
           uname 17981 [006] 25617.511064876:                         psb:  psb offs: 0x4b10                                 0 [unknown] ([unknown])
           uname 17981 [006] 25617.511080762:                         psb:  psb offs: 0x5290                      7f78c11db53d _dl_addr+0x13d (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511086035:                         psb:  psb offs: 0x5a08                      7f78c11db538 _dl_addr+0x138 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511091381:                         psb:  psb offs: 0x6190                      7f78c11db534 _dl_addr+0x134 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511096681:                         psb:  psb offs: 0x6910                      7f78c11db4c3 _dl_addr+0xc3 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511119520:                         psb:  psb offs: 0x7090                      7f78c10ada5e _nl_intern_locale_data+0x12e (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511126584:                         psb:  psb offs: 0x7818                      7f78c10ada50 _nl_intern_locale_data+0x120 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511132775:                         psb:  psb offs: 0x8358                      7f78c10c20c0 getenv+0xa0 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511134598:                         psb:  psb offs: 0x8ad0                      7f78c10ada09 _nl_intern_locale_data+0xd9 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511135685:                         psb:  psb offs: 0x9258                      7f78c10ada50 _nl_intern_locale_data+0x120 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511138322:                         psb:  psb offs: 0x99d0                      7f78c11fffd9 __strncmp_avx2+0x39 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
           uname 17981 [006] 25617.511158907:                         psb:  psb offs: 0xa150                                 0 [unknown] ([unknown])

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt           |   2 +-
 tools/perf/Documentation/perf-intel-pt.txt    |   7 +-
 tools/perf/builtin-script.c                   |  14 ++
 tools/perf/util/event.h                       |   7 +
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 232 ++++++++++++++----
 .../util/intel-pt-decoder/intel-pt-decoder.h  |   2 +
 tools/perf/util/intel-pt.c                    |  40 +++
 7 files changed, 251 insertions(+), 53 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 079cdfabb352..0f1005209a2b 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -4,7 +4,7 @@
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
 		w	synthesize ptwrite events
-		p	synthesize power events
+		p	synthesize power events (incl. PSB events for Intel PT)
 		o	synthesize other events recorded due to the use
 			of aux-output (refer to perf record)
 		e	synthesize error events
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index cd362dc2af07..0b8a339803cb 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -858,7 +858,7 @@ The letters are:
 	b	synthesize "branches" events
 	x	synthesize "transactions" events
 	w	synthesize "ptwrite" events
-	p	synthesize "power" events
+	p	synthesize "power" events (incl. PSB events)
 	c	synthesize branches events (calls only)
 	r	synthesize branches events (returns only)
 	e	synthesize tracing error events
@@ -913,6 +913,11 @@ Where:
 For more details refer to the Intel 64 and IA-32 Architectures Software
 Developer Manuals.
 
+PSB events show when a PSB+ occurred and also the byte-offset in the trace.
+Emitting a PSB+ can cause a CPU a slight delay. When doing timing analysis
+of code with Intel PT, it is useful to know if a timing bubble was caused
+by Intel PT or not.
+
 Error events show where the decoder lost the trace.  Error events
 are quite important.  Users must know if what they are seeing is a complete
 picture or not. The "e" option may be followed by flags which affect what errors
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e995311a9b8..89bab5bf3c1d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1750,6 +1750,18 @@ static int perf_sample__fprintf_synth_cbr(struct perf_sample *sample, FILE *fp)
 	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
+static int perf_sample__fprintf_synth_psb(struct perf_sample *sample, FILE *fp)
+{
+	struct perf_synth_intel_psb *data = perf_sample__synth_ptr(sample);
+	int len;
+
+	if (perf_sample__bad_synth_size(sample, *data))
+		return 0;
+
+	len = fprintf(fp, " psb offs: %#" PRIx64, data->offset);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
+}
+
 static int perf_sample__fprintf_synth(struct perf_sample *sample,
 				      struct evsel *evsel, FILE *fp)
 {
@@ -1766,6 +1778,8 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 		return perf_sample__fprintf_synth_pwrx(sample, fp);
 	case PERF_SYNTH_INTEL_CBR:
 		return perf_sample__fprintf_synth_cbr(sample, fp);
+	case PERF_SYNTH_INTEL_PSB:
+		return perf_sample__fprintf_synth_psb(sample, fp);
 	default:
 		break;
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 2afea7247dd3..aacb5cca61ac 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -172,6 +172,7 @@ enum perf_synth_id {
 	PERF_SYNTH_INTEL_EXSTOP,
 	PERF_SYNTH_INTEL_PWRX,
 	PERF_SYNTH_INTEL_CBR,
+	PERF_SYNTH_INTEL_PSB,
 };
 
 /*
@@ -264,6 +265,12 @@ struct perf_synth_intel_cbr {
 	u32 reserved3;
 };
 
+struct perf_synth_intel_psb {
+	u32 padding;
+	u32 reserved;
+	u64 offset;
+};
+
 /*
  * raw_data is always 4 bytes from an 8-byte boundary, so subtract 4 to get
  * 8-byte alignment.
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 197eb58a39cb..6df52d3c3f7e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -62,6 +62,7 @@ enum intel_pt_pkt_state {
 	INTEL_PT_STATE_TIP_PGD,
 	INTEL_PT_STATE_FUP,
 	INTEL_PT_STATE_FUP_NO_TIP,
+	INTEL_PT_STATE_FUP_IN_PSB,
 	INTEL_PT_STATE_RESAMPLE,
 };
 
@@ -80,6 +81,7 @@ static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
 	case INTEL_PT_STATE_TIP_PGD:
 	case INTEL_PT_STATE_FUP:
 	case INTEL_PT_STATE_FUP_NO_TIP:
+	case INTEL_PT_STATE_FUP_IN_PSB:
 		return false;
 	default:
 		return true;
@@ -119,7 +121,6 @@ struct intel_pt_decoder {
 	bool have_last_ip;
 	bool in_psb;
 	bool hop;
-	bool hop_psb_fup;
 	bool leap;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
@@ -198,6 +199,7 @@ struct intel_pt_decoder {
 	int no_progress;
 	int stuck_ip_prd;
 	int stuck_ip_cnt;
+	uint64_t psb_ip;
 	const unsigned char *next_buf;
 	size_t next_len;
 	unsigned char temp_buf[INTEL_PT_PKT_MAX_SZ];
@@ -1762,11 +1764,7 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			decoder->pge = true;
 			if (decoder->packet.count) {
 				intel_pt_set_last_ip(decoder);
-				if (decoder->hop) {
-					/* Act on FUP at PSBEND */
-					decoder->ip = decoder->last_ip;
-					decoder->hop_psb_fup = true;
-				}
+				decoder->psb_ip = decoder->last_ip;
 			}
 			break;
 
@@ -1982,26 +1980,23 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		return HOP_RETURN;
 
 	case INTEL_PT_PSB:
+		decoder->state.psb_offset = decoder->pos;
+		decoder->psb_ip = 0;
 		decoder->last_ip = 0;
 		decoder->have_last_ip = true;
-		decoder->hop_psb_fup = false;
 		*err = intel_pt_walk_psbend(decoder);
 		if (*err == -EAGAIN)
 			return HOP_AGAIN;
 		if (*err)
 			return HOP_RETURN;
-		if (decoder->hop_psb_fup) {
-			decoder->hop_psb_fup = false;
-			decoder->state.type = INTEL_PT_INSTRUCTION;
-			decoder->state.from_ip = decoder->ip;
-			decoder->state.to_ip = 0;
-			return HOP_RETURN;
+		decoder->state.type = INTEL_PT_PSB_EVT;
+		if (decoder->psb_ip) {
+			decoder->state.type |= INTEL_PT_INSTRUCTION;
+			decoder->ip = decoder->psb_ip;
 		}
-		if (decoder->cbr != decoder->cbr_seen) {
-			decoder->state.type = 0;
-			return HOP_RETURN;
-		}
-		return HOP_IGNORE;
+		decoder->state.from_ip = decoder->psb_ip;
+		decoder->state.to_ip = 0;
+		return HOP_RETURN;
 
 	case INTEL_PT_BAD:
 	case INTEL_PT_PAD:
@@ -2035,6 +2030,148 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 	}
 }
 
+struct intel_pt_psb_info {
+	struct intel_pt_pkt fup_packet;
+	bool fup;
+	int after_psbend;
+};
+
+/* Lookahead and get the FUP packet from PSB+ */
+static int intel_pt_psb_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
+{
+	struct intel_pt_psb_info *data = pkt_info->data;
+
+	switch (pkt_info->packet.type) {
+	case INTEL_PT_PAD:
+	case INTEL_PT_MNT:
+	case INTEL_PT_TSC:
+	case INTEL_PT_TMA:
+	case INTEL_PT_MODE_EXEC:
+	case INTEL_PT_MODE_TSX:
+	case INTEL_PT_MTC:
+	case INTEL_PT_CYC:
+	case INTEL_PT_VMCS:
+	case INTEL_PT_CBR:
+	case INTEL_PT_PIP:
+		if (data->after_psbend) {
+			data->after_psbend -= 1;
+			if (!data->after_psbend)
+				return 1;
+		}
+		break;
+
+	case INTEL_PT_FUP:
+		if (data->after_psbend)
+			return 1;
+		if (data->fup || pkt_info->packet.count == 0)
+			return 1;
+		data->fup_packet = pkt_info->packet;
+		data->fup = true;
+		break;
+
+	case INTEL_PT_PSBEND:
+		if (!data->fup)
+			return 1;
+		/* Keep going to check for a TIP.PGE */
+		data->after_psbend = 6;
+		break;
+
+	case INTEL_PT_TIP_PGE:
+		/* Ignore FUP in PSB+ if followed by TIP.PGE */
+		if (data->after_psbend)
+			data->fup = false;
+		return 1;
+
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
+		if (data->after_psbend) {
+			data->after_psbend -= 1;
+			if (!data->after_psbend)
+				return 1;
+			break;
+		}
+		return 1;
+
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
+static int intel_pt_psb(struct intel_pt_decoder *decoder)
+{
+	int err;
+
+	decoder->last_ip = 0;
+	decoder->psb_ip = 0;
+	decoder->have_last_ip = true;
+	intel_pt_clear_stack(&decoder->stack);
+	err = intel_pt_walk_psbend(decoder);
+	if (err)
+		return err;
+	decoder->state.type = INTEL_PT_PSB_EVT;
+	decoder->state.from_ip = decoder->psb_ip;
+	decoder->state.to_ip = 0;
+	return 0;
+}
+
+static int intel_pt_fup_in_psb(struct intel_pt_decoder *decoder)
+{
+	int err;
+
+	if (decoder->ip != decoder->last_ip) {
+		err = intel_pt_walk_fup(decoder);
+		if (!err || err != -EAGAIN)
+			return err;
+	}
+
+	decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+	err = intel_pt_psb(decoder);
+	if (err) {
+		decoder->pkt_state = INTEL_PT_STATE_ERR3;
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static bool intel_pt_psb_with_fup(struct intel_pt_decoder *decoder, int *err)
+{
+	struct intel_pt_psb_info data = { .fup = false };
+
+	if (!decoder->branch_enable || !decoder->pge)
+		return false;
+
+	intel_pt_pkt_lookahead(decoder, intel_pt_psb_lookahead_cb, &data);
+	if (!data.fup)
+		return false;
+
+	decoder->packet = data.fup_packet;
+	intel_pt_set_last_ip(decoder);
+	decoder->pkt_state = INTEL_PT_STATE_FUP_IN_PSB;
+
+	*err = intel_pt_fup_in_psb(decoder);
+
+	return true;
+}
+
 static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 {
 	int last_packet_type = INTEL_PT_PAD;
@@ -2150,24 +2287,14 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PSB:
-			decoder->last_ip = 0;
-			decoder->have_last_ip = true;
-			intel_pt_clear_stack(&decoder->stack);
-			err = intel_pt_walk_psbend(decoder);
+			decoder->state.psb_offset = decoder->pos;
+			decoder->psb_ip = 0;
+			if (intel_pt_psb_with_fup(decoder, &err))
+				return err;
+			err = intel_pt_psb(decoder);
 			if (err == -EAGAIN)
 				goto next;
-			if (err)
-				return err;
-			/*
-			 * PSB+ CBR will not have changed but cater for the
-			 * possibility of another CBR change that gets caught up
-			 * in the PSB+.
-			 */
-			if (decoder->cbr != decoder->cbr_seen) {
-				decoder->state.type = 0;
-				return 0;
-			}
-			break;
+			return err;
 
 		case INTEL_PT_PIP:
 			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
@@ -2381,6 +2508,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 				uint64_t current_ip = decoder->ip;
 
 				intel_pt_set_ip(decoder);
+				decoder->psb_ip = decoder->ip;
 				if (current_ip)
 					intel_pt_log_to("Setting IP",
 							decoder->ip);
@@ -2552,18 +2680,18 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PSB:
+			decoder->state.psb_offset = decoder->pos;
+			decoder->psb_ip = 0;
 			decoder->last_ip = 0;
 			decoder->have_last_ip = true;
 			intel_pt_clear_stack(&decoder->stack);
 			err = intel_pt_walk_psb(decoder);
 			if (err)
 				return err;
-			if (decoder->ip) {
-				/* Do not have a sample */
-				decoder->state.type = 0;
-				return 0;
-			}
-			break;
+			decoder->state.type = INTEL_PT_PSB_EVT;
+			decoder->state.from_ip = decoder->psb_ip;
+			decoder->state.to_ip = 0;
+			return 0;
 
 		case INTEL_PT_TNT:
 		case INTEL_PT_PSBEND:
@@ -2607,7 +2735,7 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 
 	intel_pt_log("Scanning for full IP\n");
 	err = intel_pt_walk_to_ip(decoder);
-	if (err)
+	if (err || ((decoder->state.type & INTEL_PT_PSB_EVT) && !decoder->ip))
 		return err;
 
 	/* In hop mode, resample to get the to_ip as an "instruction" sample */
@@ -2719,10 +2847,10 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 	decoder->continuous_period = false;
 	decoder->have_last_ip = false;
 	decoder->last_ip = 0;
+	decoder->psb_ip = 0;
 	decoder->ip = 0;
 	intel_pt_clear_stack(&decoder->stack);
 
-leap:
 	err = intel_pt_scan_for_psb(decoder);
 	if (err)
 		return err;
@@ -2734,8 +2862,11 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 	if (err)
 		return err;
 
+	decoder->state.type = INTEL_PT_PSB_EVT; /* Only PSB sample */
+	decoder->state.from_ip = decoder->psb_ip;
+	decoder->state.to_ip = 0;
+
 	if (decoder->ip) {
-		decoder->state.type = 0; /* Do not have a sample */
 		/*
 		 * In hop mode, resample to get the PSB FUP ip as an
 		 * "instruction" sample.
@@ -2744,14 +2875,6 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 			decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
 		else
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-	} else if (decoder->leap) {
-		/*
-		 * In leap mode, only PSB+ is decoded, so keeping leaping to the
-		 * next PSB until there is an ip.
-		 */
-		goto leap;
-	} else {
-		return intel_pt_sync_ip(decoder);
 	}
 
 	return 0;
@@ -2813,6 +2936,9 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			if (err == -EAGAIN)
 				err = intel_pt_walk_trace(decoder);
 			break;
+		case INTEL_PT_STATE_FUP_IN_PSB:
+			err = intel_pt_fup_in_psb(decoder);
+			break;
 		case INTEL_PT_STATE_RESAMPLE:
 			err = intel_pt_resample(decoder);
 			break;
@@ -2855,6 +2981,10 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.flags |= INTEL_PT_SAMPLE_IPC;
 	}
 
+	 /* Let PSB event always have TSC timestamp */
+	if ((decoder->state.type & INTEL_PT_PSB_EVT) && decoder->tsc_timestamp)
+		decoder->sample_timestamp = decoder->tsc_timestamp;
+
 	decoder->state.timestamp = decoder->sample_timestamp;
 	decoder->state.est_timestamp = intel_pt_est_timestamp(decoder);
 	decoder->state.cr3 = decoder->cr3;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 48adaa78acfc..ae13f3251536 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -32,6 +32,7 @@ enum intel_pt_sample_type {
 	INTEL_PT_TRACE_BEGIN	= 1 << 9,
 	INTEL_PT_TRACE_END	= 1 << 10,
 	INTEL_PT_BLK_ITEMS	= 1 << 11,
+	INTEL_PT_PSB_EVT	= 1 << 12,
 };
 
 enum intel_pt_period_type {
@@ -214,6 +215,7 @@ struct intel_pt_state {
 	uint64_t pwre_payload;
 	uint64_t pwrx_payload;
 	uint64_t cbr_payload;
+	uint64_t psb_offset;
 	uint32_t cbr;
 	uint32_t flags;
 	enum intel_pt_insn_op insn_op;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 2fff6f760457..9141699174da 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -108,6 +108,7 @@ struct intel_pt {
 	u64 exstop_id;
 	u64 pwrx_id;
 	u64 cbr_id;
+	u64 psb_id;
 
 	bool sample_pebs;
 	struct evsel *pebs_evsel;
@@ -1548,6 +1549,32 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+static int intel_pt_synth_psb_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	union perf_event *event = ptq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+	struct perf_synth_intel_psb raw;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_p_sample(pt, ptq, event, &sample);
+
+	sample.id = ptq->pt->psb_id;
+	sample.stream_id = ptq->pt->psb_id;
+	sample.flags = 0;
+
+	raw.reserved = 0;
+	raw.offset = ptq->state->psb_offset;
+
+	sample.raw_size = perf_synth__raw_size(raw);
+	sample.raw_data = perf_synth__raw_data(&raw);
+
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->pwr_events_sample_type);
+}
+
 static int intel_pt_synth_mwait_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
@@ -1995,6 +2022,11 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	}
 
 	if (pt->sample_pwr_events) {
+		if (state->type & INTEL_PT_PSB_EVT) {
+			err = intel_pt_synth_psb_sample(ptq);
+			if (err)
+				return err;
+		}
 		if (ptq->state->cbr != ptq->cbr_seen) {
 			err = intel_pt_synth_cbr_sample(ptq);
 			if (err)
@@ -3092,6 +3124,14 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		pt->cbr_id = id;
 		intel_pt_set_event_name(evlist, id, "cbr");
 		id += 1;
+
+		attr.config = PERF_SYNTH_INTEL_PSB;
+		err = intel_pt_synth_event(session, "psb", &attr, id);
+		if (err)
+			return err;
+		pt->psb_id = id;
+		intel_pt_set_event_name(evlist, id, "psb");
+		id += 1;
 	}
 
 	if (pt->synth_opts.pwr_events && (evsel->core.attr.config & 0x10)) {
-- 
2.17.1

