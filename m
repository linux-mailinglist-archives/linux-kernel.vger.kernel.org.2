Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560E3B1A01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFWM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhFWM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10AC0613A3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:12 -0700 (PDT)
Message-Id: <20210623121454.223594101@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CuUu94Vc/Xe73Ip1OGBqeZ+IKe94uJEBq6FJRMo5bSc=;
        b=Sk3DqbNj75+f3wqatpKKfky6N7a6Zv3JEarIdYRy21VWm4IEuzGBmX3Y11oICoiUIACZ2C
        +/YkkKHxlU1yGttrvGLkT4PV21AmQcqDOQZECXXg4V+biTVrvSLiIJVxRKvQbxwWsAcEFM
        pvyN0lNVfgEUBZpXPC8orcsQqnPiEBdB4p9V+4BMbintBdBqjDBan53GWgrqIPklfWHn/5
        aFPxWqnXRbrwip5BjPoTONFKe/K+xO7QSLwv/Zc93LFxOOekGyWwUc99HxDIUes3iivTLh
        oJ/dD6y8HwdHuo/xokvIz/1mvQn+a6C5n2tHcaigNc4n8GxCGKQPcn6RtUTZyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CuUu94Vc/Xe73Ip1OGBqeZ+IKe94uJEBq6FJRMo5bSc=;
        b=LsYVUK4O/WRZ46pudWP0eB9RxgHaWTDWC36Iqyc0YR2VBxf9PtBf0q43iRGAjeeBtF3cof
        AM8peWJkBTh3meBw==
Date:   Wed, 23 Jun 2021 14:01:56 +0200
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
Subject: [patch V4 29/65] x86/fpu: Rename fregs related copy functions
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for fnsave/fnrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_kernel_to_fregs() to fnrstor()
	copy_fregs_to_user()   to fnsave_to_user_sigframe()
	copy_user_to_fregs()   to frstor_from_user_sigframe()

so it's clear what these are doing. All these functions are really low
level wrappers around the equaly named instructions, so mapping to the
documentation is just natural.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: Rename (Boris)
---
 arch/x86/include/asm/fpu/internal.h |   10 +++++-----
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -124,7 +124,7 @@ static inline void fpstate_init_soft(str
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
@@ -162,17 +162,17 @@ static inline int fxrstor_from_user_sigf
 		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_kernel_to_fregs(struct fregs_state *fx)
+static inline void frstor(struct fregs_state *fx)
 {
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
+static inline int frstor_safe(struct fregs_state *fx)
 {
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
@@ -385,7 +385,7 @@ static inline void __copy_kernel_to_fpre
 		if (use_fxsr())
 			fxrstor(&fpstate->fxsave);
 		else
-			copy_kernel_to_fregs(&fpstate->fsave);
+			frstor(&fpstate->fsave);
 	}
 }
 
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -318,7 +318,7 @@ static inline void copy_init_fpstate_to_
 	else if (use_fxsr())
 		fxrstor(&init_fpstate.fxsave);
 	else
-		copy_kernel_to_fregs(&init_fpstate.fsave);
+		frstor(&init_fpstate.fsave);
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
 		copy_init_pkru_to_fpregs();
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -133,7 +133,7 @@ static inline int copy_fpregs_to_sigfram
 	else if (use_fxsr())
 		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = copy_fregs_to_user((struct fregs_state __user *) buf);
+		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 
 	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
 		err = -EFAULT;
@@ -274,7 +274,7 @@ static int copy_user_to_fpregs_zeroing(v
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
 	} else
-		return copy_user_to_fregs(buf);
+		return frstor_from_user_sigframe(buf);
 }
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
@@ -465,7 +465,7 @@ static int __fpu__restore_sig(void __use
 			goto out;
 
 		fpregs_lock();
-		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
+		ret = frstor_safe(&fpu->state.fsave);
 	}
 	if (!ret)
 		fpregs_mark_activate();

