Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353173ACEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhFRPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhFRPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB20C0611F9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:56 -0700 (PDT)
Message-Id: <20210618143447.780873283@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7+41AwVdLbaTVZgvAeXy/OOX+D3x/I9EAVOm5/HkGxw=;
        b=nDmowS62wT9dNUR5Ljh+viqjs+WNiUoip/tJ4O/xUYmQ3FFIhf2gfeT+2rAPhTiKjxTO/W
        WEwASmgRcrI0BPI0uUwmzB6QOA5/vaBKu9MWQrjb4Gh7UVwZWIxsxMpJ4EQq1PUmap4xjx
        G/kdKpnp3b3WwsVu7wi4eH/lFZ8iSf2jIO+FVWC4VlDHsTE1+sH4TApCz4Gv2xfw3TtaM2
        EYSSPdcmGFul5kObonT0o5JFpZLK/MEOHmJEA1ZkV0mck/XXNMgY7ArrADzc6uub8fJipv
        f2WdI3p/6+lUBQZPiyxwsLnp5y6FjoEkBy9nMIEuooVvsyHZeA69jq/mZZlrMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7+41AwVdLbaTVZgvAeXy/OOX+D3x/I9EAVOm5/HkGxw=;
        b=F58TQn7tcRDT3xI9p7uMpJ8icHJqtMqyLaBb5f75wYNhQQ/KuS2tPQBuLGieWOlq9CTQwl
        Ov6RBtKdLJoxuoDw==
Date:   Fri, 18 Jun 2021 16:18:53 +0200
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
Subject: [patch V3 30/66] x86/fpu: Rename fregs related copy functions
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for fnsave/fnrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_fregs_to_kernel() to fnsave()
	copy_kernel_to_fregs() to fnrstor()
	copy_fregs_to_user()   to fnsave_to_user_sigframe()
	copy_user_to_fregs()   to fnrstor_from_user_sigframe()

so it's clear what these are doing. All these functions are really low
level wrappers around the equaly named instructions, so mapping to the
documentation is just natural.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Rename (Boris)
---
 arch/x86/include/asm/fpu/internal.h |   10 +++++-----
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -126,7 +126,7 @@ static inline void fpstate_init_soft(str
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
@@ -164,17 +164,17 @@ static inline int fxrstor_from_user_sigf
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
@@ -387,7 +387,7 @@ static inline void __copy_kernel_to_fpre
 		if (use_fxsr())
 			fxrstor(&fpstate->fxsave);
 		else
-			copy_kernel_to_fregs(&fpstate->fsave);
+			frstor(&fpstate->fsave);
 	}
 }
 
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -362,7 +362,7 @@ static inline void copy_init_fpstate_to_
 	else if (static_cpu_has(X86_FEATURE_FXSR))
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

