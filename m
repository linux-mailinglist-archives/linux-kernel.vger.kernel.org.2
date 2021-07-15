Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CD3C993C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhGOG6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhGOG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:58:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C7C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k20so5039999pgg.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPcqApWBuKW7GfPlsaG9+/zGPf3URdDkl4ZR0Uvn25Y=;
        b=uY0D8Ya2x+0imIxIe22xA5N5VZFl2IpsSAix9tg7YJ/I1K/E9j/ayNn3HQifuCqMq/
         o6f5dfFIO8lwYj4NTYRofH6xBiIUd+bsFN8fEd3m0t8BXnG92NSabVqFVc6jVZFbXHwm
         Z82H62ogynCdiCQ18K7ciZvQ/ZeQI8TpV+N5TqLj7xsvTsWA9F38iZ8/iV2vaDILl6wA
         evd2m9qPP856CKUWOWxkPYgoRXNzRMLtfVwo3RrIMc0vYk/D+7Pkc0EWNcY3J9cPDP2S
         e57rbuTgLLe/Ezr+aDtwUNRoW9rHgw2zwpXrQksdoEtJd3Ty6GhpatVDN3u7Mc2KuwUG
         wM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPcqApWBuKW7GfPlsaG9+/zGPf3URdDkl4ZR0Uvn25Y=;
        b=gfHN/YkOSQy2rrJShNp10/ZD3GeaydsWMK9OBtwP6OYc77FTJzDF9YZW2sJPwUoVqV
         WRmuWPkKL9UHt/R6a0jSbNNLy6QW9YG+HL0/6HzssvSd0JOpT8/9GI65Mnzw7NElVC44
         sGvXxdbSznrEdF63ryMfVtmYfKkQsF96Xrd5L34n4ZNHn8ek4+pk7CWgCrETl5H2gI2/
         5XPcPuXPkZPNrX7k++qydGn7TXVW/dvue9mdr91/tfgxEr9bgEKvjMbzZVXQx3GOHoEw
         hjuOMpsij82ykLWu+ejTKy1WMercNs7AqY/5I8cJp8xDlfbbdFXOeFPFwcjCic0n64iB
         MMWQ==
X-Gm-Message-State: AOAM532fvT4ZqeJVZrIcGcZHseGxDaXoFoOO2nLggZva1pYLXn6sC+MI
        fIbZ9Mw7RoZ0pE1C8skcNhI=
X-Google-Smtp-Source: ABdhPJwbdVzI7mwu4v3hTn3RyzVvkmqETYUtX4ANHEhGqAhzwipI6YdUyZ4M+qNyWT9T8TGFM6SapQ==
X-Received: by 2002:a65:60d7:: with SMTP id r23mr2846699pgv.417.1626332118249;
        Wed, 14 Jul 2021 23:55:18 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm5032689pfc.203.2021.07.14.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 23:55:17 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] clocksource/drivers/timer-of: Add boilerplate macros for timer module driver
Date:   Thu, 15 Jul 2021 14:54:54 +0800
Message-Id: <20210715065455.392923-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715065455.392923-1-zhang.lyra@gmail.com>
References: <20210715065455.392923-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

To support module build, platform driver structs, .probe(), match table and
module macros need to be added to the timer driver. So this patch provides
a few macros to take care of these things, and that would reduce the repeat
code lines in every sigle driver.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clocksource/timer-of.c | 13 +++++++++++++
 drivers/clocksource/timer-of.h | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 7f108978fd51..ecd7f7379400 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -8,7 +8,9 @@
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "timer-of.h"
@@ -229,3 +231,14 @@ void timer_of_cleanup(struct timer_of *to)
 	if (to->flags & TIMER_OF_BASE)
 		timer_of_base_exit(&to->of_base);
 }
+
+int platform_timer_probe(struct platform_device *pdev)
+{
+	int (*init_cb)(struct device_node *node);
+	struct device_node *np = pdev->dev.of_node;
+
+	init_cb = of_device_get_match_data(&pdev->dev);
+
+	return init_cb(np);
+}
+EXPORT_SYMBOL_GPL(platform_timer_probe);
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index 1b8cfac5900a..129f539d5f54 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -3,6 +3,7 @@
 #define __TIMER_OF_H__
 
 #include <linux/clockchips.h>
+#include <linux/platform_device.h>
 
 #define TIMER_OF_BASE	0x1
 #define TIMER_OF_CLOCK	0x2
@@ -71,4 +72,23 @@ extern int timer_of_init(struct device_node *np,
 
 extern void timer_of_cleanup(struct timer_of *to);
 
+extern int platform_timer_probe(struct platform_device *pdev);
+
+#define TIMER_PLATFORM_DRIVER_BEGIN(drv_name)	\
+static const struct of_device_id drv_name##_timer_match_table[] = {
+
+#define TIMER_MATCH(compat, _data) { .compatible = compat, .data = _data },
+
+#define TIMER_PLATFORM_DRIVER_END(drv_name)			\
+	{},							\
+};								\
+MODULE_DEVICE_TABLE(of, drv_name##_timer_match_table);		\
+static struct platform_driver drv_name##_driver = {		\
+	.probe  = platform_timer_probe,				\
+	.driver = {						\
+		.name = #drv_name,				\
+		.of_match_table = drv_name##_timer_match_table,	\
+	},							\
+};								\
+module_platform_driver(drv_name##_driver)
 #endif
-- 
2.25.1

