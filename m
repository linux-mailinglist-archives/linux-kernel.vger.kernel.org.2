Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D23B1A07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFWM2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhFWM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:53 -0400
Message-Id: <20210623121456.211585137@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xlv2+TnrhPjHRvGQbHtIyrZ0+7S9XLobYqIdUCbd4/I=;
        b=nirlt0RtZ6fYHirFaQcsmDTdVhuj/cN+NDAQ4SzSVWSeJ1FHKzNzIP6YmjNZbOpald8UDO
        k5TL4BbZX3AWFIBFKfsPoNepAxJqN8bXcrZdfrsUFBBqfadwUx8Ep+1s7DO9OR4G1ZNP98
        cgoQdbJNNE1q+s9lur0BuwVwL8pk+9wNurVxqwzMjKnqxP4QbQeBdIxTfupP3MaAq2Sk2O
        W25/z4v12OnLNlmgAPY+sI+VSTV4WSD6KEUPHsaMwrc59PZwoaikht88nT7IKqBioIRdPK
        LkN8H8CgbqgKY9LWZaW50kkoImZhniP9632m1ExCTVz2go8sQOdCCKwi/KICYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xlv2+TnrhPjHRvGQbHtIyrZ0+7S9XLobYqIdUCbd4/I=;
        b=SOamXJxGHuR3AxuKyJVXr7t/2pHjlJJECXMXFs4BvHWJbsoN29N/vuO8POGG/HILeDAIdv
        fbo5ZniarrrYN+Aw==
Date:   Wed, 23 Jun 2021 14:02:16 +0200
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
Subject: [patch V4 49/65] x86/fpu: Rename xfeatures_mask_user() to
 xfeatures_mask_uabi()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename it so it's clear that this is about user ABI features which can
differ from the feature set which the kernel saves and restores because the
kernel handles e.g. PKRU differently. But the user ABI (ptrace, signal
frame) expects it to be there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    7 ++++++-
 arch/x86/include/asm/fpu/xstate.h   |    6 +++++-
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |   10 +++++-----
 arch/x86/kernel/fpu/xstate.c        |   18 +++++++++---------
 5 files changed, 26 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -324,7 +324,12 @@ static inline void os_xrstor(struct xreg
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
-	u64 mask = xfeatures_mask_user();
+	/*
+	 * Include the features which are not xsaved/rstored by the kernel
+	 * internally, e.g. PKRU. That's user space ABI and also required
+	 * to allow the signal handler to modify PKRU.
+	 */
+	u64 mask = xfeatures_mask_uabi();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -83,7 +83,11 @@ static inline u64 xfeatures_mask_supervi
 	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_user(void)
+/*
+ * The xfeatures which are enabled in XCR0 and expected to be in ptrace
+ * buffers and signal frames.
+ */
+static inline u64 xfeatures_mask_uabi(void)
 {
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,7 +404,7 @@ void fpu__clear_user_states(struct fpu *
 	}
 
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_user());
+	restore_fpregs_from_init_fpstate(xfeatures_mask_uabi());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -257,14 +257,14 @@ static int copy_user_to_fpregs_zeroing(v
 
 	if (use_xsave()) {
 		if (fx_only) {
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 
 			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
 		} else {
-			init_bv = xfeatures_mask_user() & ~xbv;
+			init_bv = xfeatures_mask_uabi() & ~xbv;
 
 			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
@@ -420,7 +420,7 @@ static int __fpu__restore_sig(void __use
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
+		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
 
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
@@ -454,7 +454,7 @@ static int __fpu__restore_sig(void __use
 		if (use_xsave()) {
 			u64 init_bv;
 
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 			os_xrstor(&init_fpstate.xsave, init_bv);
 		}
 
@@ -549,7 +549,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_user();
+	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -144,7 +144,7 @@ void fpu__init_cpu_xstate(void)
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
@@ -453,7 +453,7 @@ int xfeature_size(int xfeature_nr)
 static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_user())
+	if (hdr->xfeatures & ~xfeatures_mask_uabi())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -756,7 +756,7 @@ void __init fpu__init_system_xstate(void
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
-	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -791,7 +791,7 @@ void __init fpu__init_system_xstate(void
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -828,14 +828,14 @@ void fpu__resume_cpu(void)
 	/*
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
 	 * of XSAVES and MSR_IA32_XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
@@ -993,7 +993,7 @@ void copy_xstate_to_uabi_buf(struct memb
 		break;
 
 	case XSTATE_COPY_XSAVE:
-		header.xfeatures &= xfeatures_mask_user();
+		header.xfeatures &= xfeatures_mask_uabi();
 		break;
 	}
 
@@ -1038,7 +1038,7 @@ void copy_xstate_to_uabi_buf(struct memb
 		 * compacted init_fpstate. The gap tracking will zero this
 		 * later.
 		 */
-		if (!(xfeatures_mask_user() & BIT_ULL(i)))
+		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
 			continue;
 
 		/*

