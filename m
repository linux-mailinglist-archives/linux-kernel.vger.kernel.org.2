Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA245E294
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351144AbhKYVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:37:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:45492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243525AbhKYVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:35:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222796322"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222796322"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="741844744"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 13:32:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30778128; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 04/10] misc: at25: Get platform data via dev_get_platdata()
Date:   Thu, 25 Nov 2021 23:31:57 +0200
Message-Id: <20211125213203.86693-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 86f5433d0278..b235f20c56da 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -378,7 +378,7 @@ MODULE_DEVICE_TABLE(spi, at25_spi_ids);
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
-	struct spi_eeprom	chip;
+	struct spi_eeprom	chip, *pdata;
 	int			err;
 	int			sr;
 	u8 id[FM25_ID_LEN];
@@ -393,7 +393,8 @@ static int at25_probe(struct spi_device *spi)
 		is_fram = false;
 
 	/* Chip description */
-	if (!spi->dev.platform_data) {
+	pdata = dev_get_platdata(&spi->dev);
+	if (!pdata) {
 		if (is_fram) {
 			/* We file fields for FRAM case later on */
 			memset(&chip, 0, sizeof(chip));
@@ -403,7 +404,7 @@ static int at25_probe(struct spi_device *spi)
 				return err;
 		}
 	} else
-		chip = *(struct spi_eeprom *)spi->dev.platform_data;
+		chip = *pdata;
 
 	/* Ping the chip ... the status register is pretty portable,
 	 * unlike probing manufacturer IDs.  We do expect that system
-- 
2.33.0

