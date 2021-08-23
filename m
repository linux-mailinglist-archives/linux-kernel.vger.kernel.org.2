Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF893F4618
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhHWHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:54:19 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:38685 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235316AbhHWHyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:54:17 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtPcn5X26z9shn;
        Mon, 23 Aug 2021 09:53:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id laukmtmX5Lot; Mon, 23 Aug 2021 09:53:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtPcP4GJQz9sgy;
        Mon, 23 Aug 2021 09:53:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 09E0E8B7AA;
        Mon, 23 Aug 2021 09:53:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3bY0EdiHkIxZ; Mon, 23 Aug 2021 09:53:08 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 07BD98B7B3;
        Mon, 23 Aug 2021 09:52:45 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3311E6BB01; Mon, 23 Aug 2021 07:52:45 +0000 (UTC)
Message-Id: <e751f698c15b2bac3f7b69178b36190b04d2d9d5.1629705142.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Avoid link stack corruption in a few places
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Aug 2021 07:52:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bcl 20,31,+4 instead of bl in order to preserve link stack.

See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
in __get_datapage()") for details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S    |  2 +-
 arch/powerpc/kernel/reloc_32.S   |  2 +-
 arch/powerpc/kexec/relocate_32.S | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d8645efff902..d81e15a88a34 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -67,7 +67,7 @@ _GLOBAL(reloc_got2)
 	srwi.	r8,r8,2
 	beqlr
 	mtctr	r8
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r0
 	lis	r4,1b@ha
 	addi	r4,r4,1b@l
diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index 10e96f3e22fe..5e9b58ae319e 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -30,7 +30,7 @@ R_PPC_RELATIVE = 22
 _GLOBAL(relocate)
 
 	mflr	r0		/* Save our LR */
-	bl	0f		/* Find our current runtime address */
+	bcl	20,31,0f	/* Find our current runtime address */
 0:	mflr	r12		/* Make it accessible */
 	mtlr	r0
 
diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index 61946c19e07c..e25a5a9861ea 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -93,7 +93,7 @@ wmmucr:
 	 * Invalidate all the TLB entries except the current entry
 	 * where we are running from
 	 */
-	bl	0f				/* Find our address */
+	bcl	20,31,0f			/* Find our address */
 0:	mflr	r5				/* Make it accessible */
 	tlbsx	r23,0,r5			/* Find entry we are in */
 	li	r4,0				/* Start at TLB entry 0 */
@@ -158,7 +158,7 @@ write_out:
 	/* Switch to other address space in MSR */
 	insrwi	r9, r7, 1, 26		/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r8
 	addi	r8, r8, (2f-1b)		/* Find the target offset */
 
@@ -202,7 +202,7 @@ next_tlb:
 	li	r9,0
 	insrwi	r9, r7, 1, 26			/* Set MSR[IS] = r7 */
 
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r8
 	and	r8, r8, r11			/* Get our offset within page */
 	addi	r8, r8, (2f-1b)
@@ -240,7 +240,7 @@ setup_map_47x:
 	sync
 
 	/* Find the entry we are running from */
-	bl	2f
+	bcl	20,31,2f
 2:	mflr	r23
 	tlbsx	r23, 0, r23
 	tlbre	r24, r23, 0			/* TLB Word 0 */
@@ -296,7 +296,7 @@ clear_utlb_entry:
 	/* Update the msr to the new TS */
 	insrwi	r5, r7, 1, 26
 
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r6
 	addi	r6, r6, (2f-1b)
 
@@ -355,7 +355,7 @@ write_utlb:
 	/* Defaults to 256M */
 	lis	r10, 0x1000
 
-	bl	1f
+	bcl	20,31,1f
 1:	mflr	r4
 	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
 
-- 
2.25.0

