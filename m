Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D1E34F1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhC3Teb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:34:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:55947 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233185AbhC3TeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:34:01 -0400
IronPort-SDR: nSAXVUHGIOHQMFajZ0Br+CAwPOVQiXn3GC3j7u1n8z3moK29YPfvE/yOcHk1rT63NHjNZ2Er4i
 P/xteV2Yc8gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191870641"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191870641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 12:33:59 -0700
IronPort-SDR: 5+CChIrFyBJo8MUV3bFYkgmwXJxX1ZiIMZbnIFHajcGvPsk7739HVKP72GM3EQ6cLZ1qQmckAK
 1MmGpGorHPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445294190"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2021 12:33:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 44120133; Tue, 30 Mar 2021 22:34:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] mux: gpio: Make it OF independent
Date:   Tue, 30 Mar 2021 22:33:24 +0300
Message-Id: <20210330193325.68362-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
References: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module doesn't use OF APIs anyhow, make it OF independent by replacing
headers and dropping useless of_match_ptr() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
v2: moved mod_devicetable before module (Peter)
 drivers/mux/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index d1b4aa923657..92cc476c916e 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -10,9 +10,9 @@
 #include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mux/driver.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
@@ -98,7 +98,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
 static struct platform_driver mux_gpio_driver = {
 	.driver = {
 		.name = "gpio-mux",
-		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
+		.of_match_table	= mux_gpio_dt_ids,
 	},
 	.probe = mux_gpio_probe,
 };
-- 
2.30.2

