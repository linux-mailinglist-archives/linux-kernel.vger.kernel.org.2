Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF93B19FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhFWM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFWM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:41 -0400
Message-Id: <20210623121455.196727450@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YXowmCXHonvW8AM4/6rfQtQwmKDQq1zXLGAlLt6QXGg=;
        b=qW29xIPy2lVJDK/dUk0f7iazjB33OiAyd70FNkTWirDR3tOAZATFbQpW5Ytllp64z3xq/k
        lVRiyKpCgPfdJ/LPJNNLSpeuqQlWu6vY7yarut8CP6GsjCva7MIpEJd6VaFNOmNPBtrjsw
        rzDwn40B0CgKYEX8XS0PmOtbI9hJxpLlE5Anf6H4piqMbElISyMzJQPGZg1Gsu8yEDWVEu
        y6uDvSabGFDmhuoS+D/EjNZxpAFRLVWKMwbH+I5SpxHCxctmEp6W8UOsxHmd+uu/LhwKFp
        mytHt8Zjt/Jstt8ydmDKldlw3a0cwLMC2Pt0I1+Ua2SHYKfha9fwpQU1GXtSug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YXowmCXHonvW8AM4/6rfQtQwmKDQq1zXLGAlLt6QXGg=;
        b=ZeuFheMFvtokVkkMTqIk62OcHhOoGqa9HNSS8NqNdzUKizhPFeBgl3/237bwYatbxct+3g
        9ZWhbKpFbwb4nxAQ==
Date:   Wed, 23 Jun 2021 14:02:06 +0200
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
Subject: [patch V4 39/65] x86/fpu: Rename and sanitize fpu__save/copy()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions are a misnomer.

fpu__save() is actually about synchronizing the hardware register state
into the task's memory state so that either coredump or a math exception
handler can inspect the state at the time where the problem happens.

The function guarantees to preserve the register state, while "save" is a
common terminology for saving the current state so it can be modified and
restored later. This is clearly not the case here.

Rename it to fpu_sync_fpstate().

fpu__copy() is used to clone the current task's FPU state when duplicating
task_struct. While the register state is a copy the rest of the FPU state
is not.

Name it accordingly and remove the really pointless @src argument along
with the warning which comes along with it.

Nothing can ever copy the FPU state of a non-current task. It's clearly
just a consequence of arch_dup_task_struct(), but it makes no sense to
proliferate that further.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: New patch
---
 arch/x86/include/asm/fpu/internal.h |    6 ++++--
 arch/x86/kernel/fpu/core.c          |   17 ++++++++---------
 arch/x86/kernel/fpu/regset.c        |    2 +-
 arch/x86/kernel/process.c           |    3 +--
 arch/x86/kernel/traps.c             |    5 +++--
 5 files changed, 17 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,14 +26,16 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
+extern void fpu_sync_fpstate(struct fpu *fpu);
+
+extern int  fpu_clone(struct task_struct *dst);
+
 /*
  * Boot time FPU initialization functions:
  */
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -159,11 +159,10 @@ void kernel_fpu_end(void)
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
- * Save the FPU state (mark it for reload if necessary):
- *
- * This only ever gets called for the current task.
+ * Sync the FPU register state to current's memory register state when the
+ * current task owns the FPU. The hardware register state is preserved.
  */
-void fpu__save(struct fpu *fpu)
+void fpu_sync_fpstate(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
@@ -221,18 +220,18 @@ void fpstate_init(union fpregs_state *st
 }
 EXPORT_SYMBOL_GPL(fpstate_init);
 
-int fpu__copy(struct task_struct *dst, struct task_struct *src)
+/* Clone current's FPU state on fork */
+int fpu_clone(struct task_struct *dst)
 {
+	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
-	struct fpu *src_fpu = &src->thread.fpu;
 
+	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
-	if (!static_cpu_has(X86_FEATURE_FPU))
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		return 0;
 
-	WARN_ON_FPU(src_fpu != &current->thread.fpu);
-
 	/*
 	 * Don't let 'init optimized' areas of the XSAVE area
 	 * leak into the child task:
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -41,7 +41,7 @@ int regset_xregset_fpregs_active(struct
 static void sync_fpstate(struct fpu *fpu)
 {
 	if (fpu == &current->thread.fpu)
-		fpu__save(fpu);
+		fpu_sync_fpstate(fpu);
 }
 
 /*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -87,8 +87,7 @@ int arch_dup_task_struct(struct task_str
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-
-	return fpu__copy(dst, src);
+	return fpu_clone(dst);
 }
 
 /*
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1046,9 +1046,10 @@ static void math_error(struct pt_regs *r
 	}
 
 	/*
-	 * Save the info for the exception handler and clear the error.
+	 * Synchronize the FPU register state to the memory register state
+	 * if necessary. This allows the exception handler to inspect it.
 	 */
-	fpu__save(fpu);
+	fpu_sync_fpstate(fpu);
 
 	task->thread.trap_nr	= trapnr;
 	task->thread.error_code = 0;

