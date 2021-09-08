Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3D404006
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbhIHT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:57:10 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:29703 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234047AbhIHT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:57:09 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d75 with ME
        id rXvy250043riaq203XvyeH; Wed, 08 Sep 2021 21:55:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Sep 2021 21:55:59 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] misc: genwqe: Fixes DMA mask setting
Date:   Wed,  8 Sep 2021 21:55:56 +0200
Message-Id: <be49835baa8ba6daba5813b399edf6300f7fdbda.1631130862.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 505b08777d78 ("misc: genwqe: Use dma_set_mask_and_coherent to simplify code")
changed the logic in the code.

Instead of a ||, a && should have been used to keep the code the same.

Fixes: 505b08777d78 ("misc: genwqe: Use dma_set_mask_and_coherent to simplify code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Also as reported in [1], setting a 64 bits DMA mask never fails if
dev->dma_mask is non-NULL.
So the code could be simplified further.

Even if told twice that it is safe, and checking the code in the different
platforms, I'm still unsure about it :(

So I first post the fix to the bug I've introduced (sorry about that).
Should it be confirmed another time that removing the 32-bits case is safe,
then I'll send a v2 which does the additional clean-up.
---
 drivers/misc/genwqe/card_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 2e1befbd1ad9..693981891870 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1090,7 +1090,7 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 
 	/* check for 64-bit DMA address supported (DAC) */
 	/* check for 32-bit DMA address supported (SAC) */
-	if (dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64)) ||
+	if (dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32))) {
 		dev_err(&pci_dev->dev,
 			"err: neither DMA32 nor DMA64 supported\n");
-- 
2.30.2

