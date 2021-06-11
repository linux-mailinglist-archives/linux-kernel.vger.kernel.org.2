Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6096F3A46D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFKQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhFKQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA9C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:28 -0700 (PDT)
Message-Id: <20210611163113.510912441@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LDU4UBfBApeLySDk/G4HAnUJnM0OOEHDMvpUmUzHZMg=;
        b=0iEftpLFnR27UxNjDb528KHd+lqrjfFlPXVhTQ0Z0qfwxIvUdvRVkdUE/JPUjJXgljtZTj
        J0E8UB3aPnELH6mKqZirkuJUSMswXdDhKOfQt7aizffuvZn9HQeMK1lXaFmPvYDLPdwB/G
        U+5q6iQYySE0Md3Or9nSK40apsO8A1B5+4nmLcq+ZYjF9eg86BtY8FGbML4sgDheZws1xQ
        O7fh7Jmq1UPrVIKRCGR80DTxq3iV7rCVulwlnaULir2O1szIOHdCDeeEW7bbu/NzSkeDRQ
        3y+N91sTlXyGZyS2Ytwazn0mDbclRwr05lZauwg8cpItrZHc0bqQxbpJymjk1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LDU4UBfBApeLySDk/G4HAnUJnM0OOEHDMvpUmUzHZMg=;
        b=hPrs2dwm1q8jL2UVO0bIW0r5F+/Y0s8zJhfSHVFpbudZI/M9rLOLpBSayNkllqW2GFN6uB
        WvV461vnAq9ow/CA==
Date:   Fri, 11 Jun 2021 18:15:47 +0200
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
Subject: [patch 24/41] x86/fpu: Differentiate "copy" versus "move" of fpregs
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

There are three ways in the ISA to bulk save FPU state:
 1. XSAVE, every CPU newer than 2008 does this
 2. FXSAVE, from ~2000->2007
 3. FNSAVE, pre-2000

XSAVE and FXSAVE are nice.  They just copy FPU state to memory.  FNSAVE is
nasty; it destroys the FPU state when it writes it to memory.  It is more
of a "move".

Currently, copy_fpregs_to_fpstate() returns a number to its caller to say
whether it used the nice, non-destructive XSAVE/FXSAVE or used the mean,
clobbering FNSAVE.  Some sites need special handling for the FNSAVE case to
restore any FNSAVE-clobbered state.  Others don't care, like when they are
about to load new state anyway.

The nasty part about the copy_fpregs_to_fpstate() interface is that it's
hard to tell if callers expect the "move" or the "copy" behavior.

Create a new, explicit "move" interface for callers that can handle
clobbering register state.  Make "copy" only do copies and never clobber
register state.

== switch_fpu_prepare() optimization ==

switch_fpu_prepare() had a nice optimization for the FNSAVE case.  It can
handle either clobbering or preserving register state.  For the
XSAVE/FXSAVE case, it records that the fpregs state is still loaded, just
in case a later "restore" operation can be elided.  For the FNSAVE case, it
marks the fpregs as not loaded on the CPU, since they were clobbered.

Instead of having switch_fpu_prepare() modify its behavior based on whether
registers were clobbered or not, simply switch its behavior based on
whether FNSAVE is in use.  This makes it much more clear what is going on
and what the common path is.

It would be simpler to just remove this FNSAVE optimization: Always save
and restore in the FNSAVE case.  This may incur the cost of the restore
even in cases where the restored state is never used.  But, it would only
hurt painfully ancient (>20 years old) processors.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Picked it up from Dave's series and adopted it to the other changes.
---

 arch/x86/include/asm/fpu/internal.h |   14 ++++--
 arch/x86/kernel/fpu/core.c          |   84 +++++++++++++++++++++---------------
 2 files changed, 59 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -395,7 +395,8 @@ static inline int xrstor_from_kernel_err
 	return err;
 }
 
-extern int save_fpregs_to_fpstate(struct fpu *fpu);
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
+extern void copy_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
@@ -527,10 +528,15 @@ static inline void __fpregs_load_activat
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!save_fpregs_to_fpstate(old_fpu))
-			old_fpu->last_cpu = -1;
-		else
+		/*
+		 * Avoid the expense of restoring fpregs with FNSAVE when it
+		 * might be unnecssary. XSAVE and FXSAVE preserve the FPU state.
+		 */
+		save_fpregs_to_fpstate(old_fpu);
+		if (likely(use_xsave() || use_fxsr()))
 			old_fpu->last_cpu = cpu;
+		else
+			old_fpu->last_cpu = -1;
 
 		/* But leave fpu_fpregs_owner_ctx! */
 		trace_x86_fpu_regs_deactivated(old_fpu);
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -83,16 +83,17 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
- *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
+ * Must be called with fpregs locked.
+ *
+ * Returns 'true' if the FPU state has been clobbered and the register
+ * contents are lost.
+ *
+ * The legacy FNSAVE instruction clobebrs all FPU state unconditionally, so
+ * registers are essentially destroyed.
+ *
+ * XSAVE and FXSAVE preserve register contents.
  */
-int save_fpregs_to_fpstate(struct fpu *fpu)
+static bool __clobber_save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		xsave_to_kernel(&fpu->state.xsave);
@@ -103,23 +104,46 @@ int save_fpregs_to_fpstate(struct fpu *f
 		 */
 		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
-		return 1;
+		return false;
 	}
 
 	if (likely(use_fxsr())) {
 		fxsave_to_kernel(fpu);
-		return 1;
+		return false;
 	}
 
-	/*
-	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
-	 */
+	/* Legacy FPU register saving, FNSAVE always clears FPU registers */
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
 
-	return 0;
+	return true;
+}
+
+/**
+ * save_fpregs_to_fpstate - Save fpregs in fpstate
+ * @fpu:	Pointer to FPU context
+ *
+ * Hardware register state might be clobbered when the
+ * function returns.
+ */
+void save_fpregs_to_fpstate(struct fpu *fpu)
+{
+	__clobber_save_fpregs_to_fpstate(fpu);
+}
+EXPORT_SYMBOL_GPL(save_fpregs_to_fpstate);
+
+/**
+ * copy_fpregs_to_fpstate - Copy fpregs to fpstate
+ * @fpu:	Pointer to FPU context
+ *
+ * Guarantees that the hardware register state is preserved.
+ */
+void copy_fpregs_to_fpstate(struct fpu *fpu)
+{
+	bool clobbered = __clobber_save_fpregs_to_fpstate(fpu);
+
+	if (clobbered)
+		restore_fpregs_from_fpstate(&fpu->state);
 }
-EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -133,10 +157,6 @@ void kernel_fpu_begin_mask(unsigned int
 	if (!(current->flags & PF_KTHREAD) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		/*
-		 * Ignore return value -- we don't care if reg state
-		 * is clobbered.
-		 */
 		save_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
@@ -160,7 +180,8 @@ void kernel_fpu_end(void)
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
- * Save the FPU state (mark it for reload if necessary):
+ * Save the FPU register state. If the registers are active then they are
+ * preserved.
  *
  * This only ever gets called for the current task.
  */
@@ -171,11 +192,8 @@ void fpu__save(struct fpu *fpu)
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!save_fpregs_to_fpstate(fpu)) {
-			restore_fpregs_from_fpstate(&fpu->state);
-		}
-	}
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+		copy_fpregs_to_fpstate(fpu);
 
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
@@ -245,18 +263,14 @@ int fpu__copy(struct task_struct *dst, s
 
 	/*
 	 * If the FPU registers are not current just memcpy() the state.
-	 * Otherwise save current FPU registers directly into the child's FPU
-	 * context, without any memory-to-memory copying.
-	 *
-	 * ( The function 'fails' in the FNSAVE case, which destroys
-	 *   register contents so we have to load them back. )
+	 * Otherwise copy current FPU registers directly into the child's
+	 * FPU context.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
-
-	else if (!save_fpregs_to_fpstate(dst_fpu))
-		restore_fpregs_from_fpstate(&dst_fpu->state);
+	else
+		copy_fpregs_to_fpstate(dst_fpu);
 
 	fpregs_unlock();
 

