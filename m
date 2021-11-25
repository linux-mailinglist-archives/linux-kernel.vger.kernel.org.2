Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C045E2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351367AbhKYVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:41:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:36692 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235980AbhKYVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:39:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215596098"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="215596098"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="571949452"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2021 13:32:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 113A711C; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 02/10] misc: at25: Unshadow error codes in at25_fw_to_chip()
Date:   Thu, 25 Nov 2021 23:31:55 +0200
Message-Id: <20211125213203.86693-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_property_read_u32() may return different error codes.
Unshadow them in the at25_fw_to_chip() to give better error
report.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 40 +++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 6bea9c7c64a0..027840c73fc8 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -304,33 +304,35 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 {
 	u32 val;
+	int err;
 
 	memset(chip, 0, sizeof(*chip));
 	strncpy(chip->name, "at25", sizeof(chip->name));
 
-	if (device_property_read_u32(dev, "size", &val) == 0 ||
-	    device_property_read_u32(dev, "at25,byte-len", &val) == 0) {
-		chip->byte_len = val;
-	} else {
+	err = device_property_read_u32(dev, "size", &val);
+	if (err)
+		err = device_property_read_u32(dev, "at25,byte-len", &val);
+	if (err) {
 		dev_err(dev, "Error: missing \"size\" property\n");
-		return -ENODEV;
+		return err;
 	}
+	chip->byte_len = val;
 
-	if (device_property_read_u32(dev, "pagesize", &val) == 0 ||
-	    device_property_read_u32(dev, "at25,page-size", &val) == 0) {
-		chip->page_size = val;
-	} else {
+	err = device_property_read_u32(dev, "pagesize", &val);
+	if (err)
+		err = device_property_read_u32(dev, "at25,page-size", &val);
+	if (err) {
 		dev_err(dev, "Error: missing \"pagesize\" property\n");
-		return -ENODEV;
+		return err;
 	}
-
-	if (device_property_read_u32(dev, "at25,addr-mode", &val) == 0) {
-		chip->flags = (u16)val;
-	} else {
-		if (device_property_read_u32(dev, "address-width", &val)) {
-			dev_err(dev,
-				"Error: missing \"address-width\" property\n");
-			return -ENODEV;
+	chip->page_size = val;
+
+	err = device_property_read_u32(dev, "at25,addr-mode", &val);
+	if (err) {
+		err = device_property_read_u32(dev, "address-width", &val);
+		if (err) {
+			dev_err(dev, "Error: missing \"address-width\" property\n");
+			return err;
 		}
 		switch (val) {
 		case 9:
@@ -353,6 +355,8 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 		}
 		if (device_property_present(dev, "read-only"))
 			chip->flags |= EE_READONLY;
+	} else {
+		chip->flags = (u16)val;
 	}
 	return 0;
 }
-- 
2.33.0

