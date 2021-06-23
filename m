Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380EC3B19F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFWM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFWM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0991FC061768
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:00 -0700 (PDT)
Message-Id: <20210623121453.234942936@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iQNhkJ1f5XnoXOWpLA9a1QWuFJTCwOgFaaiRHMdFMBo=;
        b=AHoEuq5RsoT2FEpxSzuZHsqCO/wqiyW+KIZBMCS9GeZ/t5tP2OmpqXlHioyRdhIJvdKXEd
        vziAePFJO46L8L3vyNSa5hCHskvu+Q5s0IxYBYHyNuoIZagDD1liSZCUnYA19h7OhohRlY
        Q/lyHCauoj25A6daUuxS6Ntsi/qTAmpMg2T+iw4H4LnxilBXdN3bYMcCN+dT9Y5S6XR6NV
        /2nYlb2rJcevXAgQP+zIW0CZA+tUBrR/yy1lNXUH+/WY9p7D3EaUsfN7NfaSedhGknQLR2
        H+jjPTEC+X5FmkVcYzdTwHiahshOp0jZ4r2EXqQ9N8HidZ7TMQmSCKlwHrR9+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iQNhkJ1f5XnoXOWpLA9a1QWuFJTCwOgFaaiRHMdFMBo=;
        b=K/XOaf7/5wRWMDnSmHQKdqot4Wx0G6DqgsYrAEOld0D58KLCyuDmsQUP73DrBUwkbTdEal
        I9IsJZdJkVN/wbDQ==
Date:   Wed, 23 Jun 2021 14:01:46 +0200
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
Subject: [patch V4 19/65] x86/fpu/regset: Move fpu__read_begin() into regset
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function can only be used from the regset get() callbacks safely. So
there is no reason to have it globaly exposed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    1 -
 arch/x86/kernel/fpu/core.c          |   20 --------------------
 arch/x86/kernel/fpu/regset.c        |   22 +++++++++++++++++++---
 3 files changed, 19 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -282,26 +282,6 @@ static void fpu__initialize(struct fpu *
 }
 
 /*
- * This function must be called before we read a task's fpstate.
- *
- * There's two cases where this gets called:
- *
- * - for the current task (when coredumping), in which case we have
- *   to save the latest FPU registers into the fpstate,
- *
- * - or it's called for stopped tasks (ptrace), in which case the
- *   registers were already saved by the context-switch code when
- *   the task scheduled out.
- *
- * If the task has used the FPU before then save it.
- */
-void fpu__prepare_read(struct fpu *fpu)
-{
-	if (fpu == &current->thread.fpu)
-		fpu__save(fpu);
-}
-
-/*
  * This function must be called before we write a task's fpstate.
  *
  * Invalidate any cached FPU registers.
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -28,6 +28,22 @@ int regset_xregset_fpregs_active(struct
 		return 0;
 }
 
+/*
+ * The regset get() functions are invoked from:
+ *
+ *   - coredump to dump the current task's fpstate. If the current task
+ *     owns the FPU then the memory state has to be synchronized and the
+ *     FPU register state preserved. Otherwise fpstate is already in sync.
+ *
+ *   - ptrace to dump fpstate of a stopped task, in which case the registers
+ *     have already been saved to fpstate on context switch.
+ */
+static void sync_fpstate(struct fpu *fpu)
+{
+	if (fpu == &current->thread.fpu)
+		fpu__save(fpu);
+}
+
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
@@ -36,7 +52,7 @@ int xfpregs_get(struct task_struct *targ
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	if (!use_xsave()) {
 		return membuf_write(&to, &fpu->state.fxsave,
@@ -96,7 +112,7 @@ int xstateregs_get(struct task_struct *t
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
 	return 0;
@@ -287,7 +303,7 @@ int fpregs_get(struct task_struct *targe
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
-	fpu__prepare_read(fpu);
+	sync_fpstate(fpu);
 
 	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return fpregs_soft_get(target, regset, to);

