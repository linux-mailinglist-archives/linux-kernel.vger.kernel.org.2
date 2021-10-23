Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F309438385
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJWLt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:49:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54660 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231376AbhJWLtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:49:53 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4HbzwW1m9Sz9s2t;
        Sat, 23 Oct 2021 13:47:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b9j-txkBeket; Sat, 23 Oct 2021 13:47:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by pegase1.c-s.fr (Postfix) with ESMTPS id 4HbzwS30HBz9s2q;
        Sat, 23 Oct 2021 13:47:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19NBlKfL441179
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 13:47:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19NBlKvV441178;
        Sat, 23 Oct 2021 13:47:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/10] powerpc/fsl_booke: Enable reloading of TLBCAM without switching to AS1
Date:   Sat, 23 Oct 2021 13:47:11 +0200
Message-Id: <ba02555bb912382b729c3b3dad4575bc84246a72.1634983809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
References: <33e7fe0f6134c58e044eb63d3925cd34aa120104.1634983809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634989633; l=1787; s=20211009; h=from:subject:message-id; bh=hnT3Htr9Kbjvusle9HHm9twnh707ikQ9q4C7xZV0VCI=; b=mm0VTjxyZnHkEiWZ+UfNvUF40XqaZ5duwP80HNQAODJ3/i8DY17prjHTMvw8+JpJBbaw6hckZ/vg gCByfb4hCmio4ULga6Spb/rAb8anoe7M+UHDAtUZucZlJ/cjgjgh
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid switching to AS1 when reloading TLBCAM after init for
STRICT_KERNEL_RWX.

When we setup AS1 we expect the entire accessible memory to be mapped
through one entry, this is not the case anymore at the end of init.

We are not changing the size of TLBCAMs, only flags, so no need to
switch to AS1.

So change loadcam_multi() to not switch to AS1 when the given
temporary tlb entry in 0.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: No change
---
 arch/powerpc/mm/nohash/tlb_low.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb_low.S b/arch/powerpc/mm/nohash/tlb_low.S
index 5add4a51e51f..dd39074de9af 100644
--- a/arch/powerpc/mm/nohash/tlb_low.S
+++ b/arch/powerpc/mm/nohash/tlb_low.S
@@ -369,7 +369,7 @@ _GLOBAL(_tlbivax_bcast)
  * extern void loadcam_entry(unsigned int index)
  *
  * Load TLBCAM[index] entry in to the L2 CAM MMU
- * Must preserve r7, r8, r9, r10 and r11
+ * Must preserve r7, r8, r9, r10, r11, r12
  */
 _GLOBAL(loadcam_entry)
 	mflr	r5
@@ -401,7 +401,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
  *
  * r3 = first entry to write
  * r4 = number of entries to write
- * r5 = temporary tlb entry
+ * r5 = temporary tlb entry (0 means no switch to AS1)
  */
 _GLOBAL(loadcam_multi)
 	mflr	r8
@@ -409,6 +409,8 @@ _GLOBAL(loadcam_multi)
 	mfmsr	r11
 	andi.	r11,r11,MSR_IS
 	bne	10f
+	mr.	r12, r5
+	beq	10f
 
 	/*
 	 * Set up temporary TLB entry that is the same as what we're
@@ -446,6 +448,8 @@ _GLOBAL(loadcam_multi)
 	/* Don't return to AS=0 if we were in AS=1 at function start */
 	andi.	r11,r11,MSR_IS
 	bne	3f
+	cmpwi	r12, 0
+	beq	3f
 
 	/* Return to AS=0 and clear the temporary entry */
 	mfmsr	r6
-- 
2.31.1

