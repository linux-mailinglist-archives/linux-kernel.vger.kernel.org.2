Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E3D31EBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBRP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:56:38 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21955 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhBRN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613654801; x=1645190801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a73GG6FM0Icm2GR7U293i2N7W7TlhbendQ/I0wVoeak=;
  b=WTJaGWjIJOQbb6+nfaltk1EqTyx/0uICObRwePpIT62dWL5zL6BwKsXk
   oHOSLCd3dMS3tOeqHAAA1HopFotFTo4Uo682L0g9LtR4nFDwyRmc4gN61
   E6sQeQpAvWOam5YYqikF4I2MuaGpgHgoGvwpfogpLxnJQn3LlZ4GfSTLC
   1GfuEgloa/6X3qm7oWgaRJPiQvbmjbFKl0E5y3HrFDHsFtdmBowaD706e
   dVsYX/1B1XUEo1TqM1J9mOqktEX23RElhR/1/gww0Fo1bSckTFNCkswpV
   jU2Dj5yawDy9psc+cv97ygwFruIu2LxVNscLeiCNLp/pqjF6rMxo2sDIE
   w==;
IronPort-SDR: zxbKzXfTRozYBZ29N2SyxEocNyZHrfTag6LqqaZUU5k5xzvcOV+QVKoFAKsE2r/OXr+NvvksmH
 xt6kNoYF9jZSHo9z96g2UWl2kjq3+gt4pEL5iaq9cdJ8/RC9W35ZUhCT5ya3HNB/PATw/yevE5
 0tdQix+zCEBFBAh8UB6fEHyNaP0Qwl/GWBY4Vr8GFuOJZSVS/pTtIA2ripNS2p4vMLEh+VsPCy
 xt0BwkGJHrRuIpCG1ZUmv9Zzh6p6Mbrq8FeLRYhMhZp4urmyNhDp+bBUeIrUMbuDVGL22rx238
 o7M=
X-IronPort-AV: E=Sophos;i="5.81,187,1610434800"; 
   d="scan'208";a="109744715"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2021 06:19:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 06:09:54 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 18 Feb 2021 06:09:52 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] spi: spi-ti-qspi: Free DMA resources
Date:   Thu, 18 Feb 2021 15:09:50 +0200
Message-ID: <20210218130950.90155-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release the RX channel and free the dma coherent memory when
devm_spi_register_master() fails.

Fixes: 5720ec0a6d26 ("spi: spi-ti-qspi: Add DMA support for QSPI mmap read")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: Add Fixes tag and Cc stable.

 drivers/spi/spi-ti-qspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 9417385c0921..e06aafe169e0 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -733,6 +733,17 @@ static int ti_qspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static void ti_qspi_dma_cleanup(struct ti_qspi *qspi)
+{
+	if (qspi->rx_bb_addr)
+		dma_free_coherent(qspi->dev, QSPI_DMA_BUFFER_SIZE,
+				  qspi->rx_bb_addr,
+				  qspi->rx_bb_dma_addr);
+
+	if (qspi->rx_chan)
+		dma_release_channel(qspi->rx_chan);
+}
+
 static const struct of_device_id ti_qspi_match[] = {
 	{.compatible = "ti,dra7xxx-qspi" },
 	{.compatible = "ti,am4372-qspi" },
@@ -886,6 +897,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!ret)
 		return 0;
 
+	ti_qspi_dma_cleanup(qspi);
+
 	pm_runtime_disable(&pdev->dev);
 free_master:
 	spi_master_put(master);
@@ -904,12 +917,7 @@ static int ti_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (qspi->rx_bb_addr)
-		dma_free_coherent(qspi->dev, QSPI_DMA_BUFFER_SIZE,
-				  qspi->rx_bb_addr,
-				  qspi->rx_bb_dma_addr);
-	if (qspi->rx_chan)
-		dma_release_channel(qspi->rx_chan);
+	ti_qspi_dma_cleanup(qspi);
 
 	return 0;
 }
-- 
2.25.1

