Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051E4402FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346824AbhIGU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346487AbhIGU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:15 -0400
Message-ID: <20210907200849.223169145@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+WebksPMH5OvSVdteGdXp/rfcM179M0H/SObaqVRYmQ=;
        b=NBoRjney97RR0xKUD8wve6GFG1d8BDQXqF/K/86voRX1LgYGJNRABspCuNM2m2OUGQ1dQ5
        G2aGKdVcHJJOGsfG0JpD4jb9bLtkwaGX2uAyXGRPEi5sQoevEfYhGtpdA6fAaLrGQVAa18
        7211t2AL4ezx+OIRKINuvhf843uGHmb7g9XmxUimpoxgYZjIi/WPfLwZ7wSR6AjPvAbm/P
        wuBsoYPCWOogUplspAZhoraMyvTWPP4OK4zbQEAS2TbAf65/IZxDUDOwILiDQZ1aWvVm4+
        cYcyUbldodj9rlhUuRLaS11R1NDvWAEbgUBejGj139gsyMWfXEDO6BxuWas0Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+WebksPMH5OvSVdteGdXp/rfcM179M0H/SObaqVRYmQ=;
        b=gN4ir+Hv+fkWvsFI8QQd9xCIpXAWjZCOYx/tFOqiMe/xJknWG3JMrKqhdoH9yK/lUdg/8I
        b5K7k+qpHruNZLDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 17/20] x86/fpu/signal: Change return type of
 fpu__restore_sig() to boolean
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:07 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the call sites cares about the error code. All they need to know is
whether the function succeeded or not.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/ia32/ia32_signal.c         |    2 +-
 arch/x86/include/asm/fpu/internal.h |    2 +-
 arch/x86/kernel/fpu/signal.c        |   22 ++++++++++------------
 arch/x86/kernel/signal.c            |    4 ++--
 4 files changed, 14 insertions(+), 16 deletions(-)

--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -94,7 +94,7 @@ static bool ia32_restore_sigcontext(stru
 	 * normal case.
 	 */
 	reload_segments(&sc);
-	return !fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
 COMPAT_SYSCALL_DEFINE0(sigreturn)
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,7 @@
 /*
  * High level FPU state handling functions:
  */
-extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
+extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -434,17 +434,17 @@ static inline int xstate_sigframe_size(v
 /*
  * Restore FPU state from a sigframe:
  */
-int fpu__restore_sig(void __user *buf, int ia32_frame)
+bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
 	unsigned int size = xstate_sigframe_size();
 	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
-	int ret;
+	bool success = false;
 
 	if (unlikely(!buf)) {
 		fpu__clear_user_states(fpu);
-		return 0;
+		return true;
 	}
 
 	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
@@ -460,23 +460,21 @@ int fpu__restore_sig(void __user *buf, i
 		ia32_fxstate = true;
 	}
 
-	if (!access_ok(buf, size)) {
-		ret = -EACCES;
+	if (!access_ok(buf, size))
 		goto out;
-	}
 
 	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
-		ret = fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
+		success = !fpregs_soft_set(current, NULL, 0,
+					   sizeof(struct user_i387_ia32_struct),
+					   NULL, buf);
 	} else {
-		ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+		success = !__fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
 
 out:
-	if (unlikely(ret))
+	if (unlikely(!success))
 		fpu__clear_user_states(fpu);
-	return ret;
+	return success;
 }
 
 unsigned long
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -136,8 +136,8 @@ static bool restore_sigcontext(struct pt
 		force_valid_ss(regs);
 #endif
 
-	return !fpu__restore_sig((void __user *)sc.fpstate,
-				 IS_ENABLED(CONFIG_X86_32));
+	return fpu__restore_sig((void __user *)sc.fpstate,
+			       IS_ENABLED(CONFIG_X86_32));
 }
 
 static __always_inline int

