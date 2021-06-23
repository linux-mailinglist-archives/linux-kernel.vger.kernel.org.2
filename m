Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074563B19F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFWM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:22 -0400
Message-Id: <20210623121453.734561971@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=01WpygfFRGjrldoKJIoHrdsDBh5jc0Rp0vdud8BMKQY=;
        b=bKRHpQePE6MDWt5Mxf5ZSyB+w1bqEbqPUMAt7HttVOrNE0EX77GB9wqQimZWKJAqWDIIRg
        jFn/VooSul/s7dMEScuyXpG/chDCn1GZs+9lbT3rGO8vl9ktwn61c6lP85C/8UEFBtmQ7p
        U3d9Cvb01YfypQjAefgsYFCBRSNibhu4H7E8IC9oMiM15S/WdxzYKPLzWaxYkh6PPDQ6tS
        ScBslBWLTlm8RVLIWmg+5j4jIyL0kUolA8kwaVFKrmYHjJC6AdSk+hD9tx15C8Hti6mZZn
        fvt6lebhdTlLNsWcOcC0pwInxPHWPjrGWIWk+nenjpe3ORNddDkYkVxibijAtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=01WpygfFRGjrldoKJIoHrdsDBh5jc0Rp0vdud8BMKQY=;
        b=KbAG3EfrSj1pPxhR4HOEIr2F4atsfBZJQANIJmkDbsXw7puGDiKH1g/8SgFyAQtiSEsZBe
        mTMbPXLYPH/AVjBw==
Date:   Wed, 23 Jun 2021 14:01:51 +0200
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
Subject: [patch V4 24/65] x86/fpu: Get rid of copy_supervisor_to_kernel()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the fast path of restoring the FPU state on sigreturn fails or is not
taken and the current task's FPU is active then the FPU has to be
deactivated for the slow path to allow a safe update of the tasks FPU
memory state.

With supervisor states enabled, this requires to save the supervisor state
in the memory state first. Supervisor states require XSAVES so saving only
the supervisor state requires to reshuffle the memory buffer because XSAVES
uses the compacted format and therefore stores the supervisor states at the
beginning of the memory state. That's just an overengineered optimization.

Get rid of it and save the full state for this case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/xstate.h |    1 
 arch/x86/kernel/fpu/signal.c      |   13 +++++---
 arch/x86/kernel/fpu/xstate.c      |   55 --------------------------------------
 3 files changed, 8 insertions(+), 61 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,7 +104,6 @@ void *get_xsave_addr(struct xregs_state
 int xfeature_size(int xfeature_nr);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -401,15 +401,18 @@ static int __fpu__restore_sig(void __use
 	 * the optimisation).
 	 */
 	fpregs_lock();
-
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-
 		/*
-		 * Supervisor states are not modified by user space input.  Save
-		 * current supervisor states first and invalidate the FPU regs.
+		 * If supervisor states are available then save the
+		 * hardware state in current's fpstate so that the
+		 * supervisor state is preserved. Save the full state for
+		 * simplicity. There is no point in optimizing this by only
+		 * saving the supervisor states and then shuffle them to
+		 * the right place in memory. This is the slow path and the
+		 * above XRSTOR failed or ia32_fxstate is true. Shrug.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_supervisor_to_kernel(&fpu->state.xsave);
+			copy_xregs_to_kernel(&fpu->state.xsave);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1197,61 +1197,6 @@ int copy_user_to_xstate(struct xregs_sta
 	return 0;
 }
 
-/*
- * Save only supervisor states to the kernel buffer.  This blows away all
- * old states, and is intended to be used only in __fpu__restore_sig(), where
- * user states are restored from the user buffer.
- */
-void copy_supervisor_to_kernel(struct xregs_state *xstate)
-{
-	struct xstate_header *header;
-	u64 max_bit, min_bit;
-	u32 lmask, hmask;
-	int err, i;
-
-	if (WARN_ON(!boot_cpu_has(X86_FEATURE_XSAVES)))
-		return;
-
-	if (!xfeatures_mask_supervisor())
-		return;
-
-	max_bit = __fls(xfeatures_mask_supervisor());
-	min_bit = __ffs(xfeatures_mask_supervisor());
-
-	lmask = xfeatures_mask_supervisor();
-	hmask = xfeatures_mask_supervisor() >> 32;
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* We should never fault when copying to a kernel buffer: */
-	if (WARN_ON_FPU(err))
-		return;
-
-	/*
-	 * At this point, the buffer has only supervisor states and must be
-	 * converted back to normal kernel format.
-	 */
-	header = &xstate->header;
-	header->xcomp_bv |= xfeatures_mask_all;
-
-	/*
-	 * This only moves states up in the buffer.  Start with
-	 * the last state and move backwards so that states are
-	 * not overwritten until after they are moved.  Note:
-	 * memmove() allows overlapping src/dst buffers.
-	 */
-	for (i = max_bit; i >= min_bit; i--) {
-		u8 *xbuf = (u8 *)xstate;
-
-		if (!((header->xfeatures >> i) & 1))
-			continue;
-
-		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
-			xbuf + xstate_supervisor_only_offsets[i],
-			xstate_sizes[i]);
-	}
-}
-
 /**
  * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
  *                                       an xsave area

