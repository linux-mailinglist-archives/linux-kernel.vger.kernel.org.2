Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5210945E295
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351785AbhKYVhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:37:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:19914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243749AbhKYVfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:35:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296374599"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296374599"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457971702"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46302288; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 06/10] misc: at25: Switch to use BIT() instead of custom approaches
Date:   Thu, 25 Nov 2021 23:31:59 +0200
Message-Id: <20211125213203.86693-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's obvious that custom approach of getting power of 2 number with
int_pow() kinda interesting. Replace it and some others approaches
by using a simple BIT() operation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 70cab386040a..c9660a4625ce 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2006 David Brownell
  */
 
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -17,7 +18,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
-#include <linux/math.h>
 
 /*
  * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
@@ -94,7 +94,7 @@ static int at25_ee_read(void *priv, unsigned int offset,
 
 	instr = AT25_READ;
 	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-		if (offset >= (1U << (at25->addrlen * 8)))
+		if (offset >= BIT(at25->addrlen * 8))
 			instr |= AT25_INSTR_BIT3;
 	*cp++ = instr;
 
@@ -227,7 +227,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 
 		instr = AT25_WRITE;
 		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-			if (offset >= (1U << (at25->addrlen * 8)))
+			if (offset >= BIT(at25->addrlen * 8))
 				instr |= AT25_INSTR_BIT3;
 		*cp++ = instr;
 
@@ -437,7 +437,7 @@ static int at25_probe(struct spi_device *spi)
 			return -ENODEV;
 		}
 
-		at25->chip.byte_len = int_pow(2, id[7] - 0x21 + 4) * 1024;
+		at25->chip.byte_len = BIT(id[7] - 0x21 + 4) * 1024;
 		if (at25->chip.byte_len > 64 * 1024)
 			at25->chip.flags |= EE_ADDR3;
 		else
-- 
2.33.0

