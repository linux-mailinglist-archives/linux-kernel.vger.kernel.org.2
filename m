Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6D39DA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFGK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:58:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2233 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhFGK6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:58:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fz9K31GJdzB9X2;
        Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id knNczCCxCNDI; Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fz9K30MmCzB9Ww;
        Mon,  7 Jun 2021 12:56:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3B718B78F;
        Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u07wuyf3V8SH; Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C948A8B78D;
        Mon,  7 Jun 2021 12:56:06 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B1B1764C69; Mon,  7 Jun 2021 10:56:06 +0000 (UTC)
Message-Id: <83a008a9fd6cc3f2bbcb470f592555d260ed7a3d.1623063174.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
References: <5838caffa269e0957c5a50cc85477876220298b0.1623063174.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 3/3] powerpc/32s: Rename PTE_SIZE to PTE_T_SIZE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  7 Jun 2021 10:56:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTE_SIZE means PTE page table size in most placed, whereas
in hash_low.S in means size of one entry in the table.

Rename it PTE_T_SIZE, and define it directly in hash_low.S
instead of going through asm-offsets.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/asm-offsets.c   | 2 --
 arch/powerpc/mm/book3s32/hash_low.S | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f1b6ff14c8a0..2bd936ebcae8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -361,8 +361,6 @@ int main(void)
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
 #endif
 
-	DEFINE(PTE_SIZE, sizeof(pte_t));
-
 #ifdef CONFIG_KVM
 	OFFSET(VCPU_HOST_STACK, kvm_vcpu, arch.host_stack);
 	OFFSET(VCPU_HOST_PID, kvm_vcpu, arch.host_pid);
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index fb4233a5bdf7..6925ce998557 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -27,8 +27,10 @@
 #include <asm/code-patching-asm.h>
 
 #ifdef CONFIG_PTE_64BIT
+#define PTE_T_SIZE		8
 #define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
 #else
+#define PTE_T_SIZE		4
 #define PTE_FLAGS_OFFSET	0
 #endif
 
@@ -488,7 +490,7 @@ _GLOBAL(flush_hash_pages)
 	bne	2f
 	ble	cr1,19f
 	addi	r4,r4,0x1000
-	addi	r5,r5,PTE_SIZE
+	addi	r5,r5,PTE_T_SIZE
 	addi	r6,r6,-1
 	b	1b
 
@@ -573,7 +575,7 @@ _GLOBAL(flush_hash_pages)
 
 8:	ble	cr1,9f			/* if all ptes checked */
 81:	addi	r6,r6,-1
-	addi	r5,r5,PTE_SIZE
+	addi	r5,r5,PTE_T_SIZE
 	addi	r4,r4,0x1000
 	lwz	r0,0(r5)		/* check next pte */
 	cmpwi	cr1,r6,1
-- 
2.25.0

