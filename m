Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F03B8F27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhGAIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhGAIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:55:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082FC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:52:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i13so3228580plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqi5dYju1eQpu1Gv8JeZV2pnVuxQV19mlpxHCz/3bw4=;
        b=kqM74IEV9LjH2L+lLiR6R6EAVh0PCSiJxDgvv5m8FaUJWoIIs5BLsA0MYT77/v1w/Y
         qAruwtwNxE3zqk5qNR46sBLZDGxwrpq8rSH+9Avv55Nvamm6NuranIRHQ5ZQ5fUlXIUU
         1A314r1iYZN4kcW5RYlq7IDVMFI0JZkc3r4ZUbmBhkKt5NK85eIpLozcm/M+6Md73dTE
         B78NEIPlCLL/2Hlt67PHG96X6eTMX/2K9iv09kuPNCWrOZ50Yc93pRe4sdphO9RK3XcD
         +M4rBbJiCNySOTHNxVmR/4lxOAzH9sIdA7IguJXEDUvHd0DWEvqI+W0+d2nFBpWAr5gS
         F/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqi5dYju1eQpu1Gv8JeZV2pnVuxQV19mlpxHCz/3bw4=;
        b=QWOO+wQjsXbxOccg1b7sr3cscABdH2q5ifakQ3836Gdz+9qtCOwd0Xjhi39KbYDU9p
         d5Z5aRaKlJCORAcnHPMomB+cWj5oWuErSwspQtnJS9zDfg/Nz0rPcFNn/G6Lqv5p07g4
         HoVmWqh9bqEoHsnOX/iGIIEQsSrBAnsRMItcYfNtJBsEambN88aVLpTBDsyI44GFJPV2
         vLRVglHXHsaCsV8Y6+AdOxILYQEbOOzJmFcfNTWkurR5Ue8prSYr8BQaJIas9LEp/lZW
         ezr+jNODmnugDUX9zvEJCqR6/gEuQF4MsQCKMz1QVOsvGZ4XYcNXExy1JYNzdPFyB/yE
         TOwA==
X-Gm-Message-State: AOAM531TVtgsjFP++vSEzJj7nBkY5NYUd9sHxV/y0FSKPi/9x7qW3L0Q
        NSSiGN0fjswM7ZSGxQxuOQU=
X-Google-Smtp-Source: ABdhPJzCxYbwOiLTbJuv++8ov90r2QsnB0H+ApTnYZFVCB+3MqUWzQyVsCnrXV/gbFMW68GwOYmbYg==
X-Received: by 2002:a17:90a:2d8c:: with SMTP id p12mr22457490pjd.41.1625129574509;
        Thu, 01 Jul 2021 01:52:54 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i27sm24926973pgl.78.2021.07.01.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:52:54 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] clocksource/drivers/sprd: Add module support to Unisoc timer
Date:   Thu,  1 Jul 2021 16:51:59 +0800
Message-Id: <20210701085159.208143-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701085159.208143-1-zhang.lyra@gmail.com>
References: <20210701085159.208143-1-zhang.lyra@gmail.com>
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
 drivers/clocksource/timer-sprd.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 39aa21d01e05..9f16c2779edb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -447,7 +447,7 @@ config MTK_TIMER
 	  Support for Mediatek timer driver.
 
 config SPRD_TIMER
-	bool "Spreadtrum timer driver" if EXPERT
+	tristate "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..73c7b3f8c901 100644
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
 
@@ -204,6 +206,15 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	return 0;
 }
 
+#ifdef MODULE
+TIMER_PLATFORM_DRIVER_BEGIN(sprd_timer)
+TIMER_MATCH("sprd,sc9860-timer", sprd_timer_init)
+TIMER_MATCH("sprd,sc9860-suspend-timer", sprd_suspend_timer_init)
+TIMER_PLATFORM_DRIVER_END(sprd_timer);
+MODULE_DESCRIPTION("Unisoc broadcast timer module");
+MODULE_LICENSE("GPL");
+#else
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
 TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
 		 sprd_suspend_timer_init);
+#endif
-- 
2.25.1

