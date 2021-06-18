Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64F53ACECC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhFRP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhFRPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265DCC0611BE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:20:09 -0700 (PDT)
Message-Id: <20210618143448.953929649@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=slvjmprRcRZPgnQePfI2zzKXjzS6amjXJ99XhH4pGD0=;
        b=CAi0VXWLwHnBAiNGO/t6B2BTFSWIJy46JFYClGQGekuG2B1YImJiznVihp7lz0VkUcoo9I
        tmTIVl/Dn+Y0lvC2GPstz5hPfSWV+gqwxnhvkQCJ3zHEdBkRnItKomRoMcIAKS1bMqM8ud
        hRFrP5VRhFhEjtIKsd9GTPxtzgkMGe2mju7Qeh+RbE+1aXxpRgPMYtMtSPtCkdd7wxY2Y7
        U+HvfWtBUjNT2USfYNJKukI7Gdlqb4I7zmOQHjbq7uuq0hb9GciFTPnxlwK5gy0hQsnHk7
        m+TNzPB5segKKcYJJS6Gw/BxviADqHP0RaxMlJMdOHhyjRqEGZ4mDmZWl/KybQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=slvjmprRcRZPgnQePfI2zzKXjzS6amjXJ99XhH4pGD0=;
        b=xeaC0M9A2dDe5BBb7HceAwfSgTTYHD/CmOlmERnXcsKt7AY+fRbXKZxcZIMLn1y+hbxwxH
        omjia5ywQXzb10BA==
Date:   Fri, 18 Jun 2021 16:19:03 +0200
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
Subject: [patch V3 40/66] x86/fpu: Rename and sanitize fpu__save/copy()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions are misnomed.

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
---
V3: New patch
---
 arch/x86/include/asm/fpu/internal.h |    6 ++++--
 arch/x86/kernel/fpu/core.c          |   15 +++++++--------
 arch/x86/kernel/fpu/regset.c        |    2 +-
 arch/x86/kernel/process.c           |    3 +--
 arch/x86/kernel/traps.c             |    5 +++--
 5 files changed, 16 insertions(+), 15 deletions(-)

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
 
 	if (!static_cpu_has(X86_FEATURE_FPU))
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

