Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B703B19F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFWM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFWM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED8C061283
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:01 -0700 (PDT)
Message-Id: <20210623121453.328652975@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KVAlfBsiGWgYhEuiPNHlnifsv34XVfht9psaGU9ku3k=;
        b=fCVQhfTBUBVlTvXAZ2TIajRW4ry6ZneOJgBG7TJjydukvtToweFBVHlDj+hkTT9ym5u82P
        uJLvY6pCuZWJnsnRGgkhfaytQMzF9pxXi49JaSqI0tobNSNqhj+dED6Oh3ZNgFQJ5QaUB1
        PdN6Wcfpd0Ckc8a6/xRv/rsYXQzRbax1axZSOxPb0a1Gx23vTtPQl4qxmMYLAXukL1pMlk
        P7JB3OG7Ft+rrsfLe8pxO2zrQsyGzh8PfjwTstEitiszZ9X7UZYDCrP0jvNd0BZR0MbSkS
        s0SK1etWkDr/Bkaaz9UkHMD7DLBoFwiwFG9d6asfuRqUnpK6OcuAQYc/A0SVmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KVAlfBsiGWgYhEuiPNHlnifsv34XVfht9psaGU9ku3k=;
        b=0/xoLHPbvP8r8p6+T0rjPue7rEYdNBZ4leyEiMI/qIaaEuR3VEWCZFwQQ3GTU+1hxnjzk2
        QeAyIDOCUrrP/JCA==
Date:   Wed, 23 Jun 2021 14:01:47 +0200
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
Subject: [patch V4 20/65] x86/fpu: Move fpu__write_begin() to regset
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usecase for fpu__write_begin is the set() callback of regset, so
the function is pointlessly global.

Move it to the regset code and rename it to fpu_force_restore() which is
exactly decribing what the function does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    1 -
 arch/x86/kernel/fpu/core.c          |   24 ------------------------
 arch/x86/kernel/fpu/regset.c        |   25 ++++++++++++++++++++++---
 3 files changed, 22 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -282,30 +282,6 @@ static void fpu__initialize(struct fpu *
 }
 
 /*
- * This function must be called before we write a task's fpstate.
- *
- * Invalidate any cached FPU registers.
- *
- * After this function call, after registers in the fpstate are
- * modified and the child task has woken up, the child task will
- * restore the modified FPU state from the modified context. If we
- * didn't clear its cached status here then the cached in-registers
- * state pending on its former CPU could be restored, corrupting
- * the modifications.
- */
-void fpu__prepare_write(struct fpu *fpu)
-{
-	/*
-	 * Only stopped child tasks can be used to modify the FPU
-	 * state in the fpstate buffer:
-	 */
-	WARN_ON_FPU(fpu == &current->thread.fpu);
-
-	/* Invalidate any cached state: */
-	__fpu_invalidate_fpregs_state(fpu);
-}
-
-/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -44,6 +44,25 @@ static void sync_fpstate(struct fpu *fpu
 		fpu__save(fpu);
 }
 
+/*
+ * Invalidate cached FPU registers before modifying the stopped target
+ * task's fpstate.
+ *
+ * This forces the target task on resume to restore the FPU registers from
+ * modified fpstate. Otherwise the task might skip the restore and operate
+ * with the cached FPU registers which discards the modifications.
+ */
+static void fpu_force_restore(struct fpu *fpu)
+{
+	/*
+	 * Only stopped child tasks can be used to modify the FPU
+	 * state in the fpstate buffer:
+	 */
+	WARN_ON_FPU(fpu == &current->thread.fpu);
+
+	__fpu_invalidate_fpregs_state(fpu);
+}
+
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
@@ -88,7 +107,7 @@ int xfpregs_set(struct task_struct *targ
 	if (newstate.mxcsr & ~mxcsr_feature_mask)
 		return -EINVAL;
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 
 	/* Copy the state  */
 	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
@@ -146,7 +165,7 @@ int xstateregs_set(struct task_struct *t
 		}
 	}
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
@@ -346,7 +365,7 @@ int fpregs_set(struct task_struct *targe
 	if (ret)
 		return ret;
 
-	fpu__prepare_write(fpu);
+	fpu_force_restore(fpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_FXSR))
 		convert_to_fxsr(&fpu->state.fxsave, &env);

