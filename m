Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8C3F4105
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhHVSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 14:55:10 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:59391 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHVSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 14:55:09 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d51 with ME
        id kiuR250043riaq203iuRdm; Sun, 22 Aug 2021 20:54:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Aug 2021 20:54:26 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     oakad@yahoo.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tifm: switch from 'pci_' to 'dma_' API
Date:   Sun, 22 Aug 2021 20:54:24 +0200
Message-Id: <fa6cc76718abf0a546e2e9bd9509ea6e495aadd6.1629658403.git.christophe.jaillet@wanadoo.fr>
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
---
 drivers/misc/tifm_7xx1.c | 2 +-
 drivers/misc/tifm_core.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index 228f2eb1d476..017c2f7d6287 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -311,7 +311,7 @@ static int tifm_7xx1_probe(struct pci_dev *dev,
 	int pci_dev_busy = 0;
 	int rc;
 
-	rc = pci_set_dma_mask(dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index 52656fc87e99..f5d275cee21f 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -293,14 +293,15 @@ EXPORT_SYMBOL(tifm_has_ms_pif);
 int tifm_map_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
 		int direction)
 {
-	return pci_map_sg(to_pci_dev(sock->dev.parent), sg, nents, direction);
+	return dma_map_sg(&to_pci_dev(sock->dev.parent)->dev, sg, nents,
+			  direction);
 }
 EXPORT_SYMBOL(tifm_map_sg);
 
 void tifm_unmap_sg(struct tifm_dev *sock, struct scatterlist *sg, int nents,
 		   int direction)
 {
-	pci_unmap_sg(to_pci_dev(sock->dev.parent), sg, nents, direction);
+	dma_unmap_sg(&to_pci_dev(sock->dev.parent)->dev, sg, nents, direction);
 }
 EXPORT_SYMBOL(tifm_unmap_sg);
 
-- 
2.30.2

