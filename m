Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FE3ACEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhFRPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:24:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhFRPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:24 -0400
Message-Id: <20210618143449.527823701@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YcOG69swkGIP6zhz0Y+gK3UbyJf80IxLsbfsuRqB10M=;
        b=UXb7u2cD6G5BWWTNe5DB0lAwptKB7GBHnbwkoC4kwVFPvsqHCV2a286Fw81U0rj18J4NFJ
        lGp1BSzvT+12mBJNKDmBoOzQ0zg7tqqJnqGK4shdmjkjeQ6xKSyzkR/58bzXQqBhxK/kSt
        0RucUjlqGKtEZKWs+ea/ycO/T7wFj37zewBHAfmHeCjXUSbyjBDWHSQR4YtxxGrakAHsTa
        0pjWflnO0d7KOXxvAY8/9yu7mMQoQlM5mImR+RWDVOq42+6hZN+e8ZEn5EUoKU6c4TGQ84
        lcwefVteX/NmupOjOJa8FMkUj3c2YmdRn3MO0EhuB8V0e3UAvT+V4MaYIAQHHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YcOG69swkGIP6zhz0Y+gK3UbyJf80IxLsbfsuRqB10M=;
        b=54gFmsqOJDtfgTS/5qO7SWjvfP01KgS2v9Yi77gUfHsHy3kK6cUs56aPFCBXj21lNpuLhT
        NF9kQedyMaIcTvDA==
Date:   Fri, 18 Jun 2021 16:19:08 +0200
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
Subject: [patch V3 45/66] x86/fpu: Use pkru_write_default() in
 copy_init_fpstate_to_fpregs()
References: <20210618141823.161158090@linutronix.de>
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
 		frstor(&init_fpstate.fsave);
 
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

