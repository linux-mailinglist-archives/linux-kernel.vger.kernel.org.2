Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A9366BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbhDUNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240157AbhDUNHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 058276144B;
        Wed, 21 Apr 2021 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010402;
        bh=WkM5OqGDtqhj2vez0uEmj2CADFldwYZrt7aOxxWbg1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pukQ2+J5Dp+5bSKloNntBKOUczLImurBcZzovWczlKPBeGalGVCAbE/QXMD0MsAAb
         LXQb7G7etyDhsN6SHoGkl2+o7pJvi3+/F5p05ksyhbyYrfmFZulQ61zCWSLHCFQy38
         W5WttRmnZyzDt4S60WWsY0c1KeE6ZIwcC34Joo8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 124/190] Revert "spi : spi-topcliff-pch: Fix to handle empty DMA buffers"
Date:   Wed, 21 Apr 2021 14:59:59 +0200
Message-Id: <20210421130105.1226686-125-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f37d8e67f39e6d3eaf4cc5471e8a3d21209843c6.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-topcliff-pch.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index b459e369079f..12d749e9436b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1290,27 +1290,18 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
 				  dma->rx_buf_virt, dma->rx_buf_dma);
 }
 
-static int pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
+static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
 			      struct pch_spi_data *data)
 {
 	struct pch_spi_dma_ctrl *dma;
-	int ret;
 
 	dma = &data->dma;
-	ret = 0;
 	/* Get Consistent memory for Tx DMA */
 	dma->tx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->tx_buf_dma, GFP_KERNEL);
-	if (!dma->tx_buf_virt)
-		ret = -ENOMEM;
-
 	/* Get Consistent memory for Rx DMA */
 	dma->rx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->rx_buf_dma, GFP_KERNEL);
-	if (!dma->rx_buf_virt)
-		ret = -ENOMEM;
-
-	return ret;
 }
 
 static int pch_spi_pd_probe(struct platform_device *plat_dev)
@@ -1387,9 +1378,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	if (use_dma) {
 		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
-		ret = pch_alloc_dma_buf(board_dat, data);
-		if (ret)
-			goto err_spi_register_master;
+		pch_alloc_dma_buf(board_dat, data);
 	}
 
 	ret = spi_register_master(master);
-- 
2.31.1

