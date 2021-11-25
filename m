Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A472645E282
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357203AbhKYVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:32:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:21457 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235610AbhKYVan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:30:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235392645"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235392645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="475725469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 13:27:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 353EDE6; Thu, 25 Nov 2021 23:27:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 3/3] misc: at25: Check proper value of chip length in FRAM case
Date:   Thu, 25 Nov 2021 23:27:29 +0200
Message-Id: <20211125212729.86585-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously the byte_len value should be checked from the chip
and not from at25->chip.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index f0b0efc30ee6..e21216541b0f 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -433,9 +433,9 @@ static int at25_probe(struct spi_device *spi)
 			dev_err(&spi->dev, "Error: unsupported size (id %02x)\n", id[7]);
 			return -ENODEV;
 		}
-		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
 
-		if (at25->chip.byte_len > 64 * 1024)
+		chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+		if (chip.byte_len > 64 * 1024)
 			at25->chip.flags |= EE_ADDR3;
 		else
 			at25->chip.flags |= EE_ADDR2;
-- 
2.33.0

