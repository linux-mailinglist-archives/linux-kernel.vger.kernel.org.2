Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA143A61E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhJYVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:52:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42243 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhJYVwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:52:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4HdTBQ1P18z9s2Q;
        Mon, 25 Oct 2021 23:49:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ERZg5QPJs17B; Mon, 25 Oct 2021 23:49:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by pegase1.c-s.fr (Postfix) with ESMTPS id 4HdTBP446tz9s2M;
        Mon, 25 Oct 2021 23:49:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19PLnAIr007255
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 23:49:12 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19PLiYEt007030;
        Mon, 25 Oct 2021 23:44:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 06/10] powerpc/fsl_booke: Enable reloading of TLBCAM without switching to AS1
Date:   Mon, 25 Oct 2021 23:44:18 +0200
Message-Id: <f39cf3f4c8aaae7e3bfabdbb568bca2f92ad763b.1635198209.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
References: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635198260; l=1802; s=20211009; h=from:subject:message-id; bh=uamvXOC8yjHDz3KhY1xpnVSjjrkZsEuJGoVWxGyoTu4=; b=nQbQAhxVgq9euHMpoCWhP4YXrv6S0gunzsgh6klrZYKm6npTe4fFe4Xi4om1blbDX95i8PP+fufz z2OL4TFiC1dfjtrTl3QAFqK76ZhMc8tq33RZZzVx+7KWM6ZY/7j5
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
v3: No change
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

