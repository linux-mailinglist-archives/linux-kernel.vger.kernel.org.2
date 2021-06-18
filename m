Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B433ACE98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhFRPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhFRPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:52 -0400
Message-Id: <20210618143446.550649873@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Jfp2/tBlHUfPoLqqo/GjryHewTW0miGtJka8Q+jMfOA=;
        b=nxijAHqx47sCA8lEhAZTcSpy1P9B5Voz15UPnuNFKKWFgFxKB05M3UvlY7q8ny3fYcMCF6
        1ZTl/TZys4o+oEA4PhcfWG+ZDwnE+oKjpqcTeHgCUUSzZxPCLFlJMqeE2DTDhKNKHyt0mG
        0SM+TBnYaTN0L/yYWhO9FGJGhKmzixVSaF5FLyJEQtF8fxQoOazNw4aYDq0QffqiB1TpSS
        k42Xst6O93nPlZUk8VppPQm546oX7rV7sY0MPxfIc93MICO+4C3y7m85Hj2mGY+kLlgfUM
        evuPbHNx2emrZU4hbSW1F3qonWvy6nFUFaPWfUcv5wZcvHQ8hYShUsh0YlBSGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Jfp2/tBlHUfPoLqqo/GjryHewTW0miGtJka8Q+jMfOA=;
        b=A4D4q6OITZTuz/5X0mcxjE6zDE4OvfSxZqC/MVgsN7eszwbs42SgtrFLFsaNeuQnVsVpWz
        I4kcVvHBxXUCiQBg==
Date:   Fri, 18 Jun 2021 16:18:42 +0200
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
Subject: [patch V3 19/66] x86/fpu: Use copy_xstate_to_uabi_buf() in fpregs_get()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new functionality of copy_xstate_to_uabi_buf() to retrieve the
FX state when XSAVE* is in use. This avoids to overwrite the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: Adopted to function rename
V2: New patch
---
 arch/x86/kernel/fpu/regset.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -211,10 +211,10 @@ static inline u32 twd_fxsr_to_i387(struc
  * FXSR floating point environment conversions.
  */
 
-void
-convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
+				struct task_struct *tsk,
+				struct fxregs_state *fxsave)
 {
-	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
 	struct _fpreg *to = (struct _fpreg *) &env->st_space[0];
 	struct _fpxreg *from = (struct _fpxreg *) &fxsave->st_space[0];
 	int i;
@@ -248,6 +248,12 @@ convert_from_fxsr(struct user_i387_ia32_
 		memcpy(&to[i], &from[i], sizeof(to[0]));
 }
 
+void
+convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
+{
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
+}
+
 void convert_to_fxsr(struct fxregs_state *fxsave,
 		     const struct user_i387_ia32_struct *env)
 
@@ -280,25 +286,29 @@ int fpregs_get(struct task_struct *targe
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct user_i387_ia32_struct env;
+	struct fxregs_state fxsave, *fx;
 
 	fpu__prepare_read(fpu);
 
-	if (!boot_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR)) {
 		return membuf_write(&to, &fpu->state.fsave,
 				    sizeof(struct fregs_state));
 	}
 
-	fpstate_sanitize_xstate(fpu);
+	if (use_xsave()) {
+		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
-	if (to.left == sizeof(env)) {
-		convert_from_fxsr(to.p, target);
-		return 0;
+		/* Handle init state optimized xstate correctly */
+		copy_xstate_to_uabi_buf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		fx = &fxsave;
+	} else {
+		fx = &fpu->state.fxsave;
 	}
 
-	convert_from_fxsr(&env, target);
+	__convert_from_fxsr(&env, target, fx);
 	return membuf_write(&to, &env, sizeof(env));
 }
 

