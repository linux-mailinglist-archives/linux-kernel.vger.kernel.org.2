Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A93A7E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFOMl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFOMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:41:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3712BC0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:39:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j2so26639133lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyZKI2E4xTT0UFZR/tw10S5XdRfz+byZmgoSg9CzmTo=;
        b=rIYK1gIKo3lAxjw+6EGBH8HFSTz0+g9e1u0LDG0pFGprGw/dR5tKmTnXiZVF/mu0vd
         FaIvQbVu7aPUysVyTt/PDXrWBB5al/txEClciVkBCvn1wy5JzYeA2qvIIKRKZl5FMk++
         uwtt0d0sT3JKxIp63hf9AeAH5JhiXZUdB/UA3c3p1xlKKH4bW2e6BdPav0veoBYdrFUr
         rIzOqkvh8F1rYn6JB1DHFpZmoiHBOLPycUCqg6IM8leMWedzLCYb63Fz/ZxG97ged74T
         30AEpzHKU2nuZ2bcGGEJ5zK1yAY5EmVPZsA7Nj2cjQ0jPlBC/KPAx7/+XGIohZY+bzVt
         5NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyZKI2E4xTT0UFZR/tw10S5XdRfz+byZmgoSg9CzmTo=;
        b=WggDHfxdwB7r/9tfdMv6SvAqxfLoGaa6ZOPmDRH0xR3ODWWDvnP510aWSzjzsGRuY+
         WqfpVzS1J2HPVk7qVt7EJ+3VIJGKvvL9ems4s25Z+x/LF6XdPcJDjB2dWeKDsT2aCxUT
         169S6PtIVOvSal2BeQ4Xkc/7RBgnrC705mCMQUWpKRoC4/O97eC5DOhvx57z6GQdIkGg
         AjLHbu+DaJqBjU4kpR+Kt5Yr1RGss5++WcdNQj499kbPkVxu/sa0akMfpgQQ36K6+FNE
         By39lXKrGzGkDPvOgzJ4Y3BiDWTn5KZx48LYfnJ2yNOq9i6PLSnz5zh4wx3GgwWL6B28
         vD9g==
X-Gm-Message-State: AOAM533sNd2VmrFVNwpISX4LJ9FybOxoE+bFWyP10zB9/ARwtDHWydu+
        ykGk4S7/dYvGk+cFyYe5CeiruA==
X-Google-Smtp-Source: ABdhPJxD7qxtXON/8OSwQ7cI6lXNk91cBUpvej8MlVp9AQ7iz606MAkLBwiYkiiYtlGim4zS0KqTAA==
X-Received: by 2002:a19:6a0b:: with SMTP id u11mr5558470lfu.269.1623760753465;
        Tue, 15 Jun 2021 05:39:13 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id m12sm811418lfb.231.2021.06.15.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:39:13 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        grzegorz.jaszczyk@linaro.org,
        Michal Koziel <michal.koziel@emlogic.no>
Subject: [PATCH 2/2] watchdog: imx2_wdg: notify wdog subsystem about wdog suspend/resume
Date:   Tue, 15 Jun 2021 14:39:04 +0200
Message-Id: <20210615123904.2568052-3-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210615123904.2568052-1-grzegorz.jaszczyk@linaro.org>
References: <20210615123904.2568052-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend routine disables wdog clk. Nevertheless, the watchdog subsystem
is not aware of that and can still try to ping wdog through
watchdog_ping_work. In order to prevent such condition and therefore
prevent from system hang (caused by the wdog register access issued
while the wdog clock is disabled) take advantage of
watchdog_dev_suspend/resume routines which will take care of watchdog
ping worker cancel and restore.

Additionally remove hw ping from suspend/resume since it will be
issued by watchdog_dev_suspend/resume routines.

Signed-off-by: Michal Koziel <michal.koziel@emlogic.no>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/watchdog/imx2_wdt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index b84f80f7d342..24e3a4d2b529 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -348,6 +348,17 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdog = dev_get_drvdata(dev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+	int ret;
+
+	/*
+	 * Before disabling clk we need to notify wdog subsystem that HW wdog
+	 * is being suspended. This e.g. prevents watchdog_ping_work to fire
+	 * when the clk is disabled, which would result with system hang caused
+	 * by wdog register access while wdog clock is disabled.
+	 */
+	ret = watchdog_dev_suspend(wdog);
+	if (ret)
+		return ret;
 
 	/* The watchdog IP block is running */
 	if (imx2_wdt_is_running(wdev)) {
@@ -356,7 +367,6 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
 		 * during resume.
 		 */
 		__imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
-		imx2_wdt_ping(wdog);
 	}
 
 	clk_disable_unprepare(wdev->clk);
@@ -383,12 +393,12 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
 		 */
 		imx2_wdt_setup(wdog);
 	}
-	if (imx2_wdt_is_running(wdev)) {
+	if (imx2_wdt_is_running(wdev))
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
-		imx2_wdt_ping(wdog);
-	}
 
-	return 0;
+	ret = watchdog_dev_resume(wdog);
+
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
-- 
2.29.0

