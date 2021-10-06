Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E78423E14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhJFMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:50:39 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36081 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238621AbhJFMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:50:34 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPZ4X6vRDz9sVY;
        Wed,  6 Oct 2021 14:48:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4KpPEue7jEus; Wed,  6 Oct 2021 14:48:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPZ4M4xL5z9sWH;
        Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9158E8B781;
        Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id c18w1kzNLOoe; Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA0BF8B78D;
        Wed,  6 Oct 2021 14:48:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 196ClppY579416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Oct 2021 14:47:52 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 196ChscL579291;
        Wed, 6 Oct 2021 14:43:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 11/15] powerpc/kuap: Wire-up KUAP on 44x
Date:   Wed,  6 Oct 2021 14:43:44 +0200
Message-Id: <6f7dfafe22d5d681135c7e66a39d860d3963b862.1633523837.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633523837.git.christophe.leroy@csgroup.eu>
References: <cover.1633523837.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds KUAP support to 44x. This is done by checking
the content of SPRN_PID at the time it is read and written
into SPRN_MMUCR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_44x.S         | 16 ++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 02d2928d1e01..cf92a3434acd 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -334,6 +334,10 @@ interrupt_base:
 	mfspr	r12,SPRN_MMUCR
 	mfspr   r13,SPRN_PID		/* Get PID */
 	rlwimi	r12,r13,0,24,31		/* Set TID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r13,0
+	beq	2f			/* KUAP Fault */
+#endif
 
 4:
 	mtspr	SPRN_MMUCR,r12
@@ -444,6 +448,10 @@ interrupt_base:
 	mfspr	r12,SPRN_MMUCR
 	mfspr   r13,SPRN_PID		/* Get PID */
 	rlwimi	r12,r13,0,24,31		/* Set TID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r13,0
+	beq	2f			/* KUAP Fault */
+#endif
 
 4:
 	mtspr	SPRN_MMUCR,r12
@@ -575,6 +583,10 @@ finish_tlb_load_44x:
 3:	mfspr	r11,SPRN_SPRG3
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r12,0
+	beq	2f			/* KUAP Fault */
+#endif
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Mask of required permission bits. Note that while we
@@ -672,6 +684,10 @@ finish_tlb_load_44x:
 3:	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
+#ifdef CONFIG_PPC_KUAP
+	cmpwi	r12,0
+	beq	2f			/* KUAP Fault */
+#endif
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Make up the required permissions */
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index dce1cf31047b..74e5887abbce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -62,6 +62,7 @@ config 44x
 	select HAVE_PCI
 	select PHYS_64BIT
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 
 endchoice
 
-- 
2.31.1

