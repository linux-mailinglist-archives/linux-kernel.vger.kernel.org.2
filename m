Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1650732FEF5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 06:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhCGFOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 00:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCGFOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 00:14:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 21:14:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g17so8361643ybh.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 21:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WJiB9dl71l/TjVCBFVP2J9zHhd24ZHwnIvXPdaQCFZY=;
        b=HqHsPJvrkUj5j04KeFl9vZy3iGpnxQOY3ziwzKL3IXZ31Tgju2LCRkQeqvQ0lmiXyi
         lRCQVJzgI2mLiUT5hYgXafkjlvbEQD3svPn1Z+mbUQkwcg8wj6k/sYiknIaIFpI92lWw
         zsEHMMWre7s2yCgGu2OLxnxtbYSQl63id5YTrualccELHkB+zDavmUQ3edsMYRBhmuwL
         a6R23RxggRFes6ZgDk5wO4XpU1RetJOMjOexuLM0dO8Ll6bTx8E5ljEcRMOM/axn5LKI
         1HAKnwDIOnOlFY26dfD3w6mTo/4fapDOKJswHcmT3EsUZWF9DXw9NKt4e+3ZW7/7y0Wg
         TTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WJiB9dl71l/TjVCBFVP2J9zHhd24ZHwnIvXPdaQCFZY=;
        b=sb8qeCVtx3MLMHk3UuxkL6iq1t6SFKZWzse1LmlFRs97VOSOw2RYjjQg8Iasz2H0pj
         //N+Pv9Vl0MQKyYBLcyFQ25DrqXcplE+wBlzvAK+ozhEsYXK5M5XQsuBT69W1CA1BCZf
         rnXwrm06YKZNunidjkQswV2pdXrOzANnMFDdF1RgywBjX0a+aZdb/tXjWkNpAfntwC3M
         A+k04RUAtUw9ZDYwMvkoy1VQ5uTzgZG789/x0UOqb7Etu7qxVXaYxQQqoFggT7btJ7Bl
         oF4tt3rb3tgTjR2WvjE97mX3crxNt9RaiHpz1W8v2DV0MoRYq2HdjHoIHxZRWR5jCfw+
         gO8w==
X-Gm-Message-State: AOAM531Ee1ZswTEZ5rmdW8hS+zewKGvy+Tt92wAOudvC+HMXVI1HONnw
        oVJblrrXTwqDeYS25Bs0YiI/4gALcI20
X-Google-Smtp-Source: ABdhPJzs26sD6VqREDeu5WrFROEjBQ9ktES24L7dgdDRKwum6qooTvs5F8n41hy0wHH+NLPNXhhPKOUB5unL
Sender: "maskray via sendgmr" <maskray@maskray1.svl.corp.google.com>
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:0:5cbf:1a9f:3f48:ea77])
 (user=maskray job=sendgmr) by 2002:a25:38d6:: with SMTP id
 f205mr25328159yba.448.1615094076144; Sat, 06 Mar 2021 21:14:36 -0800 (PST)
Date:   Sat,  6 Mar 2021 21:14:33 -0800
Message-Id: <20210307051433.2756645-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] Replace __toc_start + 0x8000 with .TOC.
From:   Fangrui Song <maskray@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Fangrui Song <maskray@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TOC relocations are like GOT relocations on other architectures.
However, unlike other architectures, GNU ld's ppc64 port defines .TOC.
relative to the .got output section instead of the linker synthesized
.got input section. LLD defines .TOC. as the .got input section plus
0x8000. When CONFIG_PPC_OF_BOOT_TRAMPOLINE=y,
arch/powerpc/kernel/prom_init.o is built, and LLD computed .TOC. can be
different from __toc_start defined by the linker script.

Simplify kernel_toc_addr with asm label .TOC. so that we can get rid of
__toc_start.

With this change, powernv_defconfig with CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
is bootable with LLD. There is still an untriaged issue with Alexey's
configuration.

Link: https://github.com/ClangBuiltLinux/linux/issues/1318
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/powerpc/boot/crt0.S            |  2 +-
 arch/powerpc/boot/zImage.lds.S      |  1 -
 arch/powerpc/include/asm/sections.h | 10 ++--------
 arch/powerpc/kernel/head_64.S       |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S   |  1 -
 5 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 1d83966f5ef6..e45907fe468f 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -28,7 +28,7 @@ p_etext:	.8byte	_etext
 p_bss_start:	.8byte	__bss_start
 p_end:		.8byte	_end
 
-p_toc:		.8byte	__toc_start + 0x8000 - p_base
+p_toc:		.8byte	.TOC. - p_base
 p_dyn:		.8byte	__dynamic_start - p_base
 p_rela:		.8byte	__rela_dyn_start - p_base
 p_prom:		.8byte	0
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index d6f072865627..32cf7816292f 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -39,7 +39,6 @@ SECTIONS
   . = ALIGN(256);
   .got :
   {
-    __toc_start = .;
     *(.got)
     *(.toc)
   }
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 324d7b298ec3..bd22ca0b5eca 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -48,14 +48,8 @@ static inline int in_kernel_text(unsigned long addr)
 
 static inline unsigned long kernel_toc_addr(void)
 {
-	/* Defined by the linker, see vmlinux.lds.S */
-	extern unsigned long __toc_start;
-
-	/*
-	 * The TOC register (r2) points 32kB into the TOC, so that 64kB of
-	 * the TOC can be addressed using a single machine instruction.
-	 */
-	return (unsigned long)(&__toc_start) + 0x8000UL;
+	extern unsigned long toc asm(".TOC.");
+	return (unsigned long)(&toc);
 }
 
 static inline int overlaps_interrupt_vector_text(unsigned long start,
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index ece7f97bafff..9542d03b2efe 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -899,7 +899,7 @@ _GLOBAL(relative_toc)
 	blr
 
 .balign 8
-p_toc:	.8byte	__toc_start + 0x8000 - 0b
+p_toc:	.8byte	.TOC. - 0b
 
 /*
  * This is where the main kernel code starts.
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 72fa3c00229a..c28f4e5bae3f 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -328,7 +328,6 @@ SECTIONS
 
 	. = ALIGN(256);
 	.got : AT(ADDR(.got) - LOAD_OFFSET) {
-		__toc_start = .;
 #ifndef CONFIG_RELOCATABLE
 		__prom_init_toc_start = .;
 		arch/powerpc/kernel/prom_init.o*(.toc .got)
-- 
2.30.1.766.gb4fecdf3b7-goog

