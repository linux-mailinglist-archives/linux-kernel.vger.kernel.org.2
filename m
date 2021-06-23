Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9943B1A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhFWM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhFWM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202CC0611FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:15 -0700 (PDT)
Message-Id: <20210623121454.508853062@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FtnYcODUXDnBALgwJ5Ou9onaGXOy3UuICkvWur3i3iU=;
        b=g4zKLuHzy+HrgKxUApnrLFmzBaVU2CfxmXnUXvFLxdnDqsmiX6eRiTSSl/gyst14r1F3oe
        7BoHy5UU08BEuSE4QKfForVhiPZtzVpR5KB4xZ+WJhrblaRf7W7QsYfGZeAx9vx5Isv0Rk
        Hd8dY+kKoswJaAVE4jkeHM3VhSdQhlOaVcga7Fhvfe5dwoFbGUDWom3YkoLStFLN9s5Nos
        OBNX5TfyiYhM4SuCpFnu3qhLkY99ZR9e0Uf2k26dRY+JhPrfFtBYq/IlXJ+DrE/HGTusAm
        A6XhufCctx129Xw0MKZ+/+lwlh4D7CgInD15KV6Zde4Fw/8X61HVerMY3C9FGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FtnYcODUXDnBALgwJ5Ou9onaGXOy3UuICkvWur3i3iU=;
        b=EQ0dw1hZ+f+04I3FuC6tI0/OH1NEjzLFLF9pxrZJQV9w//P1al9KxHRaxzkPy59Cexwv77
        WTv6ZlhpeE7TaXDQ==
Date:   Wed, 23 Jun 2021 14:01:59 +0200
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
Subject: [patch V4 32/65] x86/fpu: Rename copy_fpregs_to_fpstate() to
 save_fpregs_to_fpstate()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A copy is guaranteed to leave the source intact, which is not the case when
FNSAVE is used as that reinitilizes the registers.

Save does not make such guarantees and it matches what this is about,
i.e. to save the state for a later restore.

Rename it to save_fpregs_to_fpstate(). 

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/kernel/fpu/core.c          |   10 +++++-----
 arch/x86/kvm/x86.c                  |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -375,7 +375,7 @@ static inline int os_xrstor_safe(struct
 	return err;
 }
 
-extern int copy_fpregs_to_fpstate(struct fpu *fpu);
+extern int save_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
@@ -507,7 +507,7 @@ static inline void __fpregs_load_activat
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
 		os_xsave(&fpu->state.xsave);
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

