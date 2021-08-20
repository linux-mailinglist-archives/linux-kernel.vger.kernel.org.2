Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A963F297C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhHTJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhHTJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:50:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:49:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t13so8111686pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iViKe5K3OqUUSjVw078CMVuYB4UJnlNbs8QNGz+R2bk=;
        b=tr53/Zq7BdM+PMq0xv6BcfjVUhwQeISniZyICgN+KM1e3jgkB3X02YC3tdJ4SiiFSv
         D5VIBQWGMQPKsHUJuIijEWOcYsR3Uj07sy7RyBJ6ymPo+bjhW175mH0nDydJCz0ZljC7
         J8Xg4hcV46OdOj1NViEPq7STK0BuBkYPIbPjHKU3uPULRjvB9ocsAnINIk2n1oOYLIeR
         3jIWQELHibrkEilHru+BX51WnnE3AOYnuDV2KH1hC/8gCF7sMOW+Mtous/liImV8xTQV
         gPh2p1fG6lrlIcqEILABXkpYfzhKAgnKvj8cU5F10Bt5+OByD/MMXDOjFXdSye7D0Aqx
         7jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iViKe5K3OqUUSjVw078CMVuYB4UJnlNbs8QNGz+R2bk=;
        b=irJi8O8JHk3dhE/KT/d7jpEfFm4MsduIvpYLdFsmd0A2QScAdhINaUHAgC0/+WlIZV
         UprbgoHBYrDd+Sh0/zkbwgm9DzdJ2PuNG2x9ENtNyFOGJgq8C2PhzhVOpniQbyHTXuJV
         defbd4mmEJ418SXWSZY9v7DNnujCxYA06pVpl4hhbHsU9CleEzKrQFJ06BoYkq+QB6UU
         ElDulO8f/2Z2SvQbZQltECIqrLVKemWlb406u3k0stq/kvPNrFiAqdCx5pH98qVmNw7Y
         tOGqvwke4bb2O02Q8XENgrwNVYs+eV+x6fc8CeLyTNacrvoNTvjU+oNuxiMWYLVJlUk0
         rQLQ==
X-Gm-Message-State: AOAM5300nK1zygm2Dy4qBWAvOkJMaJmhXH5twrxE3t78beW4A57ZCUdh
        EpEdTFbBsyOLgoAsHqGZJ68=
X-Google-Smtp-Source: ABdhPJwU6VODGOO7SunF65BTd+eDuBTM+WpxltkyLijgRMbN+cOR/LOqvY5gq4M/QaW/UpEfz33OmA==
X-Received: by 2002:a63:303:: with SMTP id 3mr17813642pgd.439.1629452993904;
        Fri, 20 Aug 2021 02:49:53 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a4sm4955172pfa.203.2021.08.20.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 02:49:53 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] drivers/clocksource/timer-of: Remove __init markings
Date:   Fri, 20 Aug 2021 17:47:29 +0800
Message-Id: <20210820094731.1890536-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820094731.1890536-1-zhang.lyra@gmail.com>
References: <20210820094731.1890536-1-zhang.lyra@gmail.com>
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

