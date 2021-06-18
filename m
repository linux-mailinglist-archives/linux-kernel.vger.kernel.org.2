Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6543ACEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhFRPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhFRPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:04 -0400
Message-Id: <20210618143447.676670973@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mKy6IiR1jFPeKPFifw31W55wM3bjNuu6E0phnoutMsg=;
        b=WkQ12UbIVnkgdo78a0zXhhfEuaepOhRPcG7fTKFfJ1AzSQe/g0QR0ftYIwjtwEyXxXX+9S
        2MEvOvFjgqgpK23SBTbINPjVhXd9G2t8TrWiqwydgogUNWc4KEWX4+8tYVqOHrI6bDrknH
        IM+i/wFbKGRALJRse8adiOkVL8ZwtDU+/AG3GUIe3aT7MomJR1bqIfAM2v1qbOZQ9C6kGH
        yFJPgJHOsO6mCKpR+0FHlolL9hgo5IxcGSaXiMalcDH43xasGbG2d3WY7OzrQtJ4Is+B8Q
        kb4rFH7MuEonUlX50p/PiPZlnj96X0LCRJeAmb9LDsQ/ITme+F/iukOyOY+HEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mKy6IiR1jFPeKPFifw31W55wM3bjNuu6E0phnoutMsg=;
        b=89LSq3E3p9PzuRuCvSmMQ9sMZz5YXqShRPRhSvxuT0ZKaAYq3kvkftiaM5ycVDAolW4QcE
        8OfWJY3EempKJoDQ==
Date:   Fri, 18 Jun 2021 16:18:52 +0200
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
Subject: [patch V3 29/66] x86/fpu: Rename fxregs related copy functions
References: <20210618141823.161158090@linutronix.de>
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
V3: Rename (Boris)
---
 arch/x86/include/asm/fpu/internal.h |   18 +++++-------------
 arch/x86/kernel/fpu/core.c          |    4 ++--
 arch/x86/kernel/fpu/signal.c        |   10 +++++-----
 3 files changed, 12 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -131,7 +131,7 @@ static inline int copy_fregs_to_user(str
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
 
-static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
+static inline int fxsave_to_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
@@ -140,7 +140,7 @@ static inline int copy_fxregs_to_user(st
 
 }
 
-static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
+static inline void fxrstor(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -148,7 +148,7 @@ static inline void copy_kernel_to_fxregs
 		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
+static inline int fxrstor_safe(struct fxregs_state *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -156,7 +156,7 @@ static inline int copy_kernel_to_fxregs_
 		return kernel_insn_err(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
+static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
@@ -179,14 +179,6 @@ static inline int copy_user_to_fregs(str
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
@@ -393,7 +385,7 @@ static inline void __copy_kernel_to_fpre
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
 
@@ -360,7 +360,7 @@ static inline void copy_init_fpstate_to_
 	if (use_xsave())
 		os_xrstor(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
-		copy_kernel_to_fxregs(&init_fpstate.fxsave);
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

