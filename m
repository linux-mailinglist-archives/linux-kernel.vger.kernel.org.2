Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7063A6C18
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhFNQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhFNQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:23 -0400
Message-Id: <20210614155356.549332888@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9/hGT5uCeUBODjxx6P7fIzGSMOXdABNPDxzLF3iZIA8=;
        b=17rIYILfGhfJnzYC+cI6Bo52cWVinjqdT4Ewxz0yv8iyEYH04LtQvfw1+QhgXRnchHVHbi
        ByKwVU92TNXtRjidxCrvQotp1CZl0LPR3reUUbeT4FFLjvG4agVklXkV33s+DuFgeXiWtN
        4fYpHlyoVv9+6ScWf1i51kLliEIawayB79SBBqf5eGA5trWjR/aXMCBi7UPu6uJ3R7g6fM
        Ry3yIVTUP1nxtPbIjoQW4yuSjpEmLBTQxZ4yiW7argwdt846sehAgLZNsS4VQb2bII+fKr
        V6AkqC1DTkjYbbP8dFuQOfeVliRIaQwta06bSMpKc/YhLRP6NzXijX7zAjr7yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9/hGT5uCeUBODjxx6P7fIzGSMOXdABNPDxzLF3iZIA8=;
        b=5Qf3L6kjuk5RMRXh3dLimewibbqxjZtuyO6NgnzTyVbav/H1cvtVOif18D15pqxDwv6ETh
        t991F+EazyTSLpDw==
Date:   Mon, 14 Jun 2021 17:44:36 +0200
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
Subject: [patch V2 28/52] x86/fpu: Rename copy_fpregs_to_fpstate() to
 save_fpregs_to_fpstate()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A copy is guaranteed to leave the source intact, which is not the case when
FNSAVE is used as that reinitilizes the registers.

Rename it to save_fpregs_to_fpstate() which does not make such guarantees.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/kernel/fpu/core.c          |   10 +++++-----
 arch/x86/kvm/x86.c                  |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -373,7 +373,7 @@ static inline int xrstor_from_kernel_err
 	return err;
 }
 
-extern int copy_fpregs_to_fpstate(struct fpu *fpu);
+extern int save_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
@@ -505,7 +505,7 @@ static inline void __fpregs_load_activat
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		if (!copy_fpregs_to_fpstate(old_fpu))
+		if (!save_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
 			old_fpu->last_cpu = cpu;
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(irq_fpu_usable);
  * Modern FPU state can be kept in registers, if there are
  * no pending FP exceptions.
  */
-int copy_fpregs_to_fpstate(struct fpu *fpu)
+int save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		xsave_to_kernel(&fpu->state.xsave);
@@ -119,7 +119,7 @@ int copy_fpregs_to_fpstate(struct fpu *f
 
 	return 0;
 }
-EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
@@ -137,7 +137,7 @@ void kernel_fpu_begin_mask(unsigned int
 		 * Ignore return value -- we don't care if reg state
 		 * is clobbered.
 		 */
-		copy_fpregs_to_fpstate(&current->thread.fpu);
+		save_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -172,7 +172,7 @@ void fpu__save(struct fpu *fpu)
 	trace_x86_fpu_before_save(fpu);
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		if (!copy_fpregs_to_fpstate(fpu)) {
+		if (!save_fpregs_to_fpstate(fpu)) {
 			copy_kernel_to_fpregs(&fpu->state);
 		}
 	}
@@ -255,7 +255,7 @@ int fpu__copy(struct task_struct *dst, s
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!copy_fpregs_to_fpstate(dst_fpu))
+	else if (!save_fpregs_to_fpstate(dst_fpu))
 		copy_kernel_to_fpregs(&dst_fpu->state);
 
 	fpregs_unlock();
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9618,7 +9618,7 @@ static void kvm_save_current_fpu(struct
 		memcpy(&fpu->state, &current->thread.fpu.state,
 		       fpu_kernel_xstate_size);
 	else
-		copy_fpregs_to_fpstate(fpu);
+		save_fpregs_to_fpstate(fpu);
 }
 
 /* Swap (qemu) user FPU context for the guest FPU context. */

