Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5379A338786
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhCLIgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhCLIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:36:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9BC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:36:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f16so5701908ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3IZh6Sr3KpjXM0LqFQFqH1i8vaQmDVN35tRH7/mbAU=;
        b=w4PN1C4PgugnW7X5qRA0bcvSlXdgQLcTfkchIx0g+Hin/luGafbnvA2aV/WxDs2ar6
         XrD/+ibpcgVcuoPff1Cp1tkimFnIBsHp48mxcjjn58EWXIz4SJqmxKEXImfdGQwdZtQF
         +IO0VbfdjPVxP4ZBNW/Bbicd0DoS2ZjmsycP4IHap5SpZ4U1jGnropCsldbRsPXZiEZO
         kntOeDJluDH47l0LSpRjbsgf8w7NJPXpkpEWaTPvCOAE4f3paj3i8hYY40SdKSemRz/z
         VWNOk0fzneDCuiWEmduxwGqYtxMVbd6TpvE7ZIOezFhqugFwYv2UDZ3YzpiPrtyMBCRD
         7drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3IZh6Sr3KpjXM0LqFQFqH1i8vaQmDVN35tRH7/mbAU=;
        b=BLoeGecpXr9FErZhPrL6vlMKHwVVqX4IkCy6rhtkymZNI0/oO3pJKsPx8tcFizoKum
         iDPZN87m8yELk8uGV0ZMs0999feOhtYIwZfgGZJbrQjYaRAxlF23r1z924Ki/U1ra50t
         2tAvmjDAxUDhbE9Hy7v4QvKRJksuFFba+NqCUANDpq60VgbI+hE5ajV/+gkSLQ59Gpy0
         rI5l4gWvtANWWVT5urBPf7hlspUBVULmwHDpRaoc1EspEsxTRPSWOngz4mRSwxh39uno
         XOzYHyC7Hob2uGLlIKE/kSuTYtzIi+XUHAh128lLI88L7z/1rWyjIvyDySsQoJHGkyvf
         UZZg==
X-Gm-Message-State: AOAM530umRfYJj63Ag9hqR7ao4+W+aZU1V7rBT2R3HHwr8qHLdwg1qnw
        UlhDNpnjOmlIbCYTnTipyBTK2sC8i3GsfDZnndM=
X-Google-Smtp-Source: ABdhPJy9M4sSSBaKf+jN/ywwLXdo+WJR/aU9Z0pLUCJ/Mp9QUJNGkawLsTml2ipEhkUt62BQxkwYuQ==
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr1760158ljm.62.1615538173441;
        Fri, 12 Mar 2021 00:36:13 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id p6sm1617532lfc.71.2021.03.12.00.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:36:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4] mfd/power: ab8500: Push algorithm to power supply code
Date:   Fri, 12 Mar 2021 09:36:03 +0100
Message-Id: <20210312083604.3708890-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charging algorithm header is only used locally in the
power supply subsystem so push this down into
drivers/power/supply and rename from the confusing
"ux500_chargalg.h" to "ab8500-chargalg.h" for clarity:
it is only used with the AB8500.

This is another remnant of non-DT code needing to pass
data from boardfiles, which we don't do anymore.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../power/supply/ab8500-chargalg.h                          | 6 +++---
 drivers/power/supply/ab8500_charger.c                       | 2 +-
 drivers/power/supply/abx500_chargalg.c                      | 2 +-
 drivers/power/supply/pm2301_charger.c                       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)

diff --git a/include/linux/mfd/abx500/ux500_chargalg.h b/drivers/power/supply/ab8500-chargalg.h
similarity index 93%
rename from include/linux/mfd/abx500/ux500_chargalg.h
rename to drivers/power/supply/ab8500-chargalg.h
index 9b97d284d0ce..94a6f9068bc5 100644
--- a/include/linux/mfd/abx500/ux500_chargalg.h
+++ b/drivers/power/supply/ab8500-chargalg.h
@@ -4,8 +4,8 @@
  * Author: Johan Gardsmark <johan.gardsmark@stericsson.com> for ST-Ericsson.
  */
 
-#ifndef _UX500_CHARGALG_H
-#define _UX500_CHARGALG_H
+#ifndef _AB8500_CHARGALG_H_
+#define _AB8500_CHARGALG_H_
 
 #include <linux/power_supply.h>
 
@@ -48,4 +48,4 @@ struct ux500_charger {
 
 extern struct blocking_notifier_head charger_notifier_list;
 
-#endif
+#endif /* _AB8500_CHARGALG_H_ */
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 50989a5ec95c..a9be10eb2c22 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -28,12 +28,12 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/usb/otg.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 
 /* Charger constants */
 #define NO_PW_CONN			0
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 5b28d58041b4..f5b792243727 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -28,10 +28,10 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/notifier.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 
 /* Watchdog kick interval */
 #define CHG_WD_INTERVAL			(6 * HZ)
diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 5aeff75db33b..d53e0c37c059 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -18,13 +18,13 @@
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/pm2301_charger.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 #include "pm2301_charger.h"
 
 #define to_pm2xxx_charger_ac_device_info(x) container_of((x), \
-- 
2.29.2

