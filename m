Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353663A3B42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFKFPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhFKFPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:15:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00EEB613AE;
        Fri, 11 Jun 2021 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623388419;
        bh=0aZE3s6YXvLfrboW0DBLXtcTN3mUxLzSyvQ3dV/46Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deASRgbhtEvt5dmTnkCikHeij0ZP9YaPYy18r7Z0pBJpZjfssxQdn1UBMTH6dttfr
         JGrVqOCpaquAZwln0r+Yerh91/ffE3O1T27iZIUQki2WHE7fAcZM3NeclP0AlyeRKH
         XhsuhZIQTFTL2Dey+c0UNYeISa7Wqu4ZDfvaVUbMDYk0G72MU6T+QGep0YZ7raCFRf
         izcyEIj45DnUNAFfh9bvBepzlHJS8hBRrOjSrmi1sHCdUP6m4J0a7Cxk50Rc9S1/39
         RNnu2ebReSfegmX99t0Q8hdYXVem3cdAKYQcXxkHZGurVDcg00Qhcc6BF4UMdjQHPo
         p2XvqjYDxin4w==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] x86/fpu: Rename "dynamic" XSTATEs to "independent"
Date:   Thu, 10 Jun 2021 22:13:36 -0700
Message-Id: <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623388344.git.luto@kernel.org>
References: <cover.1623388344.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The salient feature of "dynamic" XSTATEs is that they are not part of the
main task XSTATE buffer.  The fact that they are dynamically allocated is
irrelevant and will become quite confusing when user math XSTATEs start
being dynamically allocated.  Rename them to "independent" because they
are independent of the main XSTATE code.

This is just a search-and-replace with some whitespace updates to keep
things aligned.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/events/intel/lbr.c       |  6 +--
 arch/x86/include/asm/fpu/xstate.h | 14 +++----
 arch/x86/kernel/fpu/xstate.c      | 62 +++++++++++++++----------------
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 76dbab6ac9fb..0189807fc3c1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -978,7 +978,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 47a92232d595..5802b1715c7f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -56,7 +56,7 @@
  * - Don't set the bit corresponding to the dynamic supervisor feature in
  *   IA32_XSS at run time, since it has been set at boot time.
  */
-#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+#define XFEATURE_MASK_INDEPENDENT (XFEATURE_MASK_LBR)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
@@ -66,7 +66,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -87,12 +87,12 @@ static inline u64 xfeatures_mask_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_INDEPENDENT;
 }
 
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
@@ -109,8 +109,8 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
 
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8ac0f67b861a..d582275164ad 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -237,7 +237,7 @@ void fpu__init_cpu_xstate(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -616,7 +616,7 @@ static void check_xstate_against_struct(int nr)
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
  *
- * Dynamic XSAVE features allocate their own buffers and are not
+ * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
@@ -682,18 +682,18 @@ static unsigned int __init get_xsaves_size(void)
 }
 
 /*
- * Get the total size of the enabled xstates without the dynamic supervisor
+ * Get the total size of the enabled xstates without the independent supervisor
  * features.
  */
-static unsigned int __init get_xsaves_size_no_dynamic(void)
+static unsigned int __init get_xsaves_size_no_independent(void)
 {
-	u64 mask = xfeatures_mask_dynamic();
+	u64 mask = xfeatures_mask_independent();
 	unsigned int size;
 
 	if (!mask)
 		return get_xsaves_size();
 
-	/* Disable dynamic features. */
+	/* Disable independent features. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 
 	/*
@@ -702,7 +702,7 @@ static unsigned int __init get_xsaves_size_no_dynamic(void)
 	 */
 	size = get_xsaves_size();
 
-	/* Re-enable dynamic features so XSAVES will work on them again. */
+	/* Re-enable independent features so XSAVES will work on them again. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
 
 	return size;
@@ -745,7 +745,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size_no_dynamic();
+		possible_xstate_size = get_xsaves_size_no_independent();
 	else
 		possible_xstate_size = xsave_size;
 
@@ -887,7 +887,7 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -1287,34 +1287,34 @@ void copy_supervisor_to_kernel(struct xregs_state *xstate)
 }
 
 /**
- * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
- *                                       an xsave area
+ * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features saved into the xsave area
+ * @mask: Represent the independent supervisor features saved into the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * Only the independent supervisor states sets in the mask are saved into the xsave
+ * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
+ * supervisor feature). Besides the independent supervisor states, the legacy
  * region and XSAVE header are also saved into the xsave area. The supervisor
  * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 
@@ -1323,34 +1323,34 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 }
 
 /**
- * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
- *                                       an xsave area
+ * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features restored from the xsave area
+ * @mask: Represent the independent supervisor features restored from the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
+ * Only the independent supervisor states sets in the mask are restored from the
+ * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
+ * independent supervisor feature). Besides the independent supervisor states, the
  * legacy region and XSAVE header are also restored from the xsave area. The
  * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 
-- 
2.31.1

