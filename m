Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2449B311785
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBEX7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:59:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22898 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhBENyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612533263; x=1644069263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KEwzymtXFqmnAlGpSQgTzF8vEry5JGTqNgDxxRxmIU=;
  b=JisaAfK9eK5Noj6xDKI8TFuJtUrkP13j7Pqr0pLg8lyL5aMgnotgZY1L
   DX58x3/phLDUHqNOF8PgI/mzsjGRi/6X4+UjEye077vi128cIOY/Q0U6G
   AvKrByifZlGZX/4y0V/Q8CGcqvYEogKO4zyZRWOn3aau6P5uq7YRBIiI6
   /i2tYBFYRnu6sQUR9tq4EwmrkQidqjI5Xgdl0/OM3tBfGXiTsXLfIEzM5
   tBHtJ4G6u7z7ugDcutdkXIe1q6kqEIxgiZPO5U31BW9KkNnMWvA0htkcQ
   u+ajUOr9pWn0xkCVt0F10QXTSeTsDd9Mr/hw5BgbDCpHN4TcdzJHHiMhs
   g==;
IronPort-SDR: y+maKmez/7/dyTnc2dtjCVkaY5DwwnlJ7ERVyGljZpRhLWRQb+JYhdwQWuXdp3NvZI8whVtCHN
 kEn/lbfVYpDVNFuoRhf4jb7GmxqHZpq7TUCFxp26j/POt5NzOkLwmpvweHVRtQfOLq6Cy88IaH
 t4YNKXxBRgolUS1+AlaxKDBaA5H2KJlOxc/2FFU37nXW8G618ailSquxPKPnHIy+/V4xN78XLb
 m5CBg+r3zQ7+ri7igj4zGrE0HtFg+1X7XWocJjQmLA4cmF2MHKBVQq1F0Fu/nZIaUHiEFEX+gk
 B90=
X-IronPort-AV: E=Sophos;i="5.81,155,1610434800"; 
   d="scan'208";a="105561347"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 06:52:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 06:52:58 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 06:52:57 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <Takahiro.Kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: core: Add dbg msg for spi_nor_erase_multi_sectors()
Date:   Fri, 5 Feb 2021 15:52:53 +0200
Message-ID: <20210205135253.675793-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205135253.675793-1-tudor.ambarus@microchip.com>
References: <20210205135253.675793-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful when debugging non-uniform erase.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bcaa161bc7db..7401c60b53e6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1622,6 +1622,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
 			if (ret)
 				goto destroy_erase_cmd_list;
 
+			dev_dbg(nor->dev, "erase_cmd->size = 0x%08x, erase_cmd->opcode = 0x%02x, erase_cmd->count = %d\n",
+				cmd->size, cmd->opcode, cmd->count);
+
 			addr += cmd->size;
 			cmd->count--;
 		}
-- 
2.25.1

