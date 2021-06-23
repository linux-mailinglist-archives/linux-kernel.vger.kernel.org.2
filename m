Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1433B19FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFWM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhFWM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:34 -0400
Message-Id: <20210623121454.617369268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NkYLUQFJf8nM5xx35K2H7wgm+R3lNFt84bul0StquQg=;
        b=NkG1soBfYFJkWzgqVD5Wp25rgXkK4T7ZI1lwn039p0CRyS+eps9Jwtj5v7ucL9CQZCnhzr
        cc14/NHJ+juHQOJY2jb9ShULhHv9YUxrmWXSx3cscL36mJ2otzAwg9Q5qmc2HqHoC3Y6R3
        8ik/FbVqetKwU+jlsztbFeAo4rLNb+Vgk40fm2TfbcGolX4Un74IsvDM+HxTEare6pNstT
        USNJB20kpCOXZVANxOJ5ZbYFlvDSr50AoXGPa1jiAfbYVraAhBoRaMzN/YHUX3AKu4KLrh
        Ze7M9RD7reebyq14sS7z6IqNwhdtf/NOWjvxJy+0CKooylZXOVq5ApyRbqZr8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NkYLUQFJf8nM5xx35K2H7wgm+R3lNFt84bul0StquQg=;
        b=LBlZHB4oKZefKKY3UVzxVG+Gp9l9kgolxrdHbZ3tcKA1JPnlEne6ZzArV+5nf9rq4AQS0g
        zeTPmGpxUpOBDrCQ==
Date:   Wed, 23 Jun 2021 14:02:00 +0200
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
Subject: [patch V4 33/65] x86/fpu: Get rid of the FNSAVE optimization
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FNSAVE support requires conditionals in quite some call paths because
FNSAVE reinitializes the FPU hardware. If the save has to preserve the FPU
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
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: New patch
---
 arch/x86/include/asm/fpu/internal.h |   18 +++++++-----
 arch/x86/kernel/fpu/core.c          |   54 +++++++++++++++---------------------
 2 files changed, 34 insertions(+), 38 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -83,6 +83,7 @@ extern void fpstate_init_soft(struct swr
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
 #define user_insn(insn, output, input...)				\
 ({									\
@@ -375,8 +376,6 @@ static inline int os_xrstor_safe(struct
 	return err;
 }
 
-extern int save_fpregs_to_fpstate(struct fpu *fpu);
-
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
@@ -507,12 +506,17 @@ static inline void __fpregs_load_activat
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
+ * this only affects 20+ years old 32bit systems and avoids conditionals all
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

