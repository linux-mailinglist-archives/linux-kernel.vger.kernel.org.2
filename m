Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44E3F7347
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhHYK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237307AbhHYK3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:29:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF2D761052;
        Wed, 25 Aug 2021 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629887343;
        bh=fPoBNdQqhrn2rp7ggoZ8uavVmQbSm86uCIr6yA1cMbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Df6Uy0uVDKcCWtuKAilhOmpbUe5zClXJ8uqUf1WTup+f6zIiwUzJrN10O581puMWc
         rnQe24VGNq12afCMNy3B2coijxBdyRCSG/jQjW3GjxOD66wQnzITH3LRexsIGdxqNv
         J7aHnVFDpiuhQW7GpihC4TKR6g+6tgLoIi9tqjBWc4mxvSZMMannOi13s1BURsSVCb
         dnLhwaGcKfv/iau/HtgEBfXgH53heq/kx9YKQOU8aKtV2K3ZFGCkfeAZ30FDdUNHkL
         JwD3yBEp0leSY2shiT5alCr6pfzgi1WEbeaIjzogjp3v+mMAnt+D4EpLf4IUU2KkWd
         rRhF8vfEjw7xg==
Date:   Wed, 25 Aug 2021 11:28:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210825102856.GD24546@willie-the-truck>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825102044.GA3420@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:20:46AM +0100, Catalin Marinas wrote:
> Given how later we are in the -rc cycle, I suggest we revert Anshuman's
> commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID") and try to
> assess the implications in 5.15 (the patch doesn't seem to have the
> arm64 maintainers' ack anyway ;)).

I'll stick the revert (below) into kernelci now so we can get some coverage
in case it breaks something else.

Will

--->8

From e97ba0e39e486c20d8f76f3e632e4b7d933602cd Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Wed, 25 Aug 2021 11:10:07 +0100
Subject: [PATCH] Revert "arm64/mm: drop HAVE_ARCH_PFN_VALID"

This reverts commit 16c9afc776608324ca71c0bc354987bab532f51d.

Alex Bee reports a regression in 5.14 on their RK3328 SoC when
configuring the PL330 DMA controller:

 | ------------[ cut here ]------------
 | WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
 | Modules linked in: spi_rockchip(+) fuse
 | CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
 | Hardware name: Pine64 Rock64 (DT)
 | pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
 | pc : dma_map_resource+0x68/0xc0
 | lr : pl330_prep_slave_fifo+0x78/0xd0

This appears to be because dma_map_resource() is being called for a
physical address which does not correspond to a memory address yet does
have a valid 'struct page' due to the way in which the vmemmap is
constructed.

Prior to 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID"), the arm64
implementation of pfn_valid() called memblock_is_memory() to return
'false' for such regions and the DMA mapping request would proceed.
However, now that we are using the generic implementation where only the
presence of the memory map entry is considered, we return 'true' and
erroneously fail with DMA_MAPPING_ERROR because we identify the region
as DRAM.

Although fixing this in the DMA mapping code is arguably the right fix,
it is a risky, cross-architecture change at this stage in the cycle. So
just revert arm64 back to its old pfn_valid() implementation for v5.14.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Alex Bee <knaerzche@gmail.com>
Link: https://lore.kernel.org/r/d3a3c828-b777-faf8-e901-904995688437@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/page.h |  1 +
 arch/arm64/mm/init.c          | 37 +++++++++++++++++++++++++++++++++++
 include/linux/mmzone.h        |  9 ---------
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fdcd54d39c1e..62c3c1d2190f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -156,6 +156,7 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..f98c91bbd7c1 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -41,6 +41,7 @@ void tag_clear_highpage(struct page *to);
 
 typedef struct page *pgtable_t;
 
+int pfn_valid(unsigned long pfn);
 int pfn_is_map_memory(unsigned long pfn);
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8490ed2917ff..1fdb7bb7c198 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -219,6 +219,43 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
+int pfn_valid(unsigned long pfn)
+{
+	phys_addr_t addr = PFN_PHYS(pfn);
+	struct mem_section *ms;
+
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (PHYS_PFN(addr) != pfn)
+		return 0;
+
+	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+		return 0;
+
+	ms = __pfn_to_section(pfn);
+	if (!valid_section(ms))
+		return 0;
+
+	/*
+	 * ZONE_DEVICE memory does not have the memblock entries.
+	 * memblock_is_map_memory() check for ZONE_DEVICE based
+	 * addresses will always fail. Even the normal hotplugged
+	 * memory will never have MEMBLOCK_NOMAP flag set in their
+	 * memblock entries. Skip memblock search for all non early
+	 * memory sections covering all of hotplug memory including
+	 * both normal and ZONE_DEVICE based.
+	 */
+	if (!early_section(ms))
+		return pfn_section_valid(ms, pfn);
+
+	return memblock_is_memory(addr);
+}
+EXPORT_SYMBOL(pfn_valid);
+
 int pfn_is_map_memory(unsigned long pfn)
 {
 	phys_addr_t addr = PFN_PHYS(pfn);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..ee70f21a79d5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1463,15 +1463,6 @@ static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
 
-	/*
-	 * Ensure the upper PAGE_SHIFT bits are clear in the
-	 * pfn. Else it might lead to false positives when
-	 * some of the upper bits are set, but the lower bits
-	 * match a valid pfn.
-	 */
-	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
-		return 0;
-
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __nr_to_section(pfn_to_section_nr(pfn));
-- 
2.33.0.rc2.250.ged5fa647cd-goog

