Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CF3F297E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhHTJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhHTJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:51:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99914C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:50:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so563885pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQvTMW/oPZKtLwkMLP1XXUkkUyqq+aEu4LrDm88qV9U=;
        b=CpV1Ayh41HrVxKBO/sywWhHmcrThBeoSibq4nDKyCV8j12Qkk0JYVqvEhm2xxjzCIV
         EpRCcOSX8o9bL9lmUNj5wzm6wmK1uXtZHpVpgYSr3CLCHaix0BRJDB6gkS0Sy8sYWREx
         KG2feNj/hEWngV7Y1o4ri4jzs6/63ZJIJ9HS2RfW5ubrNkVQgzfxhijjrVW7WJu9Cgcz
         jXmq+AFFW2jiDQ2Y8uGlWcsWbVfq7M5fMR9z+T6AEfPCD2vwOZ3HSB1MtdrMa4FS9pMo
         0c4ylatGq5UPxX/DSyZdxN61jtvcqiWQXil/6cglINuq1JyUQ7U26vf7KPTxCE8l8MP9
         nsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQvTMW/oPZKtLwkMLP1XXUkkUyqq+aEu4LrDm88qV9U=;
        b=A3zVm6NYKPsR0khf12VPXqTab95vUIZMbxMDuSz6BbSZHNp+CmS3jgqBKQpfyyQIIV
         N+DabnhmLTYLnGvHaRVR+kwuSfoRllHu/ylATbD4Qaq3XaAm3of+jxKWa0YlFm7KVtKR
         GgjPbna8wDZ6xifiuH6lF5PLXD5SrWtMGBRPBIP1hafKrwRVEJMuuOpwfRRMUk+x/xzh
         qtVOKaPUsjL0qqa+Nwqh3pDLY++gotCpQTLaXefvYWRhomNCeYxLs33PHTzumSN1kAk9
         OobpsPih3BgUUIDU3hF/LNbShhVLlKPonGrdasBu3x63AXywpPyWaZc+UrXDBRQ9TiYi
         y/6A==
X-Gm-Message-State: AOAM533dZC63APgeQIVbFXQvLmNdZrDNfiUVKQCEq21GTjRpjOPbGyke
        DYwYRnnfMtf3dMkbyBYBQ20=
X-Google-Smtp-Source: ABdhPJzCZqALeL8+Dykk2iCmy1Jpi7OokUM1CglVrKKFraFHzvFJLJn1cC7+5u01tw+ZJi92mydTgw==
X-Received: by 2002:a17:90a:3004:: with SMTP id g4mr3937997pjb.104.1629453026210;
        Fri, 20 Aug 2021 02:50:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a4sm4955172pfa.203.2021.08.20.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 02:50:25 -0700 (PDT)
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
Date:   Fri, 20 Aug 2021 17:47:31 +0800
Message-Id: <20210820094731.1890536-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820094731.1890536-1-zhang.lyra@gmail.com>
References: <20210820094731.1890536-1-zhang.lyra@gmail.com>
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
 drivers/clocksource/timer-sprd.c | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index 430cb99d8d79..e6b7a317e84f 100644
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
 
@@ -204,6 +206,11 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	return 0;
 }
 
-TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
-TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
-		 sprd_suspend_timer_init);
+static const struct of_device_id sc9860_timer_match_table[] = {
+	{ .compatible = "sprd,sc9860-timer", .data = sprd_timer_init },
+	{ .compatible = "sprd,sc9860-suspend-timer", .data = sprd_suspend_timer_init },
+	{},
+};
+TIMER_PLATFORM_DECLEAR("Unisoc broadcast timer module", sc9860_timer,
+				sc9860_timer_match_table);
+
-- 
2.25.1

