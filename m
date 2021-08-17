Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF13EE0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhHQARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhHQARL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:17:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4827C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:16:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c12so16960412ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNlfDTm2XkePqm/itgh7jj38glw5emSbty3MWdBxwSs=;
        b=mmXQKiM3FDqgjRdrbWDFovfLyAdkZF3LHAqHH2N7MvdNQBb/r1/xqmuUHydP4SmZqe
         0/oK0sWz/kWxAU9iY726bYUwZwbTNiInLJSbvfPZT+HeA97YoJHftnx/9PYTR/Q2HzG6
         a72FRjj5NscupICDgtzz43HtjXdqbVg4idYwLNibIebjYG7bC75z8/SGkUAeZ8EoK4ma
         ksHtAumA058oTyn0sZpgPBCDEZKr7L0VZJ17y8kUSmnjF3WhWFN7phSZ9HLuGxeokxgT
         zlYxJlZyQvi6AO979DI6rZYjdPaH7Ei4f58ht1qw5GAVwjWLLQZqJc20PO2roQ/wQ2UC
         y56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNlfDTm2XkePqm/itgh7jj38glw5emSbty3MWdBxwSs=;
        b=UrxwNlScZQXD3wjZKlXAVwMtpee3CJpMJTwt2cSuE6LwkrjVZbdDvlNtx8+d31vdmd
         L9xP5JDBf/o1y0VKP9TWv/8/e3KUNNH+12iEwxGPJa5bygayAxc0y4eI9BeRPJOMJOse
         cE+5jVgg+MsibU2mQXTUq1F0lK2JijZSX0eiJv+/exo2nDgT/kj0xd5xXWEOdDHIeXfm
         nTwgVidLtPTjTQAQ+22ydu8iTQTDxYmuEKh0B5b2j50dESyZO4UK6ZX80Uks1wTuiTqm
         9VU4jhsBa3A/1Q829IGmIWqVtBvsv+wCH332ywtb7bb+I3s73VJCHnmjP53VE92YJmwE
         L9aQ==
X-Gm-Message-State: AOAM532Szb200JiyCc6ZBjXQNHJAyfwoBUDaUZMIidaFnKtJfzkPMgMK
        qJudlUxH+9XCdpo3k6gPCta4mg==
X-Google-Smtp-Source: ABdhPJw7bh8yH9xHSNsgIBPOF2j+W1FMlMgOg2QS/IwhOEMysQHXHMJ/sNtkBKjci56s38IYLpPJ3w==
X-Received: by 2002:a05:651c:2105:: with SMTP id a5mr694076ljq.259.1629159396847;
        Mon, 16 Aug 2021 17:16:36 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u15sm33927lfs.203.2021.08.16.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:16:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mfd: htc-i2cpld: Convert to a pure GPIO driver
Date:   Tue, 17 Aug 2021 02:14:34 +0200
Message-Id: <20210817001434.516298-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing GPIO numbers pertaining to ourselves through
platform data, just request GPIO descriptors from our own GPIO
chips and use them, and cut down on the unnecessary complexity.

Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-htcherald.c |  9 ----
 drivers/mfd/htc-i2cpld.c              | 59 ++++++++++++---------------
 include/linux/htcpld.h                |  2 -
 3 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 258304edf23e..261d6c1edadd 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -141,13 +141,6 @@
 #define HTCPLD_GPIO_DOWN_DPAD		HTCPLD_BASE(7, 4)
 #define HTCPLD_GPIO_ENTER_DPAD		HTCPLD_BASE(7, 3)
 
-/*
- * The htcpld chip requires a gpio write to a specific line
- * to re-enable interrupts after one has occurred.
- */
-#define HTCPLD_GPIO_INT_RESET_HI	HTCPLD_BASE(2, 7)
-#define HTCPLD_GPIO_INT_RESET_LO	HTCPLD_BASE(2, 0)
-
 /* Chip 5 */
 #define HTCPLD_IRQ_RIGHT_KBD		HTCPLD_IRQ(0, 7)
 #define HTCPLD_IRQ_UP_KBD		HTCPLD_IRQ(0, 6)
@@ -348,8 +341,6 @@ static struct htcpld_chip_platform_data htcpld_chips[] = {
 };
 
 static struct htcpld_core_platform_data htcpld_pfdata = {
-	.int_reset_gpio_hi = HTCPLD_GPIO_INT_RESET_HI,
-	.int_reset_gpio_lo = HTCPLD_GPIO_INT_RESET_LO,
 	.i2c_adapter_id	   = 1,
 
 	.chip		   = htcpld_chips,
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 417b0355d904..a6d47ce27efe 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -20,7 +20,9 @@
 #include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <linux/htcpld.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 struct htcpld_chip {
@@ -58,8 +60,8 @@ struct htcpld_data {
 	uint               irq_start;
 	int                nirqs;
 	uint               chained_irq;
-	unsigned int       int_reset_gpio_hi;
-	unsigned int       int_reset_gpio_lo;
+	struct gpio_desc   *int_reset_gpio_hi;
+	struct gpio_desc   *int_reset_gpio_lo;
 
 	/* htcpld info */
 	struct htcpld_chip *chip;
@@ -196,9 +198,9 @@ static irqreturn_t htcpld_handler(int irq, void *dev)
 	 * be asserted.
 	 */
 	if (htcpld->int_reset_gpio_hi)
-		gpio_set_value(htcpld->int_reset_gpio_hi, 1);
+		gpiod_set_value(htcpld->int_reset_gpio_hi, 1);
 	if (htcpld->int_reset_gpio_lo)
-		gpio_set_value(htcpld->int_reset_gpio_lo, 0);
+		gpiod_set_value(htcpld->int_reset_gpio_lo, 0);
 
 	return IRQ_HANDLED;
 }
@@ -562,35 +564,26 @@ static int htcpld_core_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Request the GPIO(s) for the int reset and set them up */
-	if (pdata->int_reset_gpio_hi) {
-		ret = gpio_request(pdata->int_reset_gpio_hi, "htcpld-core");
-		if (ret) {
-			/*
-			 * If it failed, that sucks, but we can probably
-			 * continue on without it.
-			 */
-			dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
-			htcpld->int_reset_gpio_hi = 0;
-		} else {
-			htcpld->int_reset_gpio_hi = pdata->int_reset_gpio_hi;
-			gpio_set_value(htcpld->int_reset_gpio_hi, 1);
-		}
-	}
+	htcpld->int_reset_gpio_hi = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
+							      7, "htcpld-core", GPIO_ACTIVE_HIGH,
+							      GPIOD_OUT_HIGH);
+	if (!htcpld->int_reset_gpio_hi)
+		/*
+		 * If it failed, that sucks, but we can probably
+		 * continue on without it.
+		 */
+		dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
 
-	if (pdata->int_reset_gpio_lo) {
-		ret = gpio_request(pdata->int_reset_gpio_lo, "htcpld-core");
-		if (ret) {
-			/*
-			 * If it failed, that sucks, but we can probably
-			 * continue on without it.
-			 */
-			dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
-			htcpld->int_reset_gpio_lo = 0;
-		} else {
-			htcpld->int_reset_gpio_lo = pdata->int_reset_gpio_lo;
-			gpio_set_value(htcpld->int_reset_gpio_lo, 0);
-		}
-	}
+
+	htcpld->int_reset_gpio_lo = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
+							      0, "htcpld-core", GPIO_ACTIVE_HIGH,
+							      GPIOD_OUT_LOW);
+	if (!htcpld->int_reset_gpio_lo)
+		/*
+		 * If it failed, that sucks, but we can probably
+		 * continue on without it.
+		 */
+		dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
 
 	dev_info(dev, "Initialized successfully\n");
 	return 0;
diff --git a/include/linux/htcpld.h b/include/linux/htcpld.h
index 842fce69ac06..5f8ac9b1d724 100644
--- a/include/linux/htcpld.h
+++ b/include/linux/htcpld.h
@@ -13,8 +13,6 @@ struct htcpld_chip_platform_data {
 };
 
 struct htcpld_core_platform_data {
-	unsigned int                      int_reset_gpio_hi;
-	unsigned int                      int_reset_gpio_lo;
 	unsigned int                      i2c_adapter_id;
 
 	struct htcpld_chip_platform_data  *chip;
-- 
2.31.1

