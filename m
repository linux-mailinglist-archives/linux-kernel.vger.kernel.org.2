Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB03408322
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhIMDaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhIMDaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:30:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0649C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:28:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g184so8098661pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iViKe5K3OqUUSjVw078CMVuYB4UJnlNbs8QNGz+R2bk=;
        b=QuvrONocgrdG2UW5id/w9e+Zg+OK6huNOHJCs5CQO8CBcP0vNlFWRGMOvhG535fUYw
         bEapnFXia2rdEQ/C9Kkhj0V0ktPKm5xbFIjD5F1M947KkfDbjSFU4iuwIiaC6WtC4bdw
         xeryu0CN2Fb9fnnmDB1rUJCAjSZM6GAa0K1ZVNEFBSjaGzpEkeXBh+k0rk1+VPfGnOsm
         Kxv0XrSQOakLGjq9cU9c/gScE1E8Fcqm0Xmrxowfm5wktenTjjzr8zThEAhR/sA0+zfM
         mvhSII69GupQsYh9+4a9fJ4L2K6eNE6OUHQsFFV5Wfvir/jKsAZhbsgqMqTDONRfGOB3
         1nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iViKe5K3OqUUSjVw078CMVuYB4UJnlNbs8QNGz+R2bk=;
        b=MAeGUlM1DqH9SNS1pjaIu8qnqO1E8c4Q0g6nL60GlL4ajyUI7bJLn0VNAM/kvuygo7
         OI8atdz+jD6UXdxWWUELhO+VsOV/bcDi07bXTU67zUuZQeE4Fytl/BNWCCkhu3COgetr
         fu/y2Y5ZqRv2bYAeowF2IAzUx3I78ROog94gLE5poYjU42J9YuSODTMmhGX9hGsanrSS
         ITbMpGsl4IdoBURoDDfO0UREO4OeLwsX6dAPIL9Sec6HC00dHHvbNZOLtSb48xk/yE57
         1XwqLO50JoIVCe+U0W7QkdvdLMmWV/Zz99Icpzv150KB8WU5JEnXBf6IjVXTzVIZdTkq
         eUhQ==
X-Gm-Message-State: AOAM531xfboTaQ4YgIb5N2M5T9dWUKVrFppErueyYr/q9ZgUycAHN/Qm
        J3AgbHSdqughAd2DVPI12uo=
X-Google-Smtp-Source: ABdhPJwjkiK7ziIc/3Ew0K5PdDMcWPuic8Fsx0T9SBWTgUSLolP2v3MTS6Lunhw3/wrjtWJzZ+yncA==
X-Received: by 2002:aa7:99de:0:b0:43c:92ed:305b with SMTP id v30-20020aa799de000000b0043c92ed305bmr5048177pfi.86.1631503737211;
        Sun, 12 Sep 2021 20:28:57 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12sm665109pjv.29.2021.09.12.20.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:28:56 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v3 1/3] drivers/clocksource/timer-of: Remove __init markings
Date:   Mon, 13 Sep 2021 11:28:32 +0800
Message-Id: <20210913032834.147237-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913032834.147237-1-zhang.lyra@gmail.com>
References: <20210913032834.147237-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

This allows timer drivers to be compiled as modules which can be a
platform-level devices, so the timer_of_init()/_cleanup() should able to
be called from platform_driver_register() which support deferred probing.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clocksource/timer-of.c | 17 +++++++++--------
 drivers/clocksource/timer-of.h |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 529cc6a51cdb..7f108978fd51 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -19,7 +19,7 @@
  *
  * Free the irq resource
  */
-static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
+static void timer_of_irq_exit(struct of_timer_irq *of_irq)
 {
 	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
 
@@ -47,7 +47,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_irq_init(struct device_node *np,
+static int timer_of_irq_init(struct device_node *np,
 				    struct of_timer_irq *of_irq)
 {
 	int ret;
@@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_node *np,
  *
  * Disables and releases the refcount on the clk
  */
-static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
+static void timer_of_clk_exit(struct of_timer_clk *of_clk)
 {
 	of_clk->rate = 0;
 	clk_disable_unprepare(of_clk->clk);
@@ -107,7 +107,7 @@ static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_clk_init(struct device_node *np,
+static int timer_of_clk_init(struct device_node *np,
 				    struct of_timer_clk *of_clk)
 {
 	int ret;
@@ -146,12 +146,12 @@ static __init int timer_of_clk_init(struct device_node *np,
 	goto out;
 }
 
-static __init void timer_of_base_exit(struct of_timer_base *of_base)
+static void timer_of_base_exit(struct of_timer_base *of_base)
 {
 	iounmap(of_base->base);
 }
 
-static __init int timer_of_base_init(struct device_node *np,
+static int timer_of_base_init(struct device_node *np,
 				     struct of_timer_base *of_base)
 {
 	of_base->base = of_base->name ?
@@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_node *np,
 	return 0;
 }
 
-int __init timer_of_init(struct device_node *np, struct timer_of *to)
+int timer_of_init(struct device_node *np, struct timer_of *to)
 {
 	int ret = -EINVAL;
 	int flags = 0;
@@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 		timer_of_base_exit(&to->of_base);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(timer_of_init);
 
 /**
  * timer_of_cleanup - release timer_of resources
@@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
  * Release the resources that has been used in timer_of_init().
  * This function should be called in init error cases
  */
-void __init timer_of_cleanup(struct timer_of *to)
+void timer_of_cleanup(struct timer_of *to)
 {
 	if (to->flags & TIMER_OF_IRQ)
 		timer_of_irq_exit(&to->of_irq);
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..1b8cfac5900a 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct timer_of *to)
 	return to->of_clk.period;
 }
 
-extern int __init timer_of_init(struct device_node *np,
+extern int timer_of_init(struct device_node *np,
 				struct timer_of *to);
 
-extern void __init timer_of_cleanup(struct timer_of *to);
+extern void timer_of_cleanup(struct timer_of *to);
 
 #endif
-- 
2.25.1

