Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EB313992
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhBHQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:35:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9349 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhBHPNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:13:36 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZ8bc4DN5zB09ZQ;
        Mon,  8 Feb 2021 16:10:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yP2LxmVx8Wlz; Mon,  8 Feb 2021 16:10:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZ8bc2YxlzB09ZC;
        Mon,  8 Feb 2021 16:10:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B17E8B7B2;
        Mon,  8 Feb 2021 16:10:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id F0aPqm2tk8Li; Mon,  8 Feb 2021 16:10:41 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31C798B7BC;
        Mon,  8 Feb 2021 16:10:41 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 279436733E; Mon,  8 Feb 2021 15:10:41 +0000 (UTC)
Message-Id: <7e381dc58b3f583556cfab37ba5d813bfd5cce1e.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 21/22] powerpc/32: Remove the counter in global_dbcr0
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  8 Feb 2021 15:10:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

global_dbcr0 has two parts, 4 bytes to save/restore the
value of SPRN_DBCR0, and 4 bytes that are incremented/decremented
everytime something is saving/loading the above value.

This counter is only incremented/decremented, its value is never
used and never read.

Remove the counter and devide the size of global_dbcr0 by 2.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: New
---
 arch/powerpc/kernel/entry_32.S   | 12 +++---------
 arch/powerpc/kernel/head_32.h    |  3 ---
 arch/powerpc/kernel/head_booke.h |  5 +----
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 7c824e8928d0..a574201b0eb6 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -175,14 +175,11 @@ transfer_to_handler:
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
 	lwz	r9,TASK_CPU(r2)
-	slwi	r9,r9,3
+	slwi	r9,r9,2
 	add	r11,r11,r9
 #endif
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
-	lwz	r12,4(r11)
-	addi	r12,r12,-1
-	stw	r12,4(r11)
 #endif
 
 	b	3f
@@ -980,14 +977,11 @@ load_dbcr0:
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
 	lwz	r9,TASK_CPU(r2)
-	slwi	r9,r9,3
+	slwi	r9,r9,2
 	add	r11,r11,r9
 #endif
 	stw	r10,0(r11)
 	mtspr	SPRN_DBCR0,r0
-	lwz	r10,4(r11)
-	addi	r10,r10,1
-	stw	r10,4(r11)
 	li	r11,-1
 	mtspr	SPRN_DBSR,r11	/* clear all pending debug events */
 	blr
@@ -996,7 +990,7 @@ load_dbcr0:
 	.align	4
 	.global global_dbcr0
 global_dbcr0:
-	.space	8*NR_CPUS
+	.space	4*NR_CPUS
 	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
 
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 282d8fd443a9..5001c6ecc3ec 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -166,9 +166,6 @@
 	addi	r11,r11,global_dbcr0@l
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
-	lwz	r12,4(r11)
-	addi	r12,r12,-1
-	stw	r12,4(r11)
 3:
 #endif
 	b	transfer_to_syscall		/* jump to handler */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index bfbd240cc8a2..5f565232b99d 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -142,14 +142,11 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
 	lwz	r10, TASK_CPU(r2)
-	slwi	r10, r10, 3
+	slwi	r10, r10, 2
 	add	r11, r11, r10
 #endif
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
-	lwz	r12,4(r11)
-	addi	r12,r12,-1
-	stw	r12,4(r11)
 
 3:
 	b	transfer_to_syscall	/* jump to handler */
-- 
2.25.0

