Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A53F3FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHVOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:05:02 -0400
Received: from out07.smtpout.orange.fr ([193.252.22.91]:21784 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230495AbhHVOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:04:59 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d74 with ME
        id ke4E250053riaq203e4Edf; Sun, 22 Aug 2021 16:04:16 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Aug 2021 16:04:16 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sanju.mehta@amd.com, Shyam-sundar.S-k@amd.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] NTB: switch from 'pci_' to 'dma_' API
Date:   Sun, 22 Aug 2021 16:04:12 +0200
Message-Id: <6a1db73ba4e46958cb40d3766eff771ef5d7a11b.1629640974.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.

It has been compile tested.


@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

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
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

This patch is mostly mechanical and compile tested. I hope it is ok to
update the "drivers/ntb/hw/" directory all at once.
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 12 ++----------
 drivers/ntb/hw/idt/ntb_hw_idt.c    | 15 ++-------------
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 12 ++----------
 3 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 71428d8cbcfc..87847c380051 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1176,22 +1176,14 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 
 	pci_set_master(pdev);
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc) {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (rc) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc)
-			goto err_dma_mask;
-		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
-	}
-
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
 		rc = -EIO;
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index e7a4c2aa8baa..733557231ed0 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2640,26 +2640,15 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	int ret;
 
 	/* Initialize the bit mask of PCI/NTB DMA */
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret != 0) {
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret != 0) {
 			dev_err(&pdev->dev, "Failed to set DMA bit mask\n");
 			return ret;
 		}
 		dev_warn(&pdev->dev, "Cannot set DMA highmem bit mask\n");
 	}
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret != 0) {
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"Failed to set consistent DMA bit mask\n");
-			return ret;
-		}
-		dev_warn(&pdev->dev,
-			"Cannot set consistent DMA highmem bit mask\n");
-	}
 
 	/*
 	 * Enable the device advanced error reporting. It's not critical to
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 093dd20057b9..e5f14e20a9ff 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1771,22 +1771,14 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 
 	pci_set_master(pdev);
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc) {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (rc)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (rc) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc)
-			goto err_dma_mask;
-		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
-	}
-
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
 		rc = -EIO;
-- 
2.30.2

