Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7D3A8861
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFOST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFOSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:19:51 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A9C0613A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:17:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:bda0:7de0:767e:26f9])
        by laurent.telenet-ops.be with bizsmtp
        id HWHe2500T4N5gS301WHe97; Tue, 15 Jun 2021 20:17:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd4-00HYOQ-8S; Tue, 15 Jun 2021 20:17:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ltDd3-005qAN-OS; Tue, 15 Jun 2021 20:17:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
Date:   Tue, 15 Jun 2021 20:17:26 +0200
Message-Id: <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623780059.git.geert+renesas@glider.be>
References: <cover.1623780059.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V uses platform-specific code to locate the elf core header in
memory.  However, this does not conform to the standard
"linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
with the "linux,elfcorehdr" compatible value, instead of on a
"linux,elfcorehdr" property under the "/chosen" node.

The non-compliant code can just be removed, as the standard behavior is
already implemented by platform-agnostic handling in the FDT core code.

Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/riscv/mm/init.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6fd36af52a8520b3..2c5c8a24199002a3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -839,26 +839,6 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_CRASH_DUMP
-/*
- * We keep track of the ELF core header of the crashed
- * kernel with a reserved-memory region with compatible
- * string "linux,elfcorehdr". Here we register a callback
- * to populate elfcorehdr_addr/size when this region is
- * present. Note that this region will be marked as
- * reserved once we call early_init_fdt_scan_reserved_mem()
- * later on.
- */
-static int __init elfcore_hdr_setup(struct reserved_mem *rmem)
-{
-	elfcorehdr_addr = rmem->base;
-	elfcorehdr_size = rmem->size;
-	return 0;
-}
-
-RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
-#endif
-
 void __init paging_init(void)
 {
 	setup_bootmem();
-- 
2.25.1

