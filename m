Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E829402FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbhIGU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbhIGU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:14 -0400
Message-ID: <20210907200849.165901323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8iCph3lKt2+PZkLTTTATfYPeA1p/3gwkIcq374+L1CM=;
        b=fc1C2VAy1lo3fmLFrrAsUpQUa2nINhrmtxVKuCTIpHLTKVHHopqy4imMHDqACfcHdysCwk
        IhEotCmwS6YoZlUpQiqtqmVVOuVIFlwliRgLc00EOMVi7PSYqtpUQghBGQRF3cPujucnuz
        5K2oGSE8qbJCSJVXR0MeopOpwJB2MxPT+j8WBncDb5Qn1IjxCXqJ264eAHeJ/5AKvqFcGa
        BRGK/gFFLrcs8hXcn1KJqTfJz/w+8sz7elEakEqqkuN3xvn2fAjtak3IAncr2FI3HJI4gs
        abxXGAZF2pV3lQI2CndGJkPygBlWAgl2OYzxKr0MoZoka4cZgrvmlwF8QZbMzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8iCph3lKt2+PZkLTTTATfYPeA1p/3gwkIcq374+L1CM=;
        b=v8TdgmD/41wZbWjXPf4PKAVEmSIW+xFVJuwrq/v3eIgDNUcLPF7oQHVtN4JH26Zfu1fdJA
        ONwaUiy+45AjkIDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 16/20] x86/signal: Change return type of
 restore_sigcontext() to boolean
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:05 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the call sites cares about the return code. All they are interested
in is success or fail.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/ia32/ia32_signal.c |   12 ++++++------
 arch/x86/kernel/signal.c    |   18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -57,8 +57,8 @@ static inline void reload_segments(struc
 /*
  * Do a signal return; undo the signal stack.
  */
-static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *usc)
+static bool ia32_restore_sigcontext(struct pt_regs *regs,
+				    struct sigcontext_32 __user *usc)
 {
 	struct sigcontext_32 sc;
 
@@ -66,7 +66,7 @@ static int ia32_restore_sigcontext(struc
 	current->restart_block.fn = do_no_restart_syscall;
 
 	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
-		return -EFAULT;
+		return false;
 
 	/* Get only the ia32 registers. */
 	regs->bx = sc.bx;
@@ -94,7 +94,7 @@ static int ia32_restore_sigcontext(struc
 	 * normal case.
 	 */
 	reload_segments(&sc);
-	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+	return !fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
 COMPAT_SYSCALL_DEFINE0(sigreturn)
@@ -111,7 +111,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 
 	set_current_blocked(&set);
 
-	if (ia32_restore_sigcontext(regs, &frame->sc))
+	if (!ia32_restore_sigcontext(regs, &frame->sc))
 		goto badframe;
 	return regs->ax;
 
@@ -135,7 +135,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
 	if (compat_restore_altstack(&frame->uc.uc_stack))
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -79,9 +79,9 @@ static void force_valid_ss(struct pt_reg
 # define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
-static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *usc,
-			      unsigned long uc_flags)
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
 {
 	struct sigcontext sc;
 
@@ -89,7 +89,7 @@ static int restore_sigcontext(struct pt_
 	current->restart_block.fn = do_no_restart_syscall;
 
 	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return -EFAULT;
+		return false;
 
 #ifdef CONFIG_X86_32
 	set_user_gs(regs, sc.gs);
@@ -136,8 +136,8 @@ static int restore_sigcontext(struct pt_
 		force_valid_ss(regs);
 #endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
-			       IS_ENABLED(CONFIG_X86_32));
+	return !fpu__restore_sig((void __user *)sc.fpstate,
+				 IS_ENABLED(CONFIG_X86_32));
 }
 
 static __always_inline int
@@ -641,7 +641,7 @@ SYSCALL_DEFINE0(sigreturn)
 	 * x86_32 has no uc_flags bits relevant to restore_sigcontext.
 	 * Save a few cycles by skipping the __get_user.
 	 */
-	if (restore_sigcontext(regs, &frame->sc, 0))
+	if (!restore_sigcontext(regs, &frame->sc, 0))
 		goto badframe;
 	return regs->ax;
 
@@ -669,7 +669,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
 	if (restore_altstack(&frame->uc.uc_stack))
@@ -927,7 +927,7 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
 	if (compat_restore_altstack(&frame->uc.uc_stack))

