Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9F45E283
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbhKYVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:33:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:29414 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244740AbhKYVbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:31:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222795997"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222795997"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="607663686"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 13:27:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2665E11C; Thu, 25 Nov 2021 23:27:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH v1 2/3] misc: at25: Don't copy garbage to the at25->chip in FRAM case
Date:   Thu, 25 Nov 2021 23:27:28 +0200
Message-Id: <20211125212729.86585-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if we know that we are going to fill everything later on
it's bad style and fragile to copy garbage from the stack to
the data structure that will be used in the driver.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 57599eac2f71..f0b0efc30ee6 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -390,7 +390,10 @@ static int at25_probe(struct spi_device *spi)
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-		if (!is_fram) {
+		if (is_fram) {
+			/* We file fields for FRAM case later on */
+			memset(&chip, 0, sizeof(chip));
+		} else {
 			err = at25_fw_to_chip(&spi->dev, &chip);
 			if (err)
 				return err;
-- 
2.33.0

