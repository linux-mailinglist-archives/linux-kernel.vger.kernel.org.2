Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6F45E297
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351278AbhKYVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:37:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:19943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351286AbhKYVf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:35:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296374600"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296374600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457971703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7294C362; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 10/10] misc: at25: Align comment style
Date:   Thu, 25 Nov 2021 23:32:03 +0200
Message-Id: <20211125213203.86693-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make multi-line comment style aligned.
While at it, drop filename from the file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 9264bb17963e..f16f67baf3d2 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * at25.c -- support most SPI EEPROMs, such as Atmel AT25 models
- *	     and Cypress FRAMs FM25 models
+ * Driver for most of the SPI EEPROMs, such as Atmel AT25 models
+ * and Cypress FRAMs FM25 models.
  *
  * Copyright (C) 2006 David Brownell
  */
@@ -21,7 +21,7 @@
 #include <linux/nvmem-provider.h>
 
 /*
- * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
+ * NOTE: this is an *EEPROM* driver. The vagaries of product naming
  * mean that some AT25 products are EEPROMs, and others are FLASH.
  * Handle FLASH chips with the drivers/mtd/devices/m25p80.c driver,
  * not this one!
@@ -57,13 +57,14 @@ struct at25_data {
 #define	AT25_SR_BP1	0x08
 #define	AT25_SR_WPEN	0x80		/* writeprotect enable */
 
-#define	AT25_INSTR_BIT3	0x08		/* Additional address bit in instr */
+#define	AT25_INSTR_BIT3	0x08		/* additional address bit in instr */
 
 #define	FM25_ID_LEN	9		/* ID length */
 
 #define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
 
-/* Specs often allow 5 msec for a page write, sometimes 20 msec;
+/*
+ * Specs often allow 5ms for a page write, sometimes 20ms;
  * it's important to recover from write timeouts.
  */
 #define	EE_TIMEOUT	25
@@ -108,7 +109,7 @@ static int at25_ee_read(void *priv, unsigned int offset,
 		*cp++ = offset >> 8;
 		fallthrough;
 	case 1:
-	case 0:	/* can't happen: for better codegen */
+	case 0:	/* can't happen: for better code generation */
 		*cp++ = offset >> 0;
 	}
 
@@ -125,11 +126,12 @@ static int at25_ee_read(void *priv, unsigned int offset,
 
 	mutex_lock(&at25->lock);
 
-	/* Read it all at once.
+	/*
+	 * Read it all at once.
 	 *
 	 * REVISIT that's potentially a problem with large chips, if
 	 * other devices on the bus need to be accessed regularly or
-	 * this chip is clocked very slowly
+	 * this chip is clocked very slowly.
 	 */
 	status = spi_sync(at25->spi, &m);
 	dev_dbg(&at25->spi->dev, "read %zu bytes at %d --> %zd\n",
@@ -139,9 +141,7 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	return status;
 }
 
-/*
- * read extra registers as ID or serial number
- */
+/* Read extra registers as ID or serial number */
 static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
 			 int len)
 {
@@ -207,7 +207,8 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	if (!bounce)
 		return -ENOMEM;
 
-	/* For write, rollover is within the page ... so we write at
+	/*
+	 * For write, rollover is within the page ... so we write at
 	 * most one page, then manually roll over to the next page.
 	 */
 	mutex_lock(&at25->lock);
@@ -241,7 +242,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 			*cp++ = offset >> 8;
 			fallthrough;
 		case 1:
-		case 0:	/* can't happen: for better codegen */
+		case 0:	/* can't happen: for better code generation */
 			*cp++ = offset >> 0;
 		}
 
@@ -257,8 +258,9 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		if (status < 0)
 			break;
 
-		/* REVISIT this should detect (or prevent) failed writes
-		 * to readonly sections of the EEPROM...
+		/*
+		 * REVISIT this should detect (or prevent) failed writes
+		 * to read-only sections of the EEPROM...
 		 */
 
 		/* Wait for non-busy status */
@@ -427,8 +429,9 @@ static int at25_probe(struct spi_device *spi)
 	else
 		is_fram = false;
 
-	/* Ping the chip ... the status register is pretty portable,
-	 * unlike probing manufacturer IDs.  We do expect that system
+	/*
+	 * Ping the chip ... the status register is pretty portable,
+	 * unlike probing manufacturer IDs. We do expect that system
 	 * firmware didn't write it in the past few milliseconds!
 	 */
 	sr = spi_w8r8(spi, AT25_RDSR);
-- 
2.33.0

