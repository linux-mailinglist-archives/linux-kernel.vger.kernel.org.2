Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495173B19FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFWM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhFWM0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:38 -0400
Message-Id: <20210623121455.004880675@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N9LcKVWpbQangVgYTA6eoBK2vFTcQr5UBGApQ2KY7YQ=;
        b=fb8v+9MoUsp1SemHQpVY2er3Rm93adlUqAC6995arBaJJiidCV+kTbFTvKYIy9wEUCDN5i
        AMYnrFQ0JirkjuOSmwQdfuSZUDrlKtLNaHNJVTyynrZZ6DD4bBHXCTof2mjaUBs4z8gcnV
        iYVW7CVwTHcmORyEOyyn5upgVrYx1avRqA71xRcWHYDzkeUda2MGbZ35yJMX6hjUhuhMOM
        0prVbUNxMqVFhTB90AI2phdSD5lMDYRB5gh2BOpj9E2QCLaiyVZSW4ljnP9I7kuVcrXKMv
        ENRGn96xSWdPW/7lD05AZm+uIzNLWdOX1QLoNJX0yj7IB9U6Z/RV1XzN8XS9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=N9LcKVWpbQangVgYTA6eoBK2vFTcQr5UBGApQ2KY7YQ=;
        b=a1f6L7OrYmSd7Iy+O19+sxl6ax+Tylb8S8EirHCrZM6yFF9TnSNmreTO5WGq0wAtcwWQnF
        5ZHvfYRtKs510GAQ==
Date:   Wed, 23 Jun 2021 14:02:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 37/65] x86/fpu/xstate: Sanitize handling of independent features
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy functions for the independent features are horribly named and the
supervisor and independent part is just overengineered.

The point is that the supplied mask has either to be a subset of the
independent features or a subset of the task->fpu.xstate managed features.

Rewrite it so it checks for invalid overlaps of these areas in the caller
supplied feature mask. Rename it so it follows the new naming convention
for these operations. Mop up the function documentation.

This allows to use that function for other purposes as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
---
V4: Split out the duplicated validation code (Boris)
V3: Rename
---
 arch/x86/events/intel/lbr.c       |    6 +-
 arch/x86/include/asm/fpu/xstate.h |    5 +
 arch/x86/kernel/fpu/xstate.c      |   98 ++++++++++++++++++--------------------
 3 files changed, 54 insertions(+), 55 deletions(-)

--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(v
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xrstors(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(vo
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xsaves(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsav
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,8 +104,9 @@ void *get_xsave_addr(struct xregs_state
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
+
+void xsaves(struct xregs_state *xsave, u64 mask);
+void xrstors(struct xregs_state *xsave, u64 mask);
 
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1162,76 +1162,74 @@ int copy_sigframe_from_user_to_xstate(st
 	return copy_uabi_to_xstate(xsave, NULL, ubuf);
 }
 
+static bool validate_xsaves_xrstors(u64 mask)
+{
+	u64 xchk;
+
+	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
+		return false;
+	/*
+	 * Validate that this is either a task->fpstate related component
+	 * subset or an independent one.
+	 */
+	if (mask & xfeatures_mask_independent())
+		xchk = ~xfeatures_mask_independent();
+	else
+		xchk = ~xfeatures_mask_all;
+
+	if (WARN_ON_ONCE(!mask || mask & xchk))
+		return false;
+
+	return true;
+}
+
 /**
- * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features saved into the xsave area
+ * xsaves - Save selected components to a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
  *
- * Only the independent supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
- * supervisor feature). Besides the independent supervisor states, the legacy
- * region and XSAVE header are also saved into the xsave area. The supervisor
- * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
+ * The @xstate buffer must be 64 byte aligned and correctly initialized as
+ * XSAVES does not write the full xstate header. Before first use the
+ * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
+ * can #GP.
  *
- * The xsave area must be 64-bytes aligned.
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void xsaves(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (WARN_ON_FPU(!independent_mask))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying to a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 /**
- * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features restored from the xsave area
+ * xrstors - Restore selected components from a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to restore
  *
- * Only the independent supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
- * independent supervisor feature). Besides the independent supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
- * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
+ * The @xstate buffer must be 64 byte aligned and correctly initialized
+ * otherwise XRSTORS from that buffer can #GP.
  *
- * The xsave area must be 64-bytes aligned.
+ * Proper usage is to restore the state which was saved with
+ * xsaves() into @xstate.
+ *
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
+void xrstors(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	if (WARN_ON_FPU(!independent_mask))
-		return;
-
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying from a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS

