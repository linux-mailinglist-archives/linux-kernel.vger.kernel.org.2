Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738233ACECE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhFRP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhFRPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:58 -0400
Message-Id: <20210618143450.527252651@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ENhK2En/sCJMM3vmBmPG+mjKS/IzNIUxpgmlPIUqJlQ=;
        b=3n77NEDkn2AanCzgqSRyswOSUR701pzkCWmZBQ2TncK+EQELfdFNCBQ3obocoSwsNobU7v
        rqoLBtFVYtKmCxpPtxsn127Hl2gKYVG+FLE48DD9Pyd4zX88XRv2cZkOMWpXxf+TLm8iYt
        VaXLinyVDLx68Xl2kP/B9DXvEovnwbKkcuEi3Jel07OsDN7q2nW3Wziem1RY6oFqjZ0JQ2
        p58a3BJQ9ZFlbh3jRQrIBJ8lWhAdsLG696p8ay22tVeWNPRrYwqCQL9KhCTvwuHsDvfQrX
        B9Awbg5LvoP6cZqY4+Lb0LF97QbfmZNxr/WwhdvlKIQvvmgtdp6FrmWECkjnWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ENhK2En/sCJMM3vmBmPG+mjKS/IzNIUxpgmlPIUqJlQ=;
        b=iMRuUAfftVpDul5zMqac2rNh/rjQh9c1rIQDNBdPToUzzt/HFxvH1OHz2IYMDZ4tmmNNy8
        Br9mEv/L2G3h1+DQ==
Date:   Fri, 18 Jun 2021 16:19:17 +0200
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
Subject: [patch V3 54/66] x86/fpu: Mask PKRU from kernel XRSTOR[S] operations
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PKRU state is managed seperately restoring it from the xstate buffer
would be counterproductive as it might either restore a stale value or
reinit the PKRU state to 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/include/asm/fpu/xstate.h   |   10 ++++++++++
 arch/x86/kernel/fpu/xstate.c        |    1 +
 arch/x86/mm/extable.c               |    2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -258,7 +258,7 @@ static inline void fxsave(struct fxregs_
  */
 static inline void os_xrstor_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_fpstate();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -389,7 +389,7 @@ extern void __restore_fpregs_from_fpstat
 
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

