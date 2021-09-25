Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5357418206
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbhIYMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:48:20 -0400
Received: from mx22.baidu.com ([220.181.50.185]:40300 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244971AbhIYMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:48:19 -0400
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
        by Forcepoint Email with ESMTPS id 35F7190114D56D35C58B;
        Sat, 25 Sep 2021 20:46:43 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 25 Sep 2021 20:46:43 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 20:46:42 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] parisc: Fix function names in print messages and coments
Date:   Sat, 25 Sep 2021 20:46:36 +0800
Message-ID: <20210925124637.303-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_xxx_xxx() instead of pci_xxx_xxx(),
because the pci function wrappers are not called here.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/parisc/ccio-dma.c  | 22 +++++++++++-----------
 drivers/parisc/sba_iommu.c |  8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 059566f54429..c212db3351dd 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -480,7 +480,7 @@ typedef unsigned long space_t;
 ** o if SAFE_DMA isn't set, mapping is for FAST_DMA. SAFE_DMA should be
 **   set for subcacheline DMA transfers since we don't want to damage the
 **   other part of a cacheline.
-** o SAFE_DMA must be set for "memory" allocated via pci_alloc_consistent().
+** o SAFE_DMA must be set for "memory" allocated via dma_alloc_coherent().
 **   This bit tells U2 to do R/M/W for partial cachelines. "Streaming"
 **   data can avoid this if the mapping covers full cache lines.
 ** o STOP_MOST is needed for atomicity across cachelines.
@@ -502,7 +502,7 @@ typedef unsigned long space_t;
 **    be much more careful with this.
 */
 #define IOPDIR_VALID    0x01UL
-#define HINT_SAFE_DMA   0x02UL	/* used for pci_alloc_consistent() pages */
+#define HINT_SAFE_DMA   0x02UL	/* used for dma_alloc_coherent() pages */
 #ifdef CONFIG_EISA
 #define HINT_STOP_MOST  0x04UL	/* LSL support */
 #else
@@ -718,7 +718,7 @@ ccio_dma_supported(struct device *dev, u64 mask)
  * @size: The length of the DMA region.
  * @direction: The direction of the DMA transaction (to/from device).
  *
- * This function implements the pci_map_single function.
+ * This function implements the dma_map_single function.
  */
 static dma_addr_t 
 ccio_map_single(struct device *dev, void *addr, size_t size,
@@ -839,7 +839,7 @@ ccio_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
  * @size: The length of the DMA region.
  * @dma_handle: The DMA address handed back to the device (not the cpu).
  *
- * This function implements the pci_alloc_consistent function.
+ * This function implements the dma_alloc_coherent function.
  */
 static void * 
 ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
@@ -873,7 +873,7 @@ ccio_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle, gfp_t flag,
  * @cpu_addr: The cpu address returned from the ccio_alloc_consistent.
  * @dma_handle: The device address returned from the ccio_alloc_consistent.
  *
- * This function implements the pci_free_consistent function.
+ * This function implements the dma_free_coherent function.
  */
 static void 
 ccio_free(struct device *dev, size_t size, void *cpu_addr,
@@ -902,7 +902,7 @@ ccio_free(struct device *dev, size_t size, void *cpu_addr,
  * @nents: The number of entries in the scatter/gather list.
  * @direction: The direction of the DMA transaction (to/from device).
  *
- * This function implements the pci_map_sg function.
+ * This function implements the dma_map_sg function.
  */
 static int
 ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents, 
@@ -981,7 +981,7 @@ ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
  * @nents: The number of entries in the scatter/gather list.
  * @direction: The direction of the DMA transaction (to/from device).
  *
- * This function implements the pci_unmap_sg function.
+ * This function implements the dma_unmap_sg function.
  */
 static void 
 ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents, 
@@ -1071,21 +1071,21 @@ static int ccio_proc_info(struct seq_file *m, void *p)
 		seq_printf(m, "  Bitmap search : %ld/%ld/%ld (min/avg/max CPU Cycles)\n",
 			   min, avg, max);
 
-		seq_printf(m, "pci_map_single(): %8ld calls  %8ld pages (avg %d/1000)\n",
+		seq_printf(m, "dma_map_single(): %8ld calls  %8ld pages (avg %d/1000)\n",
 			   ioc->msingle_calls, ioc->msingle_pages,
 			   (int)((ioc->msingle_pages * 1000)/ioc->msingle_calls));
 
 		/* KLUGE - unmap_sg calls unmap_page for each mapped page */
 		min = ioc->usingle_calls - ioc->usg_calls;
 		max = ioc->usingle_pages - ioc->usg_pages;
-		seq_printf(m, "pci_unmap_single: %8ld calls  %8ld pages (avg %d/1000)\n",
+		seq_printf(m, "dma_unmap_single: %8ld calls  %8ld pages (avg %d/1000)\n",
 			   min, max, (int)((max * 1000)/min));
 
-		seq_printf(m, "pci_map_sg()    : %8ld calls  %8ld pages (avg %d/1000)\n",
+		seq_printf(m, "dma_map_sg()    : %8ld calls  %8ld pages (avg %d/1000)\n",
 			   ioc->msg_calls, ioc->msg_pages,
 			   (int)((ioc->msg_pages * 1000)/ioc->msg_calls));
 
-		seq_printf(m, "pci_unmap_sg()  : %8ld calls  %8ld pages (avg %d/1000)\n\n\n",
+		seq_printf(m, "dma_unmap_sg()  : %8ld calls  %8ld pages (avg %d/1000)\n\n\n",
 			   ioc->usg_calls, ioc->usg_pages,
 			   (int)((ioc->usg_pages * 1000)/ioc->usg_calls));
 #endif	/* CCIO_COLLECT_STATS */
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index e60690d38d67..c7d6d45a0c4b 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1821,21 +1821,21 @@ static int sba_proc_info(struct seq_file *m, void *p)
 	seq_printf(m, "  Bitmap search : %ld/%ld/%ld (min/avg/max CPU Cycles)\n",
 		   min, avg, max);
 
-	seq_printf(m, "pci_map_single(): %12ld calls  %12ld pages (avg %d/1000)\n",
+	seq_printf(m, "dma_map_single(): %12ld calls  %12ld pages (avg %d/1000)\n",
 		   ioc->msingle_calls, ioc->msingle_pages,
 		   (int)((ioc->msingle_pages * 1000)/ioc->msingle_calls));
 
 	/* KLUGE - unmap_sg calls unmap_single for each mapped page */
 	min = ioc->usingle_calls;
 	max = ioc->usingle_pages - ioc->usg_pages;
-	seq_printf(m, "pci_unmap_single: %12ld calls  %12ld pages (avg %d/1000)\n",
+	seq_printf(m, "dma_unmap_single: %12ld calls  %12ld pages (avg %d/1000)\n",
 		   min, max, (int)((max * 1000)/min));
 
-	seq_printf(m, "pci_map_sg()    : %12ld calls  %12ld pages (avg %d/1000)\n",
+	seq_printf(m, "dma_map_sg()    : %12ld calls  %12ld pages (avg %d/1000)\n",
 		   ioc->msg_calls, ioc->msg_pages,
 		   (int)((ioc->msg_pages * 1000)/ioc->msg_calls));
 
-	seq_printf(m, "pci_unmap_sg()  : %12ld calls  %12ld pages (avg %d/1000)\n",
+	seq_printf(m, "dma_unmap_sg()  : %12ld calls  %12ld pages (avg %d/1000)\n",
 		   ioc->usg_calls, ioc->usg_pages,
 		   (int)((ioc->usg_pages * 1000)/ioc->usg_calls));
 #endif
-- 
2.25.1

