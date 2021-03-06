Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE732F933
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCFJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:51:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6733 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCFJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615024222; x=1646560222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ntGPrOaW4RoWXY/jkpumcnSQ+hE89vhCyHANUqE9kEc=;
  b=Duhyu0lx4/mcEvllZjnAQPOGF9rR8laGUEuK/x+Od/UpJ7AwV011gKe8
   EWvyczA5DSoiS6dXWWIjRnfZ8LMQ+C1uLTTGK2V33Pvjki0kPWVMbLhRQ
   +0fjk27a+G3cL+nrVYIgbG8KzFKBD7aBT+Rh0NDvSse3V8/5t5eAnHi5i
   OgVOgXmh59dyydVJL13pjXKuX5+LndIpGw6bN/158cZho4cyUDJ4QkwCV
   14kfB5zRbBUKFONL8WHAlOlI8xGuOBKbsFOZARd5pcOTVfBwev8QlBAow
   fJQAorE/OhWsFl6Utkpg3edTrN3JmGuicUw2BnVGdrU1cHt0f4mYY+Uqj
   g==;
IronPort-SDR: Q0r0o8Ei2NK0Hf0zmhitHDUvXgcDKX5+zjcHjOx3cxQUYtAjP4McLzT1XThqPGCFOKLMHxgW+9
 favsPeipU2xAXgAkWSPd/3vgVf+CQsJ3zL/S99J2+yVYJiR7oubKRMjhkgAyjXoOiCAu0kWvpO
 EvInX7/woOzTOd4Ti07L+42FlsQWwX3OOrh1OZ6vXcJWtVMIvI3ZV7/4I3GTCjDfHTjmNTqHvl
 zS/fKs9AtmeBEn0M+4UNGKbQMYBm5EYF10HkiUy3rM7Bd4YrnW+ODKbkDSbqk9mvecNbkVSE+b
 kIs=
X-IronPort-AV: E=Sophos;i="5.81,227,1610434800"; 
   d="scan'208";a="112202514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2021 02:50:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 6 Mar 2021 02:50:21 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 6 Mar 2021 02:50:19 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 5/5] mtd: spi-nor: swp: Drop 'else' after 'return'
Date:   Sat, 6 Mar 2021 11:50:02 +0200
Message-ID: <20210306095002.22983-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306095002.22983-1-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

else is not generally useful after a break or return.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/swp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 75b9bb53d584..c35cb3becb41 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -25,8 +25,8 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
 {
 	if (nor->flags & SNOR_F_HAS_SR_TB_BIT6)
 		return SR_TB_BIT6;
-	else
-		return SR_TB_BIT5;
+
+	return SR_TB_BIT5;
 }
 
 static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
@@ -41,8 +41,8 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 	if (bp_slots_needed > bp_slots)
 		return nor->info->sector_size <<
 			(bp_slots_needed - bp_slots);
-	else
-		return nor->info->sector_size;
+
+	return nor->info->sector_size;
 }
 
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
@@ -96,9 +96,9 @@ static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
 	if (locked)
 		/* Requested range is a sub-range of locked range */
 		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
-	else
-		/* Requested range does not overlap with locked range */
-		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+
+	/* Requested range does not overlap with locked range */
+	return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
 }
 
 static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-- 
2.25.1

