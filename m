Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2449242EE54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhJOKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:05:24 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50767 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235195AbhJOKFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:05:14 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HW1zr388Gz9sSC;
        Fri, 15 Oct 2021 12:03:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZF9y0K-j-C9i; Fri, 15 Oct 2021 12:03:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HW1zp60CGz9sSF;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3C9A8B798;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5pq2kR6hr0AA; Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.255])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41FFA8B78B;
        Fri, 15 Oct 2021 12:03:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19FA2rR52627027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 12:02:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19FA2rda2627026;
        Fri, 15 Oct 2021 12:02:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/8] powerpc/fsl_booke: Rename fsl_booke.c to fsl_book3e.c
Date:   Fri, 15 Oct 2021 12:02:43 +0200
Message-Id: <5dc871db1f67739319bec11f049ca450da1c13a2.1634292136.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
References: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634292164; l=1717; s=20211009; h=from:subject:message-id; bh=VxUAmAWD7dGzT5yvZGNANK66dD3tDSndACQ0/tIeNcQ=; b=748Q6zRrZ9almTF1W+kePb6b4iEB+r4ThQhUw/htIljGaCH/Rl46CsLrIXw+Ie1g1VENGYC5evj5 /mDV/KO7Da1VBnzr8AqZxO/asTrRh1IwjWRwj7QNex0i2CqrAIb1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a myriad of CONFIG symbols around different variants
of BOOKEs, which would be worth tidying up one day.

But at least, make file names and CONFIG option match:

We have CONFIG_FSL_BOOKE and CONFIG_PPC_FSL_BOOK3E.

fsl_booke.c is selected by and only by CONFIG_PPC_FSL_BOOK3E.
So rename it fsl_book3e to reduce confusion.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/Makefile                      | 4 ++--
 arch/powerpc/mm/nohash/{fsl_booke.c => fsl_book3e.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/mm/nohash/{fsl_booke.c => fsl_book3e.c} (100%)

diff --git a/arch/powerpc/mm/nohash/Makefile b/arch/powerpc/mm/nohash/Makefile
index 0424f6ce5bd8..b1f630d423d8 100644
--- a/arch/powerpc/mm/nohash/Makefile
+++ b/arch/powerpc/mm/nohash/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_low_64e.o book3e_pgtable.o
 obj-$(CONFIG_40x)		+= 40x.o
 obj-$(CONFIG_44x)		+= 44x.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_book3e.o
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr_booke.o
 ifdef CONFIG_HUGETLB_PAGE
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= book3e_hugetlbpage.o
@@ -16,4 +16,4 @@ endif
 # Disable kcov instrumentation on sensitive code
 # This is necessary for booting with kcov enabled on book3e machines
 KCOV_INSTRUMENT_tlb.o := n
-KCOV_INSTRUMENT_fsl_booke.o := n
+KCOV_INSTRUMENT_fsl_book3e.o := n
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_book3e.c
similarity index 100%
rename from arch/powerpc/mm/nohash/fsl_booke.c
rename to arch/powerpc/mm/nohash/fsl_book3e.c
-- 
2.31.1

