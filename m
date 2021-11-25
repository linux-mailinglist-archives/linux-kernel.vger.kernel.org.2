Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72C45E2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbhKYVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:43:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:25829 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234862AbhKYVlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:41:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216279371"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216279371"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="475726151"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 670F1352; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 09/10] misc: at25: Replace commas by spaces in the ID tables
Date:   Thu, 25 Nov 2021 23:32:02 +0200
Message-Id: <20211125213203.86693-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better readability replace commas by spaces in the ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 3e60124d14a3..9264bb17963e 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -400,15 +400,15 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 }
 
 static const struct of_device_id at25_of_match[] = {
-	{ .compatible = "atmel,at25",},
-	{ .compatible = "cypress,fm25",},
+	{ .compatible = "atmel,at25" },
+	{ .compatible = "cypress,fm25" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, at25_of_match);
 
 static const struct spi_device_id at25_spi_ids[] = {
-	{ .name = "at25",},
-	{ .name = "fm25",},
+	{ .name = "at25" },
+	{ .name = "fm25" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, at25_spi_ids);
-- 
2.33.0

