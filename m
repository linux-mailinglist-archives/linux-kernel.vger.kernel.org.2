Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9794426DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbhJHPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:43:39 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:38337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243199AbhJHPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:43:15 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HQsq22QWZz9sSj;
        Fri,  8 Oct 2021 17:41:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N0zKjX-lsIpv; Fri,  8 Oct 2021 17:41:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HQspx6GWLz9sSk;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA25E8B763;
        Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bWhorp1jYWlc; Fri,  8 Oct 2021 17:40:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.75])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E874E8B799;
        Fri,  8 Oct 2021 17:40:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 198FeosT1129704
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Oct 2021 17:40:50 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 198Feox61129703;
        Fri, 8 Oct 2021 17:40:50 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/16] powerpc: Remove CONFIG_PPC_HAVE_KUAP
Date:   Fri,  8 Oct 2021 17:40:44 +0200
Message-Id: <191371e5b94077cad24809d22a07b310271fbaf1.1633707305.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633707305.git.christophe.leroy@csgroup.eu>
References: <cover.1633707305.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms now have KUAP so remove CONFIG_PPC_HAVE_KUAP

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/kup.c           |  1 -
 arch/powerpc/platforms/Kconfig.cputype | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kup.c b/arch/powerpc/mm/nohash/kup.c
index bbacbd780806..eaea52231dd6 100644
--- a/arch/powerpc/mm/nohash/kup.c
+++ b/arch/powerpc/mm/nohash/kup.c
@@ -10,7 +10,6 @@
 #include <linux/smp.h>
 
 #include <asm/kup.h>
-#include <asm/mmu.h>
 #include <asm/smp.h>
 
 #ifdef CONFIG_PPC_KUAP
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d0e52ad45d73..d0ae0d6a1384 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -31,20 +31,17 @@ config PPC_BOOK3S_32
 	imply PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
-	select PPC_HAVE_KUAP
 	select HAVE_ARCH_VMAP_STACK
 
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
-	select PPC_HAVE_KUAP
 
 config PPC_8xx
 	bool "Freescale 8xx"
 	select ARCH_SUPPORTS_HUGETLBFS
 	select FSL_SOC
 	select PPC_HAVE_KUEP
-	select PPC_HAVE_KUAP
 	select HAVE_ARCH_VMAP_STACK
 	select HUGETLBFS
 
@@ -54,7 +51,6 @@ config 40x
 	select PPC_UDBG_16550
 	select 4xx_SOC
 	select HAVE_PCI
-	select PPC_HAVE_KUAP
 
 config 44x
 	bool "AMCC 44x, 46x or 47x"
@@ -64,7 +60,6 @@ config 44x
 	select HAVE_PCI
 	select PHYS_64BIT
 	select PPC_HAVE_KUEP
-	select PPC_HAVE_KUAP
 
 endchoice
 
@@ -110,7 +105,6 @@ config PPC_BOOK3S_64
 	select IRQ_WORK
 	select PPC_MM_SLICES
 	select PPC_HAVE_KUEP
-	select PPC_HAVE_KUAP
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
@@ -118,7 +112,6 @@ config PPC_BOOK3E_64
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
 	select ZONE_DMA
-	select PPC_HAVE_KUAP
 
 endchoice
 
@@ -408,12 +401,8 @@ config PPC_KUEP
 
 	  If you're unsure, say Y.
 
-config PPC_HAVE_KUAP
-	bool
-
 config PPC_KUAP
 	bool "Kernel Userspace Access Protection"
-	depends on PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for Kernel Userspace Access Protection (KUAP)
-- 
2.31.1

