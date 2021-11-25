Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195BB45E2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357226AbhKYVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:45:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:17763 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbhKYVnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:43:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="259469989"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="259469989"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="592105593"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 13:32:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 05A5667; Thu, 25 Nov 2021 23:32:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 01/10] misc: at25: Use at25->chip instead of local chip everywhere in ->probe()
Date:   Thu, 25 Nov 2021 23:31:54 +0200
Message-Id: <20211125213203.86693-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently some values are compared against the contents of the chip structure
and most are from its updated copy in at25->chip. Use the latter one everywhere
in ->probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index e21216541b0f..6bea9c7c64a0 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -434,8 +434,8 @@ static int at25_probe(struct spi_device *spi)
 			return -ENODEV;
 		}
 
-		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
-		if (chip.byte_len > 64 * 1024)
+		at25->chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+		if (at25->chip.byte_len > 64 * 1024)
 			at25->chip.flags |= EE_ADDR3;
 		else
 			at25->chip.flags |= EE_ADDR2;
@@ -466,7 +466,7 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.type = is_fram ? NVMEM_TYPE_FRAM : NVMEM_TYPE_EEPROM;
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
-	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
+	at25->nvmem_config.read_only = at25->chip.flags & EE_READONLY;
 	at25->nvmem_config.root_only = true;
 	at25->nvmem_config.owner = THIS_MODULE;
 	at25->nvmem_config.compat = true;
@@ -476,17 +476,17 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.priv = at25;
 	at25->nvmem_config.stride = 1;
 	at25->nvmem_config.word_size = 1;
-	at25->nvmem_config.size = chip.byte_len;
+	at25->nvmem_config.size = at25->chip.byte_len;
 
 	at25->nvmem = devm_nvmem_register(&spi->dev, &at25->nvmem_config);
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);
 
 	dev_info(&spi->dev, "%d %s %s %s%s, pagesize %u\n",
-		 (chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
-		 (chip.byte_len < 1024) ? "Byte" : "KByte",
+		 (at25->chip.byte_len < 1024) ? at25->chip.byte_len : (at25->chip.byte_len / 1024),
+		 (at25->chip.byte_len < 1024) ? "Byte" : "KByte",
 		 at25->chip.name, is_fram ? "fram" : "eeprom",
-		 (chip.flags & EE_READONLY) ? " (readonly)" : "",
+		 (at25->chip.flags & EE_READONLY) ? " (readonly)" : "",
 		 at25->chip.page_size);
 	return 0;
 }
-- 
2.33.0

