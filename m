Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A233345E296
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352018AbhKYVhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:37:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:42062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243722AbhKYVfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:35:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235812025"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235812025"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="509863942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B50F18D; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 05/10] misc: at25: Get rid of intermediate storage for AT25 chip data
Date:   Thu, 25 Nov 2021 23:31:58 +0200
Message-Id: <20211125213203.86693-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to copy twice the same data. Drop needless local
variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index b235f20c56da..70cab386040a 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -306,7 +306,6 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	u32 val;
 	int err;
 
-	memset(chip, 0, sizeof(*chip));
 	strncpy(chip->name, "at25", sizeof(chip->name));
 
 	err = device_property_read_u32(dev, "size", &val);
@@ -378,9 +377,9 @@ MODULE_DEVICE_TABLE(spi, at25_spi_ids);
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
-	struct spi_eeprom	chip, *pdata;
 	int			err;
 	int			sr;
+	struct spi_eeprom *pdata;
 	u8 id[FM25_ID_LEN];
 	u8 sernum[FM25_SN_LEN];
 	bool is_fram;
@@ -392,20 +391,6 @@ static int at25_probe(struct spi_device *spi)
 	else
 		is_fram = false;
 
-	/* Chip description */
-	pdata = dev_get_platdata(&spi->dev);
-	if (!pdata) {
-		if (is_fram) {
-			/* We file fields for FRAM case later on */
-			memset(&chip, 0, sizeof(chip));
-		} else {
-			err = at25_fw_to_chip(&spi->dev, &chip);
-			if (err)
-				return err;
-		}
-	} else
-		chip = *pdata;
-
 	/* Ping the chip ... the status register is pretty portable,
 	 * unlike probing manufacturer IDs.  We do expect that system
 	 * firmware didn't write it in the past few milliseconds!
@@ -421,10 +406,23 @@ static int at25_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	mutex_init(&at25->lock);
-	at25->chip = chip;
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
 
+	/* Chip description */
+	pdata = dev_get_platdata(&spi->dev);
+	if (pdata) {
+		at25->chip = *pdata;
+	} else {
+		if (is_fram) {
+			/* We file fields for FRAM case later on */
+		} else {
+			err = at25_fw_to_chip(&spi->dev, &at25->chip);
+			if (err)
+				return err;
+		}
+	}
+
 	if (is_fram) {
 		/* Get ID of chip */
 		fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
-- 
2.33.0

