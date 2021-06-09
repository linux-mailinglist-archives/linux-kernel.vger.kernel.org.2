Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913FA3A0C33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhFIGM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:12:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54359 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhFIGMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:12:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G0GtZ0x1XzBDJ9;
        Wed,  9 Jun 2021 08:10:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MF3WHZLI9UTZ; Wed,  9 Jun 2021 08:10:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G0GtZ02hkzBCHr;
        Wed,  9 Jun 2021 08:10:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D880D8B7CD;
        Wed,  9 Jun 2021 08:10:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pWQworC-cdmm; Wed,  9 Jun 2021 08:10:29 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 977AC8B7C3;
        Wed,  9 Jun 2021 08:10:29 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6914364C62; Wed,  9 Jun 2021 06:10:29 +0000 (UTC)
Message-Id: <37f41d74faa0c66f90b373e243e8b1ee37a1f6fa.1623219019.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Move update_power8_hid0() into its only user
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  9 Jun 2021 06:10:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_power8_hid0() is used only by powernv platform subcore.c

Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h           | 10 ----------
 arch/powerpc/platforms/powernv/subcore.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3bb01a8779c9..c5a527489ba5 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1445,16 +1445,6 @@ extern void scom970_write(unsigned int address, unsigned long value);
 struct pt_regs;
 
 extern void ppc_save_regs(struct pt_regs *regs);
-
-static inline void update_power8_hid0(unsigned long hid0)
-{
-	/*
-	 *  The HID0 update on Power8 should at the very least be
-	 *  preceded by a SYNC instruction followed by an ISYNC
-	 *  instruction
-	 */
-	asm volatile("sync; mtspr %0,%1; isync":: "i"(SPRN_HID0), "r"(hid0));
-}
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_REG_H */
diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
index 73207b53dc2b..4fe0594c3f4d 100644
--- a/arch/powerpc/platforms/powernv/subcore.c
+++ b/arch/powerpc/platforms/powernv/subcore.c
@@ -169,6 +169,16 @@ static void update_hid_in_slw(u64 hid0)
 	}
 }
 
+static void update_power8_hid0(unsigned long hid0)
+{
+	/*
+	 *  The HID0 update on Power8 should at the very least be
+	 *  preceded by a SYNC instruction followed by an ISYNC
+	 *  instruction
+	 */
+	asm volatile("sync; mtspr %0,%1; isync":: "i"(SPRN_HID0), "r"(hid0));
+}
+
 static void unsplit_core(void)
 {
 	u64 hid0, mask;
-- 
2.25.0

