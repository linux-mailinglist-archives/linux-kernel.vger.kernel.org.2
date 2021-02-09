Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5A314CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhBIKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:23:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1310 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231269AbhBIKFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:05:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbM6phTz9txgj;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Z_gz7k_4XbO1; Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbM602jz9txg8;
        Tue,  9 Feb 2021 10:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0EC78B7D6;
        Tue,  9 Feb 2021 10:57:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id arl6NBI6vbyQ; Tue,  9 Feb 2021 10:57:04 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9483A8B7D4;
        Tue,  9 Feb 2021 10:57:04 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6DC0167342; Tue,  9 Feb 2021 09:57:04 +0000 (UTC)
Message-Id: <d90ed040720621c78bd5e08b4cd01c46ed74916c.1612864004.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 39/41] powerpc/32s: Create C version of kuap
 save/restore/check helpers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:57:04 +0000 (UTC)
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

