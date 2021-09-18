Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14DB410436
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhIRFiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:38:11 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:60634 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232366AbhIRFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:38:09 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d65 with ME
        id vHck2500E4m3Hzu03Hckx2; Sat, 18 Sep 2021 07:36:45 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Sep 2021 07:36:45 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] mei: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sat, 18 Sep 2021 07:36:42 +0200
Message-Id: <c6f280927835c5677cc0367fccdc0ef54b307bd8.1631943364.git.christophe.jaillet@wanadoo.fr>
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
 drivers/misc/mei/pci-txe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index aec0483b8e72..fa20d9a27813 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -69,9 +69,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(36));
+	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(36));
 	if (err) {
-		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			dev_err(&pdev->dev, "No suitable DMA available.\n");
 			goto end;
-- 
2.30.2

