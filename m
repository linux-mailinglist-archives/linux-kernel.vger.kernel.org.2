Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB583A6C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhFNQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhFNQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B74C0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:06 -0700 (PDT)
Message-Id: <20210614155355.354479349@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rsts9erWqJk36WQpWh+9WIajOyfRU5jT3My7JmYuy4w=;
        b=zwRf6kA34YGFQKF4qNKjJuvT8m8QY0dxSuxoxPhvALjjbio4VUe+d2lCkeMVSWKSiiWtaQ
        Fee9i0SyyleVwkeF+j7D/fG0bZDj2EnRauriEk60g+Dvp6ZbhuLDWppm6py3CBKcC1MSnI
        kjWqd96qnCo4JYfzsw6iagkDPD5v44HMfJIz6v6JP7kn0zh61vZmK1xg0L89tbxvAXzFQm
        krz7d8r26RUPYqiShfrDKHCkayc2KQ8RO95pb537MPStFVPXhVhCFnW0dWov7vO5w1h7XS
        eFq+IUkcxZwAlHij32mDwnI4iddz1G6DRQv7HZsHFOjsdGrk3o1HbqG4ehmcXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rsts9erWqJk36WQpWh+9WIajOyfRU5jT3My7JmYuy4w=;
        b=qQdSCho243KyrEqzhirlzq27r8kx3SdXEJhDJpCXY2PCaPXthjGQNdutpA9iRHuDLBLD6f
        kccg17+d/PjyV/Cw==
Date:   Mon, 14 Jun 2021 17:44:24 +0200
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
Subject: [patch V2 16/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in fpregs_get()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new functionality of copy_uabi_xstate_to_membuf() to retrieve the
FX state when XSAVE* is in use. This avoids to overwrite the FPU state
buffer with fpstate_sanitize_xstate() which is error prone and duplicated
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
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
+	if (!static_cpu_has(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
+	if (!static_cpu_has(X86_FEATURE_FXSR)) {
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
+		copy_uabi_xstate_to_membuf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		fx = &fxsave;
+	} else {
+		fx = &fpu->state.fxsave;
 	}
 
-	convert_from_fxsr(&env, target);
+	__convert_from_fxsr(&env, target, fx);
 	return membuf_write(&to, &env, sizeof(env));
 }
 

