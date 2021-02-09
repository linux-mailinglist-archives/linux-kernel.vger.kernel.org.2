Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F41314CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBIKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:21:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38034 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhBIKFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:05:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbM1GWrz9txgh;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ULGDL_7PpC0x; Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbM0Gtzz9txg8;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F015C8B7D6;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HxMRq77Q7_8q; Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89E278B7D4;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6149E67342; Tue,  9 Feb 2021 09:57:03 +0000 (UTC)
Message-Id: <803affcdac55f75a88f9526e2d177f64ba39f72b.1612864004.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 38/41] powerpc/64s: Make kuap_check_amr() and
 kuap_get_and_check_amr() generic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:57:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting powerpc32 to C syscall entry/exit,
rename kuap_check_amr() and kuap_get_and_check_amr() as kuap_check()
and kuap_get_and_check(), and move in the generic asm/kup.h the stub
for when CONFIG_PPC_KUAP is not selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 24 ++----------------------
 arch/powerpc/include/asm/kup.h           | 10 +++++++++-
 arch/powerpc/kernel/interrupt.c          | 12 ++++++------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 8bd905050896..d9b07e9998be 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -287,7 +287,7 @@ static inline void kuap_kernel_restore(struct pt_regs *regs,
 	 */
 }
 
-static inline unsigned long kuap_get_and_check_amr(void)
+static inline unsigned long kuap_get_and_check(void)
 {
 	if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
 		unsigned long amr = mfspr(SPRN_AMR);
@@ -298,27 +298,7 @@ static inline unsigned long kuap_get_and_check_amr(void)
 	return 0;
 }
 
-#else /* CONFIG_PPC_PKEY */
-
-static inline void kuap_user_restore(struct pt_regs *regs)
-{
-}
-
-static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
-{
-}
-
-static inline unsigned long kuap_get_and_check_amr(void)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PPC_PKEY */
-
-
-#ifdef CONFIG_PPC_KUAP
-
-static inline void kuap_check_amr(void)
+static inline void kuap_check(void)
 {
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		WARN_ON_ONCE(mfspr(SPRN_AMR) != AMR_KUAP_BLOCKED);
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 25671f711ec2..b7efa46b3109 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -74,7 +74,15 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return false;
 }
 
-static inline void kuap_check_amr(void) { }
+static inline void kuap_check(void) { }
+static inline void kuap_save_and_lock(struct pt_regs *regs) { }
+static inline void kuap_user_restore(struct pt_regs *regs) { }
+static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
+
+static inline unsigned long kuap_get_and_check(void)
+{
+	return 0;
+}
 
 /*
  * book3s/64/kup-radix.h defines these functions for the !KUAP case to flush
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 3c2e9b28b05d..8180ed261a27 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -75,7 +75,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	} else
 #endif
 #ifdef CONFIG_PPC64
-		kuap_check_amr();
+		kuap_check();
 #endif
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -241,7 +241,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
 #ifdef CONFIG_PPC64
-	kuap_check_amr();
+	kuap_check();
 #endif
 
 	regs->result = r3;
@@ -381,7 +381,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	 * AMR can only have been unlocked if we interrupted the kernel.
 	 */
 #ifdef CONFIG_PPC64
-	kuap_check_amr();
+	kuap_check();
 #endif
 
 	local_irq_save(flags);
@@ -467,7 +467,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	unsigned long flags;
 	unsigned long ret = 0;
 #ifdef CONFIG_PPC64
-	unsigned long amr;
+	unsigned long kuap;
 #endif
 
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
@@ -483,7 +483,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 		CT_WARN_ON(ct_state() == CONTEXT_USER);
 
 #ifdef CONFIG_PPC64
-	amr = kuap_get_and_check_amr();
+	kuap = kuap_get_and_check();
 #endif
 
 	if (unlikely(current_thread_info()->flags & _TIF_EMULATE_STACK_STORE)) {
@@ -527,7 +527,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	 * value from the check above.
 	 */
 #ifdef CONFIG_PPC64
-	kuap_kernel_restore(regs, amr);
+	kuap_kernel_restore(regs, kuap);
 #endif
 
 	return ret;
-- 
2.25.0

