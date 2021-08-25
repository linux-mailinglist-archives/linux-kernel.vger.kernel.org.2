Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9A3F79B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhHYQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:32825 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241309AbhHYQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="281267313"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="281267313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317311"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:46 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 23/28] x86/fpu/xstate: Skip writing zeros to signal frame for dynamic user states if in INIT-state
Date:   Wed, 25 Aug 2021 08:54:08 -0700
Message-Id: <20210825155413.19673-24-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, for XSTATE features in the INIT-state, XSAVE writes zeros to
the uncompressed destination buffer.

E.g., if you are not using AVX-512, you will still get a bunch of zeros on
the signal stack where live AVX-512 data would go.

For 'dynamic user state' (currently only XTILEDATA), explicitly skip this
data transfer. The result is that the user buffer for the AMX region will
not be touched by XSAVE.

[ Reading XINUSE takes about 20-30 cycles, but writing zeros consumes about
  5-times or more, e.g., for XTILEDATA. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)

Changes from v5:
* Mentioned the optimization trade-offs in the changelog. (Dave Hansen)
* Added code comment.

Changes from v4:
* Added as a new patch.
---
 arch/x86/include/asm/fpu/internal.h | 38 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a7e39862df30..0225ab63e5d1 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -337,8 +337,9 @@ static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
+	struct fpu *fpu = &current->thread.fpu;
 	u32 lmask, hmask;
-	u64 mask;
+	u64 state_mask;
 	int err;
 
 	/*
@@ -346,21 +347,38 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	mask = xfeatures_mask_uabi();
+	state_mask = xfeatures_mask_uabi();
+
+	if (!xfeatures_mask_user_dynamic)
+		goto mask_ready;
 
 	/*
 	 * Exclude dynamic user states for non-opt-in threads.
 	 */
-	if (xfeatures_mask_user_dynamic) {
-		struct fpu *fpu = &current->thread.fpu;
-
-		mask &= fpu->dynamic_state_perm ?
-			fpu->state_mask :
-			~xfeatures_mask_user_dynamic;
+	if (!fpu->dynamic_state_perm) {
+		state_mask &= ~xfeatures_mask_user_dynamic;
+	} else {
+		u64 dynamic_state_mask;
+
+		state_mask &= fpu->state_mask;
+
+		dynamic_state_mask = state_mask & xfeatures_mask_user_dynamic;
+		if (dynamic_state_mask && cpu_feature_enabled(X86_FEATURE_XGETBV1)) {
+			u64 dynamic_xinuse, dynamic_init;
+			u64 xinuse = xgetbv(1);
+
+			dynamic_xinuse = xinuse & dynamic_state_mask;
+			dynamic_init = ~xinuse & dynamic_state_mask;
+			if (dynamic_init) {
+				state_mask &= ~xfeatures_mask_user_dynamic;
+				state_mask |= dynamic_xinuse;
+			}
+		}
 	}
 
-	lmask = mask;
-	hmask = mask >> 32;
+mask_ready:
+	lmask = state_mask;
+	hmask = state_mask >> 32;
 
 	/*
 	 * Clear the xsave header first, so that reserved fields are
-- 
2.17.1

