Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598B8432F75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhJSHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:32:18 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59985 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234522AbhJSHcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:32:10 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HYQPG4fZtz9sTP;
        Tue, 19 Oct 2021 09:29:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RqsWyrroj6Hm; Tue, 19 Oct 2021 09:29:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HYQP70TlLz9sSq;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF7398B779;
        Tue, 19 Oct 2021 09:29:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CMVX_pBMUPaK; Tue, 19 Oct 2021 09:29:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12EC08B775;
        Tue, 19 Oct 2021 09:29:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19J7TcqS3188414
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 09:29:38 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19J7TcZL3188413;
        Tue, 19 Oct 2021 09:29:38 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 04/22] powerpc/book3e: Activate KUEP at all time
Date:   Tue, 19 Oct 2021 09:29:15 +0200
Message-Id: <e376b114283fb94504e2aa2de846780063252cde.1634627931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634627931.git.christophe.leroy@csgroup.eu>
References: <cover.1634627931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634628570; l=1520; s=20211009; h=from:subject:message-id; bh=zH92Uw7y5lljZgW1nS5KSi24zhEKlsa9355ulU235vo=; b=kxBAA8HvYb5ggG/5Zw1DtPorpy7BGrPCopO6DQuOtJBqlHb2m9bpJMTE3PyWy262+jzQ8x3nM1TH wykCeRAECaB8/UQHcjxXOqzO3lIjv3uwVorAw0ycY8Q2AlXAXfcS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3e,
- When using 64 bits PTE: User pages don't have the SX bit defined
so KUEP is always active.
- When using 32 bits PTE: Implement KUEP by clearing SX bit during
TLB miss for user pages. The impact is minimal and worth neither
boot time nor build time selection.

Activate it at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_fsl_booke.S   | 1 +
 arch/powerpc/platforms/Kconfig.cputype | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 0a9a0f301474..4622b50a5208 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -777,6 +777,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	andi.	r10, r11, _PAGE_USER	/* Test for _PAGE_USER */
 	slwi	r10, r12, 1
 	or	r10, r10, r12
+	rlwinm	r10, r10, 0, ~_PAGE_EXEC	/* Clear SX on user pages */
 	iseleq	r12, r12, r10
 	rlwimi	r13, r12, 0, 20, 31	/* Get RPN from PTE, merge w/ perms */
 	mtspr	SPRN_MAS3, r13
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 6f2e8a4026ff..68361ab7078d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -292,6 +292,8 @@ config PPC_FSL_BOOK3E
 	select FSL_EMB_PERFMON
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
+	select PPC_HAVE_KUEP
+	select PPC_KUEP
 	default y if FSL_BOOKE
 
 config PTE_64BIT
-- 
2.31.1

