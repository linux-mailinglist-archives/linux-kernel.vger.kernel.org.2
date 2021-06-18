Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34A83ACEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhFRP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:28:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhFRPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:43 -0400
Message-Id: <20210618143451.783907985@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgYl+WKJJwpGOoKbU6GsuN7pInuO8RuPhDfh1laaoG4=;
        b=ozkQkZkH2WKq+NSP9jSnVKWOc/UIX5SRRmZpO+FdH95MjlEsHaQRZ9u9cftpWPIKxipmt5
        oJuiXAe6ZFtwxPsEIuJU9DWulYZ8aN/txclZUkqwWPJ7J4XZCHw5mQ+7eYne//q0JLOrgh
        rTkh9ADtRl0bJVOpDKuPEPyfRA/tktUWSRynG/cmhgg8Hnh2fDGfGWanelLB015s5gDPKR
        SVAezAY3I4/7TXTEKjhn+pJ7+p6w/oHN3sVh/K/6Rl/oiymAxR2vX3/AE/6u7+n/acbKbH
        NqxV5gtrdS03e+7S2HfVC8oK4dIHs9qhpiBlG+QNqC4vjKzxIWk+ptZaM/fhfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GgYl+WKJJwpGOoKbU6GsuN7pInuO8RuPhDfh1laaoG4=;
        b=12xGu46eBXi5t0MiyDqH6nvNZTe6Wb4euSr2nYxVUF3/8/ypHj3giW1SJnELpoZAVrN48K
        rMfqNfzl+WgJ4tBA==
Date:   Fri, 18 Jun 2021 16:19:28 +0200
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
Subject: [patch V3 65/66] x86/fpu/signal: Handle #PF in the direct restore path
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If *RSTOR raises an exception, then the slow path is taken. That's wrong
because if the reason was not #PF then going through the slow path is waste
of time because that will end up with the same conclusion that the data is
invalid.

Now that the wrapper around *RSTOR return an negative error code, which is
the negated trap number, it's possible to differentiate.

If the *RSTOR raised #PF then handle it directly in the fast path and if it
was some other exception, e.g. #GP, then give up and do not try the fast
path.

This removes the legacy frame FRSTOR code from the slow path because FRSTOR
is not a ia32_fxstate frame and is therefore handled in the fast path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   65 ++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -270,11 +270,17 @@ static int restore_hwregs_from_user(void
 	}
 }
 
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+/*
+ * Attempt to restore the FPU registers directly from user memory.
+ * Pagefaults are handled and any errors returned are fatal.
+ */
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				    bool fx_only, unsigned int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret ;
 
+retry:
 	fpregs_lock();
 	pagefault_disable();
 	ret = restore_hwregs_from_user(buf, xrestore, fx_only);
@@ -291,15 +297,16 @@ static int restore_fpregs_from_user(void
 		 * invalidate the FPU register state otherwise the task
 		 * might preempt current and return to user space with
 		 * corrupted FPU registers.
-		 *
-		 * In case current owns the FPU registers then no further
-		 * action is required. The fixup in the slow path will
-		 * handle it correctly.
 		 */
 		if (test_thread_flag(TIF_NEED_FPU_LOAD))
 			__cpu_invalidate_fpregs_state();
 		fpregs_unlock();
-		return ret;
+
+		if (ret == -EFAULT)
+			ret = fault_in_pages_readable(buf, size);
+		if (!ret)
+			goto retry;
+		return ret == -EFAULT ? ret : -EINVAL;
 	}
 
 	/*
@@ -309,8 +316,7 @@ static int restore_fpregs_from_user(void
 	 *
 	 * We cannot do a single XRSTORS here - which would be nice -
 	 * because the rest of the FPU registers are being restored from a
-	 * user buffer directly. The single XRSTORS happens below, when the
-	 * user buffer has been copied to the kernel one.
+	 * user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
 		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
@@ -323,14 +329,13 @@ static int restore_fpregs_from_user(void
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
-	struct user_i387_ia32_struct *envp = NULL;
 	int state_size = fpu_kernel_xstate_size;
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	u64 user_xfeatures = 0;
 	bool fx_only = false;
-	int ret = 0;
+	int ret;
 
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
@@ -351,21 +356,20 @@ static int __fpu_restore_sig(void __user
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
-		if (likely(!ret))
-			return 0;
-	} else {
-		/*
-		 * For 32-bit frames with fxstate, copy the fxstate so it can
-		 * be reconstructed later.
-		 */
-		ret = __copy_from_user(&env, buf, sizeof(env));
-		if (ret)
-			return ret;
-		envp = &env;
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						state_size);
 	}
 
 	/*
+	 * Copy the legacy state because the FP portion of the FX frame has
+	 * to be ignored for histerical raisins. The legacy state is folded
+	 * in once the larger state has been copied.
+	 */
+	ret = __copy_from_user(&env, buf, sizeof(env));
+	if (ret)
+		return ret;
+
+	/*
 	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
 	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
@@ -379,8 +383,7 @@ static int __fpu_restore_sig(void __user
 		 * supervisor state is preserved. Save the full state for
 		 * simplicity. There is no point in optimizing this by only
 		 * saving the supervisor states and then shuffle them to
-		 * the right place in memory. This is the slow path and the
-		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
+		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
 			os_xsave(&fpu->state.xsave);
@@ -396,7 +399,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
+		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -409,12 +412,12 @@ static int __fpu_restore_sig(void __user
 		ret = os_xrstor_safe(&fpu->state.xsave,
 				     user_xfeatures | xfeatures_mask_supervisor());
 
-	} else if (use_fxsr()) {
+	} else {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
 		if (ret)
 			return -EFAULT;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
+		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
 
 		fpregs_lock();
 		if (use_xsave()) {
@@ -425,14 +428,8 @@ static int __fpu_restore_sig(void __user
 		}
 
 		ret = fxrstor_safe(&fpu->state.fxsave);
-	} else {
-		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
-		if (ret)
-			return ret;
-
-		fpregs_lock();
-		ret = frstor_safe(&fpu->state.fsave);
 	}
+
 	if (!ret)
 		fpregs_mark_activate();
 	else

