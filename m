Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF643B1A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhFWM3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFWM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F68DC06121D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:41 -0700 (PDT)
Message-Id: <20210623121456.606745195@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4HzeING7IsxLYKICIA1b9gmIi8d4deE8z4AOv2IimGA=;
        b=hwvSgCB8ERrgaPW4wL8POAC1AQcysRryFETt1uYmTCXcmzQA1znOjdtJy846AscxN9W1nu
        v45sYChL+qMKwl97pE2OvQtUlRHE46vcvH30d+QE+1ChJCgm8GYhto/xSUdAdI3xpaPl8p
        buGnEpNEhu2EWsmKUeSO4ruHj1ka0CAi8svrPHvyfr1S9N8Crl65Z88HVIjLkz496ityhj
        sJunsYtW75Imdd8AKqLf5aHT/jFJtEqjGka42pKha4V1I30xrUAhNVmzOMBc8SqEM7OHYm
        VQW3pPozZcn5g67aOp/3jzYVajwsxOZSsJx7aMLeO/QZJRP1GP/faUlg2ILxeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4HzeING7IsxLYKICIA1b9gmIi8d4deE8z4AOv2IimGA=;
        b=9W28hkMAPAOx32ENFDRrZUdYebFbkh1E/7L8D6VVo2hDwlwO06skRrMgDpAhd1oAIgszh2
        rjare/kwQHqvKqDg==
Date:   Wed, 23 Jun 2021 14:02:20 +0200
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
Subject: [patch V4 53/65] x86/fpu: Mask PKRU from kernel XRSTOR[S] operations
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PKRU state is managed separately restoring it from the xstate buffer
would be counterproductive as it might either restore a stale value or
reinit the PKRU state to 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/include/asm/fpu/xstate.h   |   10 ++++++++++
 arch/x86/kernel/fpu/xstate.c        |    1 +
 arch/x86/mm/extable.c               |    2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -259,7 +259,7 @@ static inline void fxsave(struct fxregs_
  */
 static inline void os_xrstor_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_fpstate();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -388,7 +388,7 @@ extern void __restore_fpregs_from_fpstat
 
 static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
-	__restore_fpregs_from_fpstate(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,6 +111,16 @@ static inline u64 xfeatures_mask_restore
 	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
 }
 
+/*
+ * Like xfeatures_mask_restore_user() but additionally restors the
+ * supported supervisor states.
+ */
+static inline u64 xfeatures_mask_fpstate(void)
+{
+	return xfeatures_mask_all & \
+		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
+}
+
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -60,6 +60,7 @@ static short xsave_cpuid_features[] __in
  * XSAVE buffer, both supervisor and user xstates.
  */
 u64 xfeatures_mask_all __ro_after_init;
+EXPORT_SYMBOL_GPL(xfeatures_mask_all);
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	__restore_fpregs_from_fpstate(&init_fpstate, -1);
+	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 	return true;
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);

