Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12FE42EE55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhJOKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:05:26 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50767 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhJOKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:05:18 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HW1zs0bdmz9sSF;
        Fri, 15 Oct 2021 12:03:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E0ZK-zE5vIsx; Fri, 15 Oct 2021 12:03:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HW1zp641Vz9sSH;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B58FB8B799;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HUrL_P9iqOzM; Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.255])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5401D8B790;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19FA2r5R2627035
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 12:02:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19FA2rRI2627034;
        Fri, 15 Oct 2021 12:02:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/8] powerpc/fsl_booke: Enable reloading of TLBCAM without switching to AS1
Date:   Fri, 15 Oct 2021 12:02:45 +0200
Message-Id: <a9d517fbfbc940f56103c46b323f6eb8f4485571.1634292136.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
References: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634292165; l=1767; s=20211009; h=from:subject:message-id; bh=B8r0vE6ZUiWl1za29TlPeLwngGx9iult/yrmTG7s7ic=; b=XVmXDcA/sppH+eAfCm6+oQN6vf8GtwExhQ09O/mkmZ9Bh+hev6xu/rZYjySHkkBNIio9gL+lGPaI 81btHHndDAj9wu3fAqgM0etp7tYLBfMd8Bjc1rnzTUyFmliQcLR9
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

