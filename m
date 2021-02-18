Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760131E937
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhBRLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:41:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:58033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232302AbhBRJ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:58:51 -0500
IronPort-SDR: pfXpqmfCf2gWp4Kshm2Hz4TXxzIbrkwc1AuHTUhTQ0exHOZar+Vk+t3jFhCl45eRmEjniEMLNM
 XW4/tsUhDZCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127904"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:09 -0800
IronPort-SDR: xJK0vtepywahzIHW3s+hojekc3FXjI2azCx7ULVrT5BbGMX+s1hZpU/kcwbZefAGlOjCqSp6rX
 RuKZOTl97m/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427606"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:07 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] perf intel_pt: Add vmlaunch and vmresume as branches
Date:   Thu, 18 Feb 2021 11:57:52 +0200
Message-Id: <20210218095801.19576-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support Intel PT decoding of virtual machine traces, add
vmlaunch and vmresume as branch instructions.

Note, sample flags will show "VMentry" even if the VM-Entry fails.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/insn-x86.c              |  1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c | 15 +++++++++++++++
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 745f29adb14b..f782ef8c5982 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -48,6 +48,7 @@ static int get_op(const char *op_str)
 		{"int",     INTEL_PT_OP_INT},
 		{"syscall", INTEL_PT_OP_SYSCALL},
 		{"sysret",  INTEL_PT_OP_SYSRET},
+		{"vmentry",  INTEL_PT_OP_VMENTRY},
 		{NULL, 0},
 	};
 	struct val_data *val;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index fb8a3558d3d5..2f6cc7eea251 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -43,6 +43,17 @@ static void intel_pt_insn_decoder(struct insn *insn,
 	switch (insn->opcode.bytes[0]) {
 	case 0xf:
 		switch (insn->opcode.bytes[1]) {
+		case 0x01:
+			switch (insn->modrm.bytes[0]) {
+			case 0xc2: /* vmlaunch */
+			case 0xc3: /* vmresume */
+				op = INTEL_PT_OP_VMENTRY;
+				branch = INTEL_PT_BR_INDIRECT;
+				break;
+			default:
+				break;
+			}
+			break;
 		case 0x05: /* syscall */
 		case 0x34: /* sysenter */
 			op = INTEL_PT_OP_SYSCALL;
@@ -213,6 +224,7 @@ const char *branch_name[] = {
 	[INTEL_PT_OP_INT]	= "Int",
 	[INTEL_PT_OP_SYSCALL]	= "Syscall",
 	[INTEL_PT_OP_SYSRET]	= "Sysret",
+	[INTEL_PT_OP_VMENTRY]	= "VMentry",
 };
 
 const char *intel_pt_insn_name(enum intel_pt_insn_op op)
@@ -267,6 +279,9 @@ int intel_pt_insn_type(enum intel_pt_insn_op op)
 	case INTEL_PT_OP_SYSRET:
 		return PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN |
 		       PERF_IP_FLAG_SYSCALLRET;
+	case INTEL_PT_OP_VMENTRY:
+		return PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+		       PERF_IP_FLAG_VMENTRY;
 	default:
 		return 0;
 	}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
index 95a1eb0141ff..c2861cfdd768 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
@@ -24,6 +24,7 @@ enum intel_pt_insn_op {
 	INTEL_PT_OP_INT,
 	INTEL_PT_OP_SYSCALL,
 	INTEL_PT_OP_SYSRET,
+	INTEL_PT_OP_VMENTRY,
 };
 
 enum intel_pt_insn_branch {
-- 
2.17.1

