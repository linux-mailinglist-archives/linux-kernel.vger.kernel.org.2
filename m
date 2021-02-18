Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2131E8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBRLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:09:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:58033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhBRKBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:01:49 -0500
IronPort-SDR: MtAQCq/1yYxz1n2TBjhpN9VPiQb8QkaalUadGtyMNxnBohR1tdac0y0SxJhiF8TLzDJcNssubN
 2yUWK7vyfYGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127919"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:13 -0800
IronPort-SDR: QGT9+rCGakUTNxiAHELvDu1bZQnQkEXAGey3UqFykRY8/wTRX9PqfrXAwgqxs2PqdUfi08t/UX
 qXPO2RcOraXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427624"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] perf intel-pt: Amend decoder to track the NR flag
Date:   Thu, 18 Feb 2021 11:57:54 +0200
Message-Id: <20210218095801.19576-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PIP packet NR (non-root) flag indicates whether or not a virtual
machine is being traced (NR=1 => VM). Add support for tracking its value.

In particular note that the PIP packet (outside of PSB+) will be
associated with a TIP packet from which address the NR value takes
effect. At that point, there is a branch from_ip, to_ip with
corresponding from_nr and to_nr.

In the event of VM-Entry failure, there should still PIP and TIP packets
that can be followed in the same way.

Also note that this assumes that a host VMM is not employing VMX controls
that affect Intel PT, e.g. to hide the host from a guest using Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 59 ++++++++++++++++---
 .../util/intel-pt-decoder/intel-pt-decoder.h  |  3 +-
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index cfaa091c935c..8c59677bee13 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -122,6 +122,8 @@ struct intel_pt_decoder {
 	bool in_psb;
 	bool hop;
 	bool leap;
+	bool nr;
+	bool next_nr;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -503,6 +505,28 @@ static inline void intel_pt_update_in_tx(struct intel_pt_decoder *decoder)
 	decoder->tx_flags = decoder->packet.payload & INTEL_PT_IN_TX;
 }
 
+static inline void intel_pt_update_pip(struct intel_pt_decoder *decoder)
+{
+	decoder->pip_payload = decoder->packet.payload;
+}
+
+static inline void intel_pt_update_nr(struct intel_pt_decoder *decoder)
+{
+	decoder->next_nr = decoder->pip_payload & 1;
+}
+
+static inline void intel_pt_set_nr(struct intel_pt_decoder *decoder)
+{
+	decoder->nr = decoder->pip_payload & 1;
+	decoder->next_nr = decoder->nr;
+}
+
+static inline void intel_pt_set_pip(struct intel_pt_decoder *decoder)
+{
+	intel_pt_update_pip(decoder);
+	intel_pt_set_nr(decoder);
+}
+
 static int intel_pt_bad_packet(struct intel_pt_decoder *decoder)
 {
 	intel_pt_clear_tx_flags(decoder);
@@ -1240,6 +1264,7 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 		decoder->continuous_period = false;
 		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 		decoder->state.type |= INTEL_PT_TRACE_END;
+		intel_pt_update_nr(decoder);
 		return 0;
 	}
 	if (err == INTEL_PT_RETURN)
@@ -1247,6 +1272,8 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 	if (err)
 		return err;
 
+	intel_pt_update_nr(decoder);
+
 	if (intel_pt_insn.branch == INTEL_PT_BR_INDIRECT) {
 		if (decoder->pkt_state == INTEL_PT_STATE_TIP_PGD) {
 			decoder->pge = false;
@@ -1359,6 +1386,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 			decoder->state.from_ip = decoder->ip;
 			decoder->state.to_ip = decoder->last_ip;
 			decoder->ip = decoder->last_ip;
+			intel_pt_update_nr(decoder);
 			return 0;
 		}
 
@@ -1483,6 +1511,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
+	intel_pt_set_nr(decoder);
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
@@ -1757,7 +1786,7 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->pip_payload = decoder->packet.payload;
+			intel_pt_set_pip(decoder);
 			break;
 
 		case INTEL_PT_FUP:
@@ -1856,6 +1885,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			decoder->pge = false;
 			decoder->continuous_period = false;
 			decoder->state.type |= INTEL_PT_TRACE_END;
+			intel_pt_update_nr(decoder);
 			return 0;
 
 		case INTEL_PT_TIP_PGE:
@@ -1871,6 +1901,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			}
 			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
 			intel_pt_mtc_cyc_cnt_pge(decoder);
+			intel_pt_set_nr(decoder);
 			return 0;
 
 		case INTEL_PT_TIP:
@@ -1881,10 +1912,11 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 				intel_pt_set_ip(decoder);
 				decoder->state.to_ip = decoder->ip;
 			}
+			intel_pt_update_nr(decoder);
 			return 0;
 
 		case INTEL_PT_PIP:
-			decoder->pip_payload = decoder->packet.payload;
+			intel_pt_update_pip(decoder);
 			break;
 
 		case INTEL_PT_MTC:
@@ -1943,21 +1975,27 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		return HOP_IGNORE;
 
 	case INTEL_PT_TIP_PGD:
-		if (!decoder->packet.count)
+		if (!decoder->packet.count) {
+			intel_pt_set_nr(decoder);
 			return HOP_IGNORE;
+		}
 		intel_pt_set_ip(decoder);
 		decoder->state.type |= INTEL_PT_TRACE_END;
 		decoder->state.from_ip = 0;
 		decoder->state.to_ip = decoder->ip;
+		intel_pt_update_nr(decoder);
 		return HOP_RETURN;
 
 	case INTEL_PT_TIP:
-		if (!decoder->packet.count)
+		if (!decoder->packet.count) {
+			intel_pt_set_nr(decoder);
 			return HOP_IGNORE;
+		}
 		intel_pt_set_ip(decoder);
 		decoder->state.type = INTEL_PT_INSTRUCTION;
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
+		intel_pt_update_nr(decoder);
 		return HOP_RETURN;
 
 	case INTEL_PT_FUP:
@@ -2222,6 +2260,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 		case INTEL_PT_TIP_PGE: {
 			decoder->pge = true;
 			intel_pt_mtc_cyc_cnt_pge(decoder);
+			intel_pt_set_nr(decoder);
 			if (decoder->packet.count == 0) {
 				intel_pt_log_at("Skipping zero TIP.PGE",
 						decoder->pos);
@@ -2297,7 +2336,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			return err;
 
 		case INTEL_PT_PIP:
-			decoder->pip_payload = decoder->packet.payload;
+			intel_pt_update_pip(decoder);
 			break;
 
 		case INTEL_PT_MTC:
@@ -2536,7 +2575,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->pip_payload = decoder->packet.payload;
+			intel_pt_set_pip(decoder);
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2655,7 +2694,7 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->pip_payload = decoder->packet.payload;
+			intel_pt_set_pip(decoder);
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2953,6 +2992,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		decoder->state.from_ip = decoder->ip;
 		intel_pt_update_sample_time(decoder);
 		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
+		intel_pt_set_nr(decoder);
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen) {
@@ -2985,9 +3025,12 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 	if ((decoder->state.type & INTEL_PT_PSB_EVT) && decoder->tsc_timestamp)
 		decoder->sample_timestamp = decoder->tsc_timestamp;
 
+	decoder->state.from_nr = decoder->nr;
+	decoder->state.to_nr = decoder->next_nr;
+	decoder->nr = decoder->next_nr;
+
 	decoder->state.timestamp = decoder->sample_timestamp;
 	decoder->state.est_timestamp = intel_pt_est_timestamp(decoder);
-	decoder->state.pip_payload = decoder->pip_payload;
 	decoder->state.tot_insn_cnt = decoder->tot_insn_cnt;
 	decoder->state.tot_cyc_cnt = decoder->sample_tot_cyc_cnt;
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index b9564c93fca7..d9e62a7f6f0e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -201,10 +201,11 @@ struct intel_pt_blk_items {
 
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
+	bool from_nr;
+	bool to_nr;
 	int err;
 	uint64_t from_ip;
 	uint64_t to_ip;
-	uint64_t pip_payload;
 	uint64_t tot_insn_cnt;
 	uint64_t tot_cyc_cnt;
 	uint64_t timestamp;
-- 
2.17.1

