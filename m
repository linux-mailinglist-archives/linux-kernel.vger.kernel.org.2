Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C703C993D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhGOG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhGOG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:58:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28483C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c15so2680609pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQd1xqPN+JSi+9DxnSXU/6k7gzbtlQufr0yhn1a7d78=;
        b=bJWjD52M3QeovDLoofO4rlzUgoUaLiJ5W2d6iiP2Zep+4Mbvdq5Kz7jJZ0p/P/C9m7
         U+f/nfGbCYx7v5Q2t3Sr3UiHTkQOGkCF/7exnAfQCh7ABpe5Izj6fja2P5T1H10zj1kj
         XdzKoyMma52lS3R9wnfDLQtFYQqkC1htvn57wA/aj9JylLKcd/OgX4ck3Ykf5wnbUqNx
         RVGFB3aA7spKbmYFlRmg7/op9a6XBTDT5iXI8uKo7UJ+EyBFjrj6xrURV6wDwKqDeswV
         k2srsnnSXA4kL3ePAjHmgejXV7vUlle9XleKB4/As5mmyGiPq+ljtXCtqnlw0ySWy18n
         C5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQd1xqPN+JSi+9DxnSXU/6k7gzbtlQufr0yhn1a7d78=;
        b=KnVzqWtiN15995AcoecZQEHTB2lgI+9+NbT8G8tAQ9LW7qV7gXSuFYQ27gcHsbcc/v
         AFxFNzdlU+Sp8qvUMm1HJeyXaROeWrlxUTPfekVrkNJN96xtbZWHGbHqoIQN1l+vg9Lk
         4kWondLaFCNphXPIpr7FVNSVBXbiDfElESiYJIql9RMpaqdPd6iK6I3/WHiS2SgJ2Aws
         F1k6Hs152rDym0ciwE89UUGidGgU/Y7RdMVr2a+Dz1Zv7AwAQgYVYxsKZTXuYG5uAdv/
         YPN4y3aF0sb/wfhUAh9+VfbkB6SkPSYZMiszR7niIYkD4Br5ZrjG8MHK0IzOIfs4zqec
         5fBA==
X-Gm-Message-State: AOAM532PjnnG874gbiazKwXeSvvhfu1ZHexBTunbH/ZvXKFf1T62x9nR
        Mg95lG5Sq5X0eFTS9xz7gRRvG72O22Rdtg==
X-Google-Smtp-Source: ABdhPJwuRgbhcT3cwFP9IQEBdbuVh+gDzVKm/fJGctDz0gfPGcHEa5aUOxFMKByS2n5tniG17rO5ow==
X-Received: by 2002:a17:90a:7484:: with SMTP id p4mr2745409pjk.40.1626332121787;
        Wed, 14 Jul 2021 23:55:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm5032689pfc.203.2021.07.14.23.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 23:55:21 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] clocksource/drivers/sprd: Add module support to Unisoc timer
Date:   Thu, 15 Jul 2021 14:54:55 +0800
Message-Id: <20210715065455.392923-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715065455.392923-1-zhang.lyra@gmail.com>
References: <20210715065455.392923-1-zhang.lyra@gmail.com>
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
 drivers/clocksource/timer-sprd.c | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eb661b539a3e..a5a5b7c883ec 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -461,7 +461,7 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if EXPERT
+	tristate "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..a8a7d3ea3464 100644
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
 
@@ -204,6 +206,9 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	return 0;
 }
 
-TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
-TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
-		 sprd_suspend_timer_init);
+TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
+TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
+TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
+TIMER_PLATFORM_DRIVER_END(sprd_timer);
+MODULE_DESCRIPTION("Unisoc broadcast timer module");
+MODULE_LICENSE("GPL");
-- 
2.25.1

