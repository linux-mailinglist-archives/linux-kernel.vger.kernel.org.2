Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BEB408323
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhIMDaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhIMDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:30:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB1BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:29:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id n30so4826118pfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvKCNgGgd0GfHhvU5GqfwrcS3OOFuoT/zQm30z+9BCY=;
        b=p1VbC9GMif3NvnkePRhh7l1KRQ6XwrGM46Gi+7GHRgMJ6tZjwSEv+MHy28wYGHJpo/
         JHwpjti5wBwgQrAnKvZDFphYZH6Zqm7kP8dSPvxjOMlu9hLSBZG7p8pZnEiqlmYDQijs
         p/PPYFkyr7pkcEEAqgrki5w72ik+EOuLVTAaYep94Rdgr6eRL9xGWDH0picc2Ukl70Jg
         1Z+/c1fD6pMfIzN2sm/Lf7r0aN6gHoyuw5c26eotamZZ78Pk1Fx5Ok0yaxdGAw4e5LdP
         WpTBlj8L1/lhuEwKnkj4IQs4S7nyiafVQbEdNa0nuP6Eq0QUap32R9J971nwWlv02L4E
         OPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvKCNgGgd0GfHhvU5GqfwrcS3OOFuoT/zQm30z+9BCY=;
        b=Uxsk2VBbW9kCa8SE4SwBmNXOBfUnNruiFhPjApvODEzBx0omRQHg0zXqMs9CJr4vRF
         tdAyPh7MbJ0typzMRPm9NcuS3b1ziXSKvsTS8J7uIwxscQ4QPSMuggdgpR0a/Uywq9nL
         JMUpmNMC2XUD4LEJoA/8heFzyMHiwh2kbcK2IFOkD0H5j8D8Mk1Xodk3S2XpECLjpKOF
         dO7c3Mk3hG/IMpboUZ+2FaAyVONANLdzu7puXwh9oPIDEPWe2bPpAPk2oeCZ08QtxgrW
         6R5yP/Fp0JYAqCX0KEcqBTuD6agdUlrnPWvMf8rTWqUyouqytQfZOaQYuxNSv2kBAaWg
         xqaA==
X-Gm-Message-State: AOAM5304oTbO8a6oJIf5KBT09uEAN3D7kYUg9MBsPnGhEduae04bp+7c
        6fq4Dl8OnjfxNIoHRy8YPNI=
X-Google-Smtp-Source: ABdhPJwL6awSS3mYuObiTCmClkKcOFDGBObJ8smaCP4HabqjuWi9bjFd0cWqalzKgNTe+FFlWpkr1Q==
X-Received: by 2002:a05:6a00:a8a:b029:356:be61:7f18 with SMTP id b10-20020a056a000a8ab0290356be617f18mr9157356pfl.29.1631503742075;
        Sun, 12 Sep 2021 20:29:02 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12sm665109pjv.29.2021.09.12.20.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:29:01 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 2/3] clocksource/drivers/timer-of: Add a boilerplate macro for timer module driver
Date:   Mon, 13 Sep 2021 11:28:33 +0800
Message-Id: <20210913032834.147237-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913032834.147237-1-zhang.lyra@gmail.com>
References: <20210913032834.147237-1-zhang.lyra@gmail.com>
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

