Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B533CD4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhGSLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236641AbhGSLvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 754CF6112D;
        Mon, 19 Jul 2021 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626697910;
        bh=Ug/r2feAaGIb6+QokAtRbFiyhRVvC2vbMd393hUZuo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LaYcA2Zfi+afZ03bxatVFUeBhnW1jD0S60oUgq/xTMQsYlwFW3B/lekOhMyrobYmA
         yM7m+pDYEWDjEs/xjdca6gf1T09fXzO1ACWpWXhdJ2P/F+gjgdZG/GYH4cTRW9N2Jr
         iO5KgugNXKpGl/gNeLc80keRZ5kHuNHkf56U5OaEeJzoLoRx3kE2u0A3T7IXRdxYKw
         B7O9q1HU0BKAje/160E01TuLKmzBiHhzx0onvIMbStVtKRlkULFpoS00wD137RILid
         jEpJRqCZExnam+C+/HjFLuKbClPlA50km768M0uxZIXSsnv18dE46ICGYHjmCd5ouk
         LCzUTPvDx970w==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/5] swiotlb: Point io_default_tlb_mem at static allocation
Date:   Mon, 19 Jul 2021 13:30:51 +0100
Message-Id: <20210719123054.6844-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719123054.6844-1-will@kernel.org>
References: <20210719123054.6844-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the
swiotlb pool used"), 'struct device' may hold a copy of the global
'io_default_tlb_mem' pointer if the device is using swiotlb for DMA. A
subsequent call to swiotlb_exit() will therefore leave dangling pointers
behind in these device structures, resulting in KASAN splats such as:

  |  BUG: KASAN: use-after-free in __iommu_dma_unmap_swiotlb+0x64/0xb0
  |  Read of size 8 at addr ffff8881d7830000 by task swapper/0/0
  |
  |  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc3-debug #1
  |  Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
  |  Call Trace:
  |   <IRQ>
  |   dump_stack+0x9c/0xcf
  |   print_address_description.constprop.0+0x18/0x130
  |   kasan_report.cold+0x7f/0x111
  |   __iommu_dma_unmap_swiotlb+0x64/0xb0
  |   nvme_pci_complete_rq+0x73/0x130
  |   blk_complete_reqs+0x6f/0x80
  |   __do_softirq+0xfc/0x3be

Point 'io_default_tlb_mem' at a static structure, so that the per-device
pointers remain valid after swiotlb_exit() has been invoked. The 'slots'
array is still allocated dynamically and referenced via a pointer rather
than a flexible array member.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Fixes: 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/swiotlb.h |  2 +-
 kernel/dma/swiotlb.c    | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 39284ff2a6cd..d3b617c19045 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -103,7 +103,7 @@ struct io_tlb_mem {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
 		unsigned int list;
-	} slots[];
+	} *slots;
 };
 extern struct io_tlb_mem *io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1a9ae7fad8f..992d73cdc944 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -71,6 +71,7 @@
 enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem *io_tlb_default_mem;
+static struct io_tlb_mem _io_tlb_default_mem;
 
 /*
  * Max segment that we can provide which (if pages are contingous) will
@@ -201,7 +202,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 {
-	struct io_tlb_mem *mem;
+	struct io_tlb_mem *mem = &_io_tlb_default_mem;
 	size_t alloc_size;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -211,9 +212,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
 
-	alloc_size = PAGE_ALIGN(struct_size(mem, slots, nslabs));
-	mem = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!mem)
+	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
+	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!mem->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
@@ -304,7 +305,7 @@ swiotlb_late_init_with_default_size(size_t default_size)
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
-	struct io_tlb_mem *mem;
+	struct io_tlb_mem *mem = &_io_tlb_default_mem;
 	unsigned long bytes = nslabs << IO_TLB_SHIFT;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -314,12 +315,11 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (WARN_ON_ONCE(io_tlb_default_mem))
 		return -ENOMEM;
 
-	mem = (void *)__get_free_pages(GFP_KERNEL,
-		get_order(struct_size(mem, slots, nslabs)));
-	if (!mem)
+	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+		get_order(array_size(sizeof(*mem->slots), nslabs)));
+	if (!mem->slots)
 		return -ENOMEM;
 
-	memset(mem, 0, sizeof(*mem));
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
@@ -337,12 +337,13 @@ void __init swiotlb_exit(void)
 	if (!mem)
 		return;
 
-	size = struct_size(mem, slots, mem->nslabs);
+	size = array_size(sizeof(*mem->slots), mem->nslabs);
 	if (mem->late_alloc)
-		free_pages((unsigned long)mem, get_order(size));
+		free_pages((unsigned long)mem->slots, get_order(size));
 	else
-		memblock_free_late(__pa(mem), PAGE_ALIGN(size));
+		memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
 	io_tlb_default_mem = NULL;
+	memset(mem, 0, sizeof(*mem));
 }
 
 /*
@@ -783,10 +784,17 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	 * to it.
 	 */
 	if (!mem) {
-		mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 		if (!mem)
 			return -ENOMEM;
 
+		mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
+				     GFP_KERNEL);
+		if (!mem->slots) {
+			kfree(mem);
+			return -ENOMEM;
+		}
+
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
-- 
2.32.0.402.g57bb445576-goog

