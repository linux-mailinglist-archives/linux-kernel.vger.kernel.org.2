Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDE311786
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBEX7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:59:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63922 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBENyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612533263; x=1644069263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yXFj/yQEcFvcy6InZXdmBwNt8d4tBVYQlHOFM8p4OSE=;
  b=NF3zyCnnzBqNybQsgxWI/tM0Uk/0YGv/QMaaJcM0u7W1YTGsG6721TuK
   sCB+Epj4J5oPnBi7Bs25Rr6r7qcX21ZDKp4bXGlBztRu5sGuFXckLOGMg
   /0FhzgH0V6XSQdpy6zoJxgXCkainlun6eBVUUXB9+d+6JjaT7r9e0n7Ck
   lOArr2DcjX1dgQsschYUkcwHlYuPmVn8K9PZtLV6OcADNq+j5QX/bp/WF
   vJdM66oIeq8yTzc5FH04q80dlHs5BpGYlFLXRaNZ3HAXkaYuu3Pnf3TAk
   jvWsdo8aKi0tthwCg6oF9SUyJkI+TduGMy7EDZrt/7er6qpct549LMXXu
   w==;
IronPort-SDR: YgX4M0MGVxH0VOIOkSsNai1MpDPgzRNucUeYtYiYRbiaoeqiZL2xjjNlcEGmb6QVF7UUhH8DqR
 Uhu+RGMY2wx53XtkBf6pHZKS5g32ucAhJY8ldBT8xd7GqyHySSqAP1iCfxz1GL4xXmOVp3BzRn
 1Vx36d/DkRv1rkbOEE0MvzbD91lN91auHwL4/igSxOjWLdbW7XYzSVyx2+/r/h/wHs/2+UfjII
 VT5lAMrClmWBqdwJdGfP2CGiVeMU7Mqdpd5SG6q2JAOPxW98XtrfNLm8vaphJ/KQy+iXlobl7U
 m+U=
X-IronPort-AV: E=Sophos;i="5.81,155,1610434800"; 
   d="scan'208";a="43074440"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 06:52:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 06:52:56 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 06:52:54 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <Takahiro.Kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] mtd: spi-nor: core: Advance erase after the erase cmd has been completed
Date:   Fri, 5 Feb 2021 15:52:52 +0200
Message-ID: <20210205135253.675793-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for the erase cmd to complete and then advance the erase.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
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

