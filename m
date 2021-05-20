Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55B38B3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhETQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:03:45 -0400
Received: from router.aksignal.cz ([62.44.4.214]:57550 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhETQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:03:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 55119491C3;
        Thu, 20 May 2021 18:01:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id QX9ci3a1pKv8; Thu, 20 May 2021 18:01:32 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 5C047491C0;
        Thu, 20 May 2021 18:01:31 +0200 (CEST)
From:   Jiri Prchal <jiri.prchal@aksignal.cz>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 2/5] nvmem: eeprom: at25: add support for FRAM
Date:   Thu, 20 May 2021 18:01:24 +0200
Message-Id: <20210520160127.51394-3-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
References: <20210520160127.51394-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for Cypress FRAMs.
These frams have ID and some of them have serial number too.
Size of them is recognized by ID. They don't have pages, it could
be read or written at once, but it's limited in this driver to
io limit 4096.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
v2: fixed warning at %zd at int
Reported-by: kernel test robot <lkp@intel.com>
v3: resend and added more recipients
v4: resend
v5: used in-kernel function int_pow
---
 drivers/misc/eeprom/Kconfig |   5 +-
 drivers/misc/eeprom/at25.c  | 141 ++++++++++++++++++++++++++++--------
 2 files changed, 114 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 0f791bfdc1f5..f0a7531f354c 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -32,12 +32,13 @@ config EEPROM_AT24
 	  will be called at24.
 
 config EEPROM_AT25
-	tristate "SPI EEPROMs from most vendors"
+	tristate "SPI EEPROMs (FRAMs) from most vendors"
 	depends on SPI && SYSFS
 	select NVMEM
 	select NVMEM_SYSFS
 	help
-	  Enable this driver to get read/write support to most SPI EEPROMs,
+	  Enable this driver to get read/write support to most SPI EEPROMs
+	  and Cypress FRAMs,
 	  after you configure the board init code to know about each eeprom
 	  on your target board.
 
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index b76e4901b4a4..45a486994828 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * at25.c -- support most SPI EEPROMs, such as Atmel AT25 models
+ *	     and Cypress FRAMs FM25 models
  *
  * Copyright (C) 2006 David Brownell
  */
@@ -16,6 +17,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/math.h>
 
 /*
  * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
@@ -34,6 +38,7 @@ struct at25_data {
 	unsigned		addrlen;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
+	int has_sernum;
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -42,6 +47,9 @@ struct at25_data {
 #define	AT25_WRSR	0x01		/* write status register */
 #define	AT25_READ	0x03		/* read byte(s) */
 #define	AT25_WRITE	0x02		/* write byte(s)/sector */
+#define	FM25_SLEEP	0xb9		/* enter sleep mode */
+#define	FM25_RDID	0x9f		/* read device ID */
+#define	FM25_RDSN	0xc3		/* read S/N */
 
 #define	AT25_SR_nRDY	0x01		/* nRDY = write-in-progress */
 #define	AT25_SR_WEN	0x02		/* write enable (latched) */
@@ -51,6 +59,9 @@ struct at25_data {
 
 #define	AT25_INSTR_BIT3	0x08		/* Additional address bit in instr */
 
+#define	FM25_ID_LEN	9		/* ID length */
+#define	FM25_SN_LEN	8		/* serial number length */
+
 #define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
 
 /* Specs often allow 5 msec for a page write, sometimes 20 msec;
@@ -58,6 +69,9 @@ struct at25_data {
  */
 #define	EE_TIMEOUT	25
 
+#define	IS_EEPROM	0
+#define	IS_FRAM		1
+
 /*-------------------------------------------------------------------------*/
 
 #define	io_limit	PAGE_SIZE	/* bytes */
@@ -129,6 +143,36 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	return status;
 }
 
+/*
+ * read extra registers as ID or serial number
+ */
+static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
+			 int len)
+{
+	int status;
+	struct spi_transfer t[2];
+	struct spi_message m;
+
+	spi_message_init(&m);
+	memset(t, 0, sizeof(t));
+
+	t[0].tx_buf = &command;
+	t[0].len = 1;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	t[1].len = len;
+	spi_message_add_tail(&t[1], &m);
+
+	mutex_lock(&at25->lock);
+
+	status = spi_sync(at25->spi, &m);
+	dev_dbg(&at25->spi->dev, "read %d aux bytes --> %d\n", len, status);
+
+	mutex_unlock(&at25->lock);
+	return status;
+}
+
 static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at25_data *at25 = priv;
@@ -303,34 +347,37 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	return 0;
 }
 
+static const struct of_device_id at25_of_match[] = {
+	{ .compatible = "atmel,at25", .data = (const void *)IS_EEPROM },
+	{ .compatible = "cypress,fm25", .data = (const void *)IS_FRAM },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at25_of_match);
+
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
 	struct spi_eeprom	chip;
 	int			err;
 	int			sr;
-	int			addrlen;
+	char id[FM25_ID_LEN];
+	const struct of_device_id *match;
+	int is_fram = 0;
+
+	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
+	if (match)
+		is_fram = (int)(uintptr_t)match->data;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-		err = at25_fw_to_chip(&spi->dev, &chip);
-		if (err)
-			return err;
+		if (!is_fram) {
+			err = at25_fw_to_chip(&spi->dev, &chip);
+			if (err)
+				return err;
+		}
 	} else
 		chip = *(struct spi_eeprom *)spi->dev.platform_data;
 
-	/* For now we only support 8/16/24 bit addressing */
-	if (chip.flags & EE_ADDR1)
-		addrlen = 1;
-	else if (chip.flags & EE_ADDR2)
-		addrlen = 2;
-	else if (chip.flags & EE_ADDR3)
-		addrlen = 3;
-	else {
-		dev_dbg(&spi->dev, "unsupported address type\n");
-		return -EINVAL;
-	}
-
 	/* Ping the chip ... the status register is pretty portable,
 	 * unlike probing manufacturer IDs.  We do expect that system
 	 * firmware didn't write it in the past few milliseconds!
@@ -349,9 +396,49 @@ static int at25_probe(struct spi_device *spi)
 	at25->chip = chip;
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
-	at25->addrlen = addrlen;
 
-	at25->nvmem_config.type = NVMEM_TYPE_EEPROM;
+	if (is_fram) {
+		/* Get ID of chip */
+		fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
+		if (id[6] != 0xc2) {
+			dev_err(&spi->dev,
+				"Error: no Cypress FRAM (id %02x)\n", id[6]);
+			return -ENODEV;
+		}
+		/* set size found in ID */
+		if (id[7] < 0x21 || id[7] > 0x26) {
+			dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
+			return -ENODEV;
+		}
+		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+
+		if (at25->chip.byte_len > 64 * 1024)
+			at25->chip.flags |= EE_ADDR3;
+		else
+			at25->chip.flags |= EE_ADDR2;
+
+		if (id[8])
+			at25->has_sernum = 1;
+		else
+			at25->has_sernum = 0;
+
+		at25->chip.page_size = PAGE_SIZE;
+		strncpy(at25->chip.name, "fm25", sizeof(at25->chip.name));
+	}
+
+	/* For now we only support 8/16/24 bit addressing */
+	if (at25->chip.flags & EE_ADDR1)
+		at25->addrlen = 1;
+	else if (at25->chip.flags & EE_ADDR2)
+		at25->addrlen = 2;
+	else if (at25->chip.flags & EE_ADDR3)
+		at25->addrlen = 3;
+	else {
+		dev_dbg(&spi->dev, "unsupported address type\n");
+		return -EINVAL;
+	}
+
+	at25->nvmem_config.type = is_fram ? NVMEM_TYPE_FRAM : NVMEM_TYPE_EEPROM;
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
 	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
@@ -370,23 +457,17 @@ static int at25_probe(struct spi_device *spi)
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);
 
-	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
-		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
-		(chip.byte_len < 1024) ? "Byte" : "KByte",
-		at25->chip.name,
-		(chip.flags & EE_READONLY) ? " (readonly)" : "",
-		at25->chip.page_size);
+	dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
+		 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
+		 (chip.byte_len < 1024) ? "Byte" : "KByte",
+		 at25->chip.name, is_fram ? "fram" : "eeprom",
+		 (chip.flags & EE_READONLY) ? " (readonly)" : "",
+		 at25->chip.page_size);
 	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
 
-static const struct of_device_id at25_of_match[] = {
-	{ .compatible = "atmel,at25", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, at25_of_match);
-
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
-- 
2.25.1

