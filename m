Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE763C3ADC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 08:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhGKGQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 02:16:09 -0400
Received: from out05.smtpout.orange.fr ([193.252.22.214]:29894 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGKGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 02:16:08 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d42 with ME
        id TiDL2500221Fzsu03iDLkq; Sun, 11 Jul 2021 08:13:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Jul 2021 08:13:20 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, tomaszx.kowalik@intel.com,
        marco.chiappero@intel.com, andriy.shevchenko@linux.intel.com,
        fiona.trahe@intel.com, wojciech.ziemba@intel.com,
        ztong0001@gmail.com, qat-linux@intel.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] crypto: qat - Simplify code and axe the use of a deprecated API
Date:   Sun, 11 Jul 2021 08:13:18 +0200
Message-Id: <7283306389ffa7fe230e2a40f7328f064b872757.1625983602.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1625983602.git.christophe.jaillet@wanadoo.fr>
References: <cover.1625983602.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
and less verbose 'dma_set_mask_and_coherent()' call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

We could also reduce indentation by merging the 2 'if' together. If this
is the preferred style, I'll send a v2.
---
 drivers/crypto/qat/qat_4xxx/adf_drv.c       | 8 ++------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c      | 9 ++-------
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    | 9 ++-------
 drivers/crypto/qat/qat_c62x/adf_drv.c       | 9 ++-------
 drivers/crypto/qat/qat_c62xvf/adf_drv.c     | 9 ++-------
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c   | 9 ++-------
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c | 9 ++-------
 7 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/qat/qat_4xxx/adf_drv.c b/drivers/crypto/qat/qat_4xxx/adf_drv.c
index a8805c815d16..f2b6c0ca039a 100644
--- a/drivers/crypto/qat/qat_4xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_4xxx/adf_drv.c
@@ -221,16 +221,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Set DMA identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration.\n");
 			ret = -EFAULT;
 			goto out_err;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	/* Get accelerator capabilities mask */
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index 7fb3343ae8b0..cc4ed61478a8 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -159,17 +159,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_C3XXX_DEVICE_NAME)) {
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
index 067ca5e17d38..e271da064266 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -141,17 +141,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_C3XXXVF_DEVICE_NAME)) {
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index 1f5de442e1e6..5e2fc0c1a759 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -159,17 +159,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_C62X_DEVICE_NAME)) {
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
index 51ea88c0b17d..8fa5660fe654 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -141,17 +141,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_C62XVF_DEVICE_NAME)) {
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index a9ec4357144c..d0bd18e65104 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -159,17 +159,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_DH895XCC_DEVICE_NAME)) {
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
index 29999da716cc..ce5eab45218e 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -141,17 +141,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* set dma identifier */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
-		if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			dev_err(&pdev->dev, "No usable DMA configuration\n");
 			ret = -EFAULT;
 			goto out_err_disable;
-		} else {
-			pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		}
-
-	} else {
-		pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	}
 
 	if (pci_request_regions(pdev, ADF_DH895XCCVF_DEVICE_NAME)) {
-- 
2.30.2

