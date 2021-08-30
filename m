Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384E53FBA26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbhH3Q2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbhH3Q22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:28 -0400
Message-ID: <20210830162545.766864034@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GAz1pMiSS+mYKnOm/uR2LqMMhy6iyBu/k4CJkBPyLgg=;
        b=nmJL+fmPxS3QxiP9Z8OwCZiItz26O+Dejc/RZsI586WWaweJGWhZNk5JQTQuICKc3kqDuS
        2FUmWgtUXpHUrZW7N4ntiiWHIfJHCQSyGzYAsUsQNhodxedcx9TVKdZ3JvN/ouWUPcj7In
        6LYlc0I1rOUWjrbkCOJFflrISRMrzIckSVaxqGnQGOPoAKgVJypci4i5h/Z0u+peuTBRay
        qRrVMq1amxO41CE/AA9QYR0XnKPI6eNp/6XIF0EythOKyE9Ut+cw1wJdR/L5KrztUqkH35
        VceC139RgwqVdyH5Ps10iGadM4Cf3xf4CVODLBkUJIlaZr6Ii4LEQ1mH2qEFpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GAz1pMiSS+mYKnOm/uR2LqMMhy6iyBu/k4CJkBPyLgg=;
        b=jK1kwSS8Yr9BYuBvRUxgV/7AFL7fJM4WhTaQ1Ptf16T9t2ZZCzrR9Yz5W83XypK9IwS/Zp
        JtEbhF9tR47taVDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 08/10] x86/fpu/signal: Change return type of
 __fpu_restore_sig() to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:33 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fpu__restore_sig() returns a boolean get rid of the individual
error codes in __fpu_restore_sig() as well.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -310,8 +310,8 @@ static int restore_fpregs_from_user(void
 	return 0;
 }
 
-static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
-			     bool ia32_fxstate)
+static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			      bool ia32_fxstate)
 {
 	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
@@ -319,14 +319,14 @@ static int __fpu_restore_sig(void __user
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
 	bool fx_only = false;
-	int ret;
+	bool success;
+
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 
-		ret = check_xstate_in_sigframe(buf_fx, &fx_sw_user);
-		if (unlikely(ret))
-			return ret;
+		if (check_xstate_in_sigframe(buf_fx, &fx_sw_user))
+			return false;
 
 		fx_only = !fx_sw_user.magic1;
 		state_size = fx_sw_user.xstate_size;
@@ -342,8 +342,8 @@ static int __fpu_restore_sig(void __user
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return !restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						 state_size);
 	}
 
 	/*
@@ -351,9 +351,8 @@ static int __fpu_restore_sig(void __user
 	 * to be ignored for histerical raisins. The legacy state is folded
 	 * in once the larger state has been copied.
 	 */
-	ret = __copy_from_user(&env, buf, sizeof(env));
-	if (ret)
-		return ret;
+	if (__copy_from_user(&env, buf, sizeof(env)))
+		return false;
 
 	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
@@ -380,17 +379,16 @@ static int __fpu_restore_sig(void __user
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
-		if (ret)
-			return ret;
+		if (copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx))
+			return false;
 	} else {
 		if (__copy_from_user(&fpu->state.fxsave, buf_fx,
 				     sizeof(fpu->state.fxsave)))
-			return -EFAULT;
+			return false;
 
 		/* Reject invalid MXCSR values. */
 		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
-			return -EINVAL;
+			return false;
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())
@@ -414,17 +412,18 @@ static int __fpu_restore_sig(void __user
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpu->state.xsave.header.xfeatures &= mask;
-		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
+		success = !os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
 	} else {
-		ret = fxrstor_safe(&fpu->state.fxsave);
+		success = !fxrstor_safe(&fpu->state.fxsave);
 	}
 
-	if (likely(!ret))
+	if (likely(success))
 		fpregs_mark_activate();
 
 	fpregs_unlock();
-	return ret;
+	return success;
 }
+
 static inline int xstate_sigframe_size(void)
 {
 	return use_xsave() ? fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE :
@@ -468,7 +467,7 @@ bool fpu__restore_sig(void __user *buf,
 					   sizeof(struct user_i387_ia32_struct),
 					   NULL, buf);
 	} else {
-		success = !__fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+		success = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
 
 out:

