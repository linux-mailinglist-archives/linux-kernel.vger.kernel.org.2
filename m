Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABDF32F92F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCFJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:50:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCFJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615024212; x=1646560212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F67KRwC5EvnpuwLQWrA/2oiNrHaxxAL/UiwBj3D0GEU=;
  b=ONzqPhh3h0rHiB3C+zMb9Sz5HKHGe88dmP6ojNTW9lzO6ySQ1BIeGNZj
   eArRcPL1n1tC3TZAqfGR+vuKhQbWB0MhouXw5n9V5mZIAdjkdRZLaZGBp
   6+a4deSVojCtDqbMyRl94feGhCZWqH8dBAkTfgtQoiIgCLrixMRRdnIcl
   z0o9mYNcLPh3eWZbY7CTsIjOjACmFQO6bA44GuTipioPAIL9AhcXvL5fP
   hhdIWmh5f3VIvnOfffEcrZKx+6gQBwMJhTTIoRglwwDThIt/nKZB03mX6
   I8QGwPLgHmnPJysvkVP9mYngNBhf6BD0kK2KGfmrKHjNZZrQ1fKDopPBm
   A==;
IronPort-SDR: j6vwh5zVtSGoszYfxQfynJCECjNI9V1AvIb48+gPb47r5d9BcpqBDUCtIj2bb5Ya8pl4b0hR3e
 2u7zVKFikw3XULTnHEv7SOvUZJZ7tpprVOmntTvISCF6Vsbw0jOppklrz9JOuGQkN0TrV370k6
 UgVns943nW4JV3SJ8xwHAqR8JhI2r2Ka9fVYL9gsCgpIyO7R8HZIbgNTiTZvrkfUlPhssBumsf
 nRM8TbkInlj2BqLJfjh64yuc2eZgjAxT9NtaNlKn4CavIMtQBg8oSOyf9zoUaHSE8tujwotNI4
 SA8=
X-IronPort-AV: E=Sophos;i="5.81,227,1610434800"; 
   d="scan'208";a="112202496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2021 02:50:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 6 Mar 2021 02:50:11 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 6 Mar 2021 02:50:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 1/5] mtd: spi-nor: core: Advance erase after the erase cmd has been completed
Date:   Sat, 6 Mar 2021 11:49:58 +0200
Message-ID: <20210306095002.22983-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306095002.22983-1-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addr and len were gratuitously updated even when spi_nor_wait_till_ready()
failed. Wait for the erase cmd to complete and then advance the erase.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v2:
- update commit message
- Add R-b tag

 drivers/mtd/spi-nor/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0522304f52fa..bcaa161bc7db 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1618,12 +1618,12 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
 			if (ret)
 				goto destroy_erase_cmd_list;
 
-			addr += cmd->size;
-			cmd->count--;
-
 			ret = spi_nor_wait_till_ready(nor);
 			if (ret)
 				goto destroy_erase_cmd_list;
+
+			addr += cmd->size;
+			cmd->count--;
 		}
 		list_del(&cmd->list);
 		kfree(cmd);
@@ -1704,12 +1704,12 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			if (ret)
 				goto erase_err;
 
-			addr += mtd->erasesize;
-			len -= mtd->erasesize;
-
 			ret = spi_nor_wait_till_ready(nor);
 			if (ret)
 				goto erase_err;
+
+			addr += mtd->erasesize;
+			len -= mtd->erasesize;
 		}
 
 	/* erase multiple sectors */
-- 
2.25.1

