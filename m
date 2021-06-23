Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8EE3B1A00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhFWM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFWM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE3C061766
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:09 -0700 (PDT)
Message-Id: <20210623121454.017863494@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BSHQQ/XmVC3eKAt7b37AyiesKGdhrv9sHa7iB/FXc+4=;
        b=DmWYad7LsSzFXwCqYDnGXG614XrCbnHrNVpiCbCqeU1hMlUtui6zamVM7C89KJnTmrKAAC
        AxzyJiOzC0leGE2P56+KxxGGHqPLSSmb+4cVmZnXpDBM+HvvaQzfCrcuJ+1u98haAaqHEH
        Qth5T7vKqPLkRDHrtJoRUdzCYK6as2OhklCQH5yVLc7Oe206f8kp07Heyyds7la8kP3AkS
        1WFk4wGa6felozx7753+oe7ggMLeSrRHg5epBXIdOWWP1BC10BT6S3PR6g2hfpkCgKrjx2
        nyUHDyPxlGyoxUODWg3KJutixaoY0nfx9dRy9/BuKCSQxMa2XvIotCd7pnsl8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BSHQQ/XmVC3eKAt7b37AyiesKGdhrv9sHa7iB/FXc+4=;
        b=z0XjJngzZNj5NnF178YD8pHqjxOgNXpMlHjxw53aoBRhZF91mkSmNMjF4CyCpUqOe/bAT1
        rj8kVZfXDxB00cBA==
Date:   Wed, 23 Jun 2021 14:01:54 +0200
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
Subject: [patch V4 27/65] x86/fpu: Rename fxregs related copy functions
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for fxsave/fxrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_fxregs_to_kernel() to fxsave()
	copy_kernel_to_fxregs() to fxrstor()
	copy_fxregs_to_user() to fxsave_to_user_sigframe()
	copy_user_to_fxregs() to fxrstor_from_user_sigframe()

so it's clear what these are doing. All these functions are really low
level wrappers around the equaly named instructions, so mapping to the
documentation is just natural.

While at it replace the static_cpu_has(X86_FEATURE_FXSR) with use_fxsr() to
be consistent with the rest of the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Replace the static_cpu_has() in the code and not just talk about it (Boris)
V3: Rename (Boris)
---
 arch/x86/include/asm/fpu/internal.h |   18 +++++-------------
 arch/x86/kernel/fpu/core.c          |    6 +++---
 arch/x86/kernel/fpu/signal.c        |   10 +++++-----
 3 files changed, 13 insertions(+), 21 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -129,7 +129,7 @@ static inline int copy_fregs_to_user(str
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
 
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
@@ -138,7 +138,7 @@ static inline int copy_fxregs_to_user(st
 
 }
 
-static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
+static inline void fxrstor(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -146,7 +146,7 @@ static inline void copy_kernel_to_fxregs
 		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
+static inline int fxrstor_safe(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -154,7 +154,7 @@ static inline int copy_kernel_to_fxregs_
 		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -177,14 +177,6 @@ static inline int copy_user_to_fregs(str
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_fxregs_to_kernel(struct fpu *fpu)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
-	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
-}
-
 static inline void fxsave(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -391,7 +383,7 @@ static inline void __copy_kernel_to_fpre
 		os_xrstor(&fpstate->xsave, mask);
 	} else {
 		if (use_fxsr())
-			copy_kernel_to_fxregs(&fpstate->fxsave);
+			fxrstor(&fpstate->fxsave);
 		else
 			copy_kernel_to_fregs(&fpstate->fsave);
 	}
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -107,7 +107,7 @@ int copy_fpregs_to_fpstate(struct fpu *f
 	}
 
 	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
+		fxsave(&fpu->state.fxsave);
 		return 1;
 	}
 
@@ -315,8 +315,8 @@ static inline void copy_init_fpstate_to_
 {
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
-	else if (static_cpu_has(X86_FEATURE_FXSR))
-		copy_kernel_to_fxregs(&init_fpstate.fxsave);
+	else if (use_fxsr())
+		fxrstor(&init_fpstate.fxsave);
 	else
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -64,7 +64,7 @@ static inline int save_fsave_header(stru
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			copy_fxregs_to_kernel(&tsk->thread.fpu);
+			fxsave(&tsk->thread.fpu.state.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -131,7 +131,7 @@ static inline int copy_fpregs_to_sigfram
 	if (use_xsave())
 		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
-		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
+		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
 		err = copy_fregs_to_user((struct fregs_state __user *) buf);
 
@@ -259,7 +259,7 @@ static int copy_user_to_fpregs_zeroing(v
 		if (fx_only) {
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 
-			r = copy_user_to_fxregs(buf);
+			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
@@ -272,7 +272,7 @@ static int copy_user_to_fpregs_zeroing(v
 			return r;
 		}
 	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
+		return fxrstor_from_user_sigframe(buf);
 	} else
 		return copy_user_to_fregs(buf);
 }
@@ -458,7 +458,7 @@ static int __fpu__restore_sig(void __use
 			os_xrstor(&init_fpstate.xsave, init_bv);
 		}
 
-		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
+		ret = fxrstor_safe(&fpu->state.fxsave);
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)

