Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1FC45E29C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbhKYVk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:40:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:55944 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349146AbhKYVi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:38:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="321804758"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="321804758"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="607664353"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50FCF28E; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 07/10] misc: at25: Factor out at_fram_to_chip()
Date:   Thu, 25 Nov 2021 23:32:00 +0200
Message-Id: <20211125213203.86693-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the similar way as it's done for EEPROM, factor out
a new helper function for FRAM.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 85 ++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index c9660a4625ce..b9d26c9ee768 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -31,9 +31,9 @@
 
 #define	FM25_SN_LEN	8		/* serial number length */
 struct at25_data {
+	struct spi_eeprom	chip;
 	struct spi_device	*spi;
 	struct mutex		lock;
-	struct spi_eeprom	chip;
 	unsigned		addrlen;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
@@ -360,6 +360,44 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	return 0;
 }
 
+static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
+{
+	struct at25_data *at25 = container_of(chip, struct at25_data, chip);
+	u8 sernum[FM25_SN_LEN];
+	u8 id[FM25_ID_LEN];
+	int i;
+
+	strncpy(chip->name, "fm25", sizeof(chip->name));
+
+	/* Get ID of chip */
+	fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
+	if (id[6] != 0xc2) {
+		dev_err(dev, "Error: no Cypress FRAM (id %02x)\n", id[6]);
+		return -ENODEV;
+	}
+	/* Set size found in ID */
+	if (id[7] < 0x21 || id[7] > 0x26) {
+		dev_err(dev, "Error: unsupported size (id %02x)\n", id[7]);
+		return -ENODEV;
+	}
+
+	chip->byte_len = BIT(id[7] - 0x21 + 4) * 1024;
+	if (chip->byte_len > 64 * 1024)
+		chip->flags |= EE_ADDR3;
+	else
+		chip->flags |= EE_ADDR2;
+
+	if (id[8]) {
+		fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
+		/* Swap byte order */
+		for (i = 0; i < FM25_SN_LEN; i++)
+			at25->sernum[i] = sernum[FM25_SN_LEN - 1 - i];
+	}
+
+	chip->page_size = PAGE_SIZE;
+	return 0;
+}
+
 static const struct of_device_id at25_of_match[] = {
 	{ .compatible = "atmel,at25",},
 	{ .compatible = "cypress,fm25",},
@@ -380,10 +418,7 @@ static int at25_probe(struct spi_device *spi)
 	int			err;
 	int			sr;
 	struct spi_eeprom *pdata;
-	u8 id[FM25_ID_LEN];
-	u8 sernum[FM25_SN_LEN];
 	bool is_fram;
-	int i;
 
 	err = device_property_match_string(&spi->dev, "compatible", "cypress,fm25");
 	if (err >= 0)
@@ -414,44 +449,12 @@ static int at25_probe(struct spi_device *spi)
 	if (pdata) {
 		at25->chip = *pdata;
 	} else {
-		if (is_fram) {
-			/* We file fields for FRAM case later on */
-		} else {
-			err = at25_fw_to_chip(&spi->dev, &at25->chip);
-			if (err)
-				return err;
-		}
-	}
-
-	if (is_fram) {
-		/* Get ID of chip */
-		fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
-		if (id[6] != 0xc2) {
-			dev_err(&spi->dev,
-				"Error: no Cypress FRAM (id %02x)\n", id[6]);
-			return -ENODEV;
-		}
-		/* set size found in ID */
-		if (id[7] < 0x21 || id[7] > 0x26) {
-			dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
-			return -ENODEV;
-		}
-
-		at25->chip.byte_len = BIT(id[7] - 0x21 + 4) * 1024;
-		if (at25->chip.byte_len > 64 * 1024)
-			at25->chip.flags |= EE_ADDR3;
+		if (is_fram)
+			err = at25_fram_to_chip(&spi->dev, &at25->chip);
 		else
-			at25->chip.flags |= EE_ADDR2;
-
-		if (id[8]) {
-			fm25_aux_read(at25, sernum, FM25_RDSN, FM25_SN_LEN);
-			/* swap byte order */
-			for (i = 0; i < FM25_SN_LEN; i++)
-				at25->sernum[i] = sernum[FM25_SN_LEN - 1 - i];
-		}
-
-		at25->chip.page_size = PAGE_SIZE;
-		strncpy(at25->chip.name, "fm25", sizeof(at25->chip.name));
+			err = at25_fw_to_chip(&spi->dev, &at25->chip);
+		if (err)
+			return err;
 	}
 
 	/* For now we only support 8/16/24 bit addressing */
-- 
2.33.0

