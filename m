Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3433922B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhCLPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhCLPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:46:41 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7628C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:46:40 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f9e2:c536:b8cc:fbbc])
        by laurent.telenet-ops.be with bizsmtp
        id fTmc2400D1ACAb301Tmcmh; Fri, 12 Mar 2021 16:46:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lKjzn-0079iK-SM; Fri, 12 Mar 2021 16:46:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lKjzn-00ErPJ-8j; Fri, 12 Mar 2021 16:46:35 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] RISC-V: Fix out-of-bounds accesses in init_resources()
Date:   Fri, 12 Mar 2021 16:46:34 +0100
Message-Id: <20210312154634.3541844-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_resources() allocates an array of resources, based on the current
total number of memory regions and reserved memory regions.  However,
allocating this array using memblock_alloc() might increase the number
of reserved memory regions.  If that happens, populating the array later
based on the new number of regions will cause out-of-bounds writes
beyond the end of the allocated array.

Fix this by allocating one more entry, which may or may not be used.

Fixes: 797f0375dd2ef5cd ("RISC-V: Do not allocate memblock while iterating reserved memblocks")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on vexriscv, which works now using L1_CACHE_SHIFT = 6, too.

This issue may show up during early boot as:

    Unable to handle kernel paging request at virtual address c8000008
    Oops [#1]
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.11.0-orangecrab-00023-g7c4fc8e3e982-dirty #137
    epc: c04d6660 ra : c04d6560 sp : c05ddf70
     gp : c0678bc0 tp : c05e5b40 t0 : c8000000
     t1 : 00030000 t2 : ffffffff s0 : c05ddfc0
     s1 : c8000000 a0 : 00000000 a1 : c7ffffe0
     a2 : 00000005 a3 : 00000001 a4 : 0000000c
     a5 : 00000000 a6 : c04fe000 a7 : 0000000c
     s2 : c04fe098 s3 : 000000a0 s4 : c7ffff60
     s5 : c04fe0dc s6 : 80000200 s7 : c059f1d4
     s8 : 81000200 s9 : c059f1f0 s10: 80000200
     s11: c059f1d4 t3 : 405dbb60 t4 : c05e6f08
     t5 : 81000200 t6 : 40501000
    status: 00000100 badaddr: c8000008 cause: 0000000f
    random: get_random_bytes called from print_oops_end_marker+0x38/0x7c with crng_init=0
    ---[ end trace 0000000000000000 ]---

or much later as:

    Unable to handle kernel paging request at virtual address 69726573
---
 arch/riscv/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index e85bacff1b5075ee..f8f15332caa20263 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -147,7 +147,8 @@ static void __init init_resources(void)
 	bss_res.end = __pa_symbol(__bss_stop) - 1;
 	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
+	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
+	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
 	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
 	if (!mem_res)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
-- 
2.25.1

