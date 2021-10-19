Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA08432F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhJSHc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:32:56 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59985 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234532AbhJSHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:32:46 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HYQPQ23Prz9sSm;
        Tue, 19 Oct 2021 09:30:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 10x_9KnyJlTZ; Tue, 19 Oct 2021 09:30:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HYQP758jKz9sSy;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B9128B786;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ra3SWlL39iq0; Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41A308B780;
        Tue, 19 Oct 2021 09:29:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19J7Tftk3188486
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 09:29:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19J7Tf3l3188485;
        Tue, 19 Oct 2021 09:29:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 22/22] powerpc: Remove CONFIG_PPC_HAVE_KUAP and CONFIG_PPC_HAVE_KUEP
Date:   Tue, 19 Oct 2021 09:29:33 +0200
Message-Id: <a3c007ad0951965199e6ab2ef1035966bc66e771.1634627931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634627931.git.christophe.leroy@csgroup.eu>
References: <cover.1634627931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634628571; l=2518; s=20211009; h=from:subject:message-id; bh=+Ag+EzR4jN80NF6HBsWjInBW4fd1lRK6plQvTBEObwc=; b=0L6eY0+OEIBUyOAvLtLb6mHjb6iQfFSGStHCP5vyNVn3284Plcny75wq7gqOOvNm5raSRfHaBKaS bBxbxjpsCmzFQIo6/terkNHlwuGaudHP+fW8ryCU570ZTsZ3sJLn
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms now have KUAP and KUEP so remove CONFIG_PPC_HAVE_KUAP
and CONFIG_PPC_HAVE_KUEP.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/Kconfig.cputype | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f3614bfd47ad..744cb201ae4d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -30,22 +30,17 @@ config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	imply PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
-	select PPC_HAVE_KUEP
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
-	select PPC_HAVE_KUEP
 	select PPC_KUEP
-	select PPC_HAVE_KUAP
 	select HAVE_ARCH_VMAP_STACK
 	select HUGETLBFS
 
@@ -55,8 +50,6 @@ config 40x
 	select PPC_UDBG_16550
 	select 4xx_SOC
 	select HAVE_PCI
-	select PPC_HAVE_KUAP
-	select PPC_HAVE_KUEP
 	select PPC_KUEP if PPC_KUAP
 
 config 44x
@@ -66,9 +59,7 @@ config 44x
 	select 4xx_SOC
 	select HAVE_PCI
 	select PHYS_64BIT
-	select PPC_HAVE_KUEP
 	select PPC_KUEP
-	select PPC_HAVE_KUAP
 
 endchoice
 
@@ -113,8 +104,6 @@ config PPC_BOOK3S_64
 	select HAVE_MOVE_PUD
 	select IRQ_WORK
 	select PPC_MM_SLICES
-	select PPC_HAVE_KUEP
-	select PPC_HAVE_KUAP
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
@@ -122,7 +111,6 @@ config PPC_BOOK3E_64
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
 	select ZONE_DMA
-	select PPC_HAVE_KUAP
 
 endchoice
 
@@ -303,7 +291,6 @@ config PPC_FSL_BOOK3E
 	select FSL_EMB_PERFMON
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
-	select PPC_HAVE_KUEP
 	select PPC_KUEP
 	default y if FSL_BOOKE
 
@@ -402,24 +389,16 @@ config PPC_RADIX_MMU_DEFAULT
 
 	  If you're unsure, say Y.
 
-config PPC_HAVE_KUEP
-	bool
-
 config PPC_KUEP
 	bool "Kernel Userspace Execution Prevention" if !40x
-	depends on PPC_HAVE_KUEP
 	default y if !40x
 	help
 	  Enable support for Kernel Userspace Execution Prevention (KUEP)
 
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

