Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D63426DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhJHPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:43:47 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:38337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243235AbhJHPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:43:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsq44W2cz9sSm;
        Fri,  8 Oct 2021 17:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nKjfZJLiK7Vn; Fri,  8 Oct 2021 17:41:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspx6Jgfz9sSl;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFE178B78B;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2lAMevwI3rXg; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2B5E8B790;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198FemxF1129664
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198Femnk1129663;
        Fri, 8 Oct 2021 17:40:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/16] powerpc/kuap: Add kuap_lock()
Date:   Fri,  8 Oct 2021 17:40:34 +0200
Message-Id: <8f2f2bacc68eaf70db79fcfb996ca734f91f0cac.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kuap_lock() and call it when entering interrupts from user.

It is called kuap_lock() as it is similar to kuap_save_and_lock()
without the save.

However book3s/32 already have a kuap_lock(). Rename it
kuap_lock_addr().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 12 ++++++++----
 arch/powerpc/include/asm/interrupt.h         |  5 ++++-
 arch/powerpc/include/asm/kup.h               |  9 +++++++++
 arch/powerpc/include/asm/nohash/32/kup-8xx.h |  4 ++++
 arch/powerpc/kernel/interrupt.c              |  2 ++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index e273a6d3b6ad..b61a48550e59 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -60,7 +60,7 @@ static inline void kuap_unlock_all(void)
 void kuap_lock_all_ool(void);
 void kuap_unlock_all_ool(void);
 
-static inline void kuap_lock(unsigned long addr, bool ool)
+static inline void kuap_lock_addr(unsigned long addr, bool ool)
 {
 	if (likely(addr != KUAP_ALL))
 		kuap_lock_one(addr);
@@ -80,6 +80,10 @@ static inline void kuap_unlock(unsigned long addr, bool ool)
 		kuap_unlock_all_ool();
 }
 
+static inline void __kuap_lock(void)
+{
+}
+
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	unsigned long kuap = current->thread.kuap;
@@ -89,7 +93,7 @@ static inline void __kuap_save_and_lock(struct pt_regs *regs)
 		return;
 
 	current->thread.kuap = KUAP_NONE;
-	kuap_lock(kuap, false);
+	kuap_lock_addr(kuap, false);
 }
 
 static inline void kuap_user_restore(struct pt_regs *regs)
@@ -142,7 +146,7 @@ static __always_inline void __prevent_user_access(unsigned long dir)
 		return;
 
 	current->thread.kuap = KUAP_NONE;
-	kuap_lock(kuap, true);
+	kuap_lock_addr(kuap, true);
 }
 
 static inline unsigned long __prevent_user_access_return(void)
@@ -151,7 +155,7 @@ static inline unsigned long __prevent_user_access_return(void)
 
 	if (flags != KUAP_NONE) {
 		current->thread.kuap = KUAP_NONE;
-		kuap_lock(flags, true);
+		kuap_lock_addr(flags, true);
 	}
 
 	return flags;
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 3bbca1fbbe1e..ae719e200c80 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -140,9 +140,12 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 		trace_hardirqs_off();
 
 	if (user_mode(regs))
-		account_cpu_user_entry();
+		kuap_lock();
 	else
 		kuap_save_and_lock(regs);
+
+	if (user_mode(regs))
+		account_cpu_user_entry();
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 7f0d614c5b8b..2e0c2df21b3b 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -52,6 +52,7 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 }
 
 static inline void __kuap_assert_locked(void) { }
+static inline void __kuap_lock(void) { }
 static inline void __kuap_save_and_lock(struct pt_regs *regs) { }
 static inline void kuap_user_restore(struct pt_regs *regs) { }
 static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
@@ -94,6 +95,14 @@ static __always_inline void kuap_assert_locked(void)
 }
 
 #ifdef CONFIG_PPC32
+static __always_inline void kuap_lock(void)
+{
+	if (kuap_is_disabled())
+		return;
+
+	__kuap_lock();
+}
+
 static __always_inline void kuap_save_and_lock(struct pt_regs *regs)
 {
 	if (kuap_is_disabled())
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 37fe4b32b658..c44d97751723 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -20,6 +20,10 @@ static __always_inline bool kuap_is_disabled(void)
 	return static_branch_unlikely(&disable_kuap_key);
 }
 
+static inline void __kuap_lock(void)
+{
+}
+
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	regs->kuap = mfspr(SPRN_MD_AP);
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 0d12aa66e1f9..dc56a514df0a 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -81,6 +81,8 @@ notrace long system_call_exception(long r3, long r4, long r5,
 {
 	syscall_fn f;
 
+	kuap_lock();
+
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-- 
2.31.1

