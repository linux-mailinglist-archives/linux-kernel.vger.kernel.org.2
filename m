Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D032BE2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385197AbhCCRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbhCCMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:51:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493DC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:41:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h98so23496963wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqNR7N+5z2hV0Uoq3lGK5NEf4YOsGOYOQQ1NQB4FlwU=;
        b=UzrpXaMlPmz3Kncidp4nrCMnPu6e3+GECWJR8wQm1GbTyF4URxM8l+sxjNIx1iAX5Z
         eSLmPxK8tp7m5Xl60+gDQboRH8xsRcnoEn0bTlmilTFiguwZMZeQ83aIxgGzcFAK2k84
         TrWLuxGj4LT0a7tMHW66pf0cc66W541/ByBR0X3v87Dk4XH9hEyz5Qqalz5Sei70fpMd
         1KYqxS/QNG8VUlORDtAegfoki4UwAHvydf8VgdbmKBNLBmzfX8FkYCdRb9Wp+YB8MVpj
         aDC26qjose26C+BFh1wtjpOM6pp0JslLAUeKCkeDqSNTreOy10nPsfpWD+u5OBEMvwLv
         hybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqNR7N+5z2hV0Uoq3lGK5NEf4YOsGOYOQQ1NQB4FlwU=;
        b=ktKXfE0KMj8Hb6DYCQ0yfDlxcAa7SsjtdIPPijp7hiEOBU2w+Ihiykjy5sxkm/7lsG
         Q05qfGWZQhvwG20RpTF+sU1Qb5h20aHQRCyXITT1+Q9S27/04WFs+/3YLT+5KVdeZtvG
         NS5sY8mOZkvTyiolKUbREA+A62vJb1bHZp4dfCFZOKF/IgMIT5xplsVftIwaSGjEuQI9
         fCS7fY7diOAjR96isPvn8EXpbHNBUajGXoG6LhSEITyN/lVbTFkAAcXBR5wxqm+FTzDT
         mFJGcO/RZhko0E1hw5Xbc0KUADYy6bspAhQPKXXr/ogHuRwSY7oTEwuPhEVO1SQowFgb
         l1lw==
X-Gm-Message-State: AOAM53172KUD06/9lFvDUg5zI/5Yf0kFIFhw+IwdjPqi8IGfKCHHyAJ4
        XJRkhOb0txtYUXwGKggUorTTXw==
X-Google-Smtp-Source: ABdhPJxoB2b/QuRF+x7ADj7SWVizXsw+mJxg6ob4Dxtn4fGaeHg9Yy+hl5NwwiPhrkWA8iudGf8mFA==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr26656166wry.184.1614775312791;
        Wed, 03 Mar 2021 04:41:52 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id p6sm18174525wru.2.2021.03.03.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:41:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [RESEND 1/1] arch: arm: mach-at91: pm: Move prototypes to mutually included header
Date:   Wed,  3 Mar 2021 12:41:49 +0000
Message-Id: <20210303124149.3149511-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the caller and the supplier's source file should have access to
the include file containing the prototypes.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototype for ‘at91_pinctrl_gpio_suspend’ [-Wmissing-prototypes]
 1637 | void at91_pinctrl_gpio_suspend(void)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototype for ‘at91_pinctrl_gpio_resume’ [-Wmissing-prototypes]
 1661 | void at91_pinctrl_gpio_resume(void)
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-at91/pm.c        | 19 ++++++++-----------
 drivers/pinctrl/pinctrl-at91.c |  2 ++
 include/soc/at91/pm.h          | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)
 create mode 100644 include/soc/at91/pm.h

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 120f9aa6fff32..90dcdfe3b3d0d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -17,6 +17,8 @@
 #include <linux/clk/at91_pmc.h>
 #include <linux/platform_data/atmel.h>
 
+#include <soc/at91/pm.h>
+
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
 #include <asm/system_misc.h>
@@ -25,17 +27,6 @@
 #include "generic.h"
 #include "pm.h"
 
-/*
- * FIXME: this is needed to communicate between the pinctrl driver and
- * the PM implementation in the machine. Possibly part of the PM
- * implementation should be moved down into the pinctrl driver and get
- * called as part of the generic suspend/resume path.
- */
-#ifdef CONFIG_PINCTRL_AT91
-extern void at91_pinctrl_gpio_suspend(void);
-extern void at91_pinctrl_gpio_resume(void);
-#endif
-
 struct at91_soc_pm {
 	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
 	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
@@ -326,6 +317,12 @@ static void at91_pm_suspend(suspend_state_t state)
 static int at91_pm_enter(suspend_state_t state)
 {
 #ifdef CONFIG_PINCTRL_AT91
+	/*
+	 * FIXME: this is needed to communicate between the pinctrl driver and
+	 * the PM implementation in the machine. Possibly part of the PM
+	 * implementation should be moved down into the pinctrl driver and get
+	 * called as part of the generic suspend/resume path.
+	 */
 	at91_pinctrl_gpio_suspend();
 #endif
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 8003d1bd16953..fc61aaec34cc9 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -23,6 +23,8 @@
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
 
+#include <soc/at91/pm.h>
+
 #include "pinctrl-at91.h"
 #include "core.h"
 
diff --git a/include/soc/at91/pm.h b/include/soc/at91/pm.h
new file mode 100644
index 0000000000000..7a41e53a3ffa3
--- /dev/null
+++ b/include/soc/at91/pm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Atmel Power Management
+ *
+ * Copyright (C) 2020 Atmel
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef __SOC_ATMEL_PM_H
+#define __SOC_ATMEL_PM_H
+
+void at91_pinctrl_gpio_suspend(void);
+void at91_pinctrl_gpio_resume(void);
+
+#endif /* __SOC_ATMEL_PM_H */
-- 
2.27.0

