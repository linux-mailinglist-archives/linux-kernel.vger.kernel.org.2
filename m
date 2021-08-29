Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB313FAA8A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhH2JxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:53:18 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:42093 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhH2JxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:53:18 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d25 with ME
        id nMsR250023riaq203MsR3T; Sun, 29 Aug 2021 11:52:25 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Aug 2021 11:52:25 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mchehab+huawei@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: v4l2-pci-skeleton: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sun, 29 Aug 2021 11:52:23 +0200
Message-Id: <7191e316ea3b61b6a015d063d2b068a9f4a965aa.1630230428.git.christophe.jaillet@wanadoo.fr>
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

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It has been compile tested.

get_maintainer.pl is not really helpful for this patch. I've picked up what made
sense to me from previous commit.
---
 samples/v4l/v4l2-pci-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index 3fa6582b4a68..6311b7465220 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -766,7 +766,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pdev->dev, "no suitable DMA available.\n");
 		goto disable_pci;
-- 
2.30.2

