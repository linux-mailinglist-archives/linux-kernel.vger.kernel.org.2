Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9710945EE41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377678AbhKZMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:46:02 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:52117 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235185AbhKZMoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:44:02 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0vVR6Fksz9sSM;
        Fri, 26 Nov 2021 13:40:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q6fGhm_M0oOy; Fri, 26 Nov 2021 13:40:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0vVR5FPYz9sRt;
        Fri, 26 Nov 2021 13:40:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A01F08B77D;
        Fri, 26 Nov 2021 13:40:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zLliDJAzAMvt; Fri, 26 Nov 2021 13:40:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52C618B763;
        Fri, 26 Nov 2021 13:40:47 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1AQCebcK518739
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 13:40:37 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1AQCeZWX518712;
        Fri, 26 Nov 2021 13:40:35 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32s: Allocate one 256k IBAT instead of two consecutives 128k IBATs
Date:   Fri, 26 Nov 2021 13:40:35 +0100
Message-Id: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1637930434; l=2524; s=20211009; h=from:subject:message-id; bh=iZX5KDjRSG9keLKYeWXaDkEzsljIu8vWVO5ORJ5LHiM=; b=iNeljMTDjgTn9C8NMyoj/XEQuWHYs06mT/M7ralRR+J+0tItjj0tb55ZthTxA4eJKxE6GOLjXE+f g79rV3bGAPD+joNQExQ0Co4qtBW0qUa+G3IxEnj+xklJFLOeQJTW
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we have the following IBATs allocated:

	---[ Instruction Block Address Translation ]---
	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
	4: 0xc0780000-0xc079ffff 0x00780000       128K Kernel   x     m
	5: 0xc07a0000-0xc07bffff 0x007a0000       128K Kernel   x     m
	6:         -
	7:         -

The two 128K should be a single 256K instead.

When _etext is not aligned to 128Kbytes, the system will allocate
all necessary BATs to the lower 128Kbytes boundary, then allocate
an additional 128Kbytes BAT for the remaining block.

Instead, align the top to 128Kbytes so that the function directly
allocates a 256Mbytes last block:

	---[ Instruction Block Address Translation ]---
	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
	4: 0xc0780000-0xc07bffff 0x00780000       256K Kernel   x     m
	5:         -
	6:         -
	7:         -

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 27061583a010..33ab63d56435 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -196,18 +196,17 @@ void mmu_mark_initmem_nx(void)
 	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
 	int i;
 	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
-	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long top = ALIGN((unsigned long)_etext - PAGE_OFFSET, SZ_128K);
 	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
 	unsigned long size;
 
-	for (i = 0; i < nb - 1 && base < top && top - base > (128 << 10);) {
+	for (i = 0; i < nb - 1 && base < top;) {
 		size = block_size(base, top);
 		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
 		base += size;
 	}
 	if (base < top) {
 		size = block_size(base, top);
-		size = max(size, 128UL << 10);
 		if ((top - base) > size) {
 			size <<= 1;
 			if (strict_kernel_rwx_enabled() && base + size > border)
-- 
2.33.1

