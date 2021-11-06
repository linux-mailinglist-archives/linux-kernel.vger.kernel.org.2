Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27369446CF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhKFH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:59:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18862 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhKFH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636185386; x=1667721386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0xOFI5hWEaSGWdQ9gbww3MKKBqKAcuVlKz7F+BR/5w=;
  b=slHUy48VEdS1G29gk+eeKtiBkL3HuXBU/8Z64a6iEOBpo6nTkg55+DSs
   hE+834NTJ3CROO8jkIJVqCt5MWG3k/nHE0CpaCUasNIQQ0SK6n+tFHULu
   iZyRZU7q7wTTEv2hLuzBcic9D7kizw7HFpkabkOrK4fp/gzzeVR27yUl5
   6pY/x1Fuj+9a90feRvkzKi84hpTQ4FoNYX5yl1iOSE86iFKAZN56ZKX43
   cUtfDEYe0MB7sb30W8L1ixLEQvDcCJEra6N2ehfMOikIoLifEB+HZmrV2
   C3BNkbwV0sYU19ZMIgtTBbsh7uA0W3dwxycQZDNbAuE2f9DNrn/P/2oUo
   w==;
IronPort-SDR: ReHRl7xzAO8h4Ryc8j9cyHjItTcWzxpyiOTXoxMee2dcR4DlW65YwV1K/XtRaz/RX+C1w1B0gC
 wQdNZrdrVdaXwlAiwLPXaoaEM7DNtsX1EJmbnJ+Thm1z0whRC68xtV7vKun9Xbn0FMERMKxiBh
 qfGv4wrWmJIa0hUBh2OvmToRzMx3+Gq6kC7jKdENw54OYb+ZzcqnoNCI9fWGIfoZSldfz+hU2m
 8bqsILpfcYXQNRrcdf08pMiLCbUt+sZ8xODdGNxlok3202c9FlJSzBQJSeHI+0A1yAm4VxMjbE
 tAg4aA2vmKrzNg4R90YY2gK+
X-IronPort-AV: E=Sophos;i="5.87,213,1631602800"; 
   d="scan'208";a="138225306"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2021 00:56:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 6 Nov 2021 00:56:25 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 6 Nov 2021 00:56:23 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <Alexander.Stein@tq-group.com>, <michael@walle.cc>,
        <p.yadav@ti.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: Skip erase logic when SPI_NOR_NO_ERASE is set
Date:   Sat, 6 Nov 2021 09:56:16 +0200
Message-ID: <20211106075616.95401-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211106075616.95401-1-tudor.ambarus@microchip.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI_NOR_NO_ERASE is used either by F-RAMs, or MRAMs, or EEPROMs,
neither of which supports SFDP, so once SPI_NOR_NO_ERASE is set,
SFDP can not undo it. These type of flashes should be moved out of
the SPI NOR core anyway, so don't complicate things and just skip
the erase logic when SPI_NOR_NO_ERASE is set. Normally SPI NOR core
should operate just on SNOR_F flags, but since SPI_NOR_NO_ERASE
should be removed, don't bother with extra code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a1b5d5432f41..52c82d943499 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2680,6 +2680,9 @@ static void spi_nor_skip_sfdp_init_params(struct spi_nor *nor)
 					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
 	}
 
+	if (info_flags & SPI_NOR_NO_ERASE)
+		return;
+
 	/*
 	 * Sector Erase settings. Sort Erase Types in ascending order, with the
 	 * smallest erase size starting at BIT(0).
@@ -3195,12 +3198,13 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->name = dev_name(dev);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_CAP_NORFLASH;
-	if (nor->info->flags & SPI_NOR_NO_ERASE)
+	if (nor->info->flags & SPI_NOR_NO_ERASE) {
+		mtd->_erase = spi_nor_erase;
 		mtd->flags |= MTD_NO_ERASE;
+	}
 	mtd->writesize = nor->params->writesize;
 	mtd->writebufsize = nor->params->page_size;
 	mtd->size = nor->params->size;
-	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;
 	/* Might be already set by some SST flashes. */
 	if (!mtd->_write)
-- 
2.25.1

