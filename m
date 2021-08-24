Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D93F5985
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhHXH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:57:22 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53147 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234969AbhHXH5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:57:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gv1dw4Pnkz9sVj;
        Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uIG8z8ySajFn; Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gv1dw39hBz9sTx;
        Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B31E8B7DA;
        Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MwG8-KYn4ZtM; Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B1BD8B7D1;
        Tue, 24 Aug 2021 09:56:36 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D51B86BC7E; Tue, 24 Aug 2021 07:56:35 +0000 (UTC)
Message-Id: <c6eabb4fb6c156f75d56dcbcc6f243e5ac0fba42.1629791763.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] powerpc: Avoid link stack corruption in misc asm functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Aug 2021 07:56:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bl;mflr is used at several places to get code position.

Use bcl 20,31,+4 instead of bl in order to preserve link stack.

See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
in __get_datapage()") for details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use $+4 instead of label ; squashed several commits together
---
 arch/powerpc/kernel/misc.S       |  2 +-
 arch/powerpc/kernel/misc_32.S    |  2 +-
 arch/powerpc/kernel/misc_64.S    |  2 +-
 arch/powerpc/kernel/reloc_32.S   |  2 +-
 arch/powerpc/kexec/relocate_32.S | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 5be96feccb55..fb7de3543c03 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -29,7 +29,7 @@ _GLOBAL(reloc_offset)
 	li	r3, 0
 _GLOBAL(add_reloc_offset)
 	mflr	r0
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r5
 	PPC_LL	r4,(2f-1b)(r5)
 	subf	r5,r4,r5
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d8645efff902..e5127b19fec2 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -67,7 +67,7 @@ _GLOBAL(reloc_got2)
 	srwi.	r8,r8,2
 	beqlr
 	mtctr	r8
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r0
 	lis	r4,1b@ha
 	addi	r4,r4,1b@l
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4b761a18a74d..d38a019b38e1 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -255,7 +255,7 @@ _GLOBAL(scom970_write)
  * Physical (hardware) cpu id should be in r3.
  */
 _GLOBAL(kexec_wait)
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r5
 	addi	r5,r5,kexec_flag-1b
 
diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index 10e96f3e22fe..0508c14b4c28 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -30,7 +30,7 @@ R_PPC_RELATIVE = 22
 _GLOBAL(relocate)
 
 	mflr	r0		/* Save our LR */
-	bl	0f		/* Find our current runtime address */
+	bcl	20,31,$+4	/* Find our current runtime address */
 0:	mflr	r12		/* Make it accessible */
 	mtlr	r0
 
diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index 61946c19e07c..cf6e52bdf8d8 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -93,7 +93,7 @@ wmmucr:
 	 * Invalidate all the TLB entries except the current entry
 	 * where we are running from
 	 */
-	bl	0f				/* Find our address */
+	bcl	20,31,$+4			/* Find our address */
 0:	mflr	r5				/* Make it accessible */
 	tlbsx	r23,0,r5			/* Find entry we are in */
 	li	r4,0				/* Start at TLB entry 0 */
@@ -158,7 +158,7 @@ write_out:
 	/* Switch to other address space in MSR */
 	insrwi	r9, r7, 1, 26		/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r8
 	addi	r8, r8, (2f-1b)		/* Find the target offset */
 
@@ -202,7 +202,7 @@ next_tlb:
 	li	r9,0
 	insrwi	r9, r7, 1, 26			/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r8
 	and	r8, r8, r11			/* Get our offset within page */
 	addi	r8, r8, (2f-1b)
@@ -240,7 +240,7 @@ setup_map_47x:
 	sync
 
 	/* Find the entry we are running from */
-	bl	2f
+	bcl	20,31,$+4
 2:	mflr	r23
 	tlbsx	r23, 0, r23
 	tlbre	r24, r23, 0			/* TLB Word 0 */
@@ -296,7 +296,7 @@ clear_utlb_entry:
 	/* Update the msr to the new TS */
 	insrwi	r5, r7, 1, 26
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r6
 	addi	r6, r6, (2f-1b)
 
@@ -355,7 +355,7 @@ write_utlb:
 	/* Defaults to 256M */
 	lis	r10, 0x1000
 
-	bl	1f
+	bcl	20,31,$+4
 1:	mflr	r4
 	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
 
-- 
2.25.0

