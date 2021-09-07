Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9E402F42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbhIGT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbhIGT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:42 -0400
Message-ID: <20210907195004.560099285@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fwQIA8w5Vs38DM0ZQK2luzxbYJTG1gnnwnl/ZXt5ezQ=;
        b=uSDTJOSgB5ZbsrmGNLDgVM3cc8w/r4F6tI2hnGmb71lTHJfkoAe7ija2Kh5vf0mkRrsjS1
        sVbwydBJgT/N1PjQ6CAeL20XMiE5g+8Al/0n9yZvD1gUCVib+TacbFXgFeUDoghpDWdL5m
        3hJSZhHRTlo4PJaUdEjBGQsTJvgFVvXaP8UBFFhOZcBK4+ZbJMtZbwwB3VFGmyar0odGsj
        QC4wkbPRytT47+GK+iRWh5IKJ8yUWcKrKPR+UIHhcOMdhOWicxoqMChCa45jjN8bY47z4F
        IqNPXoCQqBRaeaiNDujCgHvQyXBTgI4DvKj1F+H3rfzmQEX7F2GKt3rJdXm/mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fwQIA8w5Vs38DM0ZQK2luzxbYJTG1gnnwnl/ZXt5ezQ=;
        b=X5i1Z+0XNrYzRdddl+nHvJjZcRVJ4j6HKqWF76d9OJxfkOM3F+guW0FmNzZJHuxD5p/ch1
        ylDCv10LgH70oECw==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 14/20] x86/fpu/signal: Change return type of
 copy_fpstate_to_sigframe() to boolean
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:34 +0200 (CEST)
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
@@ -418,7 +418,7 @@ static inline void restore_fpregs_from_f
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
 		    ret == X86_TRAP_PF)
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

