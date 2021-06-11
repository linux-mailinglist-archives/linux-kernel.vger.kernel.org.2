Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6343A46D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFKQq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhFKQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:21 -0700 (PDT)
Message-Id: <20210611163112.975911129@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9tunpPMaa0EcCpCKqz4MojeVFvWaDLvJ46PFpA/3brI=;
        b=mRuedElqM9RY6aLwrb4zn128HpVKDU5Arrc+x6yP18ZVdcjR1eYDxeYe7xUzkt+RM/qpD+
        O/qCLPFA6TpNRyAmET0uF4iY9D9GVykDSozX9F7EmWensGlNWAUcC6PFtxUwN0x48mTr1T
        qgbZPg4UrjeJA5Ry5tCzb8yLJT8TgemWSsasHbPuzgR74sW5SGsH8htkooq3JHq+cVTqA5
        I3jNQXbl6JFl66vMdIJn97vjOJ9VDkVsl7GK6ROCXlkx2Ry38/5sExUi/L5gf8KZnsFkXl
        W+L/6VtylV1fbGo4tcVRfgBsT8ye5j4v71jqnzqZA52uClNB3vGe5k1hIASuhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9tunpPMaa0EcCpCKqz4MojeVFvWaDLvJ46PFpA/3brI=;
        b=/5F3fYGC/TSIhFgxBbzwdArEEXHSgR3PMlnBLoDaZekJkDR++LFN55ZFL82xmnQjKeCFMv
        4hAZDofQ8OrSCxCA==
Date:   Fri, 11 Jun 2021 18:15:42 +0200
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
Subject: [patch 19/41] x86/fpu: Rename copy_kernel_to_fpregs() to
 restore_fpregs_from_kernel()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a copy functionality. It restores the register state from the
supplied kernel buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    8 ++++----
 arch/x86/kernel/fpu/core.c          |    4 ++--
 arch/x86/kvm/x86.c                  |    4 ++--
 arch/x86/mm/extable.c               |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -397,7 +397,7 @@ static inline int xrstor_from_kernel_err
 
 extern int save_fpregs_to_fpstate(struct fpu *fpu);
 
-static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
+static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
 		xrstor_from_kernel(&fpstate->xsave, mask);
@@ -409,7 +409,7 @@ static inline void __copy_kernel_to_fpre
 	}
 }
 
-static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
+static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
 	/*
 	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
@@ -424,7 +424,7 @@ static inline void copy_kernel_to_fpregs
 			: : [addr] "m" (fpstate));
 	}
 
-	__copy_kernel_to_fpregs(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
@@ -495,7 +495,7 @@ static inline void __fpregs_load_activat
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		copy_kernel_to_fpregs(&fpu->state);
+		restore_fpregs_from_fpstate(&fpu->state);
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -173,7 +173,7 @@ void fpu__save(struct fpu *fpu)
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		if (!save_fpregs_to_fpstate(fpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
+			restore_fpregs_from_fpstate(&fpu->state);
 		}
 	}
 
@@ -256,7 +256,7 @@ int fpu__copy(struct task_struct *dst, s
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
 	else if (!save_fpregs_to_fpstate(dst_fpu))
-		copy_kernel_to_fpregs(&dst_fpu->state);
+		restore_fpregs_from_fpstate(&dst_fpu->state);
 
 	fpregs_unlock();
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9634,7 +9634,7 @@ static void kvm_load_guest_fpu(struct kv
 	 */
 	if (vcpu->arch.guest_fpu)
 		/* PKRU is separately restored in kvm_x86_ops.run. */
-		__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu->state,
+		__restore_fpregs_from_fpstate(&vcpu->arch.guest_fpu->state,
 					~XFEATURE_MASK_PKRU);
 
 	fpregs_mark_activate();
@@ -9655,7 +9655,7 @@ static void kvm_put_guest_fpu(struct kvm
 	if (vcpu->arch.guest_fpu)
 		kvm_save_current_fpu(vcpu->arch.guest_fpu);
 
-	copy_kernel_to_fpregs(&vcpu->arch.user_fpu->state);
+	restore_fpregs_from_fpstate(&vcpu->arch.user_fpu->state);
 
 	fpregs_mark_activate();
 	fpregs_unlock();
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	__copy_kernel_to_fpregs(&init_fpstate, -1);
+	__restore_fpregs_from_fpstate(&init_fpstate, -1);
 	return true;
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);

