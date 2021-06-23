Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCA3B1A22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFWMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhFWM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6BC061A08
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:47 -0700 (PDT)
Message-Id: <20210623121457.086336154@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qiBnu++vVadD5seVVvWtxaxyyvWpknCWPtZYzh/XcCU=;
        b=2JVMz4rG0wLzmV+tmKMCgDDJo2+WacTSESvKP4XjfRnBfUntB5ju4hL01/QpZmPU+DE48i
        5hv09uRRumtpH7M7ZWbJmmhgw4d9wWWHuZqAsTO0vFkdq3XHNO1h54OyPiTC/nOHi3hqn1
        urveHdpkcGjSZusV0jYTMfyaHBibgryQN34Irx3L2t7h/ZiDBCNZ5bR/Dq51k8lez0sXzZ
        wBTqVwDp2VesU00FJx82aa32py2y3cQUMOrLxt74iCzNpFeZ0YbCvMAzxMAstCWfxINSi9
        OE/bZwxO87RKGHGVGxh/+N/AQ0i75f8ogqC0Kr174Rh4VPE4uqIFqu38NngZCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qiBnu++vVadD5seVVvWtxaxyyvWpknCWPtZYzh/XcCU=;
        b=oCLiT9w7IZ8uTd0Qhzy/kAj/C6RWUbbsta/6j5P4iuYQGBshNHVxPEyB0iQrNdMg4OS7uu
        V9sN2wG71kikYMCg==
Date:   Wed, 23 Jun 2021 14:02:25 +0200
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
Subject: [patch V4 58/65] x86/fpu/signal: Move initial checks into fpu__sig_restore()
References: <20210623120127.327154589@linutronix.de>
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
V4: Catch error for math-emu as well. Use cpu_feature_enabled(). (Boris)
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
+	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
-	int size = xstate_sigframe_size();
+	bool ia32_fxstate = false;
+	int ret;
 
+	if (unlikely(!buf)) {
+		fpu__clear_user_states(fpu);
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
 	}
 
-	return __fpu__restore_sig(buf, buf_fx, size);
+	if (!access_ok(buf, size)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
+		ret = fpregs_soft_set(current, NULL, 0,
+				      sizeof(struct user_i387_ia32_struct),
+				      NULL, buf);
+	} else {
+		ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+	}
+
+out:
+	if (unlikely(ret))
+		fpu__clear_user_states(fpu);
+	return ret;
 }
 
 unsigned long

