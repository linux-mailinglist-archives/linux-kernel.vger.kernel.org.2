Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60D403AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbhIHNbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51250 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhIHNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:47 -0400
Message-ID: <20210908132525.966197097@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jvt0gZeLeM3itPx/J9GzAl+2v2OSzL9FX2jw0G8BCTw=;
        b=dnJAmlq1GjpXcUjFAyA4ey6klZZBIMZfb1AecCPPW9Z7ZJtZwENTTTVD3QY6D2r8qrVOaU
        Mnuep8E5HWI+Dph62v+/cSl/iWpF8QVYc7QkeZaLkw/EFSVzvdgNRpc9md1dCC6XaS1n1u
        FGZJaYCxenIA0jLyk46R/jYcacstVhfW0rUlTQpwW+s6A/qQ0uryjBvjM5OnDXgprdEgIQ
        fdoaaVz6CUvtp0xL8AaGMqs1qtB5NZk2sc9RTYaC4RF4c45tJBwiKWO6a9CWBYMvzfQuDk
        2CtYR37JLvdvInO4TUUnNBypLWEQDNJFN4pxaa/BaoxwebqsH1L2PoUu8C72aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jvt0gZeLeM3itPx/J9GzAl+2v2OSzL9FX2jw0G8BCTw=;
        b=buV964gtfM9ipphgTgU8SVit5Qktaqjo4HiNIfqT/c+lccKMM6YrI98eIDqIQzEE4+hcfd
        6mJ8xnrdmCgkJTAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 18/20] x86/fpu/signal: Change return type of
 __fpu_restore_sig() to boolean
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:38 +0200 (CEST)
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
-		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all) ? -EINVAL : 0;
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

