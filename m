Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC83A46CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFKQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhFKQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:14 -0400
Message-Id: <20210611163112.540104811@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CJrPgdd5KLNu81B87dm9Lhfvwzy4H7m4Lxmf8c0bAjQ=;
        b=D/zLQadARXf0kMmWEflG7hlLNwB3hCcniNvwmzfKc4hKVv4htbn0ZJnD6nVVR0kDzWyqC0
        wKhkmXFIC/O4qmEMAG7qk8DXoIIPNccEv4lXqjTbCNNWnVe7udCOD+C7e4GV6HQO1Aa21B
        nIOd0DFs6ATF5UH0ICIZYAr1wUMCSWNVDGf0Jhbn5AptuqDlXkkDZUWn2sDhXv6GjN502l
        lezMWhANtgaQVb/+8+VD27qQobybjT5QY7BkuBZA3UhLfC4kX8UnTziQrExSc2N0xRjiVn
        hOEey1Y5T8gti9db+xlaDXWLKeE/5UB6eMwJKnhZCZcZn6EVlLN33sAY3ttdSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CJrPgdd5KLNu81B87dm9Lhfvwzy4H7m4Lxmf8c0bAjQ=;
        b=rTVSz7j8gUkOX07w8zFQG3pKdgo/yFp22Ln/yiui6Wkwxm/n0uaN0gNaLXTLgHu+S41JNw
        7oMINv+zxbSuTeCA==
Date:   Fri, 11 Jun 2021 18:15:38 +0200
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
Subject: [patch 15/41] x86/fpu: Rename fregs related copy functions
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for fnsave/fnrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_fregs_to_kernel() to fnsave_to_kernel()
	copy_kernel_to_fregs() to fnrstor_from_kernel()
	copy_fregs_to_user()   to fnsave_to_user_sigframe()
	copy_user_to_fregs()   to fnrstor_from_user_sigframe()

so it's entirely clear what this is about.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   10 +++++-----
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -127,7 +127,7 @@ static inline void fpstate_init_soft(str
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
@@ -165,17 +165,17 @@ static inline int fxrstor_from_user_sigf
 		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_kernel_to_fregs(struct fregs_state *fx)
+static inline void frstor_from_kernel(struct fregs_state *fx)
 {
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
+static inline int frstor_from_kernel_err(struct fregs_state *fx)
 {
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
@@ -405,7 +405,7 @@ static inline void __copy_kernel_to_fpre
 		if (use_fxsr())
 			fxrstor_from_kernel(&fpstate->fxsave);
 		else
-			copy_kernel_to_fregs(&fpstate->fsave);
+			frstor_from_kernel(&fpstate->fsave);
 	}
 }
 
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -362,7 +362,7 @@ static inline void copy_init_fpstate_to_
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		fxrstor_from_kernel(&init_fpstate.fxsave);
 	else
-		copy_kernel_to_fregs(&init_fpstate.fsave);
+		frstor_from_kernel(&init_fpstate.fsave);
 
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
@@ -284,7 +284,7 @@ static int copy_user_to_fpregs_zeroing(v
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
 	} else
-		return copy_user_to_fregs(buf);
+		return frstor_from_user_sigframe(buf);
 }
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
@@ -474,7 +474,7 @@ static int __fpu__restore_sig(void __use
 			goto out;
 
 		fpregs_lock();
-		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
+		ret = frstor_from_kernel_err(&fpu->state.fsave);
 	}
 	if (!ret)
 		fpregs_mark_activate();

