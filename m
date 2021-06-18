Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAC3ACAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhFRMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhFRMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:23:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:21:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624018879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTXuxeMcAKylm7zWtq7p5HJ2ZgaTzTo7cufFUtK22Ko=;
        b=hCBLlV8fTeYr52cs8fLmMQN7d2W60/OlTNNVE0A3ic1JJnANQpwGhUcOAdhsBNKSvtXE52
        Zj85Q5xEzxhwhzoArfMXQvDqVxmsET1NePUf6XH+5jA1NzPv+zRhCIGXc8SbkhOQA1cvy2
        h7P/jX+5T/SJevKfWio6lP+APaALEhGR4GDXivsQcKON+CqdJa6qDMvwmnYuuYrhWgJhyr
        L0ZhbLAny4LEtxU2OMjc99V1QdzQo+HtF9hy+JM8gdhKuORJyN+RmNpPeo6ZaGrExf/IjF
        //81hUxy0nFrsncRAC4tpwqi8s8JvEePkIMFCXmdm5/XzzHoIC5286bhWMnANQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624018879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTXuxeMcAKylm7zWtq7p5HJ2ZgaTzTo7cufFUtK22Ko=;
        b=7ZnpfEpwxsfGXe/8aU7bDe/eyX7WouKX6LBPxy8oFmqKAOus54FK41XBTiq/3odUIPc4oo
        uaXmybYUXHCf0pBg==
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
Subject: Re: [patch V2 34/52] x86/fpu: Differentiate "copy" versus "move" of fpregs
In-Reply-To: <20210614155357.167589571@linutronix.de>
References: <20210614154408.673478623@linutronix.de> <20210614155357.167589571@linutronix.de>
Date:   Fri, 18 Jun 2021 14:21:18 +0200
Message-ID: <87h7hvfjnl.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Mon, Jun 14 2021 at 17:44, Thomas Gleixner wrote:
> It would be simpler to just remove this FNSAVE optimization: Always save
> and restore in the FNSAVE case.  This may incur the cost of the restore
> even in cases where the restored state is never used.  But, it would only
> hurt painfully ancient (>20 years old) processors.

after staring more at that, I think it's the right thing to do.

Thanks,

        tglx
---
Subject: x86/fpu: Get rid of the FNSAVE optimization
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 18 Jun 2021 13:48:18 +0200

The FNSAVE support requires conditionals in quite some call paths because
FNSAVE reinitialized the FPU hardware. If the save has to preserve the FPU
register state then the caller has to conditionally restore it from memory
when FNSAVE is in use.

This also requires a conditional in context switch because the restore
avoidance optimization cannot work with FNSAVE. As this only affects 20+
years old CPUs there is really no reason to keep this optimization
effective for FNSAVE. It's about time to not optimize for antiques anymore.

Just unconditionally FRSTOR the save content to the registers and clean up
the conditionals all over the place.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/x86/include/asm/fpu/internal.h |   17 +++++++----
 arch/x86/kernel/fpu/core.c          |   54 +++++++++++++++---------------------
 2 files changed, 34 insertions(+), 37 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -375,7 +375,7 @@ static inline int os_xrstor_safe(struct
 	return err;
 }
 
-extern int save_fpregs_to_fpstate(struct fpu *fpu);
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
@@ -507,12 +507,17 @@ static inline void __fpregs_load_activat
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!save_fpregs_to_fpstate(old_fpu))
-			old_fpu->last_cpu = -1;
-		else
-			old_fpu->last_cpu = cpu;
+		save_fpregs_to_fpstate(old_fpu);
+		/*
+		 * The save operation preserved register state, so the
+		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
+		 * current CPU number in @old_fpu, so the next return
+		 * to user space can avoid the FPU register restore
+		 * when is returns on the same CPU and still owns the
+		 * context.
+		 */
+		old_fpu->last_cpu = cpu;
 
-		/* But leave fpu_fpregs_owner_ctx! */
 		trace_x86_fpu_regs_deactivated(old_fpu);
 	}
 }
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -83,16 +83,20 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
+ * Save the FPU register state in fpu->state. The register state is
+ * preserved.
  *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
+ * Must be called with fpregs_lock() held.
+ *
+ * The legacy FNSAVE instruction clears all FPU state unconditionally, so
+ * register state has to be reloaded. That might be a pointless exercise
+ * when the FPU is going to be used by another task right after that. But
+ * this only affect 20+ years old 32bit systems and avoids conditionals all
+ * over the place.
+ *
+ * FXSAVE and all XSAVE variants preserve the FPU register state.
  */
-int save_fpregs_to_fpstate(struct fpu *fpu)
+void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		os_xsave(&fpu->state.xsave);
@@ -103,21 +107,20 @@ int save_fpregs_to_fpstate(struct fpu *f
 		 */
 		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
-		return 1;
+		return;
 	}
 
 	if (likely(use_fxsr())) {
 		fxsave(&fpu->state.fxsave);
-		return 1;
+		return;
 	}
 
 	/*
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
+	 * so we have to reload them from the memory state.
 	 */
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-
-	return 0;
+	frstor(&fpu->state.fsave);
 }
 EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
@@ -133,10 +136,6 @@ void kernel_fpu_begin_mask(unsigned int
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
@@ -171,11 +170,8 @@ void fpu__save(struct fpu *fpu)
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!save_fpregs_to_fpstate(fpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-		}
-	}
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+		save_fpregs_to_fpstate(fpu);
 
 	trace_x86_fpu_after_save(fpu);
 	fpregs_unlock();
@@ -244,20 +240,16 @@ int fpu__copy(struct task_struct *dst, s
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
 
 	/*
-	 * If the FPU registers are not current just memcpy() the state.
-	 * Otherwise save current FPU registers directly into the child's FPU
-	 * context, without any memory-to-memory copying.
-	 *
-	 * ( The function 'fails' in the FNSAVE case, which destroys
-	 *   register contents so we have to load them back. )
+	 * If the FPU registers are not owned by current just memcpy() the
+	 * state.  Otherwise save the FPU registers directly into the
+	 * child's FPU context, without any memory-to-memory copying.
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!save_fpregs_to_fpstate(dst_fpu))
-		copy_kernel_to_fpregs(&dst_fpu->state);
-
+	else
+		save_fpregs_to_fpstate(dst_fpu);
 	fpregs_unlock();
 
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
