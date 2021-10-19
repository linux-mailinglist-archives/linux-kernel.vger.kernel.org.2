Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B1432F88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhJSHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:33:15 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59985 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234657AbhJSHdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:33:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HYQPV6VgVz9sT4;
        Tue, 19 Oct 2021 09:30:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6LHzAt-LvNqp; Tue, 19 Oct 2021 09:30:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HYQP76RYGz9sT0;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D18658B763;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5_z4v8vwDS9Z; Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D8A58B77A;
        Tue, 19 Oct 2021 09:29:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19J7TclS3188410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 09:29:38 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19J7TcPf3188409;
        Tue, 19 Oct 2021 09:29:38 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 03/22] powerpc/44x: Activate KUEP at all time
Date:   Tue, 19 Oct 2021 09:29:14 +0200
Message-Id: <2414d662558e7fb27d1ed41c8e47c591d576acac.1634627931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634627931.git.christophe.leroy@csgroup.eu>
References: <cover.1634627931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634628570; l=3213; s=20211009; h=from:subject:message-id; bh=CHeK/4pYoKgYF7fUsv1kePoZfCf4ohaJ7FMdv+sEVNk=; b=MDPmkVZBST3mJxlVlXdkoBJFAb/sSSr7f7xqx6FyyWpudI4s6IXayeuicFxjCv7qhJaGZw+gpcXR 2EUoeUXlAfHmlPpvXCZDzehHPI2lrLB5GI5BSGAC8+SmTS8nPUTI
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 44x, KUEP is implemented by clearing SX bit during TLB miss
for user pages. The impact is minimal and not worth neither
boot time nor build time selection.

Activate it at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 -
 arch/powerpc/kernel/head_44x.S               | 10 ++--------
 arch/powerpc/mm/nohash/44x.c                 |  8 +-------
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
index 43ceca128531..2d92a39d8f2e 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
@@ -113,7 +113,6 @@ typedef struct {
 
 /* patch sites */
 extern s32 patch__tlb_44x_hwater_D, patch__tlb_44x_hwater_I;
-extern s32 patch__tlb_44x_kuep, patch__tlb_47x_kuep;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 02d2928d1e01..916f7e91c6de 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -532,10 +532,7 @@ finish_tlb_load_44x:
 	andi.	r10,r12,_PAGE_USER		/* User page ? */
 	beq	1f				/* nope, leave U bits empty */
 	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
-#ifdef CONFIG_PPC_KUEP
-0:	rlwinm	r11,r11,0,~PPC44x_TLB_SX	/* Clear SX if User page */
-	patch_site 0b, patch__tlb_44x_kuep
-#endif
+	rlwinm	r11,r11,0,~PPC44x_TLB_SX	/* Clear SX if User page */
 1:	tlbwe	r11,r13,PPC44x_TLB_ATTRIB	/* Write ATTRIB */
 
 	/* Done...restore registers and get out of here.
@@ -747,10 +744,7 @@ finish_tlb_load_47x:
 	andi.	r10,r12,_PAGE_USER		/* User page ? */
 	beq	1f				/* nope, leave U bits empty */
 	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
-#ifdef CONFIG_PPC_KUEP
-0:	rlwinm	r11,r11,0,~PPC47x_TLB2_SX	/* Clear SX if User page */
-	patch_site 0b, patch__tlb_47x_kuep
-#endif
+	rlwinm	r11,r11,0,~PPC47x_TLB2_SX	/* Clear SX if User page */
 1:	tlbwe	r11,r13,2
 
 	/* Done...restore registers and get out of here.
diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
index e079f26b267e..ceb290df1fb5 100644
--- a/arch/powerpc/mm/nohash/44x.c
+++ b/arch/powerpc/mm/nohash/44x.c
@@ -247,12 +247,6 @@ void setup_kuep(bool disabled)
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-	if (disabled)
-		patch_instruction_site(&patch__tlb_44x_kuep, ppc_inst(PPC_RAW_NOP()));
-	else
-		pr_info("Activating Kernel Userspace Execution Prevention\n");
-
-	if (IS_ENABLED(CONFIG_PPC_47x) && disabled)
-		patch_instruction_site(&patch__tlb_47x_kuep, ppc_inst(PPC_RAW_NOP()));
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
 }
 #endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 66650ec1c7e6..6f2e8a4026ff 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -63,6 +63,7 @@ config 44x
 	select HAVE_PCI
 	select PHYS_64BIT
 	select PPC_HAVE_KUEP
+	select PPC_KUEP
 
 endchoice
 
-- 
2.31.1

