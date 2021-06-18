Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB63ACED3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhFRP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhFRPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:09 -0400
Message-Id: <20210618143451.099973627@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GSgT8HIuSKqUd/AFQ7bRr/SBlusEpjfB5L0XGGvjNX4=;
        b=J/EtmB37QaJq9Fp3JZMb+MH+pdFW1xCX0nPsm/R/LfT7hU4ybM0GdWbi2Pjyd0PDLXVy+7
        ILJcYAkv3026lenOVzayQD7AeEsAt2OUavvE/7Va7T1GaMqy8S6KqK0NrflaiaKc460F21
        i4/W9NOPm5mNZugDj7OlFJN/fZz3dqLSXWybR35vxU4q+1eGW1D8r6UyH5dqNdzTnVkqgt
        EU76D92j/5cspx5Ik3ZJJ+IruhimXef5Qe0EzVuwqfdEYS829XrGkjiLY3NrCjtXzMrDxw
        HD8VlNhEr4JKkUxwqcSRFI7ggayVZAA0eL/hcwNhROlACBL+FuD20d8Dusr51g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GSgT8HIuSKqUd/AFQ7bRr/SBlusEpjfB5L0XGGvjNX4=;
        b=7I1ojK0kLUelSsQVcvbzfe5deNEgiaNggsXGj0xGxGciQQMrUi+ozEtAVMImuyqjdifL+V
        hPllVxbmpSJ/bhAQ==
Date:   Fri, 18 Jun 2021 16:19:22 +0200
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
Subject: [patch V3 59/66] x86/fpu/signal: Move initial checks into fpu__sig_restore()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fpu_sig_restore() is convoluted and some of the basic checks can trivialy be done
in the calling function as well as the final error handling of clearing user state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   76 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -277,11 +277,11 @@ static int copy_user_to_fpregs_zeroing(v
 		return frstor_from_user_sigframe(buf);
 }
 
-static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
+static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
+			     bool ia32_fxstate)
 {
 	struct user_i387_ia32_struct *envp = NULL;
 	int state_size = fpu_kernel_xstate_size;
-	int ia32_fxstate = (buf != buf_fx);
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
@@ -289,26 +289,6 @@ static int __fpu__restore_sig(void __use
 	int fx_only = 0;
 	int ret = 0;
 
-	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
-			 IS_ENABLED(CONFIG_IA32_EMULATION));
-
-	if (!buf) {
-		fpu__clear_user_states(fpu);
-		return 0;
-	}
-
-	if (!access_ok(buf, size)) {
-		ret = -EACCES;
-		goto out;
-	}
-
-	if (!static_cpu_has(X86_FEATURE_FPU)) {
-		ret = fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
-		goto out;
-	}
-
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 		if (unlikely(check_for_xstate(buf_fx, buf_fx, &fx_sw_user))) {
@@ -391,7 +371,7 @@ static int __fpu__restore_sig(void __use
 		 */
 		ret = __copy_from_user(&env, buf, sizeof(env));
 		if (ret)
-			goto out;
+			return ret;
 		envp = &env;
 	}
 
@@ -424,7 +404,7 @@ static int __fpu__restore_sig(void __use
 
 		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
-			goto out;
+			return ret;
 
 		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
 					      fx_only);
@@ -442,10 +422,8 @@ static int __fpu__restore_sig(void __use
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-		if (ret) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (ret)
+			return -EFAULT;
 
 		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
 					      fx_only);
@@ -462,7 +440,7 @@ static int __fpu__restore_sig(void __use
 	} else {
 		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
 		if (ret)
-			goto out;
+			return ret;
 
 		fpregs_lock();
 		ret = frstor_safe(&fpu->state.fsave);
@@ -472,10 +450,6 @@ static int __fpu__restore_sig(void __use
 	else
 		fpregs_deactivate(fpu);
 	fpregs_unlock();
-
-out:
-	if (ret)
-		fpu__clear_user_states(fpu);
 	return ret;
 }
 
@@ -490,15 +464,47 @@ static inline int xstate_sigframe_size(v
  */
 int fpu__restore_sig(void __user *buf, int ia32_frame)
 {
+	unsigned int size = xstate_sigframe_size();
 	void __user *buf_fx = buf;
-	int size = xstate_sigframe_size();
+	bool ia32_fxstate = false;
+	int ret;
 
+	if (unlikely(!buf)) {
+		fpu__clear_user_states(&current->thread.fpu);
+		return 0;
+	}
+
+	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
+		       IS_ENABLED(CONFIG_IA32_EMULATION));
+
+	/*
+	 * Only FXSR enabled systems need the FX state quirk.
+	 * FRSTOR does not need it and can use the fast path.
+	 */
 	if (ia32_frame && use_fxsr()) {
 		buf_fx = buf + sizeof(struct fregs_state);
 		size += sizeof(struct fregs_state);
+		ia32_fxstate = true;
+	}
+
+	if (!access_ok(buf, size)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_X86_64) && !static_cpu_has(X86_FEATURE_FPU)) {
+		return fpregs_soft_set(current, NULL, 0,
+				       sizeof(struct user_i387_ia32_struct),
+				       NULL, buf);
 	}
 
-	return __fpu__restore_sig(buf, buf_fx, size);
+	ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+
+out:
+	if (unlikely(ret))
+		fpu__clear_user_states(&current->thread.fpu);
+
+	return ret;
 }
 
 unsigned long

