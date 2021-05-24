Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9277938F4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhEXVSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:18:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:2811 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232693AbhEXVR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:17:59 -0400
IronPort-SDR: QzgUUtGdG9kTCTugZWnENipvtLph3lpcX3Rn0LC3fxnrHhKwsMqaqdQ0H0bMTorGYstaJiUkFk
 AMy4hgbQxn4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="200134989"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="200134989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 14:16:30 -0700
IronPort-SDR: OKEj1N73DEvMFr6omQhRPcwkkoKIrPoysr6AQrk2wYQVOk6ANTFKbbI4SV0PwCxGfAS1/IHNr5
 L5oeJlK8XScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="629856710"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2021 14:16:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     luto@kernel.org, dave.hansen@intel.com, lenb@kernel.org
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, x86@kernel.org,
        len.brown@intel.com, jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5-fix 28/28] x86/fpu/amx: Clear the AMX state when appropriate
Date:   Mon, 24 May 2021 14:11:00 -0700
Message-Id: <20210524211100.3347-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJvTdKk-53JzUzgGbgWSsfMcGPjQ0Wvrb-AqYOhX3JArVsB=Qg@mail.gmail.com>
References: <CAJvTdKk-53JzUzgGbgWSsfMcGPjQ0Wvrb-AqYOhX3JArVsB=Qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AMX is enabled, and an AMX-task is saved, explicitly initialize the
AMX state after the XSAVE.

This assures that the kernel will only request idle states with clean AMX
state. In the case of the C6 idle state, this allows the hardware to get to
a deeper power saving condition.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Fixed to deactivate fpregs. (Andy Lutomirski and Dave Hansen)
* Updated the code comment. (Dave Hansen)

Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/include/asm/special_insns.h |  6 ++++++
 arch/x86/kernel/fpu/core.c           | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2acd6cb62328..f0ed063035eb 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -306,6 +306,12 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	return 0;
 }
 
+static inline void tile_release(void)
+{
+	/* Instruction opcode for TILERELEASE; supported in binutils >= 2.36. */
+	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index cccfeafe81e5..14c8216d9a39 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -106,6 +106,17 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 		 */
 		if (fpu->state->xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
+
+		/*
+		 * Leaving state in the TILE registers may prevent the
+		 * processor from entering low-power idle states. Use
+		 * TILERELEASE to initialize the state. Destroying
+		 * fpregs state is safe after the fpstate update.
+		 */
+		if (fpu->state_mask & XFEATURE_MASK_XTILE_DATA) {
+			tile_release();
+			fpregs_deactivate(fpu);
+		}
 		return 1;
 	}
 
-- 
2.17.1

