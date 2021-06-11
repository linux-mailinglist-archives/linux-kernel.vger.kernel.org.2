Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448063A46E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFKQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhFKQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461DC061226
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:39 -0700 (PDT)
Message-Id: <20210611163114.550369642@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hfxd9GkS7ZGEd/sT8BiA6c1oo/IEnXv+PZMfK+tZEXc=;
        b=mIuZQuB83x6cJ/NQROx3w/2NiWZ2UJRSc8+H+x1+j20pPMLJBcfypwHuYxcFy1qYGBk+UQ
        xJqEtV7fdMUZxn5Q6Mv0xnOjR7CO+DeDKmsReGlZUnJwbwoT3RuwN1j50QfoZnsK1fUZjq
        n3ffT9dOUB/jouL/AhKY0vJrFNQFdmELZwpfhS66biX2A/NP6q92U2p6KcTEQH6raxRjUp
        /qLb200d/56NIMQEL7tsresS1K6QlufHfxEwSOOoZjVem8a+fuGmBkMBBB3rE5ARzbAMVY
        2oJsj0QPZKF5KrD0l3glvUlDJGTy9tKdMlP9r2VtEgDwHcb1J97pzNVGEZQWTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hfxd9GkS7ZGEd/sT8BiA6c1oo/IEnXv+PZMfK+tZEXc=;
        b=N5YXalT82cMB2yOuNJPzbhjHs3HOOfLGAf6xyeOxFTe0lruj/aesOht4I5k+PNQ/1OVtVa
        mo7bAPdV0Abty2Dw==
Date:   Fri, 11 Jun 2021 18:15:56 +0200
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
Subject: [patch 33/41] x86/fpu: Move FXSAVE_LEAK quirk info __copy_kernel_to_fpregs()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_kernel_to_fpregs() restores all xfeatures but it is also the place
where the AMD FXSAVE_LEAK bug is handled.

That prevents fpregs_restore_userregs() to limit the restored features,
which is required to distangle PKRU and XSTATE handling and also for the
upcoming supervisor state management.

Move the FXSAVE_LEAK quirk into __copy_kernel_to_fpregs() and deinline that
function which has become rather fat.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 arch/x86/include/asm/fpu/internal.h |   25 +------------------------
 arch/x86/kernel/fpu/core.c          |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -399,33 +399,10 @@ static inline int xrstor_from_kernel_err
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void copy_fpregs_to_fpstate(struct fpu *fpu);
 
-static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
-{
-	if (use_xsave()) {
-		xrstor_from_kernel(&fpstate->xsave, mask);
-	} else {
-		if (use_fxsr())
-			fxrstor_from_kernel(&fpstate->fxsave);
-		else
-			frstor_from_kernel(&fpstate->fsave);
-	}
-}
+extern void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
-	/*
-	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
-	 * pending. Clear the x87 state here by setting it to fixed values.
-	 * "m" is a random variable that should be in L1.
-	 */
-	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
-		asm volatile(
-			"fnclex\n\t"
-			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
-	}
-
 	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -145,6 +145,32 @@ void copy_fpregs_to_fpstate(struct fpu *
 		restore_fpregs_from_fpstate(&fpu->state);
 }
 
+void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+{
+	/*
+	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
+	 * pending. Clear the x87 state here by setting it to fixed values.
+	 * "m" is a random variable that should be in L1.
+	 */
+	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
+		asm volatile(
+			"fnclex\n\t"
+			"emms\n\t"
+			"fildl %P[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (fpstate));
+	}
+
+	if (use_xsave()) {
+		xrstor_from_kernel(&fpstate->xsave, mask);
+	} else {
+		if (use_fxsr())
+			fxrstor_from_kernel(&fpstate->fxsave);
+		else
+			frstor_from_kernel(&fpstate->fsave);
+	}
+}
+EXPORT_SYMBOL_GPL(__restore_fpregs_from_fpstate);
+
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();

