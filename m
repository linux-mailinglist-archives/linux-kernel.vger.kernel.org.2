Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F183ACEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhFRPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhFRPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:12 -0400
Message-Id: <20210618143448.380267423@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4rOvx6NqMaMu8lgDnfp42/CM/SbqPdzqnxkCx+OzJNo=;
        b=ikhVTCRY3zdCcbtT07bD9n5w2pZMcvZL41SMTRcw4VnUWMhhsZphygG3naQvUm//7Wrp+D
        LjB7Y0q00TrZDq11EJQ5IG3OJG5YeFEUXG4UOo4Gy1aYS00rdiz1/hA44mzx8gs2QQNVme
        CM7OZr5o4OIYuAVpf/3j6j/CkPhcbCrq+b8dwCbRLcZRjQLghD2an1IxArbRvUAaBOGYrc
        N/GTdqsc1IEGciy123GuuhgMXW6Dq3eqL/PWaTSWdsOA42en6AiehfTWwTbgxIcVdaN+Vp
        SEu1oiddmHMq9MtmfDORxMa4JaLJ58468ddxnWWDkIo2rliTMRQ7O5vz5g/Jlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4rOvx6NqMaMu8lgDnfp42/CM/SbqPdzqnxkCx+OzJNo=;
        b=fChdO3xRFy2NCZT4/fJjK2ietpeVbVuna0m7QmRm1SHQ3suAPSChZFKs8DobChl/8iSPIC
        T7+UggWV/ARN8TCg==
Date:   Fri, 18 Jun 2021 16:18:58 +0200
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
Subject: [patch V3 35/66] x86/fpu: Rename copy_kernel_to_fpregs() to
 restore_fpregs_from_kernel()
References: <20210618141823.161158090@linutronix.de>
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
 arch/x86/kvm/x86.c                  |    4 ++--
 arch/x86/mm/extable.c               |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -377,7 +377,7 @@ static inline int os_xrstor_safe(struct
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
-static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
+static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
 		os_xrstor(&fpstate->xsave, mask);
@@ -389,7 +389,7 @@ static inline void __copy_kernel_to_fpre
 	}
 }
 
-static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
+static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
 	/*
 	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
@@ -404,7 +404,7 @@ static inline void copy_kernel_to_fpregs
 			: : [addr] "m" (fpstate));
 	}
 
-	__copy_kernel_to_fpregs(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
@@ -475,7 +475,7 @@ static inline void __fpregs_load_activat
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		copy_kernel_to_fpregs(&fpu->state);
+		restore_fpregs_from_fpstate(&fpu->state);
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
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

