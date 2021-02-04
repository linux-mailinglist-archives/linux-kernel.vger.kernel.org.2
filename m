Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA07C30ECE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhBDHCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:02:23 -0500
Received: from foss.arm.com ([217.140.110.172]:52886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBDHCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:02:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A8BB1424;
        Wed,  3 Feb 2021 23:01:20 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C50F03F694;
        Wed,  3 Feb 2021 23:01:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/3] dma-contiguous: Type cast MAX_ORDER as unsigned int
Date:   Thu,  4 Feb 2021 12:31:24 +0530
Message-Id: <1612422084-30429-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type cast MAX_ORDER as unsigned int to fix the following build warning.

In file included from ./include/linux/kernel.h:14,
                 from ./include/asm-generic/bug.h:20,
                 from ./arch/arm64/include/asm/bug.h:26,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./arch/arm64/include/asm/memory.h:166,
                 from ./arch/arm64/include/asm/page.h:42,
                 from kernel/dma/contiguous.c:46:
kernel/dma/contiguous.c: In function ‘rmem_cma_setup’:
./include/linux/minmax.h:18:28: warning: comparison of distinct pointer
types lacks a cast
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                            ^~
./include/linux/minmax.h:32:4: note: in expansion of macro ‘__typecheck’
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
./include/linux/minmax.h:42:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
./include/linux/minmax.h:58:19: note: in expansion of macro
‘__careful_cmp’
 #define max(x, y) __careful_cmp(x, y, >)
                   ^~~~~~~~~~~~~
kernel/dma/contiguous.c:402:35: note: in expansion of macro ‘max’
  phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..1c2782349d71 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -399,7 +399,7 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
+	phys_addr_t align = PAGE_SIZE << max((unsigned int)MAX_ORDER - 1, pageblock_order);
 	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
-- 
2.20.1

