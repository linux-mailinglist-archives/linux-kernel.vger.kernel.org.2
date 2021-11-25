Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F545E293
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhKYVhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:37:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:19908 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243524AbhKYVfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:35:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296374596"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296374596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457971692"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 13:32:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20E27120; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 03/10] misc: at25: Check new property ("address-width") first
Date:   Thu, 25 Nov 2021 23:31:56 +0200
Message-Id: <20211125213203.86693-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's done elsewhere in at25_fw_to_chip() check new property
("address-width") first.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 027840c73fc8..86f5433d0278 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -327,13 +327,15 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	}
 	chip->page_size = val;
 
-	err = device_property_read_u32(dev, "at25,addr-mode", &val);
+	err = device_property_read_u32(dev, "address-width", &val);
 	if (err) {
-		err = device_property_read_u32(dev, "address-width", &val);
+		err = device_property_read_u32(dev, "at25,addr-mode", &val);
 		if (err) {
 			dev_err(dev, "Error: missing \"address-width\" property\n");
 			return err;
 		}
+		chip->flags = (u16)val;
+	} else {
 		switch (val) {
 		case 9:
 			chip->flags |= EE_INSTR_BIT3_IS_ADDR;
@@ -355,8 +357,6 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 		}
 		if (device_property_present(dev, "read-only"))
 			chip->flags |= EE_READONLY;
-	} else {
-		chip->flags = (u16)val;
 	}
 	return 0;
 }
-- 
2.33.0

