Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4E3B1A06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhFWM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhFWM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:52 -0400
Message-Id: <20210623121456.114271278@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CV5byBDAs7AEzqrKzdCY8aT6lUA2Y84mAiWpeJ6pjFY=;
        b=QCCu31w5bVBBLh5F4s3rBOFNlvSz0yH9nRgywyN0pL5EQ5eEKlarXm+tyCefl7ORoaJs2S
        jipQw8/LQ6rmHcMfjR4qtIKoZoAKEV4plgYt871wZAy2FZmYfElnAmHuhSMWnz8ad/JI31
        jskwJQ8330a3XUZOEL8z/2kP+h0WAlNio6hoaVBr+LxWrN2R7lhF12wuv7bBcdQrP3RnrS
        cYkgzojQI55qAHahRchTxwwmq2debJflvi1Qs9N91Gx9C94zOxoQcTKv2cid5sbW+hLmR+
        HW6EWfIhEsvHoPCNNcy8ehceojiywSJyApFI648dqqpMYiFm0A6MT6YsNdmJ3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CV5byBDAs7AEzqrKzdCY8aT6lUA2Y84mAiWpeJ6pjFY=;
        b=RZ+SpSeCq7cE/acHw2559MBneVAwpAGpfXo0swobu8MsU32WIB5gbDctZS0X1kWjuKjoc7
        mLVqCH+ZGs2HWyCQ==
Date:   Wed, 23 Jun 2021 14:02:15 +0200
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
Subject: [patch V4 48/65] x86/fpu: Move FXSAVE_LEAK quirk info
 __copy_kernel_to_fpregs()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_kernel_to_fpregs() restores all xfeatures but it is also the place
where the AMD FXSAVE_LEAK bug is handled.

That prevents fpregs_restore_userregs() to limit the restored features,
which is required to untangle PKRU and XSTATE handling and also for the
upcoming supervisor state management.

Move the FXSAVE_LEAK quirk into __copy_kernel_to_fpregs() and deinline that
function which has become rather fat.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |   25 +------------------------
 arch/x86/kernel/fpu/core.c          |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -379,33 +379,10 @@ static inline int os_xrstor_safe(struct
 	return err;
 }
 
-static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
-{
-	if (use_xsave()) {
-		os_xrstor(&fpstate->xsave, mask);
-	} else {
-		if (use_fxsr())
-			fxrstor(&fpstate->fxsave);
-		else
-			frstor(&fpstate->fsave);
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
@@ -124,6 +124,33 @@ void save_fpregs_to_fpstate(struct fpu *
 }
 EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
+void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+{
+	/*
+	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
+	 * FDP/FIP/FOP unless an exception is pending. Clear the x87 state
+	 * here by setting it to fixed values.  "m" is a random variable
+	 * that should be in L1.
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
+		os_xrstor(&fpstate->xsave, mask);
+	} else {
+		if (use_fxsr())
+			fxrstor(&fpstate->fxsave);
+		else
+			frstor(&fpstate->fsave);
+	}
+}
+EXPORT_SYMBOL_GPL(__restore_fpregs_from_fpstate);
+
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();

