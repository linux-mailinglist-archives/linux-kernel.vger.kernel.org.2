Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE503A46E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhFKQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhFKQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA6C0611C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:40 -0700 (PDT)
Message-Id: <20210611163114.684506425@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dE/RU9bWNJDjEkwmuH8bhawuMLTQl22UR/vV9vivXac=;
        b=XHUCN+ZSaDpTiFDJSHknWCEfUn33eNgzXCrmjjscEdCjpnH+aQZhIEO9pGo4K+UdP7kous
        Pf6J9U/Q5rb/csHKMdBPvQPcIosoipQ1c+BQkF36zaeCkyDpBx5BV0iZcM37b8dzdPpDQB
        GHpP/Szcj7dqhpcdwztoxSVukRuCQsZDkCJ+Bt8AnVuEbfRvtrYAfxU1aD0pA3ROYOFkki
        1oYhHQJKlqmhmCwstkebiUOv8pcrse2X6+fD0XHHiPWIaV0Mm0nZ0YUqU1Ebg+vugBVAcI
        +OnJqq5z9ASeAHuPZERBKk9RTZGBO/DmDKqqSksY9aSQIFszt/92pNmhVLFudw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dE/RU9bWNJDjEkwmuH8bhawuMLTQl22UR/vV9vivXac=;
        b=TWhBDM5BTT9XHn8RUTAm9GTVX6HkVPJOFaWTU+KIeYer6fIlCBIlCmORYrYL6kwRU+wWNb
        tS06kdz32u2WBzAw==
Date:   Fri, 11 Jun 2021 18:15:57 +0200
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
Subject: [patch 34/41] x86/fpu: Rename xfeatures_mask_user() to xfeatures_mask_uabi()
References: <20210611161523.508908024@linutronix.de>
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
---
V4: New patch
---
 arch/x86/include/asm/fpu/internal.h |    7 ++++++-
 arch/x86/include/asm/fpu/xstate.h   |    6 +++++-
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |   10 +++++-----
 arch/x86/kernel/fpu/xstate.c        |   12 ++++++------
 5 files changed, 23 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -341,7 +341,12 @@ static inline void xrstor_from_kernel(st
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
@@ -471,7 +471,7 @@ void fpu__clear_user_states(struct fpu *
 	}
 
 	/* Reset user states in registers. */
-	load_fpregs_from_init_fpstate(xfeatures_mask_user());
+	load_fpregs_from_init_fpstate(xfeatures_mask_uabi());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -267,14 +267,14 @@ static int copy_user_to_fpregs_zeroing(v
 
 	if (use_xsave()) {
 		if (fx_only) {
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 
 			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;
 		} else {
-			init_bv = xfeatures_mask_user() & ~xbv;
+			init_bv = xfeatures_mask_uabi() & ~xbv;
 
 			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
@@ -429,7 +429,7 @@ static int __fpu__restore_sig(void __use
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
+		u64 init_bv = xfeatures_mask_uabi() & ~user_xfeatures;
 
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
@@ -463,7 +463,7 @@ static int __fpu__restore_sig(void __use
 		if (use_xsave()) {
 			u64 init_bv;
 
-			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
 			xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 		}
 
@@ -558,7 +558,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask_user();
+	fx_sw_reserved.xfeatures = xfeatures_mask_uabi();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -155,7 +155,7 @@ void fpu__init_cpu_xstate(void)
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
 	 */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
@@ -443,7 +443,7 @@ int using_compacted_format(void)
 static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~xfeatures_mask_user())
+	if (hdr->xfeatures & ~xfeatures_mask_uabi())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -745,7 +745,7 @@ void __init fpu__init_system_xstate(void
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_all |= ecx + ((u64)edx << 32);
 
-	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_uabi() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -776,7 +776,7 @@ void __init fpu__init_system_xstate(void
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_uabi());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -804,7 +804,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_uabi());
 
 	/*
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
@@ -981,7 +981,7 @@ void copy_uabi_xstate_to_membuf(struct m
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= xfeatures_mask_user();
+	header.xfeatures &= xfeatures_mask_uabi();
 
 	if (header.xfeatures & XFEATURE_MASK_FP)
 		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);

