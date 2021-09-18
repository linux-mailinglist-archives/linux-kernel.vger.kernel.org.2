Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B931410433
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhIRFfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:35:22 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:29011 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231336AbhIRFfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:35:20 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d65 with ME
        id vHZv2500E4m3Hzu03HZwaL; Sat, 18 Sep 2021 07:33:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Sep 2021 07:33:56 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     oakad@yahoo.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] tifm: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sat, 18 Sep 2021 07:32:26 +0200
Message-Id: <b5296677f92f7bace957e66479b3d57a5a824ca1.1631942796.git.christophe.jaillet@wanadoo.fr>
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

Finally, Arnd Bergmann reminded that the documentation was updated 11 years
ago to only describe the modern linux/dma-mapping.h interfaces and mark the
old bus-specific ones as no longer recommended, see commit 216bf58f4092
("Documentation: convert PCI-DMA-mapping.txt to use the generic DMA API").

A coccinelle script has been used to perform the needed transformation
Only relevant parts are given below.

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
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Change Subject to be more explicit
    Keep only relevant part of the coccinelle script
    Try to improve the commit message to give some reason of why this change is done
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
index 2bb46b1f4be3..a3098fea3bf7 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -292,14 +292,15 @@ EXPORT_SYMBOL(tifm_has_ms_pif);
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

