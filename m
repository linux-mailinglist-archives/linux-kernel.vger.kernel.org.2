Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E4426DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbhJHPn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:43:29 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:38337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243128AbhJHPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:43:10 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsq167PCz9sS8;
        Fri,  8 Oct 2021 17:41:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rWf2H-qylmqX; Fri,  8 Oct 2021 17:41:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspx4Qr1z9sSj;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8171D8B786;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Yf87d38cHzqS; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA84E8B78D;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198FenMV1129684
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198FenQ31129683;
        Fri, 8 Oct 2021 17:40:49 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/16] powerpc: Add KUAP support for BOOKE and 40x
Date:   Fri,  8 Oct 2021 17:40:39 +0200
Message-Id: <1b48b266828b4682979571e4af0ff0f2ff7d0bc3.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On booke/40x we don't have segments like book3s/32.
On booke/40x we don't have access protection groups like 8xx.

Use the PID register to provide user access protection.
Kernel address space can be accessed with any PID.
User address space has to be accessed with the PID of the user.
User PID is always not null.

Everytime the kernel is entered, set PID register to 0 and
restore PID register when returning to user.

Everytime kernel needs to access user data, PID is restored
for the access.

In TLB miss handlers, check the PID and bail out to data storage
exception when PID is 0 and accessed address is in user space.

Note that also forbids execution of user text by kernel except
when user access is unlocked. But this shouldn't be a problem
as the kernel is not supposed to ever run user text.

This patch prepares the infrastructure but the real activation of KUAP
is done by following patches for each processor type one by one.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kup.h              |   4 +
 arch/powerpc/include/asm/nohash/kup-booke.h | 110 ++++++++++++++++++++
 arch/powerpc/include/asm/processor.h        |   3 +
 arch/powerpc/kernel/process.c               |   3 +
 arch/powerpc/mm/mmu_context.c               |   6 ++
 arch/powerpc/mm/nohash/mmu_context.c        |   6 +-
 6 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/nohash/kup-booke.h

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 0cafcf8319cd..953991d1f7ce 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -14,6 +14,10 @@
 #include <asm/nohash/32/kup-8xx.h>
 #endif
 
+#ifdef CONFIG_BOOKE_OR_40x
+#include <asm/nohash/kup-booke.h>
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S_32
 #include <asm/book3s/32/kup.h>
 #endif
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
new file mode 100644
index 000000000000..49bb41ed0816
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_BOOKE_H_
+#define _ASM_POWERPC_KUP_BOOKE_H_
+
+#include <asm/bug.h>
+
+#ifdef CONFIG_PPC_KUAP
+
+#ifdef __ASSEMBLY__
+
+.macro kuap_check_amr	gpr1, gpr2
+.endm
+
+#else
+
+#include <linux/jump_label.h>
+#include <linux/sched.h>
+
+#include <asm/reg.h>
+
+extern struct static_key_false disable_kuap_key;
+
+static __always_inline bool kuap_is_disabled(void)
+{
+	return static_branch_unlikely(&disable_kuap_key);
+}
+
+static inline void __kuap_lock(void)
+{
+	mtspr(SPRN_PID, 0);
+	isync();
+}
+
+static inline void __kuap_save_and_lock(struct pt_regs *regs)
+{
+	regs->kuap = mfspr(SPRN_PID);
+	mtspr(SPRN_PID, 0);
+	isync();
+}
+
+static inline void kuap_user_restore(struct pt_regs *regs)
+{
+	if (kuap_is_disabled())
+		return;
+
+	mtspr(SPRN_PID, current->thread.pid);
+
+	/* Context synchronisation is performed by rfi */
+}
+
+static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+{
+	if (regs->kuap)
+		mtspr(SPRN_PID, current->thread.pid);
+
+	/* Context synchronisation is performed by rfi */
+}
+
+static inline unsigned long __kuap_get_and_assert_locked(void)
+{
+	unsigned long kuap = mfspr(SPRN_PID);
+
+	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
+		WARN_ON_ONCE(kuap);
+
+	return kuap;
+}
+
+static inline void __allow_user_access(void __user *to, const void __user *from,
+				       unsigned long size, unsigned long dir)
+{
+	mtspr(SPRN_PID, current->thread.pid);
+	isync();
+}
+
+static inline void __prevent_user_access(unsigned long dir)
+{
+	mtspr(SPRN_PID, 0);
+	isync();
+}
+
+static inline unsigned long __prevent_user_access_return(void)
+{
+	unsigned long flags = mfspr(SPRN_PID);
+
+	mtspr(SPRN_PID, 0);
+	isync();
+
+	return flags;
+}
+
+static inline void __restore_user_access(unsigned long flags)
+{
+	if (flags) {
+		mtspr(SPRN_PID, current->thread.pid);
+		isync();
+	}
+}
+
+static inline bool
+__bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+{
+	return !regs->kuap;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* _ASM_POWERPC_KUP_BOOKE_H_ */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 4b13f94a4f42..2748ae867dbd 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -160,6 +160,9 @@ struct thread_struct {
 	unsigned long	sr0;
 #endif
 #endif /* CONFIG_PPC32 */
+#if defined(CONFIG_BOOKE_OR_40x) && defined(CONFIG_PPC_KUAP)
+	unsigned long	pid;	/* value written in PID reg. at interrupt exit */
+#endif
 	/* Debug Registers */
 	struct debug_reg debug;
 #ifdef CONFIG_PPC_FPU_REGS
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2c637740c0c2..b22d70681a21 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1767,6 +1767,9 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_PPC_KUAP)
 	p->thread.kuap = KUAP_NONE;
 #endif
+#if defined(CONFIG_BOOKE_OR_40x) && defined(CONFIG_PPC_KUAP)
+	p->thread.pid = MMU_NO_CONTEXT;
+#endif
 
 	setup_ksp_vsid(p, sp);
 
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index e618d5442a28..735c36f26388 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -21,6 +21,9 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
 #ifdef CONFIG_PPC_BOOK3S_32
 	tsk->thread.sr0 = mm->context.sr0;
 #endif
+#if defined(CONFIG_BOOKE_OR_40x) && defined(CONFIG_PPC_KUAP)
+	tsk->thread.pid = mm->context.id;
+#endif
 }
 #elif defined(CONFIG_PPC_BOOK3E_64)
 static inline void switch_mm_pgdir(struct task_struct *tsk,
@@ -28,6 +31,9 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
 	get_paca()->pgd = mm->pgd;
+#ifdef CONFIG_PPC_KUAP
+	tsk->thread.pid = mm->context.id;
+#endif
 }
 #else
 static inline void switch_mm_pgdir(struct task_struct *tsk,
diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 44b2b5e7cabe..85b048f04c56 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -33,6 +33,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 #include <asm/smp.h>
+#include <asm/kup.h>
 
 #include <mm/mmu_decl.h>
 
@@ -217,7 +218,7 @@ static void set_context(unsigned long id, pgd_t *pgd)
 
 		/* sync */
 		mb();
-	} else {
+	} else if (kuap_is_disabled()) {
 		if (IS_ENABLED(CONFIG_40x))
 			mb();	/* sync */
 
@@ -305,6 +306,9 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next,
 	if (IS_ENABLED(CONFIG_BDI_SWITCH))
 		abatron_pteptrs[1] = next->pgd;
 	set_context(id, next->pgd);
+#if defined(CONFIG_BOOKE_OR_40x) && defined(CONFIG_PPC_KUAP)
+	tsk->thread.pid = id;
+#endif
 	raw_spin_unlock(&context_lock);
 }
 
-- 
2.31.1

