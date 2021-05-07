Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9E3767B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhEGPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:09:16 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:20185 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbhEGPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:09:13 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d16 with ME
        id 1r812500h21Fzsu03r83jQ; Fri, 07 May 2021 17:08:10 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 May 2021 17:08:10 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ldewangan@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, swarren@nvidia.com, grant.likely@secretlab.ca
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: tegra114: Fix an error message
Date:   Fri,  7 May 2021 17:07:59 +0200
Message-Id: <e2593974c9484b7055177ad0c9237c8e343946be.1620399829.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is known to be 0 here.
No error code is available, so just remove it from the error message.

Fixes: f333a331ad ("spi/tegra114: add spi driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-tegra114.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a2e5907276e7..5131141bbf0d 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1071,8 +1071,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		ret = wait_for_completion_timeout(&tspi->xfer_completion,
 						SPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tspi->dev,
-				"spi transfer timeout, err %d\n", ret);
+			dev_err(tspi->dev, "spi transfer timeout\n");
 			if (tspi->is_curr_dma_xfer &&
 			    (tspi->cur_direction & DATA_DIR_TX))
 				dmaengine_terminate_all(tspi->tx_dma_chan);
-- 
2.30.2

