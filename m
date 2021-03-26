Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF7934AD41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:24:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:44195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:23:53 -0400
IronPort-SDR: 6dOP9eszbCFhx1HR8BVVLhHpSxB6BEqcLGwzQFvZjOdODJXJwZmI4Dwdwqg3DXGlsGcKNs6Y15
 oGuDg5/1HQsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="171182149"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="171182149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 10:23:52 -0700
IronPort-SDR: k/GVCRLYG7QDMuSzqOUN3JK3IVXmC683HCJyssz32PB8vCFlf1962IuexFQGBq8K3vp8DT2X1O
 z/sVPLqw53nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="608947187"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2021 10:23:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC86811F; Fri, 26 Mar 2021 19:24:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 1/3] mux: gpio: Use bitmap API instead of direct assignment
Date:   Fri, 26 Mar 2021 19:23:59 +0200
Message-Id: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning bitmaps like it's done in the driver might be error prone.
Fix this by using bitmap API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mux/gpio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 02c1f2c014e8..891ee0274733 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -6,7 +6,7 @@
  *
  * Author: Peter Rosin <peda@axentia.se>
  */
-
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -23,8 +23,9 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
 	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
+	u32 value = state;
 
-	values[0] = state;
+	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
 				       mux_gpio->gpios->desc,
@@ -71,7 +72,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
-	mux_chip->mux->states = 1 << pins;
+	mux_chip->mux->states = BIT(pins);
 
 	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
 	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
-- 
2.30.2

