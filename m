Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0862033AB56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCOF5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:57:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30896 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOF4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615787798; x=1647323798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JOv9nf8B9U7wOZ0NotKK+ObE4/2lAZvK35sQX7F14L4=;
  b=jdGG3QxceSRyKZY+kS002UJWQEryImLzKK10NeA9txHa1pjDTszr8B+R
   yLKKSq30YaizSREyxLFpFi8l0J5uSGXxSuui+hVy1ySw0l3umCj9DHL72
   4420fqH1ZZ2FcXnm5zeKcm4GXMzBoSYZ7ZvuwY+XFruuqIlKjw3yyQ+9u
   S0DUTOQopq11qn8U4qbgdTgJA2Z1i2LWzhtkseg532qI0QQAwqbUXiue5
   4zx6Tt35V6we/rl3GpoZEOBiwpHrMOaVuBTy75xJPF5oIZWtWpPdRR3/0
   kbdFCzWLSfyEKNrmJvFySsepd6eZPxwVwdSW/xbBkVQ+m9QooJjJYAB3Q
   A==;
IronPort-SDR: hsLFSB8Xdzl+pfbgx4J0k//AhnnoWOx9KB+5rAPoB+vs3rQyjdm/+CTA+OxksTyviXEt5c6dps
 5ND6EAF2v7OIBo6MDLelBsyEblxjiaOUJkxAGxqaGmccozTzMkJ4lLnrUwP9eoNLSJ9dTkagl2
 kIunYKhnu78Hz3ly3rQw3vle0gAF2bNiwiETi9FRES9eIfBOsxXF2XPwXOxMvbpxsRI2lzxLbc
 F3U5FyNR8vpCmWUpOEmX4xYQNHm5yw05nTnEC5CJ0lZmy15YY3VP1Z4GdqOilyN+/xFhT4mV2K
 p4E=
X-IronPort-AV: E=Sophos;i="5.81,249,1610434800"; 
   d="scan'208";a="112724540"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2021 22:56:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 14 Mar 2021 22:56:38 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 14 Mar 2021 22:56:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: Update comment about the default flash parameters
Date:   Mon, 15 Mar 2021 07:56:34 +0200
Message-ID: <20210315055634.17332-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/legacy/default. spi_nor_info_init_params initializes some default
flash parameters and settings that can be overwritten when parsing
SFDP, or by fixup hooks. There's nothing legacy about them, they are
just some default settings, if not otherwise discovered or specified.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4a315cb1c4db..26f681cd3a98 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2913,7 +2913,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 	u8 i, erase_mask;
 
-	/* Initialize legacy flash parameters and settings. */
+	/* Initialize default flash parameters and settings. */
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
 	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
 	params->setup = spi_nor_default_setup;
-- 
2.25.1

