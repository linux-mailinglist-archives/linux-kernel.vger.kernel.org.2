Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1336A12D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhDXMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:38:26 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:55070 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhDXMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:38:15 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id A492EF40460; Sat, 24 Apr 2021 14:30:52 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] misc: eeprom_93xx46: Add new at93c56 and at93c66 compatible strings
Date:   Sat, 24 Apr 2021 14:30:30 +0200
Message-Id: <20210424123034.11755-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424123034.11755-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two devices have respectively 2048 and 4096 bits of storage,
compared to 1024 for the 93c46.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../bindings/misc/eeprom-93xx46.txt           |  3 +++
 drivers/misc/eeprom/eeprom_93xx46.c           | 21 ++++++++++++++++++-
 include/linux/eeprom_93xx46.h                 |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
index 7b636b7a8311..72ea0af368d4 100644
--- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
+++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
@@ -2,7 +2,10 @@ EEPROMs (SPI) compatible with Microchip Technology 93xx46 family.
 
 Required properties:
 - compatible : shall be one of:
+    "atmel,at93c46"
     "atmel,at93c46d"
+    "atmel,at93c56"
+    "atmel,at93c66"
     "eeprom-93xx46"
     "microchip,93lc46b"
 - data-size : number of data bits per word (either 8 or 16)
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 80114f4c80ad..64dd76f66463 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -28,14 +28,29 @@
 
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
 
@@ -375,8 +390,11 @@ static void select_deassert(void *context)
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
@@ -425,6 +443,7 @@ static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 	if (of_id->data) {
 		const struct eeprom_93xx46_devtype_data *data = of_id->data;
 
+		pd->flags |= data->flags;
 		pd->quirks = data->quirks;
 	}
 
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

