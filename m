Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3663A46DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFKQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhFKQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:31 -0400
Message-Id: <20210611163114.107879276@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ux7R0mddwN7OhGhr4YXd9ghTM+f7wZ7BEB6tcfOgqds=;
        b=ky707xDEki/AgnpeL8tGflLTfAtDnoon2uFwfh4nDlnvy1vv9AnFYU9wmdYl+H7mdaAXrp
        h/rPKolhJOm0z4KwzsyLzYsQwYueGE1dohSIr2qgidbrzhw7mCdCO6wvLtx+BG8yqNAlia
        zo/ivlXTSj+G2PXKJZRzZLns3Dt8wP/6eHdbGq7c8ot95RkcBqt9UpqmOvfeh51Mtw7fsi
        WSdkMJkht1QxmEtVmGdz9z1fA0axjks7CFqJovgNByFg0gSrTcOCRNGNSHrzRVItdB65O0
        qv1xUuZP8Vr/8iXSkqcR1I7ttu4c5GC8rW9OFOo69oAPzhliQ8L9LeHcN43uwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ux7R0mddwN7OhGhr4YXd9ghTM+f7wZ7BEB6tcfOgqds=;
        b=XxVk9iULpGk9LYx/XLLP28CzLIMGsMW4UbPGfoOFdPkWCcaDNfVTnUDZWkG5dfWLHmpPsN
        94ttKVwAyxVcTRDg==
Date:   Fri, 11 Jun 2021 18:15:52 +0200
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
Subject: [patch 29/41] x86/fpu: Use pkru_write_default() in
 copy_init_fpstate_to_fpregs()
References: <20210611161523.508908024@linutronix.de>
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
V4: New patch
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
@@ -378,8 +378,7 @@ static inline void copy_init_fpstate_to_
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

