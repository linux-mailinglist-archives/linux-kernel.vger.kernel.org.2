Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F236DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbhD1Qs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbhD1Qsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:48:51 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:48:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91bb:828d:42f8:4e5f])
        by michel.telenet-ops.be with bizsmtp
        id yGny2400d2ZBlDX06GnyTG; Wed, 28 Apr 2021 18:48:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lbnLy-0014IZ-AY; Wed, 28 Apr 2021 18:47:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lbkVD-00HLPF-Sr; Wed, 28 Apr 2021 15:45:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] riscv: Only extend kernel reservation if mapped read-only
Date:   Wed, 28 Apr 2021 15:45:17 +0200
Message-Id: <1a7660125046b94db9c6a7d62aa0ce88c8cd2f1d.1619617340.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel mapping was moved outside of the linear mapping, the
kernel memory reservation was increased, to take into account mapping
granularity.  However, this is done unconditionally, regardless of
whether the kernel memory is mapped read-only or not.

If this extension is not needed, up to 2 MiB may be lost, which has a
big impact on e.g. Canaan K210 (64-bit nommu) platforms with only 8 MiB
of RAM.

Reclaim the lost memory by only extending the reserved region when
needed, i.e. matching the conditional logic around the call to
protect_kernel_linear_mapping_text_rodata().

Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Only tested on K210 (SiPeed MAIX BiT):

    -Memory: 5852K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2340K reserved, 0K cma-reserved)
    +Memory: 5948K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2244K reserved, 0K cma-reserved)

Yes, I was lucky, as only 96 KiB was lost ;-)
---
 arch/riscv/mm/init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 788eb222deacf994..3439783f26abc488 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -136,11 +136,17 @@ void __init setup_bootmem(void)
 
 	/*
 	 * Reserve from the start of the kernel to the end of the kernel
-	 * and make sure we align the reservation on PMD_SIZE since we will
+	 */
+#if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_64BIT) && \
+    defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
+	/*
+	 * Make sure we align the reservation on PMD_SIZE since we will
 	 * map the kernel in the linear mapping as read-only: we do not want
 	 * any allocation to happen between _end and the next pmd aligned page.
 	 */
-	memblock_reserve(vmlinux_start, (vmlinux_end - vmlinux_start + PMD_SIZE - 1) & PMD_MASK);
+	vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
+#endif
+	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
-- 
2.25.1

