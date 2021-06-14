Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151433A6C24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhFNQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhFNQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:34 -0700 (PDT)
Message-Id: <20210614155357.663782593@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=K9ZlMlhODDk5mR4OBYbueYp8E7ibMBmJTa7fbzHYYck=;
        b=2KJ9O9sr03cG4MEqztgqye5xmXYjAc7yvZ3juMoRDeZp9ss5U+Mh3wsYVUeGrBoZNH/ABZ
        9Tqn0UvGOwvpSq4Rpv6bLyBmodkI9ioUu9sZujOimyFI7aLTQyLWguwGWE2CPctH6Qs3Nm
        BcTs40EVElGJ9YdictBQsZ9S7gMotMmziHUui7CVaFxfy91DiuulZweGLTGEr6fTJ8yViu
        LTLMXimmJ2z1bcaBUpYxQ3ZOumLemU9fE0FyERLSh15ZiPiEtkoOaiRLEEc5qqA4FGe8WA
        WXKYUSXNcoK1YoZS/nwzbh1n0i0jcBMKkVc48oI44CRtDCLMNdWj4M4AMHEdcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=K9ZlMlhODDk5mR4OBYbueYp8E7ibMBmJTa7fbzHYYck=;
        b=Z2z1V6qbuysAePzl/oLGaXVgYRAr75C/Pbzh+2BYYjDROcA/PgL5ahd49JjF8PVhBNvKg2
        5Oo8JdHSvKVsZeBA==
Date:   Mon, 14 Jun 2021 17:44:47 +0200
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
Subject: [patch V2 39/52] x86/fpu: Use pkru_write_default() in
 copy_init_fpstate_to_fpregs()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in using copy_init_pkru_to_fpregs() which in turn calls
write_pkru(). write_pkru() tries to fiddle with the task's xstate buffer
for nothing because the XRSTOR[S](init_fpstate) just cleared the xfeature
flag in the xstate header which makes get_xsave_addr() fail.

It's a useless exercise anyway because the reinitialization activates the
FPU so before the task's xstate buffer can be used again a XRSTOR[S] must
happen which in turn dumps the PKRU value.

Get rid of the now unused copy_init_pkru_to_fpregs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pkeys.h |    1 -
 arch/x86/kernel/fpu/core.c   |    3 +--
 arch/x86/mm/pkeys.c          |   17 -----------------
 include/linux/pkeys.h        |    4 ----
 4 files changed, 1 insertion(+), 24 deletions(-)

--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -124,7 +124,6 @@ extern int arch_set_user_pkey_access(str
 		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern void copy_init_pkru_to_fpregs(void);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -377,8 +377,7 @@ static inline void load_fpregs_from_init
 	else
 		frstor_from_kernel(&init_fpstate.fsave);
 
-	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
-		copy_init_pkru_to_fpregs();
+	pkru_write_default();
 }
 
 /*
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,7 +10,6 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
-#include <asm/pkru.h>			/* read/write_pkru()		*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -125,22 +124,6 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) |
 		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
 		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
 
-/*
- * Called from the FPU code when creating a fresh set of FPU
- * registers.  This is called from a very specific context where
- * we know the FPU registers are safe for use and we can use PKRU
- * directly.
- */
-void copy_init_pkru_to_fpregs(void)
-{
-	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Override the PKRU state that came from 'init_fpstate'
-	 * with the baseline from the process.
-	 */
-	write_pkru(init_pkru_value_snapshot);
-}
-
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -44,10 +44,6 @@ static inline bool arch_pkeys_enabled(vo
 	return false;
 }
 
-static inline void copy_init_pkru_to_fpregs(void)
-{
-}
-
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */

