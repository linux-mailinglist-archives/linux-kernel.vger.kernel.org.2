Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649B53324F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhCIMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:11:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22719 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCIMKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:10:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvvCz5rSyz9tyjF;
        Tue,  9 Mar 2021 13:10:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RnNDPD0RxgeU; Tue,  9 Mar 2021 13:10:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvCz3szWz9tyjG;
        Tue,  9 Mar 2021 13:10:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7A808B802;
        Tue,  9 Mar 2021 13:10:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m4J8kgqfh4pB; Tue,  9 Mar 2021 13:10:08 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7552F8B7FC;
        Tue,  9 Mar 2021 13:10:08 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2E8C167555; Tue,  9 Mar 2021 12:10:08 +0000 (UTC)
Message-Id: <9fb33f485e9029b06502b5524c9ce3b6075951da.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 41/43] powerpc/32s: Create C version of kuap
 save/restore/check helpers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 12:10:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting PPC32 to C syscall entry/exit,
create C version of kuap_save_and_lock() and kuap_user_restore() and
kuap_kernel_restore() and kuap_check() and kuap_get_and_check()
on book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index b97ea60f6fa3..c9d6c28bcd10 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -72,6 +72,51 @@ static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
 	isync();	/* Context sync required after mtsr() */
 }
 
+static inline void kuap_save_and_lock(struct pt_regs *regs)
+{
+	unsigned long kuap = current->thread.kuap;
+	u32 addr = kuap & 0xf0000000;
+	u32 end = kuap << 28;
+
+	regs->kuap = kuap;
+	if (unlikely(!kuap))
+		return;
+
+	current->thread.kuap = 0;
+	kuap_update_sr(mfsr(addr) | SR_KS, addr, end);	/* Set Ks */
+}
+
+static inline void kuap_user_restore(struct pt_regs *regs)
+{
+}
+
+static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+{
+	u32 addr = regs->kuap & 0xf0000000;
+	u32 end = regs->kuap << 28;
+
+	current->thread.kuap = regs->kuap;
+
+	if (unlikely(regs->kuap == kuap))
+		return;
+
+	kuap_update_sr(mfsr(addr) & ~SR_KS, addr, end);	/* Clear Ks */
+}
+
+static inline unsigned long kuap_get_and_check(void)
+{
+	unsigned long kuap = current->thread.kuap;
+
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && kuap != 0);
+
+	return kuap;
+}
+
+static inline void kuap_check(void)
+{
+	kuap_get_and_check();
+}
+
 static __always_inline void allow_user_access(void __user *to, const void __user *from,
 					      u32 size, unsigned long dir)
 {
-- 
2.25.0

