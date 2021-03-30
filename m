Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65034F1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhC3Te3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:34:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:52605 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhC3Td6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:33:58 -0400
IronPort-SDR: 0Lz+cxIxPSCY3Oi1mxtWUC1HXqP2kr/WEnN1sJszmG8nVg9RTOTZJGFBWZn45Wh4OeotHUtzAP
 zO9bUValMuuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="255833529"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="255833529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 12:33:53 -0700
IronPort-SDR: ipDdXhM0HYmcXzaf5Bf5Vbfu1j7BG0thITxWAWCWipi737+S+pQCLCZ67577xD6V8XEehnSbid
 O2x0rQCw4wtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="455158028"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2021 12:33:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA1C7133; Tue, 30 Mar 2021 22:34:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] mux: gpio: Use bitmap API instead of direct assignment
Date:   Tue, 30 Mar 2021 22:33:23 +0300
Message-Id: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning bitmaps like it's done in the driver might be error prone.
Fix this by using bitmap API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Peter Rosin <peda@axentia.se>
---
v2: left blank line untouched (Peter)
 drivers/mux/gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 02c1f2c014e8..d1b4aa923657 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -7,6 +7,7 @@
  * Author: Peter Rosin <peda@axentia.se>
  */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -23,8 +24,9 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
 	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
+	u32 value = state;
 
-	values[0] = state;
+	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
 				       mux_gpio->gpios->desc,
@@ -71,7 +73,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
-	mux_chip->mux->states = 1 << pins;
+	mux_chip->mux->states = BIT(pins);
 
 	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
 	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
-- 
2.30.2

