Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737C43A61D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhJYVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:52:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13363 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233362AbhJYVwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:52:00 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4HdTBP3LTVz9s2N;
        Mon, 25 Oct 2021 23:49:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Us0Emub2cGZe; Mon, 25 Oct 2021 23:49:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by pegase1.c-s.fr (Postfix) with ESMTPS id 4HdTBP0msLz9s2M;
        Mon, 25 Oct 2021 23:49:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19PLnAIp007255
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 23:49:10 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19PLiV8N007028;
        Mon, 25 Oct 2021 23:44:31 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 04/10] powerpc/fsl_booke: Rename fsl_booke.c to fsl_book3e.c
Date:   Mon, 25 Oct 2021 23:44:16 +0200
Message-Id: <0827aadc9536d1300190e5aa193aa469405ef6b4.1635198209.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
References: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635198260; l=1752; s=20211009; h=from:subject:message-id; bh=I/3YbXn1++mN0Nx34NByyUJsZSdlVPzXOK5gwalhscM=; b=ogQiCQwS2RbKYEdX44YSIK2NRNgLDfCinKAzohinmvqBgDn3PAR1bnnRR6iFQFxJ+lPb9Dip4mbd lsI+8R0iA/+9aYWpsh+dovWDK7AM9EtLiEAhXCq+9mrHWw8PSyC7
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
v3: No change
v2: No change
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

