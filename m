Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085DF44DF39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 01:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhKLAkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 19:40:33 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50067 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233817AbhKLAka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 19:40:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 726E85806AA;
        Thu, 11 Nov 2021 19:37:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Nov 2021 19:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Amj+GKg1xaYB+qEwrWqLPDdzpoi6vZrivMpCmLbM3NY=; b=Y5EuWWjg
        ZuahwLuVtuHlygEHy2d7GMVO6b7gaob0CdMiuMPO/nbnt0jNBj06IGVFlM3dEoMb
        6OPc/Q5ALXN1qYU8ZOJiWt1dA5saFSUMZsegrfoggXAdc/Cb+j3625rezL4+9YR+
        G7c7ihlj/mwuIWf61bwZvbbmG0JQ2kaOc+fycXsZuWXCb2IbdTwHmZK8b+84hHYI
        blL30eTX6+rHE7+VTlknot+8hnDgMIjiINOVNGC9qK54Wz6GJqCJ0HCY8rzp4dFv
        RFwUMiuHEM+YfEyxBJX0xGt6BOjHlITiMFD4e+uQEbH7F0XkMKTbOBzwGS6be/Ph
        sf6t3LJ7njNOLA==
X-ME-Sender: <xms:U7eNYR10pKHCAgAsvtjmWg0y7lVj5swmTrKNrXr8U8DzCsLB_Vpdng>
    <xme:U7eNYYGaCQx3Eh82V1MysuSbnlKTlhJy__NGht2ER7GJ2-gC0EIRkZXQ0nLDAatOh
    UX1m2dM4TMawaPNBDk>
X-ME-Received: <xmr:U7eNYR4HMwWkRDzCSX2a_ZOIE_Yv3N6vSAnH3bVjQ7MNE-LuVPTU_bNsZ_RSk0Do_WHQHAMF6fYYjv1ydoNl05Ic21DplnnVMQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:U7eNYe1nqudRxPxEnsoMLBrOiqL3H-AToKbPZ7f-EWGyw6x1RvHv5A>
    <xmx:U7eNYUHyrE2nXlGi4QExHsR4PeoNfpGC7um-5kGk9W3WsCS3o3gbDg>
    <xmx:U7eNYf8nHKfIMX8oUXx5zZZQhZMqplTR9zQRgaKhKy3_XP9Oo0AH4Q>
    <xmx:VLeNYQgsH2uAuHU6vU73OiyfJXUDm0kENCDA2ducGqM9x5fkYk9UIA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 19:37:36 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Mike Rapoport" <rppt@kernel.org>, "Sam Creasey" <sammy@sammy.net>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <1a89fd7d58f22e4817cf5bb406cc191dc0bc9325.1636677401.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Enable memtest functionality
Date:   Fri, 12 Nov 2021 11:36:41 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the memtest functionality and rearrange some code to prevent it
from clobbering the initrd.

The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
on Sun 3.

The SLIME source code at
http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
indicates that no BI_RAMDISK entry is ever passed to the kernel due
to #ifdef 0 around the relevant code.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Are there any other Linux bootloaders on Sun 3?
---
Changed since v1:
 - Updated documentation.
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/m68k/Kconfig                               |  1 +
 arch/m68k/kernel/setup_mm.c                     | 15 ++++++---------
 arch/m68k/mm/motorola.c                         |  2 ++
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..ac42b421a95c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2924,7 +2924,7 @@
 			both parameters are enabled, hugetlb_free_vmemmap takes
 			precedence over memory_hotplug.memmap_on_memory.
 
-	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
+	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
 			Specifies the number of memtest passes to be
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

