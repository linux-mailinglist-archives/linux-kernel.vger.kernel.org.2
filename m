Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D63A58B4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFMN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 09:29:53 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:48672 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhFMN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 09:29:48 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d31 with ME
        id GdTk2500721Fzsu03dTlg6; Sun, 13 Jun 2021 15:27:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jun 2021 15:27:46 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     stefanr@s5r6.in-berlin.de, greg@kroah.com
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firewire: nosy: switch from 'pci_' to 'dma_' API
Date:   Sun, 13 Jun 2021 15:27:43 +0200
Message-Id: <e1d7fa558f31abf294659a9d4edcc1e4fc065fab.1623590706.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below and has been
hand modified to replace GFP_ with a correct flag.
It has been compile tested.

When memory is allocated in 'add_card()', GFP_KERNEL can be used because
this flag is already used a few lines above and no lock is taken in the
between.

While at it, also remove some useless casting.

@@ @@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@ @@
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
---
 drivers/firewire/nosy.c | 43 +++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index 88ed971e32c0..b0d671db178a 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -511,12 +511,12 @@ remove_card(struct pci_dev *dev)
 		wake_up_interruptible(&client->buffer.wait);
 	spin_unlock_irq(&lynx->client_list_lock);
 
-	pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
-			    lynx->rcv_start_pcl, lynx->rcv_start_pcl_bus);
-	pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
-			    lynx->rcv_pcl, lynx->rcv_pcl_bus);
-	pci_free_consistent(lynx->pci_device, PAGE_SIZE,
-			    lynx->rcv_buffer, lynx->rcv_buffer_bus);
+	dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
+			  lynx->rcv_start_pcl, lynx->rcv_start_pcl_bus);
+	dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
+			  lynx->rcv_pcl, lynx->rcv_pcl_bus);
+	dma_free_coherent(&lynx->pci_device->dev, PAGE_SIZE, lynx->rcv_buffer,
+			  lynx->rcv_buffer_bus);
 
 	iounmap(lynx->registers);
 	pci_disable_device(dev);
@@ -532,7 +532,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 	u32 p, end;
 	int ret, i;
 
-	if (pci_set_dma_mask(dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&dev->dev, DMA_BIT_MASK(32))) {
 		dev_err(&dev->dev,
 		    "DMA address limits not supported for PCILynx hardware\n");
 		return -ENXIO;
@@ -564,12 +564,16 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 		goto fail_deallocate_lynx;
 	}
 
-	lynx->rcv_start_pcl = pci_alloc_consistent(lynx->pci_device,
-				sizeof(struct pcl), &lynx->rcv_start_pcl_bus);
-	lynx->rcv_pcl = pci_alloc_consistent(lynx->pci_device,
-				sizeof(struct pcl), &lynx->rcv_pcl_bus);
-	lynx->rcv_buffer = pci_alloc_consistent(lynx->pci_device,
-				RCV_BUFFER_SIZE, &lynx->rcv_buffer_bus);
+	lynx->rcv_start_pcl = dma_alloc_coherent(&lynx->pci_device->dev,
+						 sizeof(struct pcl),
+						 &lynx->rcv_start_pcl_bus,
+						 GFP_KERNEL);
+	lynx->rcv_pcl = dma_alloc_coherent(&lynx->pci_device->dev,
+					   sizeof(struct pcl),
+					   &lynx->rcv_pcl_bus, GFP_KERNEL);
+	lynx->rcv_buffer = dma_alloc_coherent(&lynx->pci_device->dev,
+					      RCV_BUFFER_SIZE,
+					      &lynx->rcv_buffer_bus, GFP_KERNEL);
 	if (lynx->rcv_start_pcl == NULL ||
 	    lynx->rcv_pcl == NULL ||
 	    lynx->rcv_buffer == NULL) {
@@ -667,14 +671,15 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 
 fail_deallocate_buffers:
 	if (lynx->rcv_start_pcl)
-		pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
-				lynx->rcv_start_pcl, lynx->rcv_start_pcl_bus);
+		dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
+				  lynx->rcv_start_pcl,
+				  lynx->rcv_start_pcl_bus);
 	if (lynx->rcv_pcl)
-		pci_free_consistent(lynx->pci_device, sizeof(struct pcl),
-				lynx->rcv_pcl, lynx->rcv_pcl_bus);
+		dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
+				  lynx->rcv_pcl, lynx->rcv_pcl_bus);
 	if (lynx->rcv_buffer)
-		pci_free_consistent(lynx->pci_device, PAGE_SIZE,
-				lynx->rcv_buffer, lynx->rcv_buffer_bus);
+		dma_free_coherent(&lynx->pci_device->dev, PAGE_SIZE,
+				  lynx->rcv_buffer, lynx->rcv_buffer_bus);
 	iounmap(lynx->registers);
 
 fail_deallocate_lynx:
-- 
2.30.2

