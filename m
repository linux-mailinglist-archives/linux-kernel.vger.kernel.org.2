Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E838DCAB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhEWTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:60026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhEWTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:56 -0400
IronPort-SDR: iRie9x8RjeYDu2iOpL01LuHnYa1Z+Yd3G9vmgpdJV0wVQ543Y550Ckt9a7qXs3fKoqRdZcgNfg
 B2w+6CcsbOoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="222949097"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="222949097"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:30 -0700
IronPort-SDR: eqkQqmfWx2FuYSG656d3eWgGt0kr8SnhkpqHWF+yNuVUY8RLdVXVTADFpaKwFzvpbQ7HucimpI
 N6/KSfrqZJ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467153"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when appropriate
Date:   Sun, 23 May 2021 12:32:59 -0700
Message-Id: <20210523193259.26200-29-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
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
Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/include/asm/special_insns.h | 6 ++++++
 arch/x86/kernel/fpu/core.c           | 8 ++++++++
 2 files changed, 14 insertions(+)

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
index cccfeafe81e5..53a5869078b8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -106,6 +106,14 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 		 */
 		if (fpu->state->xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
+
+		/*
+		 * Since the current task's state is safely in the XSAVE buffer, TILERELEASE
+		 * the TILE registers to guarantee that dirty state will not interfere with the
+		 * hardware's ability to enter the core C6 idle state.
+		 */
+		if (fpu->state_mask & XFEATURE_MASK_XTILE_DATA)
+			tile_release();
 		return 1;
 	}
 
-- 
2.17.1

