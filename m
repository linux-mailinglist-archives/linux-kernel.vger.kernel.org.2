Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217D3F29C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhHTKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbhHTKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:03:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B24C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:03:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so3113387plg.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tMIRBSBtQiJRHUZqqCi8pGuIJEFYlr035c9pZWHp7Es=;
        b=oxtMouhfVIe5Mq0IrlBbPEpVy9SJveBLNVfOyAnAbpdb1Hdp+IMSCGGYMq8bWfOzVU
         4xUSJNLZ94KTY098snT7RrhRltcsIl8H8Y6pBw31urUO4ZKi2U8fsw81TW2OkKCyMNPa
         eNmPYNdp9ZitEamXOxLe6NShzf0ocbBCgjKdOh+c+GpwX6PXtjPMtmvuik/V4s903dh6
         GFQ5E/8CX076Dqb+OQCqiJIx/ykwykInw7uTTTybsoXd83KO5/KfQNZr3oQJt+kc0hio
         q3KJRnppKOlCbI6i3hDJpdP77TAf3ZCO52NVb7oVc0kd2N4Pelu8RNiKDA/BVEu4Bw+m
         anRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMIRBSBtQiJRHUZqqCi8pGuIJEFYlr035c9pZWHp7Es=;
        b=i3KJbsjtlRGveuibCHgavMhJcPv9mBYpZFrUiU8eHjCnX61XPm2GKgbIEorTOBqXRF
         NA5Gu7w4W2rVGycJIr2yhqyVUcUrFzALj3Hlt8Is6qyr6Dl6zCTkv6XzgqdOgn9BZrT3
         rVtkEg6oUN30cCyAu4SCsCk7iD6kyG6Za5qwWL3qWMmJvlhV6OY86CPLIrynjYWyue9w
         XphkTGtnhbtF7I4YiYKylIKGPFzMH0EavV8zmMDRQs4X71D2lT629a2oEB/qxoJ8CEkx
         SnjCUUF/9QZWXiv0W665ZaDox0Twl/KtSXkXT8sd4C5PtmiD8NPSQY/z/ndRNLBWODzi
         DP7Q==
X-Gm-Message-State: AOAM5314ktmgHw06M+d2rDnueW7eDoNZQuK5GmOmixGE9g19YC0Nf3pK
        khR4N57/YwalKudKLD222Ss=
X-Google-Smtp-Source: ABdhPJzIj0dXI20Q7OqviWJdd+bUdajzFHmlKCE9hu+FN5WgpJLdZrzfTIBgDYTwQjpAmfaEfDVVYQ==
X-Received: by 2002:a17:902:d343:b0:12f:66de:cafe with SMTP id l3-20020a170902d34300b0012f66decafemr9603015plk.68.1629453781309;
        Fri, 20 Aug 2021 03:03:01 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k12sm8137001pjg.6.2021.08.20.03.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:03:00 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] clocksource/drivers/sprd: Add module support to Unisoc timer
Date:   Fri, 20 Aug 2021 18:02:40 +0800
Message-Id: <20210820100240.1893457-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820094731.1890536-4-zhang.lyra@gmail.com>
References: <20210820094731.1890536-4-zhang.lyra@gmail.com>
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

