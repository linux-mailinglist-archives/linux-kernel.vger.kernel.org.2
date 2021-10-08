Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B3426DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbhJHPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:44:02 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50989 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243149AbhJHPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:43:54 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsq81flGz9sSq;
        Fri,  8 Oct 2021 17:41:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yfPYs5fNQr6t; Fri,  8 Oct 2021 17:41:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspy04nZz9sSr;
        Fri,  8 Oct 2021 17:40:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD9C28B790;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4-n8j_k7jG3G; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18FD68B7A7;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198FeoPj1129696
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:50 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198Feoj11129695;
        Fri, 8 Oct 2021 17:40:50 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 14/16] powerpc/kuap: Wire-up KUAP on 85xx in 32 bits mode.
Date:   Fri,  8 Oct 2021 17:40:42 +0200
Message-Id: <8492bfad1f9ea2ea3a3eb9ba6a2e478dab43d16a.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds KUAP support to 85xx in 32 bits mode.
This is done by reading the content of SPRN_MAS1 and checking
the TID at the time user pgtable is loaded.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_fsl_booke.S   | 12 ++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 0a9a0f301474..44f7271194e5 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -462,6 +462,12 @@ END_BTB_FLUSH_SECTION
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
+#ifdef CONFIG_PPC_KUAP
+	mfspr	r12, SPRN_MAS1
+	rlwinm.	r12,r12,0,0x3fff0000
+	beq	2f			/* KUAP fault */
+#endif
+
 4:
 	/* Mask of required permission bits. Note that while we
 	 * do copy ESR:ST to _PAGE_RW position as trying to write
@@ -571,6 +577,12 @@ END_BTB_FLUSH_SECTION
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
+#ifdef CONFIG_PPC_KUAP
+	mfspr	r12, SPRN_MAS1
+	rlwinm.	r12,r12,0,0x3fff0000
+	beq	2f			/* KUAP fault */
+#endif
+
 	/* Make up the required permissions for user code */
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT | _PAGE_BAP_UX
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d703fd8e2feb..4ac99614d865 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -37,6 +37,7 @@ config PPC_BOOK3S_32
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
+	select PPC_HAVE_KUAP
 
 config PPC_8xx
 	bool "Freescale 8xx"
-- 
2.31.1

