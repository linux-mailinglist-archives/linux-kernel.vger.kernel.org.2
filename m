Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD5423E10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhJFMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:50:26 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36081 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238623AbhJFMuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:50:23 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPZ4T0wL5z9sWg;
        Wed,  6 Oct 2021 14:48:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pqxEuLm0EU_c; Wed,  6 Oct 2021 14:48:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPZ4M41yVz9sW1;
        Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FC818B77E;
        Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s5iktsO5hlpc; Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D8B98B788;
        Wed,  6 Oct 2021 14:48:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 196Clppg579416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Oct 2021 14:47:52 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 196ChsrQ579289;
        Wed, 6 Oct 2021 14:43:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 09/15] powerpc/kuap: Prepare for supporting KUAP on BOOK3E/64
Date:   Wed,  6 Oct 2021 14:43:42 +0200
Message-Id: <0ced530e0d438741f934861eb77d8c437576d1b0.1633523837.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633523837.git.christophe.leroy@csgroup.eu>
References: <cover.1633523837.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also call kuap_lock() and kuap_save_and_lock() from
interrupt functions with CONFIG_PPC64.

For book3s/64 we keep them empty as it is done in assembly.

Also do the locked assert when switching task unless it is
book3s/64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 9 +++++++++
 arch/powerpc/include/asm/interrupt.h     | 2 ++
 arch/powerpc/include/asm/kup.h           | 2 --
 arch/powerpc/kernel/process.c            | 6 +++---
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 503828709d55..69fcf63eec94 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -298,6 +298,15 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 	return amr;
 }
 
+/* Do nothing, book3s/64 does that in ASM */
+static inline void __kuap_lock(void)
+{
+}
+
+static inline void __kuap_save_and_lock(struct pt_regs *regs)
+{
+}
+
 /*
  * We support individually allowing read or write, but we don't support nesting
  * because that would require an expensive read/modify write of the AMR.
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 6690a41900f2..bf7e59f3d17f 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -154,12 +154,14 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 
 	if (user_mode(regs)) {
+		kuap_lock();
 		CT_WARN_ON(ct_state() != CONTEXT_USER);
 		user_exit_irqoff();
 
 		account_cpu_user_entry();
 		account_stolen_time();
 	} else {
+		kuap_save_and_lock(regs);
 		/*
 		 * CT_WARN_ON comes here via program_check_exception,
 		 * so avoid recursion.
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 92b70e18d888..cb9d4a13a9a5 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -91,7 +91,6 @@ static __always_inline void kuap_assert_locked(void)
 		__kuap_get_and_assert_locked();
 }
 
-#ifdef CONFIG_PPC32
 static __always_inline void kuap_lock(void)
 {
 	if (kuap_is_disabled())
@@ -107,7 +106,6 @@ static __always_inline void kuap_save_and_lock(struct pt_regs *regs)
 
 	__kuap_save_and_lock(regs);
 }
-#endif
 
 static __always_inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
 {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..2c637740c0c2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1281,9 +1281,9 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	set_return_regs_changed(); /* _switch changes stack (and regs) */
 
-#ifdef CONFIG_PPC32
-	kuap_assert_locked();
-#endif
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		kuap_assert_locked();
+
 	last = _switch(old_thread, new_thread);
 
 	/*
-- 
2.31.1

