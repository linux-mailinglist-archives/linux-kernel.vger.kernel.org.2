Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C593F297D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhHTJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhHTJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:50:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365DC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:50:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so8611235pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvKCNgGgd0GfHhvU5GqfwrcS3OOFuoT/zQm30z+9BCY=;
        b=Wk0kWboA3nREt4C7rEBmeVJMh0G0tuWtPip6CN/pgvZbxaTEUADTH2haJwQtF3LOjQ
         Wv5int+9yrwWdQhKJNW41Lw6l8Aj2ilSLjjW7dPcSIzhCP4TEomas7zo+OZfkS4C/BvG
         eyKpDovsUIanrlOvbMw9vgbsfd3AfjpYBfnpS98zL1opV0q0vD6BKRThXElmnYQj0eKd
         uj1aXAoQXxfurNI+JCYwu5cfhQKK4w2oA6QXhX9rylob/t4w4w0rJsY8UkLRJP3nruCV
         LRiHEI5FWIv3x/LThLXUHZ3z7UEg7MESQteLYqoHkLCqYhEsUlGtEu5SH9UKeDK44wQa
         3jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvKCNgGgd0GfHhvU5GqfwrcS3OOFuoT/zQm30z+9BCY=;
        b=IK6hZx+dtfbJHns8Cp+bXh1eYp/rIb2EsxdTCP7Tx+fTfaKbQ6O67HdUNTD5/o7frc
         0ljTS4S7Sy8OU5h7zn/I1dbIXD1z70Sf4YX+dOVlHwrisN3mH1tvZE0LY35a7mBVTq8w
         Jz5kNVz5oXETQB+a9+JGyHw4dExwMoy+keodDyxa3RXY2G7pzzO6XP7NQnQylgIBFpJC
         L+KhuGJBJzhkh9/ER/5U0JMQq02kw6uCfjEwiaaEk5ejV16JXhCPhcoFmGDh+5ELkUP4
         uDIXBgo/hcxBmy9rlp6gVNSb29dKCKnHOh9x4JfGPpdESjNIEOPITeaGA/tsBI7cghIf
         givA==
X-Gm-Message-State: AOAM533hL+jXmKgh/arGlCo2GDnNc+rGWClxPw0t5haaVmxR3vWnQ4sK
        Y3AItxg04uL3RrGQslOFnJM=
X-Google-Smtp-Source: ABdhPJyWrhO3jp4mk56wSHPbF+9CVB2tLjnAaIz1smEjZTFs7qNrHBSGnrRw6H04Q7p+T10CVdKyJw==
X-Received: by 2002:a62:1ad2:0:b029:3e0:7eb7:a6bd with SMTP id a201-20020a621ad20000b02903e07eb7a6bdmr19138459pfa.51.1629453008063;
        Fri, 20 Aug 2021 02:50:08 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a4sm4955172pfa.203.2021.08.20.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 02:50:07 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] clocksource/drivers/timer-of: Add a boilerplate macro for timer module driver
Date:   Fri, 20 Aug 2021 17:47:30 +0800
Message-Id: <20210820094731.1890536-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820094731.1890536-1-zhang.lyra@gmail.com>
References: <20210820094731.1890536-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

To support module build, platform driver structs, .probe(), match table and
module macros need to be added to the timer driver. So this patch provides
a macro to take care of these things, and that would reduce the repeat
code lines in every sigle driver.

Since timer module should support loading only, we use
builtin_platform_driver() which doesn't include module_exit() to make
sure timer modules wouldn't be unloaded.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clocksource/timer-of.c | 13 +++++++++++++
 drivers/clocksource/timer-of.h | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

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
index 1b8cfac5900a..04a476da01bb 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -3,6 +3,7 @@
 #define __TIMER_OF_H__
 
 #include <linux/clockchips.h>
+#include <linux/platform_device.h>
 
 #define TIMER_OF_BASE	0x1
 #define TIMER_OF_CLOCK	0x2
@@ -71,4 +72,18 @@ extern int timer_of_init(struct device_node *np,
 
 extern void timer_of_cleanup(struct timer_of *to);
 
+extern int platform_timer_probe(struct platform_device *pdev);
+
+#define TIMER_PLATFORM_DECLEAR(desc, drv_name, table)		\
+MODULE_DEVICE_TABLE(of, table);					\
+static struct platform_driver drv_name##_driver = {		\
+	.probe  = platform_timer_probe,				\
+	.driver = {						\
+		.name = #drv_name,				\
+		.of_match_table = table,			\
+	},							\
+};								\
+builtin_platform_driver(drv_name##_driver);			\
+MODULE_DESCRIPTION(desc);					\
+MODULE_LICENSE("GPL")
 #endif
-- 
2.25.1

