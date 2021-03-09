Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7933318D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCIWeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:34:15 -0500
Received: from finn.gateworks.com ([108.161.129.64]:50434 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230215AbhCIWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:33:39 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1lJkQx-001Npo-9q; Tue, 09 Mar 2021 22:02:31 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/4] mtd: spi-nor: fujitsu: add support for MB85RS4MT
Date:   Tue,  9 Mar 2021 14:00:12 -0800
Message-Id: <20210309220014.22205-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309220014.22205-1-tharvey@gateworks.com>
References: <20210309220014.22205-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Fujitsu MB85RS4MT SPI FRAM EEPROM device.

This is a 512KiB FRAM EEPROM.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/mtd/spi-nor/fujitsu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/fujitsu.c b/drivers/mtd/spi-nor/fujitsu.c
index e385d93e756c..9df5d0576cea 100644
--- a/drivers/mtd/spi-nor/fujitsu.c
+++ b/drivers/mtd/spi-nor/fujitsu.c
@@ -11,6 +11,7 @@
 static const struct flash_info fujitsu_parts[] = {
 	/* Fujitsu */
 	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1, SPI_NOR_NO_ERASE) },
+	{ "mb85rs4mt", INFO(0x047f49, 0, 512 * 1024, 1, SPI_NOR_NO_ERASE) },
 };
 
 const struct spi_nor_manufacturer spi_nor_fujitsu = {
-- 
2.17.1

