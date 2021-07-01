Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE53B8F26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhGAIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhGAIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:55:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE4C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:52:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u14so5421794pga.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPcqApWBuKW7GfPlsaG9+/zGPf3URdDkl4ZR0Uvn25Y=;
        b=Ia37S+uwkfrQT7oYkhU4wDhLLfzHrWSoszA5cN3b5sudeAf+SIhFHif0Eksew4Re5P
         gwnBvGNuOPeB1gGTDaeGyVCqELC36GdnfWxidKGjQhtmYu3m4HOZwZzBO2U9eVNPzYAk
         6ZGgva+ooucnHG8KSY0St4yc2CsWkXf1FUJ0XEahybyxnmc7ulyY9O5Xkk1rWAKBtTKZ
         uqt8cQl3qTxSlUzGxPgYO+SfUAcO9WyeK+/1rXzUB2DlZr06+3Ir283vEZ/dtUptkdZp
         bhrL/12tpb6KX0hJypVps4EYscVrqZcPSycLHhc3Ke2n/PwkeaEDjMiUPOwt9tNvOp7k
         irZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPcqApWBuKW7GfPlsaG9+/zGPf3URdDkl4ZR0Uvn25Y=;
        b=LgtFJNkkpDhsU/eLr7fHVQwrMyckNJ4UY1TFMojcfVE9VTxJM84CG4E0bip1yuAm+7
         hJMSb9QY+12YhG61c6HWEAFZYOeXHQW7gltp27APrwBFABbmCNVapznFXDf5Diunuiu6
         daKqE2elUzeVNglVxE4ymO50aeZMG35g6R+2tjm1RGVexdCGjl6WFzEkgYW97wp8SAEi
         IYMlh/Cok3l/IAot0qeGPzypKuibupwhv2wHNA4yCg+eBXo4JkxdZ6W+O4Q6pHxKda85
         XCP9OR0Lu6tzdJ4ASU9wKxVIVjLONcYlHClAb7q/WQ5LTnLu0+77N2cuiosXPDCFPA2g
         /DYw==
X-Gm-Message-State: AOAM533M+F8E1wQ4b6+zk7KAICL2wJKxUKKhki4aBd7RJty6NJ6LWnfZ
        w/xHiI+O3p2iO6AgW44JBRH28tGbwTU=
X-Google-Smtp-Source: ABdhPJya86T1uCRqAHL76z+GG1OntBwfNa+ux5RbDg/7vgYYzLQnl/CAwzyuQ/wkJhGYap6hV3ug1Q==
X-Received: by 2002:aa7:820d:0:b029:2f1:d22d:f21d with SMTP id k13-20020aa7820d0000b02902f1d22df21dmr40192277pfi.7.1625129571775;
        Thu, 01 Jul 2021 01:52:51 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i27sm24926973pgl.78.2021.07.01.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:52:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] clocksource/drivers/timer-of: Add boilerplate macros for timer module driver
Date:   Thu,  1 Jul 2021 16:51:58 +0800
Message-Id: <20210701085159.208143-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701085159.208143-1-zhang.lyra@gmail.com>
References: <20210701085159.208143-1-zhang.lyra@gmail.com>
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

