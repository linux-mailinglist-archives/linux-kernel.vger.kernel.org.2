Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18408408324
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhIMDaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbhIMDaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:30:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:29:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w6so4899367pll.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubwM/hTdEgGfFCUcCRbbcDqNawhF1Okjw+bs9APn7lE=;
        b=Lq4862xo0SvQr+QRGsOeUVti9aZZIX9w2fRww5XKJ40EUPkdMKJGdWjXECN0cX5PUg
         KcEHl7atktRdg+2xbKEBqNZs6lMu5+lNnaaF+NU0IUqJhuMj3xk/Go5x8OuvmhXu1rFP
         axEwEIyw6jV67znkQm+Ta6Ob27tzXcOniaJwQIivPYPTZnw5qGzoM7XG+Qr4CMj9QoYG
         b/O5a4XyuulpMV1vJ/ngxx1cz7Zb6bvy4iBdB8fOFA7RrSIOiMaLEpwn+TqeVZomIXaz
         8ChnYYR9+0pWM1f3+8aQwAe1YNUWKoFIZvc7j1/IWM40S7JtgI22qKm/UyR7ZfI9JuIT
         5oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubwM/hTdEgGfFCUcCRbbcDqNawhF1Okjw+bs9APn7lE=;
        b=vdlqucuRVG3KzFXBdjj/7FgABByBz0F0M7uOMK0eORKTszoOVti1eUNN0m4bMgLNDn
         Z4ukiVb2E586zX4BVAKMK4ZGc8bF6FLAvtili8z9WY00Dyw1JqIy5tCJQDXDA6nLD8eQ
         i0Zro/paIfqxV6jAbH8MeWIya1Qu6vdVQSJOL56QJu9woXzmiGhWHdyNkj/Gfty88ar/
         jQOl85sz3spMnSjyiQ0vCtuYjnETg0TMisK4BOlZiFDMF4PeGfHuGzdB4w4LO48zwSqX
         WouQ3Pp/xefM8mDKFbu7GUguqnrtrmAcIMUMXdF2WnFgJBBBCws3GHBi2mtEQZ+N8qx5
         cNWA==
X-Gm-Message-State: AOAM533lx3VgeEkQQA+oOP6kiDYdvMgYPX0+eDhWGCsmfIoLDHtQTWhF
        3W1TEzLWqd1RurWBW6/glY8=
X-Google-Smtp-Source: ABdhPJwHtaVLBcr5/nQPAtIutxR7nACkTETUKYH1cIDq1WpG6dQtuBh9SF4mOP2K4/FJpcdnXh3jRQ==
X-Received: by 2002:a17:90a:130f:: with SMTP id h15mr10640735pja.183.1631503746555;
        Sun, 12 Sep 2021 20:29:06 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12sm665109pjv.29.2021.09.12.20.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:29:06 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 3/3] clocksource/drivers/sprd: Add module support to Unisoc timer
Date:   Mon, 13 Sep 2021 11:28:34 +0800
Message-Id: <20210913032834.147237-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913032834.147237-1-zhang.lyra@gmail.com>
References: <20210913032834.147237-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Timers still have devices created for them. So, when compiling a timer
driver as a module, implement it as a normal platform device driver.

Original-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clocksource/Kconfig      |  2 +-
 drivers/clocksource/timer-sprd.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0f5e3983951a..901f54cebe92 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -462,7 +462,7 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if EXPERT
+	tristate "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..b29c48ef3ba5 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -5,6 +5,8 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include "timer-of.h"
 
@@ -141,7 +143,7 @@ static struct timer_of to = {
 	},
 };
 
-static int __init sprd_timer_init(struct device_node *np)
+static int sprd_timer_init(struct device_node *np)
 {
 	int ret;
 
@@ -190,7 +192,7 @@ static struct clocksource suspend_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-static int __init sprd_suspend_timer_init(struct device_node *np)
+static int sprd_suspend_timer_init(struct device_node *np)
 {
 	int ret;
 
@@ -204,6 +206,12 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	return 0;
 }
 
-TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
-TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
-		 sprd_suspend_timer_init);
+static const struct of_device_id sc9860_timer_match_table[] = {
+	{ .compatible = "sprd,sc9860-timer",
+		.data = sprd_timer_init },
+	{ .compatible = "sprd,sc9860-suspend-timer",
+		.data = sprd_suspend_timer_init },
+	{},
+};
+TIMER_PLATFORM_DECLEAR("Unisoc broadcast timer module", sc9860_timer,
+		       sc9860_timer_match_table);
-- 
2.25.1

