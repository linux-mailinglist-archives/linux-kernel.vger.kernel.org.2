Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B270E44CEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhKKBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:15:28 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54253 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhKKBP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:15:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B794F2B016A9;
        Wed, 10 Nov 2021 20:12:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 20:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gzBopdKcSAuOB8C+OTK/rUbW4nSHcYhlAOpsPtq26FU=; b=HeP3Sa7n
        6Rcn/CUSdLeUx2Z6uVIDrEkdRpKkGhJ97J+tGqTz5BS//IUj3Yefq2puJesm9ECm
        mcgJV9WVHcJp8PUP54CXewmz5xf2jS9F0+9kGy3ScADwh1GQssoiM7SZnt7ucoVx
        +qEjOFEEIn3BwHAMBbj5xGoX7xO6D6jyYqNIGrrgNBYSP/Blojjuu9HRJiOtTI+8
        SnEKPWrBHYOT6NhNY1m23MRBWc9Jx2JrV3N/7TlCBe4T38cz+KdOW82Aa7uqGZj8
        G28bGYkbhHS6jZ+QB8Fjq65mG9ChMhQ/KSghrVTICNdD7jQgOdqDqOFmNG/QE5/d
        OdjvUTgfu27qJA==
X-ME-Sender: <xms:BW6MYcOCqOQW1H_FMtDGuQWBeDDVxpXMbff8oF6UTKKnLHnB-MQOEw>
    <xme:BW6MYS_79K5gFAXdQlr1dfvE1tbo2FThqy2S4F-LgTaD5XsqcLzrS1jQDAEMAdcEM
    DjzpDwrZKGo154BCHk>
X-ME-Received: <xmr:BW6MYTSFr-A8cDnQ9iptnXOF9P4xbVUU-7fLj_tyNY6-YcWsQ9bwrgs2CXmrAzB3lW_EGRThgiTcV45xOCBAQya940FdUjxyut8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:BW6MYUvbO4U_0V_Tr_YOAIuB8nShZr2XCrvTBfYW8Lvk1_F1nY4AiQ>
    <xmx:BW6MYUeF6fDVV1Yv7B80WWuszJnRldeRJcVm2tYeUttnHOgeZ5qzbA>
    <xmx:BW6MYY0lhlG7J2BYZ7PEkDv5jr2P-7q46795PArIY2X2QTDiWliIyQ>
    <xmx:BW6MYVpU7zDW8sfEllsHaFGJLt54PaYLngHBQG62_pUO9PwlCymypF0ZAHw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 20:12:34 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Mike Rapoport" <rppt@kernel.org>, "Sam Creasey" <sammy@sammy.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <a57524fe38123ea17a6741cdc282f6c84c30a009.1636593047.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Enable memtest kernel parameter
Date:   Thu, 11 Nov 2021 12:10:47 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the memtest feature and rearrange some code to prevent it from
clobbering the initrd.

The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
on Sun 3.

The SLIME source code at http://sammy.net/ shows that no BI_RAMDISK entry
is ever passed to the kernel due to #ifdef 0 around the relevant code.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sam Creasey <sammy@sammy.net>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Are there any other Linux bootloaders on Sun 3?
---
 arch/m68k/Kconfig           |  1 +
 arch/m68k/kernel/setup_mm.c | 15 ++++++---------
 arch/m68k/mm/motorola.c     |  2 ++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 0b50da08a9c5..0e96066b3c46 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -9,6 +9,7 @@ config M68K
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select ARCH_USE_MEMTEST
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 4b51bfd38e5f..49e573b94326 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -338,13 +338,6 @@ void __init setup_arch(char **cmdline_p)
 		panic("No configuration setup");
 	}
 
-	paging_init();
-
-#ifdef CONFIG_NATFEAT
-	nf_init();
-#endif
-
-#ifndef CONFIG_SUN3
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (m68k_ramdisk.size) {
 		memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
@@ -354,6 +347,12 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
+	paging_init();
+
+#ifdef CONFIG_NATFEAT
+	nf_init();
+#endif
+
 #ifdef CONFIG_ATARI
 	if (MACH_IS_ATARI)
 		atari_stram_reserve_pages((void *)availmem);
@@ -364,8 +363,6 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-#endif /* !CONFIG_SUN3 */
-
 /* set ISA defs early as possible */
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 	if (MACH_IS_Q40) {
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 9f3f77785aa7..5b6575eb6d02 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -455,6 +455,8 @@ void __init paging_init(void)
 
 	flush_tlb_all();
 
+	early_memtest(min_addr, max_addr);
+
 	/*
 	 * initialize the bad page table and bad page to point
 	 * to a couple of allocated pages
-- 
2.26.3

