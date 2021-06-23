Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CE3B1A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhFWM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFWM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42916C0619FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:18 -0700 (PDT)
Message-Id: <20210623121454.716058365@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=M6sHhp4Se5Yntk9x02dop++K0KJgtNF0vyFL/nxBEOo=;
        b=VfPrJRJJDiIR4ATS7MYfg9kJgv+GdIZ5h8/yNGk0QD5lJBdwcoFxPg4YExCjW+STnY1RLY
        JsH8L68XVIwauRrx2gsfhNDOd+DZBI1n+21Gbj9/4LLIBlf+PYhvD76e+x03rcSFbFcGxt
        XX3WY9HU/VS/h2rCbvCTTuYaOs4NlbfGV4ywFgS3apwX5o0but3CCCsskUQrtrZumpeMsm
        5puDBzqJKZiG/MK4jKCfCnECus2lUyJ1uzxA/nncwfalrt+Vt9ZRUqpxkzs4+khHQgwz5N
        +faM44HO+FkYcV/uxtz09BJBBH2vNLj8uindNBudrIAW7aUEnABTNVQz/ZvLVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=M6sHhp4Se5Yntk9x02dop++K0KJgtNF0vyFL/nxBEOo=;
        b=y3ExrJg8ZZrNKazEHNC7+Q7bYojU3RZgZqLQVPU7JWikIpSOtu35rxUgpw9rDAtdfomnm/
        Yhfno+6vlz5IJRCw==
Date:   Wed, 23 Jun 2021 14:02:01 +0200
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
Subject: [patch V4 34/65] x86/fpu: Rename copy_kernel_to_fpregs() to
 restore_fpregs_from_fpstate()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a copy functionality. It restores the register state from the
supplied kernel buffer.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    8 ++++----
 arch/x86/kvm/x86.c                  |    4 ++--
 arch/x86/mm/extable.c               |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -376,7 +376,7 @@ static inline int os_xrstor_safe(struct
 	return err;
 }
 
-static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
+static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 {
 	if (use_xsave()) {
 		os_xrstor(&fpstate->xsave, mask);
@@ -388,7 +388,7 @@ static inline void __copy_kernel_to_fpre
 	}
 }
 
-static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
+static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
 	/*
 	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
@@ -403,7 +403,7 @@ static inline void copy_kernel_to_fpregs
 			: : [addr] "m" (fpstate));
 	}
 
-	__copy_kernel_to_fpregs(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
@@ -474,7 +474,7 @@ static inline void __fpregs_load_activat
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

