Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5374445E281
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbhKYVcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:32:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:60479 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233572AbhKYVam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:30:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="234301050"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="234301050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="741844160"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 13:27:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1849567; Thu, 25 Nov 2021 23:27:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 1/3] misc: at25: Make driver OF independent again
Date:   Thu, 25 Nov 2021 23:27:27 +0200
Message-Id: <20211125212729.86585-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f60e7074902a ("misc: at25: Make use of device property API")
made a good job by enabling the driver for non-OF platforms, but the
recent commit 604288bc6196 ("nvmem: eeprom: at25: fix type compiler warnings")
brought that back.

Restore greatness of the driver once again.

Fixes: eab61fb1cc2e ("nvmem: eeprom: at25: fram discovery simplification")
Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 632325474233..57599eac2f71 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -17,8 +17,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/math.h>
 
 /*
@@ -381,13 +379,14 @@ static int at25_probe(struct spi_device *spi)
 	int			sr;
 	u8 id[FM25_ID_LEN];
 	u8 sernum[FM25_SN_LEN];
+	bool is_fram;
 	int i;
-	const struct of_device_id *match;
-	bool is_fram = 0;
 
-	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
-	if (match && !strcmp(match->compatible, "cypress,fm25"))
-		is_fram = 1;
+	err = device_property_match_string(&spi->dev, "compatible", "cypress,fm25");
+	if (err >= 0)
+		is_fram = true;
+	else
+		is_fram = false;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-- 
2.33.0

