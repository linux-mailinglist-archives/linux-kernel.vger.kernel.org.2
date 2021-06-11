Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035BD3A494B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFKTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:10:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46586 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhFKTKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:10:55 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G1r3q3MQhzB9x0;
        Fri, 11 Jun 2021 21:08:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iQCsyBMoYoC5; Fri, 11 Jun 2021 21:08:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G1r3q1FFwzB9ss;
        Fri, 11 Jun 2021 21:08:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B9058B850;
        Fri, 11 Jun 2021 21:08:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4JeMjUmysYVf; Fri, 11 Jun 2021 21:08:55 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF37F8B848;
        Fri, 11 Jun 2021 21:08:54 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 917FC66132; Fri, 11 Jun 2021 19:08:54 +0000 (UTC)
Message-Id: <98394503e92d6fd6d8f657e0b263b32f21cf2790.1623438478.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Display modules range in virtual memory layout
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 11 Jun 2021 19:08:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3s/32 and 8xx don't use vmalloc for modules.

Print the modules area at startup as part of the virtual memory layout:

[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffafc000..0xffffc000  : fixmap
[    0.000000]   * 0xc9000000..0xffafc000  : vmalloc & ioremap
[    0.000000]   * 0xb0000000..0xc0000000  : modules
[    0.000000] Memory: 118480K/131072K available (7152K kernel code, 2320K rwdata, 1328K rodata, 368K init, 854K bss, 12592K reserved, 0K cma-reserved)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 77fce7aa7dc5..c3b4fdda7069 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -302,6 +302,10 @@ void __init mem_init(void)
 			ioremap_bot, IOREMAP_TOP);
 	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
 		VMALLOC_START, VMALLOC_END);
+#ifdef MODULES_VADDR
+	pr_info("  * 0x%08lx..0x%08lx  : modules\n",
+		MODULES_VADDR, MODULES_END);
+#endif
 #endif /* CONFIG_PPC32 */
 }
 
-- 
2.25.0

