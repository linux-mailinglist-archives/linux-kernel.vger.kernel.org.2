Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D084565BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhKRWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:34:57 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40439 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhKRWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:34:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9B54B2B011A3;
        Thu, 18 Nov 2021 17:31:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 18 Nov 2021 17:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EgttxCz67NcGqBysOvfjKjCJjUrua2/KraxC4XRjMOo=; b=MIvEX0Uw
        CHwc8/1iR65sKpJadsaYNFN3tJsJphfdn2z17p73TeiyDaJU6YdAqNYEB5EdjrBH
        WC7YHhV9oJFxmj03KIYsT5grO9Vy6c09y2Jno24SChu7o7fnKhbA4P4aTcvDFY6w
        PMWk6E9OxDcS/Jt15yovQlDljvNdJMx8BxX1aNAwQfiQNP7rLNo2EoX+4fmBD5JG
        bmziiQYeUffo48o712hQasV3Y/YU3NfW7vsiS3r9vl3lEDLMZHlF28KLgh3Vg6aZ
        Nf2rCQBAwcik/qWBZeAqhZDFZZXMgnQMAfVkfB7k0amCX3QfAY9r3+VNRoHB2XFc
        z1VvyhOCVlsFAg==
X-ME-Sender: <xms:WtSWYdXLpil2AjAeZlsHq7OdZZb_y4dMiY88UjrIm0Ij-js4t0ou3w>
    <xme:WtSWYdlDeH1hkl7U2fWdxHgTHSBC8fEMCgOY_PhIcfzZt3bLtvSJw3z9JFLNssbUK
    CRA6JXRWB6h_IFWKMk>
X-ME-Received: <xmr:WtSWYZYxlipmCY7YEpXnXAsdvBARFR44UJ5yrEl3WUwLcGjZjByAv2kLLZaIOP8OtYjnJHsSIFi2yFhwYIGeS6Wh9Oq_d_saNUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeigdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gohfhorhgsihguuggvnhfjughrucdlhedttddmnecujfgurhepvffkhffuffestddtredt
    tddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmh
    eikehkrdhorhhgqeenucfhohhrsghiugguvghnjfgurhepvffkhffuffestddtredttddt
    pdfvkffhufffsedttdertddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:WtSWYQVNqyHU2m8QhyJipMxzeFT8A-anjgcnvBiexeWR5JgKlYoPnA>
    <xmx:WtSWYXkNAtDM3whEUvHz8M_zr24WtK0gp1lm6ix07LO1_BrSU994TQ>
    <xmx:WtSWYdcObUNCRdi522esKtha7wc0BGGpnwDVy_cdJfyWUNARow-SKA>
    <xmx:WtSWYQDN26_AQMZij2_cnLlg0XMh8xmHcisxLizMroVCoA9wV1hP9jwdsCI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 17:31:52 -0500 (EST)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Mike Rapoport" <rppt@kernel.org>, "Sam Creasey" <sammy@sammy.net>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <8170fe1d1c62426d82275d36ba409ecc18754292.1637274578.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3] m68k: Enable memtest functionality
Date:   Fri, 19 Nov 2021 09:29:38 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the memtest functionality and rearrange some code to prevent it
from clobbering the initrd.

The code to implement CONFIG_BLK_DEV_INITRD was conditional on
!defined(CONFIG_SUN3). For simplicity, remove that test on the basis
that m68k_ramdisk.size == 0 on Sun 3. The SLIME source code at
http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
indicates that no BI_RAMDISK entry is ever passed to the kernel due
to #ifdef 0 around the relevant code.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Is SLIME the only Linux bootloader on Sun 3?
---
Changed since v2:
 - Made conditional on MMU_MOTOROLA.

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
index 0b50da08a9c5..4cae3fbe7f97 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -9,6 +9,7 @@ config M68K
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select ARCH_USE_MEMTEST if MMU_MOTOROLA
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

