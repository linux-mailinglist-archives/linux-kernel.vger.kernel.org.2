Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E73FBA22
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhH3Q20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbhH3Q2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:29 -0700 (PDT)
Message-ID: <20210830162545.541794090@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uzMgNkI7vpXdxJyVtV5DFnRLmy4JxwCsFf80of/Osng=;
        b=EvoKAsh4wAm1EVUyJIY1NkKl4U781Z/ayXRglvph8LRsuVTYA4xPnwK6v+OVx+ilCaNyzB
        9xMBq+kM0+RxCNM5w+Eo17ML/kpbQ++bxoxi23Lw+AEticqVGGHOHUMLZm9JlzSwWNnh8z
        C0YhuGGflMcURHrew/Jz/CfmJwnKnL+TJD70b5ourenzpXEwTjVRLMtcA2yV5bgvGSPbST
        xnYRoU9dXbo89Vx3pbUY1vk94oNUWfTrocizRYhESNrFiVHKVoDJ9g0NNPZJepOfltW5Kc
        NlNOa1J+sRKD057VTVxCqdsJdb6XFwdVHWhCZ9SJDAZGoHQ9c0WR+sH0tJZc8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uzMgNkI7vpXdxJyVtV5DFnRLmy4JxwCsFf80of/Osng=;
        b=DzxhBM5dg3Sz7U71QSJ7IlQaRCoR6TWw9K5i6OQLW74C6AvOpUc/a8vEJhYYXcmPQKNsAe
        5BDzCFdqeANQ7FDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 04/10] x86/fpu/signal: Change return type of
 copy_fpstate_to_sigframe() to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:27 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the call sites cares about the actual return code. Change the
return type to boolean and return 'true' on success.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/ia32/ia32_signal.c         |    4 ++--
 arch/x86/include/asm/fpu/internal.h |    2 +-
 arch/x86/kernel/fpu/signal.c        |   20 ++++++++++----------
 arch/x86/kernel/signal.c            |    4 +---
 4 files changed, 14 insertions(+), 16 deletions(-)

--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -220,8 +220,8 @@ static void __user *get_sigframe(struct
 
 	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate = (struct _fpstate_32 __user *) sp;
-	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				     math_size) < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
+				      math_size))
 		return (void __user *) -1L;
 
 	sp -= frame_size;
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -391,7 +391,7 @@ static inline void restore_fpregs_from_f
 	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
 }
 
-extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
 /*
  * FPU context switch related helper methods:
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -165,7 +165,7 @@ static inline int copy_fpregs_to_sigfram
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
@@ -176,13 +176,14 @@ int copy_fpstate_to_sigframe(void __user
 
 	if (!static_cpu_has(X86_FEATURE_FPU)) {
 		struct user_i387_ia32_struct fp;
+
 		fpregs_soft_get(current, NULL, (struct membuf){.p = &fp,
 						.left = sizeof(fp)});
-		return copy_to_user(buf, &fp, sizeof(fp)) ? -EFAULT : 0;
+		return !copy_to_user(buf, &fp, sizeof(fp));
 	}
 
 	if (!access_ok(buf, size))
-		return -EACCES;
+		return false;
 
 	if (use_xsave()) {
 		struct xregs_state __user *xbuf = buf_fx;
@@ -191,9 +192,8 @@ int copy_fpstate_to_sigframe(void __user
 		 * Clear the xsave header first, so that reserved fields are
 		 * initialized to zero.
 		 */
-		ret = __clear_user(&xbuf->header, sizeof(xbuf->header));
-		if (unlikely(ret))
-			return ret;
+		if (__clear_user(&xbuf->header, sizeof(xbuf->header)))
+			return false;
 	}
 retry:
 	/*
@@ -215,17 +215,17 @@ int copy_fpstate_to_sigframe(void __user
 		if (!__clear_user(buf_fx, fpu_user_xstate_size) &&
 		    ret == -X86_TRAP_PF)
 			goto retry;
-		return -1;
+		return false;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
-		return -1;
+		return false;
 
 	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
-		return -1;
+		return false;
 
-	return 0;
+	return true;
 }
 
 static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -244,7 +244,6 @@ get_sigframe(struct k_sigaction *ka, str
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int ret;
 
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -292,8 +291,7 @@ get_sigframe(struct k_sigaction *ka, str
 	}
 
 	/* save i387 and extended state */
-	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
-	if (ret < 0)
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;

