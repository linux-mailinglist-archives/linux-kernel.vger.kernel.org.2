Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6683A6C14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhFNQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhFNQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:16 -0700 (PDT)
Message-Id: <20210614155356.151608573@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gF/raH+Ou9ijGVsEaMJqYBxI2mhKOrGX6RT8r4wCbh4=;
        b=1JwDd1QpadlSFuQOGn/U0SHiqJQ2dZECh62t+ORiN4tUddsCTpZeOnaktIV97h5jzrjzCK
        0ggHHX69A6iZouvJlSq3ob+NOcTRbT+lBZTipBiibY+y/I/nbQJJPLJqnMbzaXZZZ1UOHE
        Vida36lawtRvKcOaOIfYLQqH8wtrJMaENnytrU+gfbZ4/xNh+TZzO9KcWw9XFnZXmTkhhl
        Amwypi+zpK/YPygHSO/Om+LnjT1N8cEkfUGU2LRBmtyqOdVYkSNCyiRiTa8H+t0mVP9R2f
        Si0nFIb5VPRoBfJwLREOwO3rrq9b5JzWaSo0Nqp7g64nwDj4dMp7ckv8eBuaJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gF/raH+Ou9ijGVsEaMJqYBxI2mhKOrGX6RT8r4wCbh4=;
        b=H+8fx9Wg/6b33uCfjvUuLPNK8e/BhvDY/Gq4bHAiyYKmZ8NCUiaIeSVnS8/b2M4oFE0UDQ
        /88p32irTN1npwDQ==
Date:   Mon, 14 Jun 2021 17:44:32 +0200
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
Subject: [patch V2 24/52] x86/fpu: Rename fxregs related copy functions
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for fxsave/fxrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_fxregs_to_kernel() to fxsave_to_kernel()
	copy_kernel_to_fxregs() to fxrstor_from_kernel()
	copy_fxregs_to_user() to fxsave_to_user_sigframe()
	copy_user_to_fxregs() to fxrstor_from_user_sigframe()

so it's entirely clear what this is about.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   18 +++++-------------
 arch/x86/kernel/fpu/core.c          |    4 ++--
 arch/x86/kernel/fpu/signal.c        |   10 +++++-----
 3 files changed, 12 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -132,7 +132,7 @@ static inline int copy_fregs_to_user(str
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
 
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
@@ -141,7 +141,7 @@ static inline int copy_fxregs_to_user(st
 
 }
 
-static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
+static inline void fxrstor_from_kernel(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -149,7 +149,7 @@ static inline void copy_kernel_to_fxregs
 		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
+static inline int fxrstor_from_kernel_err(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -157,7 +157,7 @@ static inline int copy_kernel_to_fxregs_
 		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -180,14 +180,6 @@ static inline int copy_user_to_fregs(str
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
 static inline void fxsave_to_kernel(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -389,7 +381,7 @@ static inline void __copy_kernel_to_fpre
 		xrstor_from_kernel(&fpstate->xsave, mask);
 	} else {
 		if (use_fxsr())
-			copy_kernel_to_fxregs(&fpstate->fxsave);
+			fxrstor_from_kernel(&fpstate->fxsave);
 		else
 			copy_kernel_to_fregs(&fpstate->fsave);
 	}
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -107,7 +107,7 @@ int copy_fpregs_to_fpstate(struct fpu *f
 	}
 
 	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
+		fxsave_to_kernel(&fpu->state.fxsave);
 		return 1;
 	}
 
@@ -360,7 +360,7 @@ static inline void copy_init_fpstate_to_
 	if (use_xsave())
 		xrstor_from_kernel(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
-		copy_kernel_to_fxregs(&init_fpstate.fxsave);
+		fxrstor_from_kernel(&init_fpstate.fxsave);
 	else
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -64,7 +64,7 @@ static inline int save_fsave_header(stru
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			copy_fxregs_to_kernel(&tsk->thread.fpu);
+			fxsave_to_kernel(&tsk->thread.fpu.state.fxsave);
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
 
@@ -269,7 +269,7 @@ static int copy_user_to_fpregs_zeroing(v
 		if (fx_only) {
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 
-			r = copy_user_to_fxregs(buf);
+			r = fxrstor_from_user_sigframe(buf);
 			if (!r)
 				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;
@@ -282,7 +282,7 @@ static int copy_user_to_fpregs_zeroing(v
 			return r;
 		}
 	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
+		return fxrstor_from_user_sigframe(buf);
 	} else
 		return copy_user_to_fregs(buf);
 }
@@ -467,7 +467,7 @@ static int __fpu__restore_sig(void __use
 			xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 		}
 
-		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
+		ret = fxrstor_from_kernel_err(&fpu->state.fxsave);
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)

