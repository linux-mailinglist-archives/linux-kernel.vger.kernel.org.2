Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9153FBA24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhH3Q2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbhH3Q2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:25 -0400
Message-ID: <20210830162545.653942429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8iCph3lKt2+PZkLTTTATfYPeA1p/3gwkIcq374+L1CM=;
        b=jkjqR9/nXZ0qOylcz4qszcP6n3fT2ECLlcXpOrWlu03nIde7KRws3sgWV4Q8frJQ0TlhY1
        hO4AD0GPvBsOg+HbvztA++UBECwFf9k+Or6kYSbq6JgBHZs2tBo6d/Vqp0QkG/KHKYcE+m
        xBDkh6FxyNQJ5UmT1KxuM8Djy/3vCobBDa7o6m5XHWUM3PbfnmuHw8wZCoEVfe9guty2oV
        LuttooWDCwc3R7sZ7GBqUDtxWr+tAXcONhMyBzkIvBu3TUpYl5w7i9qz6aio/ILiBZskgz
        /E3PSTcMSVVnWn1wvi3+xq8q7fg/3yrCX7FZ15OxRSceQX45ijKt5g5e7bJaJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8iCph3lKt2+PZkLTTTATfYPeA1p/3gwkIcq374+L1CM=;
        b=j34GTg3aaN+aHFzyMu3q1nVDIeDj9w8f+t2Ldf1gDu93ndAlkbEbM5zrGlmrjHu3Oj2W2i
        IevVZjDy90/fWiBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 06/10] x86/signal: Change return type of restore_sigcontext()
 to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:30 +0200 (CEST)
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

