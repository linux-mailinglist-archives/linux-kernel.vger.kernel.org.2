Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15760364768
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhDSPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:48:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65437 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241593AbhDSPso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:48:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPB6c0C3Zz9vBLm;
        Mon, 19 Apr 2021 17:48:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Svf3duY9WK-N; Mon, 19 Apr 2021 17:48:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPB6b6MZJz9vBLc;
        Mon, 19 Apr 2021 17:48:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A89F98B7C9;
        Mon, 19 Apr 2021 17:48:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Eg1Cuzq8-G_I; Mon, 19 Apr 2021 17:48:12 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A3868B7C6;
        Mon, 19 Apr 2021 17:48:11 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 523FD67A2A; Mon, 19 Apr 2021 15:48:11 +0000 (UTC)
Message-Id: <f7f8c9f98c33eaea316755c7fef150d1d77e047d.1618847273.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
References: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/3] powerpc/irq: Enhance readability of trap types
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, sxwjean@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 19 Apr 2021 15:48:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of trap types in irq.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/interrupt.h |  1 +
 arch/powerpc/kernel/irq.c            | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 8970990e3b08..44cde2e129b8 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -23,6 +23,7 @@
 #define INTERRUPT_INST_SEGMENT    0x480
 #define INTERRUPT_TRACE           0xd00
 #define INTERRUPT_H_DATA_STORAGE  0xe00
+#define INTERRUPT_HMI			0xe60
 #define INTERRUPT_H_FAC_UNAVAIL   0xf80
 #ifdef CONFIG_PPC_BOOK3S
 #define INTERRUPT_DOORBELL        0xa00
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 893d3f8d6f47..72cb45393ef2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -142,7 +142,7 @@ void replay_soft_interrupts(void)
 	 */
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && (local_paca->irq_happened & PACA_IRQ_HMI)) {
 		local_paca->irq_happened &= ~PACA_IRQ_HMI;
-		regs.trap = 0xe60;
+		regs.trap = INTERRUPT_HMI;
 		handle_hmi_exception(&regs);
 		if (!(local_paca->irq_happened & PACA_IRQ_HARD_DIS))
 			hard_irq_disable();
@@ -150,7 +150,7 @@ void replay_soft_interrupts(void)
 
 	if (local_paca->irq_happened & PACA_IRQ_DEC) {
 		local_paca->irq_happened &= ~PACA_IRQ_DEC;
-		regs.trap = 0x900;
+		regs.trap = INTERRUPT_DECREMENTER;
 		timer_interrupt(&regs);
 		if (!(local_paca->irq_happened & PACA_IRQ_HARD_DIS))
 			hard_irq_disable();
@@ -158,7 +158,7 @@ void replay_soft_interrupts(void)
 
 	if (local_paca->irq_happened & PACA_IRQ_EE) {
 		local_paca->irq_happened &= ~PACA_IRQ_EE;
-		regs.trap = 0x500;
+		regs.trap = INTERRUPT_EXTERNAL;
 		do_IRQ(&regs);
 		if (!(local_paca->irq_happened & PACA_IRQ_HARD_DIS))
 			hard_irq_disable();
@@ -166,10 +166,7 @@ void replay_soft_interrupts(void)
 
 	if (IS_ENABLED(CONFIG_PPC_DOORBELL) && (local_paca->irq_happened & PACA_IRQ_DBELL)) {
 		local_paca->irq_happened &= ~PACA_IRQ_DBELL;
-		if (IS_ENABLED(CONFIG_PPC_BOOK3E))
-			regs.trap = 0x280;
-		else
-			regs.trap = 0xa00;
+		regs.trap = INTERRUPT_DOORBELL;
 		doorbell_exception(&regs);
 		if (!(local_paca->irq_happened & PACA_IRQ_HARD_DIS))
 			hard_irq_disable();
@@ -178,7 +175,7 @@ void replay_soft_interrupts(void)
 	/* Book3E does not support soft-masking PMI interrupts */
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && (local_paca->irq_happened & PACA_IRQ_PMI)) {
 		local_paca->irq_happened &= ~PACA_IRQ_PMI;
-		regs.trap = 0xf00;
+		regs.trap = INTERRUPT_PERFMON;
 		performance_monitor_exception(&regs);
 		if (!(local_paca->irq_happened & PACA_IRQ_HARD_DIS))
 			hard_irq_disable();
-- 
2.25.0

