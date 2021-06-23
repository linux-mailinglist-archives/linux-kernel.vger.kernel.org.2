Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88F3B1A11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFWM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhFWM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:11 -0400
Message-Id: <20210623121457.696022863@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=19bkPhqsGk1+zhGXLFieLIPBnixhXt6do725A4g6wiM=;
        b=NgmbW6VOkcEG1H9xCi/xwlXx1E310wDVGfuUMpr6SwZth1P4soeGIkC48c5Iecrq4KtheG
        mj1iPpe3kCsn/WH6jfSNwBbBLIe6Uz2Pge27p35M1NTOFEdoJjOctl7sJsDLd/jlyko6Y4
        YKn2VtKt4aCeNcVQ4PPO1ZTi/84s+uzuIC55xPjuRXZyeSq1G7cr1xcZGMXu5tlMwyhIxZ
        qw2vvgS3ERbMXbUKUSIGCRtEIPAsta+CtS5v7MnXT8xn7NkPPjeQqtB4zA/H3FgkzHoft9
        hbThDrAj7l+tQSbh0BIcUqA2tbxkDzcrrKK2duAgN7UXEOI3Iu+B+rsYgohs9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=19bkPhqsGk1+zhGXLFieLIPBnixhXt6do725A4g6wiM=;
        b=M7Q/d3p01DMVC6xehcORb+5tnZT1thMwCqViKmo226/P+t8ua3qH0eHKYaFz6CdjSWxwNR
        F7UI2f8NepWmzQBQ==
Date:   Wed, 23 Jun 2021 14:02:31 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 64/65] x86/fpu/signal: Handle #PF in the direct restore path
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V4: Made the #PF retry path a bit more readable.
---
 arch/x86/kernel/fpu/signal.c |   67 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -272,11 +272,17 @@ static int __restore_fpregs_from_user(vo
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
 	int ret;
 
+retry:
 	fpregs_lock();
 	pagefault_disable();
 	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
@@ -293,14 +299,18 @@ static int restore_fpregs_from_user(void
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
+
+		/* Try to handle #PF, but anything else is fatal. */
+		if (ret != -EFAULT)
+			return -EINVAL;
+
+		ret = fault_in_pages_readable(buf, size);
+		if (!ret)
+			goto retry;
 		return ret;
 	}
 
@@ -311,9 +321,7 @@ static int restore_fpregs_from_user(void
 	 *
 	 * It would be optimal to handle this with a single XRSTORS, but
 	 * this does not work because the rest of the FPU registers have
-	 * been restored from a user buffer directly. The single XRSTORS
-	 * happens below, when the user buffer has been copied to the
-	 * kernel one.
+	 * been restored from a user buffer directly.
 	 */
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
 		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
@@ -326,14 +334,13 @@ static int restore_fpregs_from_user(void
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
@@ -354,21 +361,20 @@ static int __fpu_restore_sig(void __user
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
@@ -382,8 +388,7 @@ static int __fpu_restore_sig(void __user
 		 * supervisor state is preserved. Save the full state for
 		 * simplicity. There is no point in optimizing this by only
 		 * saving the supervisor states and then shuffle them to
-		 * the right place in memory. This is the slow path and the
-		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
+		 * the right place in memory. It's ia32 mode. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
 			os_xsave(&fpu->state.xsave);
@@ -399,7 +404,7 @@ static int __fpu_restore_sig(void __user
 		if (ret)
 			return ret;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures);
+		sanitize_restored_user_xstate(&fpu->state, &env, user_xfeatures);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -412,12 +417,12 @@ static int __fpu_restore_sig(void __user
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
@@ -428,14 +433,8 @@ static int __fpu_restore_sig(void __user
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

