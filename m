Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569C32F930
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCFJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:50:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37008 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhCFJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615024214; x=1646560214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1NJu+PzcJ011hmNSl8tydQwSF2vMf5cAQI9rgS5dDM=;
  b=vqOMl53xd0bn1Qr7cAcQdBTpFyXHhPp9fHrmTo4anwgDjaqZdM2x52OX
   vmv8aC5DZsoz/m+x/v/JMxqE7liQjinQyYxwL4LGxU4l3rT6JPAEvW0Q4
   sbUtRxSo/7sN/QeTZkaahl1/g0ERxXco+kSqKA3B8A70dNedAZ+/z03Xn
   Uvkc60dpKYWr9vMULdpv8w08BgdoexAY2AwsfPfhNmur/5Tw9z28rWU6y
   5DFfgmbAhTrTiYX+OV1se8MkbEPox1jv1SOhpYiCd/Ja5wVWvR6PIjRsI
   kEpxYAdzFRE4ujsNOoaqrtmea5Wv8DoFOEvCzfwafG3X255sm5jA/W6jA
   A==;
IronPort-SDR: lqBQgVhA2pbC6ItG57GVR8mLpSnjiRicRzH4Xcf2rDbLFHqGKjjaSmDc8NtGU4RVriEgS7etHi
 YzZpNnOIoRwUA368ORMXGpG2Nud34BTheNylNI6niWpYUEmQZK0F1KDZsYOtLoeC6wBN7J3S7z
 ytzR9GSAYmDwTLsHaQ1sIiQlfD4vCSMPsFRevAbicv3PcBdJk2wJDHsKZu4iZ2bN9aQDvCWsFe
 Lmuun9uMZ5sw3COUePZzzyrRBUMyK0/XuW9VIyxgs/LWJDB/RrCT62eDWLAGdN1B+QSTmXItm4
 k68=
X-IronPort-AV: E=Sophos;i="5.81,227,1610434800"; 
   d="scan'208";a="111726340"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2021 02:50:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 6 Mar 2021 02:50:13 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 6 Mar 2021 02:50:11 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/5] mtd: spi-nor: core: Add vdbg msg for spi_nor_erase_multi_sectors()
Date:   Sat, 6 Mar 2021 11:49:59 +0200
Message-ID: <20210306095002.22983-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306095002.22983-1-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful when debugging non-uniform erase.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: 
- s/dev_dbg/dev_vdb
- move vdbg message the first thing in the while

 drivers/mtd/spi-nor/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bcaa161bc7db..498da1ec3a89 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1610,6 +1610,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
 	list_for_each_entry_safe(cmd, next, &erase_list, list) {
 		nor->erase_opcode = cmd->opcode;
 		while (cmd->count) {
+			dev_vdbg(nor->dev, "erase_cmd->size = 0x%08x, erase_cmd->opcode = 0x%02x, erase_cmd->count = %d\n",
+				 cmd->size, cmd->opcode, cmd->count);
+
 			ret = spi_nor_write_enable(nor);
 			if (ret)
 				goto destroy_erase_cmd_list;
-- 
2.25.1

