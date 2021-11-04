Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEE444D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 03:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhKDCfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 22:35:06 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:59016 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229541AbhKDCfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 22:35:02 -0400
X-UUID: b5a848c057d7456daea1530d568a627c-20211104
X-UUID: b5a848c057d7456daea1530d568a627c-20211104
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 541227360; Thu, 04 Nov 2021 10:32:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Nov 2021 10:32:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 4 Nov 2021 10:32:22 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
Date:   Thu, 4 Nov 2021 10:32:21 +0800
Message-ID: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the allocated buffers use dma coherent memory with
DMA_ATTR_NO_KERNEL_MAPPING, then its kernel mapping is exist.
The caller use that DMA_ATTR_NO_KERNEL_MAPPING mean they can't
rely on kernel mapping, but removing kernel mapping have
some improvements.

The improvements are:
a) Security improvement. In some cases, we don't hope the allocated
   buffer to be read by cpu speculative execution. Therefore, it
   need to remove kernel mapping, this patch improve
   DMA_ATTR_NO_KERNEL_MAPPING to remove a page from kernel mapping
   in order that cpu doesn't read it.
b) Debugging improvement. If the allocated buffer map into user space,
   only access it in user space, nobody can access it in kernel space,
   so we can use this patch to see who try to access it in kernel space.

This patch only works if the memory is mapping at page granularity
in the linear region, so that current only support for ARM64.

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

v2:
1. modify commit message and fix the removing mapping for arm64
2. fix build error for x86

---
 include/linux/set_memory.h |  5 +++++
 kernel/dma/direct.c        | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index f36be5166c19..6c7d1683339c 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -7,11 +7,16 @@
 
 #ifdef CONFIG_ARCH_HAS_SET_MEMORY
 #include <asm/set_memory.h>
+
+#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
+static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }
+#endif
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }
 #endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4c6c5e0635e3..d5d03b51b708 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -155,6 +155,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 	int err;
+	unsigned long kaddr;
 
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
@@ -169,6 +170,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
 		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
+			kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle));
+			/* page remove kernel mapping for arm64 */
+			set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
+		}
 		/* return the page pointer as the opaque cookie */
 		return page;
 	}
@@ -275,9 +281,16 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int page_order = get_order(size);
+	unsigned long kaddr;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
+			size = PAGE_ALIGN(size);
+			kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr));
+			/* page create kernel mapping for arm64 */
+			set_memory_valid(kaddr, size >> PAGE_SHIFT, 1);
+		}
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
-- 
2.18.0

