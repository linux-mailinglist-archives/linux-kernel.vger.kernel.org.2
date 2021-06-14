Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6613A6C28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhFNQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhFNQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EAC0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:39 -0700 (PDT)
Message-Id: <20210614155358.058188608@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UqxkWdMgauavrXsl+dPl+WOnHzKy/yWo5jtOch7Wn5E=;
        b=aLjTgdtAJuj3e2qNJZ1IlV8gm6Sdz1V3WT3zVx1MNKjoj+HwxFb6Uqlg7zREMIy8NLMWDz
        6a9lMfGwfve5wSyu6Q33ewM2l6d7CoRo7LeFXA+r1v5G10Ct/FXs9QoNqDnNHFxIDYP/EO
        emiBo+NAo3oipIWYJQq3UbauP7Gbireb4hcK94w9HtnJCjlrcgexe5Th/Af0VijdLhA2C8
        M89Kh2S7/ZRJfym77kXNsOARWb8cJuClZwdDUvXrHcJW033yXMHdk8JHOduhBC9IFhg7Hl
        PVIic+QCdaOYYcOG4SDliEO2zrgSFdOTWrsK/AiELxn3XCaMfjhUeNwxiopF0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UqxkWdMgauavrXsl+dPl+WOnHzKy/yWo5jtOch7Wn5E=;
        b=Ln2/1nuuGtTZyxrPGYY9ZxBnZRTLjXVjaxx+lXFJh39Kix4AYAsCP0VYUAGA2oF1YNT5bm
        0QJVfjAnO4r9KbBw==
Date:   Mon, 14 Jun 2021 17:44:51 +0200
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
Subject: [patch V2 43/52] x86/fpu: Move FXSAVE_LEAK quirk info
 __copy_kernel_to_fpregs()
References: <20210614154408.673478623@linutronix.de>
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

