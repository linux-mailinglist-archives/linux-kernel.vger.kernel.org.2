Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFA36A32E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhDXV0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 17:26:34 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:32870 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhDXV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 17:26:33 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id B45D5F4053F; Sat, 24 Apr 2021 23:25:52 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] misc: eeprom_93xx46: Add new 93c56 and 93c66 compatible strings
Date:   Sat, 24 Apr 2021 23:25:42 +0200
Message-Id: <20210424212543.13929-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424212543.13929-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two devices have respectively 2048 and 4096 bits of storage,
compared to 1024 for the 93c46.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 35 ++++++++++++++++++++++++++---
 include/linux/eeprom_93xx46.h       |  3 +++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index ffdb8e5a26e0..29d8971ec558 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -29,14 +29,29 @@
 
 struct eeprom_93xx46_devtype_data {
 	unsigned int quirks;
+	unsigned char flags;
+};
+
+static const struct eeprom_93xx46_devtype_data at93c46_data = {
+	.flags = EE_SIZE1K,
+};
+
+static const struct eeprom_93xx46_devtype_data at93c56_data = {
+	.flags = EE_SIZE2K,
+};
+
+static const struct eeprom_93xx46_devtype_data at93c66_data = {
+	.flags = EE_SIZE4K,
 };
 
 static const struct eeprom_93xx46_devtype_data atmel_at93c46d_data = {
+	.flags = EE_SIZE1K,
 	.quirks = EEPROM_93XX46_QUIRK_SINGLE_WORD_READ |
 		  EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH,
 };
 
 static const struct eeprom_93xx46_devtype_data microchip_93lc46b_data = {
+	.flags = EE_SIZE1K,
 	.quirks = EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE,
 };
 
@@ -381,8 +396,11 @@ static void select_deassert(void *context)
 }
 
 static const struct of_device_id eeprom_93xx46_of_table[] = {
-	{ .compatible = "eeprom-93xx46", },
+	{ .compatible = "eeprom-93xx46", .data = &at93c46_data, },
+	{ .compatible = "atmel,at93c46", .data = &at93c46_data, },
 	{ .compatible = "atmel,at93c46d", .data = &atmel_at93c46d_data, },
+	{ .compatible = "atmel,at93c56", .data = &at93c56_data, },
+	{ .compatible = "atmel,at93c66", .data = &at93c66_data, },
 	{ .compatible = "microchip,93lc46b", .data = &microchip_93lc46b_data, },
 	{}
 };
@@ -432,6 +450,7 @@ static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 		const struct eeprom_93xx46_devtype_data *data = of_id->data;
 
 		pd->quirks = data->quirks;
+		pd->flags |= data->flags;
 	}
 
 	spi->dev.platform_data = pd;
@@ -461,7 +480,16 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	if (!edev)
 		return -ENOMEM;
 
-	edev->size = 128;
+	if (pd->flags & EE_SIZE1K)
+		edev->size = 128;
+	else if (pd->flags & EE_SIZE2K)
+		edev->size = 256;
+	else if (pd->flags & EE_SIZE4K)
+		edev->size = 512;
+	else {
+		dev_err(&spi->dev, "unspecified size\n");
+		return -EINVAL;
+	}
 
 	if (pd->flags & EE_ADDR8)
 		edev->addrlen = ilog2(edev->size);
@@ -496,8 +524,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	if (IS_ERR(edev->nvmem))
 		return PTR_ERR(edev->nvmem);
 
-	dev_info(&spi->dev, "%d-bit eeprom %s\n",
+	dev_info(&spi->dev, "%d-bit eeprom containing %d bytes %s\n",
 		(pd->flags & EE_ADDR8) ? 8 : 16,
+		edev->size,
 		(pd->flags & EE_READONLY) ? "(readonly)" : "");
 
 	if (!(pd->flags & EE_READONLY)) {
diff --git a/include/linux/eeprom_93xx46.h b/include/linux/eeprom_93xx46.h
index 99580c22f91a..34c2175e6a1e 100644
--- a/include/linux/eeprom_93xx46.h
+++ b/include/linux/eeprom_93xx46.h
@@ -10,6 +10,9 @@ struct eeprom_93xx46_platform_data {
 #define EE_ADDR8	0x01		/*  8 bit addr. cfg */
 #define EE_ADDR16	0x02		/* 16 bit addr. cfg */
 #define EE_READONLY	0x08		/* forbid writing */
+#define EE_SIZE1K	0x10		/* 1 kb of data, that is a 93xx46 */
+#define EE_SIZE2K	0x20		/* 2 kb of data, that is a 93xx56 */
+#define EE_SIZE4K	0x40		/* 4 kb of data, that is a 93xx66 */
 
 	unsigned int	quirks;
 /* Single word read transfers only; no sequential read. */
-- 
2.31.1

