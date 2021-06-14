Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350093A6C12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhFNQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhFNQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:16 -0400
Message-Id: <20210614155355.958020458@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=v4+FKYEhQU673Xh+XiBFsqHdh6YkwrpkWOnTZ8NEAZw=;
        b=zWGVPghlnkjQ9Zm7DrvycWSda4BVy13l1spBaAwbjOhS5EOaUNosiVUtKS5g2qSRzF25Z8
        Wyveu04w3nbb8nwQwOPDRxLCHVwN1dK94JGU3MtV1uXTeilJyWYu3WcvabLi9Fqo0ndWe/
        eAN2yvQaqNzds8YtCqT3ttjOsW/1hyDUR4D6uoaCn2yyEYLW7AvFluaiOceLuMFdcukQjE
        GC2A4XzL2Nehs+nDSfE81GTsWqM3FATD9xd2cWRGpLKb2EPfbwg0SKYEf3oqUqZBy6I89a
        atePTd0eVA6OXVH1KHcXhWB+I0lpmWnYtuASqe6G3g+bJuxE2hdaF4/LiicfAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=v4+FKYEhQU673Xh+XiBFsqHdh6YkwrpkWOnTZ8NEAZw=;
        b=zuAXsHt54bZHDp4XFXH7oQcc2oY4FGiBiv1T5dAJsy2lSMJJ9Zz6fr6BQCWpqkOc6YsYXL
        w+f91cSkmL4DL5Aw==
Date:   Mon, 14 Jun 2021 17:44:30 +0200
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
Subject: [patch V2 22/52] x86/fpu: Rename copy_xregs_to_kernel() and
 copy_kernel_to_xregs()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for xsave[s]/xrstor[s] operations are horribly named and
a permanent source of confusion.

Rename:
	copy_xregs_to_kernel() to xsave_to_kernel()
	copy_kernel_to_xregs() to xrstor_from_kernel()

so it's entirely clear what this is about.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   10 +++++-----
 arch/x86/kernel/fpu/core.c          |    6 +++---
 arch/x86/kernel/fpu/signal.c        |   14 +++++++-------
 arch/x86/kernel/fpu/xstate.c        |    2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -264,7 +264,7 @@ static inline void fxsave_to_kernel(stru
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
  */
-static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
+static inline void xrstor_from_kernel_booting(struct xregs_state *xstate)
 {
 	u64 mask = -1;
 	u32 lmask = mask;
@@ -288,7 +288,7 @@ static inline void copy_kernel_to_xregs_
 /*
  * Save processor xstate to xsave area.
  */
-static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
+static inline void xsave_to_kernel(struct xregs_state *xstate)
 {
 	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
@@ -306,7 +306,7 @@ static inline void copy_xregs_to_kernel(
 /*
  * Restore processor xstate from xsave area.
  */
-static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
+static inline void xrstor_from_kernel(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
@@ -367,7 +367,7 @@ static inline int copy_user_to_xregs(str
  * Restore xstate from kernel space xsave area, return an error code instead of
  * an exception.
  */
-static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
+static inline int xrstor_from_kernel_err(struct xregs_state *xstate, u64 mask)
 {
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
@@ -386,7 +386,7 @@ extern int copy_fpregs_to_fpstate(struct
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
-		copy_kernel_to_xregs(&fpstate->xsave, mask);
+		xrstor_from_kernel(&fpstate->xsave, mask);
 	} else {
 		if (use_fxsr())
 			copy_kernel_to_fxregs(&fpstate->fxsave);
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL(irq_fpu_usable);
 int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
+		xsave_to_kernel(&fpu->state.xsave);
 
 		/*
 		 * AVX512 state is tracked here because its use is
@@ -358,7 +358,7 @@ void fpu__drop(struct fpu *fpu)
 static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
+		xrstor_from_kernel(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
 	else
@@ -389,7 +389,7 @@ static void fpu__clear(struct fpu *fpu,
 	if (user_only) {
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
+			xrstor_from_kernel(&fpu->state.xsave,
 					     xfeatures_mask_supervisor());
 		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
 	} else {
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -271,14 +271,14 @@ static int copy_user_to_fpregs_zeroing(v
 
 			r = copy_user_to_fxregs(buf);
 			if (!r)
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
 			r = copy_user_to_xregs(buf, xbv);
 			if (!r && unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;
 		}
 	} else if (use_fxsr()) {
@@ -367,7 +367,7 @@ static int __fpu__restore_sig(void __use
 			 */
 			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
 			    xfeatures_mask_supervisor())
-				copy_kernel_to_xregs(&fpu->state.xsave,
+				xrstor_from_kernel(&fpu->state.xsave,
 						     xfeatures_mask_supervisor());
 			fpregs_mark_activate();
 			fpregs_unlock();
@@ -422,7 +422,7 @@ static int __fpu__restore_sig(void __use
 		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_xregs_to_kernel(&fpu->state.xsave);
+			xsave_to_kernel(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
@@ -440,13 +440,13 @@ static int __fpu__restore_sig(void __use
 
 		fpregs_lock();
 		if (unlikely(init_bv))
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 
 		/*
 		 * Restore previously saved supervisor xstates along with
 		 * copied-in user xstates.
 		 */
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
+		ret = xrstor_from_kernel_err(&fpu->state.xsave,
 					       user_xfeatures | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
@@ -464,7 +464,7 @@ static int __fpu__restore_sig(void __use
 			u64 init_bv;
 
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 		}
 
 		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -411,7 +411,7 @@ static void __init setup_init_fpu_buf(vo
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
 	 */
-	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
+	xrstor_from_kernel_booting(&init_fpstate.xsave);
 
 	/*
 	 * All components are now in init state. Read the state back so

