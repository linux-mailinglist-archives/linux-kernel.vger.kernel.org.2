Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4587A3AB5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhFQOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhFQOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:16:50 -0400
Received: from mxout017.mail.hostpoint.ch (mxout017.mail.hostpoint.ch [IPv6:2a00:d70:0:e::317])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:14:42 -0700 (PDT)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1ltsmt-000L01-SB; Thu, 17 Jun 2021 16:14:31 +0200
Received: from [2a02:168:6182:1:d64b:e086:4fb7:9a87] (helo=eleanor.home.reto-schneider.ch)
        by asmtp014.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1ltsmt-0001DK-Q5; Thu, 17 Jun 2021 16:14:31 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-mtd@lists.infradead.org
Cc:     Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: Add support for XM25QH64C
Date:   Thu, 17 Jun 2021 16:14:23 +0200
Message-Id: <20210617141423.143584-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reto Schneider <reto.schneider@husqvarnagroup.com>

This chip has been (briefly) tested on the MediaTek MT7688 based GARDENA
smart gateway.

Datasheet: http://xmcwh.com/Uploads/2020-12-17/XM25QH64C_Ver1.1.pdf
Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
Reviewed-by: Michael Walle <michael@walle.cc>

---

Changes in v2:
- Use Datasheet: tag

 drivers/mtd/spi-nor/xmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 2c7773b68993..b6ac37bd59b8 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -12,6 +12,8 @@ static const struct flash_info xmc_parts[] = {
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128,
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "XM25QH64C", INFO(0x204017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 };
-- 
2.30.2

