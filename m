Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99A93ACEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhFRPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:24:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhFRPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:30 -0400
Message-Id: <20210618143449.989728490@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6KOYpBrJVdcrFrdgcakKBrExwHe6h+1orlPu7jzP3qI=;
        b=gryelcCczCKrZ2hUAwnuDhbOSsfiYp/nDxpXdPY/R+kjeU4cKsdLCT97DZKHZq/ToCZRQ2
        BLuVRUGoxuVT92cB5TASIDEtpE9f34fIuxjeR0hQOSMHl4G08FiDxtpRShYNfxLPDFTy8J
        XyQh2PcDgjiG0zhhSUhOiw7eyyg+qFO3WIspET0wKB9OJl6pW2lRrpaealjHC0Xx/gNfp2
        6mABs4cZPv8B1ljoAiALiBd+ucI5YoZJjAbugJm4iwwgpSimFkeVKLUHxx7Z+DCZaKjtoZ
        v4YuuleZLNk4pgFalwJjTlQTn72MDczwkT81KlTrODnOaINZ8h2LzmQ0d77/6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6KOYpBrJVdcrFrdgcakKBrExwHe6h+1orlPu7jzP3qI=;
        b=FIZrJ4fbACd+tqaLsIhmMj631ZLzCEmneYFsrPM2LEv5cBJHFqTCeSL3lJeSkaklDoG/0g
        cZDd7qRQcgZ6O3AQ==
Date:   Fri, 18 Jun 2021 16:19:12 +0200
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
Subject: [patch V3 49/66] x86/fpu: Move FXSAVE_LEAK quirk info
 __copy_kernel_to_fpregs()
References: <20210618141823.161158090@linutronix.de>
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
 arch/x86/include/asm/fpu/internal.h |   25 +------------------------
 arch/x86/kernel/fpu/core.c          |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -380,33 +380,10 @@ static inline int os_xrstor_safe(struct
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
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

