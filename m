Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631AE3FA460
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhH1Hj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 03:39:56 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:52321 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhH1Hjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 03:39:45 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d24 with ME
        id mves250093riaq203vesxe; Sat, 28 Aug 2021 09:38:53 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Aug 2021 09:38:53 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     airlied@linux.ie, chris@chris-wilson.co.uk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] agp/intel: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sat, 28 Aug 2021 09:38:51 +0200
Message-Id: <e6b5bc8d1f79955ebba652df3deff6b8b39cc607.1630136212.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation
Only relevant parts are given below.

It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
This is less verbose.


@@ @@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It has been compile tested.
---
 drivers/char/agp/intel-gtt.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 5bfdf222d5f9..4aeccf36f9ee 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -110,8 +110,8 @@ static int intel_gtt_map_memory(struct page **pages,
 	for_each_sg(st->sgl, sg, num_entries, i)
 		sg_set_page(sg, pages[i], PAGE_SIZE, 0);
 
-	if (!pci_map_sg(intel_private.pcidev,
-			st->sgl, st->nents, PCI_DMA_BIDIRECTIONAL))
+	if (!dma_map_sg(&intel_private.pcidev->dev, st->sgl, st->nents,
+			DMA_BIDIRECTIONAL))
 		goto err;
 
 	return 0;
@@ -126,8 +126,8 @@ static void intel_gtt_unmap_memory(struct scatterlist *sg_list, int num_sg)
 	struct sg_table st;
 	DBG("try unmapping %lu pages\n", (unsigned long)mem->page_count);
 
-	pci_unmap_sg(intel_private.pcidev, sg_list,
-		     num_sg, PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_sg(&intel_private.pcidev->dev, sg_list, num_sg,
+		     DMA_BIDIRECTIONAL);
 
 	st.sgl = sg_list;
 	st.orig_nents = st.nents = num_sg;
@@ -302,9 +302,9 @@ static int intel_gtt_setup_scratch_page(void)
 	set_pages_uc(page, 1);
 
 	if (intel_private.needs_dmar) {
-		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
-				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
+		dma_addr = dma_map_page(&intel_private.pcidev->dev, page, 0,
+					PAGE_SIZE, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(&intel_private.pcidev->dev, dma_addr)) {
 			__free_page(page);
 			return -EINVAL;
 		}
@@ -551,9 +551,9 @@ static void intel_gtt_teardown_scratch_page(void)
 {
 	set_pages_wb(intel_private.scratch_page, 1);
 	if (intel_private.needs_dmar)
-		pci_unmap_page(intel_private.pcidev,
-			       intel_private.scratch_page_dma,
-			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
+		dma_unmap_page(&intel_private.pcidev->dev,
+			       intel_private.scratch_page_dma, PAGE_SIZE,
+			       DMA_BIDIRECTIONAL);
 	__free_page(intel_private.scratch_page);
 }
 
@@ -1411,13 +1411,11 @@ int intel_gmch_probe(struct pci_dev *bridge_pdev, struct pci_dev *gpu_pdev,
 
 	if (bridge) {
 		mask = intel_private.driver->dma_mask_size;
-		if (pci_set_dma_mask(intel_private.pcidev, DMA_BIT_MASK(mask)))
+		if (dma_set_mask_and_coherent(&intel_private.pcidev->dev,
+					      DMA_BIT_MASK(mask)))
 			dev_err(&intel_private.pcidev->dev,
 				"set gfx device dma mask %d-bit failed!\n",
 				mask);
-		else
-			pci_set_consistent_dma_mask(intel_private.pcidev,
-						    DMA_BIT_MASK(mask));
 	}
 
 	if (intel_gtt_init() != 0) {
-- 
2.30.2

