Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922863A6C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhFNQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhFNQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:30 -0400
Message-Id: <20210614155357.167589571@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OCfJkyZxX6wzewoQZB/xEeutpXbUxlnZROqQ1cUEdlo=;
        b=iDHP4N7kJGTIDWu8jwIAAFXG4xPvmxiEiVhSod97bshCXBTULwuPE9BDYZRoVeO08iMQQ4
        n0mo5QRkUiyNZwveCDq/NDZzj6CrfYnEvRocijHrRUtSEcOm0MnSM1KH81flAZVpUf+0F0
        in48YAVmVSJpPSHfNzYFq6HfIgNyjRk1CIhvdgg8vp502wdPwqeZJcaaIVIt9EWFV1r41V
        YiiR8IrPws05O1SJ4E397cfLbdu/I4Iu9sXPMABR1zB5Un+HbtxitNnwZCO1f0GnYBAo+X
        rT0+ODzViHrPR/h9yDiNT3DY+N7q5v5d2US7Sv2EVvA28Lvl3Dw3vyjTPvQJCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OCfJkyZxX6wzewoQZB/xEeutpXbUxlnZROqQ1cUEdlo=;
        b=o/OKNUcnGjHpUbKE9L7apRDSexDyDeg2a5iVOIU5yv48NHbqseRXru7qX+Ml6YhYUJdkf/
        20/LHZfiu6TXEGCg==
Date:   Mon, 14 Jun 2021 17:44:42 +0200
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
Subject: [patch V2 34/52] x86/fpu: Differentiate "copy" versus "move" of fpregs
References: <20210614154408.673478623@linutronix.de>
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
 arch/x86/include/asm/fpu/internal.h |   14 ++++--
 arch/x86/kernel/fpu/core.c          |   83 ++++++++++++++++++++----------------
 2 files changed, 58 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -378,7 +378,8 @@ static inline int xrstor_from_kernel_err
 	return err;
 }
 
-extern int save_fpregs_to_fpstate(struct fpu *fpu);
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
+extern void copy_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
@@ -510,10 +511,15 @@ static inline void __fpregs_load_activat
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
@@ -103,23 +104,45 @@ int save_fpregs_to_fpstate(struct fpu *f
 		 */
 		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
-		return 1;
+		return false;
 	}
 
 	if (likely(use_fxsr())) {
 		fxsave_to_kernel(&fpu->state.fxsave);
-		return 1;
+		return false;
 	}
 
-	/*
-	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
-	 */
+	/* Legacy FPU register saving, FNSAVE always clears FPU registers. */
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
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
 
-	return 0;
+	if (clobbered)
+		restore_fpregs_from_fpstate(&fpu->state);
 }
-EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -133,10 +156,6 @@ void kernel_fpu_begin_mask(unsigned int
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
@@ -160,7 +179,8 @@ void kernel_fpu_end(void)
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
- * Save the FPU state (mark it for reload if necessary):
+ * Save the FPU register state. If the registers are active then they are
+ * preserved.
  *
  * This only ever gets called for the current task.
  */
@@ -171,11 +191,8 @@ void fpu__save(struct fpu *fpu)
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
@@ -245,18 +262,14 @@ int fpu__copy(struct task_struct *dst, s
 
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
 

