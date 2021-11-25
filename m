Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070545E2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhKYVmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:42:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:25768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243231AbhKYVkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:40:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216279367"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216279367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="554728837"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2021 13:32:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B7A42D2; Thu, 25 Nov 2021 23:32:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 08/10] misc: at25: Reorganize headers for better maintenance
Date:   Thu, 25 Nov 2021 23:32:01 +0200
Message-Id: <20211125213203.86693-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split headers to three groups and sort alphabetically in each of them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index b9d26c9ee768..3e60124d14a3 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -7,17 +7,18 @@
  */
 
 #include <linux/bits.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
-#include <linux/nvmem-provider.h>
-#include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
-#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#include <linux/nvmem-provider.h>
 
 /*
  * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
-- 
2.33.0

