Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A43444864
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKCSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:41:29 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:49489 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhKCSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:41:28 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id iL9rmt2JpUGqliL9rmrujg; Wed, 03 Nov 2021 19:38:50 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Nov 2021 19:38:50 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 1/4] char: xillybus: Remove usage of the deprecated 'pci-dma-compat.h' API
Date:   Wed,  3 Nov 2021 19:38:45 +0100
Message-Id: <e25aa2a804972c5d4f06c4c4e0511e11ff97a425.1630083668.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
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
Only relevant part are given below.

'xilly_pci_direction()' has been hand modified to simplify it slightly.

It has been compile tested.


@@ @@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/xillybus/xillybus_pcie.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index bdf1c366b4fc..be25bfdb0d9a 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -36,11 +36,10 @@ static int xilly_pci_direction(int direction)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
-		return PCI_DMA_TODEVICE;
 	case DMA_FROM_DEVICE:
-		return PCI_DMA_FROMDEVICE;
+		return direction;
 	default:
-		return PCI_DMA_BIDIRECTIONAL;
+		return DMA_BIDIRECTIONAL;
 	}
 }
 
@@ -185,9 +184,9 @@ static int xilly_probe(struct pci_dev *pdev,
 	 * So go for the 64-bit mask only when failing is the other option.
 	 */
 
-	if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
+	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 		endpoint->dma_using_dac = 0;
-	} else if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
+	} else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
 		endpoint->dma_using_dac = 1;
 	} else {
 		dev_err(endpoint->dev, "Failed to set DMA mask. Aborting.\n");
-- 
2.30.2

