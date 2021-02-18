Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E638E31E8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBRLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:06:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:58029 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhBRKBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:01:50 -0500
IronPort-SDR: eF0vM/ciukpZbOXi7NPfZpv6qcLC4qRiNzzcWJJeeS+5ZrXhdr562oMKGhQ8PtglAD42eVl7+9
 gZy3bI3a1ULQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127911"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127911"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:11 -0800
IronPort-SDR: z5Afkr4Zewz3U3qGtp6QCJFbjl2qhvZOcC8auKUu/oGZm7WSh4kkypvWbBH+WMXV+uSSDII9/f
 qdL64Bv1twNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427618"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] perf intel-pt: Retain the last PIP packet payload as is
Date:   Thu, 18 Feb 2021 11:57:53 +0200
Message-Id: <20210218095801.19576-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retain the PIP packet payload as is, instead of just the CR3, because it
contains also the VMX NR flag which is needed to track VM-Entry.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |  4 ++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 14 +++++++-------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  2 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 12 ++++--------
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |  2 ++
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
index 901bf1f449c4..c933e3dcd0a8 100644
--- a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -66,8 +66,8 @@ struct test_data {
 	{7, {0x9d, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_FUP, 4, 0x60504030201}, 0, 0 },
 	{9, {0xdd, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_FUP, 6, 0x807060504030201}, 0, 0 },
 	/* Paging Information Packet */
-	{8, {0x02, 0x43, 2, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0x60504030201}, 0, 0 },
-	{8, {0x02, 0x43, 3, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0x60504030201 | (1ULL << 63)}, 0, 0 },
+	{8, {0x02, 0x43, 2, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0xC0A08060402}, 0, 0 },
+	{8, {0x02, 0x43, 3, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0xC0A08060403}, 0, 0 },
 	/* Mode Exec Packet */
 	{2, {0x99, 0x00}, 0, {INTEL_PT_MODE_EXEC, 0, 16}, 0, 0 },
 	{2, {0x99, 0x01}, 0, {INTEL_PT_MODE_EXEC, 0, 64}, 0, 0 },
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 6df52d3c3f7e..cfaa091c935c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -126,7 +126,7 @@ struct intel_pt_decoder {
 	uint64_t pos;
 	uint64_t last_ip;
 	uint64_t ip;
-	uint64_t cr3;
+	uint64_t pip_payload;
 	uint64_t timestamp;
 	uint64_t tsc_timestamp;
 	uint64_t ref_timestamp;
@@ -1757,7 +1757,7 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
+			decoder->pip_payload = decoder->packet.payload;
 			break;
 
 		case INTEL_PT_FUP:
@@ -1884,7 +1884,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			return 0;
 
 		case INTEL_PT_PIP:
-			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
+			decoder->pip_payload = decoder->packet.payload;
 			break;
 
 		case INTEL_PT_MTC:
@@ -2297,7 +2297,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			return err;
 
 		case INTEL_PT_PIP:
-			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
+			decoder->pip_payload = decoder->packet.payload;
 			break;
 
 		case INTEL_PT_MTC:
@@ -2536,7 +2536,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
+			decoder->pip_payload = decoder->packet.payload;
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2655,7 +2655,7 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_PIP:
-			decoder->cr3 = decoder->packet.payload & (BIT63 - 1);
+			decoder->pip_payload = decoder->packet.payload;
 			break;
 
 		case INTEL_PT_MODE_EXEC:
@@ -2987,7 +2987,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 
 	decoder->state.timestamp = decoder->sample_timestamp;
 	decoder->state.est_timestamp = intel_pt_est_timestamp(decoder);
-	decoder->state.cr3 = decoder->cr3;
+	decoder->state.pip_payload = decoder->pip_payload;
 	decoder->state.tot_insn_cnt = decoder->tot_insn_cnt;
 	decoder->state.tot_cyc_cnt = decoder->sample_tot_cyc_cnt;
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index ae13f3251536..b9564c93fca7 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -204,7 +204,7 @@ struct intel_pt_state {
 	int err;
 	uint64_t from_ip;
 	uint64_t to_ip;
-	uint64_t cr3;
+	uint64_t pip_payload;
 	uint64_t tot_insn_cnt;
 	uint64_t tot_cyc_cnt;
 	uint64_t timestamp;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 4ce109993e74..02a3395d6ce3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -16,8 +16,6 @@
 
 #define BIT63		((uint64_t)1 << 63)
 
-#define NR_FLAG		BIT63
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
@@ -106,9 +104,7 @@ static int intel_pt_get_pip(const unsigned char *buf, size_t len,
 
 	packet->type = INTEL_PT_PIP;
 	memcpy_le64(&payload, buf + 2, 6);
-	packet->payload = payload >> 1;
-	if (payload & 1)
-		packet->payload |= NR_FLAG;
+	packet->payload = payload;
 
 	return 8;
 }
@@ -719,10 +715,10 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet, char *buf,
 				name, (unsigned)(payload >> 1) & 1,
 				(unsigned)payload & 1);
 	case INTEL_PT_PIP:
-		nr = packet->payload & NR_FLAG ? 1 : 0;
-		payload &= ~NR_FLAG;
+		nr = packet->payload & INTEL_PT_VMX_NR_FLAG ? 1 : 0;
+		payload &= ~INTEL_PT_VMX_NR_FLAG;
 		ret = snprintf(buf, buf_len, "%s 0x%llx (NR=%d)",
-			       name, payload, nr);
+			       name, payload >> 1, nr);
 		return ret;
 	case INTEL_PT_PTWRITE:
 		return snprintf(buf, buf_len, "%s 0x%llx IP:0", name, payload);
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
index 17ca9b56d72f..996090cb84f6 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.h
@@ -21,6 +21,8 @@
 
 #define INTEL_PT_PKT_MAX_SZ		16
 
+#define INTEL_PT_VMX_NR_FLAG		1
+
 enum intel_pt_pkt_type {
 	INTEL_PT_BAD,
 	INTEL_PT_PAD,
-- 
2.17.1

