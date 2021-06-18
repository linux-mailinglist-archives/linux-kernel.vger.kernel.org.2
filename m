Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AFB3ACE84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhFRPVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhFRPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:22 -0700 (PDT)
Message-Id: <20210618143444.587311343@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OD/z3wX4ALGeihHhAG6Pg3Bk6AXkzsiS2mo6ri4GS88=;
        b=i9x03/MB5W7cS6dqyerNM+q0eTgsiGA9HMVtRRWNfnboSeF4m3DQbPdk/vyj4z2ON8+qUS
        C15IHqbWt6aH9zuu/op5zUBgqsg6qJTp3+7BVjQ4uUl2ZyqpH0QMApDSF9P+/dTHM/Bzhd
        bOQ9yeMrGwJzVH8Pfam7Spz6o/IU7v8nRi/s6zoKugo//FQME4mClWh51WNKu6KMqGltvx
        KKLH3alOqyTLVUk497oHc458IwW7AWXlp5DaEezm5ujgU2eo9pYKXeakw+pGh4CFrxebZs
        V38sHF4SOo96coGCWZWs+7bkp7gH5hWATBh/WwkJoq/4eb4R9Lzdc7e8u7IJdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OD/z3wX4ALGeihHhAG6Pg3Bk6AXkzsiS2mo6ri4GS88=;
        b=GHbwi/XKbeOBLjoq6jwcybWLZ9wv+ximRB9o+MW6WFvIL3FJvpv/6r7jP6vJsj2cqAFjCK
        CIB+dgzXZsB5HFCw==
Date:   Fri, 18 Jun 2021 16:18:25 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V3 02/66] x86/fpu: Make init_fpstate correct with optimized XSAVE
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XSAVE init code initializes all enabled and supported components with
XRSTOR(S) to init state. Then it XSAVEs the state of the components back
into init_fpstate which is used in several places to fill in the init state
of components.

This works correctly with XSAVE, but not with XSAVEOPT and XSAVES because
those use the init optimization and skip writing state of components which
are in init state. So init_fpstate.xsave still contains all zeroes after
this operation.

There are two ways to solve that:

   1) Use XSAVE unconditionally, but that requires to reshuffle the buffer when
      XSAVES is enabled because XSAVES uses compacted format.

   2) Save the components which are known to have a non-zero init state by other
      means.

Looking deeper #2 is the right thing to do because all components the
kernel supports have all-zeroes init state except the legacy features (FP,
SSE). Those cannot be hard coded because the states are not identical on all
CPUs, but they can be saved with FXSAVE which avoids all conditionals.

Use FXSAVE to save the legacy FP/SSE components in init_fpstate along with
a BUILD_BUG_ON() which reminds developers to validate that a newly added
component has all zeroes init state. As a bonus remove the now unused
copy_xregs_to_kernel_booting() crutch.

The XSAVE and reshuffle method can still be implemented in the unlikely
case that components are added which have a non-zero init state and no
other means to save them. For now FXSAVE is just simple and good enough.

Fixes: 6bad06b76892 ("x86, xsave: Use xsaveopt in context-switch path when supported")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
V3: Adjust comment - Boris
V2: New patch
---
 arch/x86/include/asm/fpu/internal.h |   30 +++++++-------------------
 arch/x86/kernel/fpu/xstate.c        |   41 +++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 25 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -204,6 +204,14 @@ static inline void copy_fxregs_to_kernel
 		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
 }
 
+static inline void fxsave(struct fxregs_state *fx)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		asm volatile( "fxsave %[fx]" : [fx] "=m" (*fx));
+	else
+		asm volatile("fxsaveq %[fx]" : [fx] "=m" (*fx));
+}
+
 /* These macros all use (%edi)/(%rdi) as the single memory argument. */
 #define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
 #define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
@@ -270,28 +278,6 @@ static inline void copy_fxregs_to_kernel
 
 /*
  * This function is called only during boot time when x86 caps are not set
- * up and alternative can not be used yet.
- */
-static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
-{
-	u64 mask = xfeatures_mask_all;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	WARN_ON(system_state != SYSTEM_BOOTING);
-
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-	else
-		XSTATE_OP(XSAVE, xstate, lmask, hmask, err);
-
-	/* We should never fault when copying to a kernel buffer: */
-	WARN_ON_FPU(err);
-}
-
-/*
- * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
  */
 static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -441,12 +441,35 @@ static void __init print_xstate_offset_s
 }
 
 /*
+ * All supported features have either init state all zeros or are
+ * handled in setup_init_fpu() individually. This is an explicit
+ * feature list and does not use XFEATURE_MASK*SUPPORTED to catch
+ * newly added supported features at build time and make people
+ * actually look at the init state for the new feature.
+ */
+#define XFEATURES_INIT_FPSTATE_HANDLED		\
+	(XFEATURE_MASK_FP |			\
+	 XFEATURE_MASK_SSE |			\
+	 XFEATURE_MASK_YMM |			\
+	 XFEATURE_MASK_OPMASK |			\
+	 XFEATURE_MASK_ZMM_Hi256 |		\
+	 XFEATURE_MASK_Hi16_ZMM	 |		\
+	 XFEATURE_MASK_PKRU |			\
+	 XFEATURE_MASK_BNDREGS |		\
+	 XFEATURE_MASK_BNDCSR |			\
+	 XFEATURE_MASK_PASID)
+
+/*
  * setup the xstate image representing the init state
  */
 static void __init setup_init_fpu_buf(void)
 {
 	static int on_boot_cpu __initdata = 1;
 
+	BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
+		      XFEATURE_MASK_SUPERVISOR_SUPPORTED) !=
+		     XFEATURES_INIT_FPSTATE_HANDLED);
+
 	WARN_ON_FPU(!on_boot_cpu);
 	on_boot_cpu = 0;
 
@@ -466,10 +489,22 @@ static void __init setup_init_fpu_buf(vo
 	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
 
 	/*
-	 * Dump the init state again. This is to identify the init state
-	 * of any feature which is not represented by all zero's.
+	 * All components are now in init state. Read the state back so
+	 * that init_fpstate contains all non-zero init state. This only
+	 * workswith XSAVE, but not with XSAVEOPT and XSAVES because
+	 * those use the init optimization which skips writing data for
+	 * components in init state.
+	 *
+	 * XSAVE could be used, but that would require to reshuffle the
+	 * data when XSAVES is available because XSAVES uses xstate
+	 * compaction. But doing so is a pointless exercise because most
+	 * components have an all zeros init state except for the legacy
+	 * ones (FP and SSE). Those can be saved with FXSAVE into the
+	 * legacy area. Adding new features requires to ensure that init
+	 * state is all zeroes or if not to add the necessary handling
+	 * here.
 	 */
-	copy_xregs_to_kernel_booting(&init_fpstate.xsave);
+	fxsave(&init_fpstate.fxsave);
 }
 
 static int xfeature_uncompacted_offset(int xfeature_nr)

