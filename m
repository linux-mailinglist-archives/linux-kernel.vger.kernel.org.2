Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CDF3B8F21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhGAIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhGAIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:54:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEDC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:52:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l11so3823578pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaS99ik3gmjreFZM9BN5U2VBxMsMMHz4ezTOIrMIRdU=;
        b=QiZWwzdsnnLwM668psvI4y3gXWFi2pl/tqrCqBJQLGYbaaCjnkVCSGukdnMXD/3AMI
         wHWcKyoWbe5TXECD4us7etIv8P/691rU8266GJzFqaPDz9GZdETMreb2pYvvbrUMTIUw
         j0uZblmi7JFPlSHBQY3qeBtGTH0NK+CFMdiKxncPkwfUQihvshFfd7OyKXRXeN+4a8ly
         4BotoTuDDfEV6U23mUYEY+YyKz07SW6eREU7q7gQAYjHbr573KlmEYG171/ZqgMmYSSn
         EawgsvWxUHYDzg8Urmtft2RgDpOBw1mMdmuAREwLlIPliyVl3jwa+Nln8IuHb5xMgc5f
         ieaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaS99ik3gmjreFZM9BN5U2VBxMsMMHz4ezTOIrMIRdU=;
        b=fqIN6Gabf/A+5ELbUXjvCaQN++CHBTtI6/C7LJYq1O51wn6Bywm5zDE3HbC0Ia0AXJ
         DFlYHAAkPsBp5brUbygOvtsoh2KUAGVb6cNloadJ4uiFfTv+8THjVv9Ly8t/ehQMQtES
         jEpLZYWxzQTbaMfORpFXBfdgs/yca/02Val7vW+uv4B6fZJzGFHlJl1xwzti3yZzbPtT
         btrQw4oPz5pUiuCen5ePzX1LuNC/Eh3JXKOKMs0A5fYEV0N2ZmFECZL9QEH1yb/11U5s
         tYnttQpekont89jCDh9xvUzaKA7BwceXQBLXikY+OEBFj+SknqKSVIHSDzRRUY734R/8
         f1jQ==
X-Gm-Message-State: AOAM532IFuCEBvG4FYTWl75NGdeZkKPIgxfa2yD0htXdsXzIYSNzQ3Tn
        Sh3VV1wbZCEu+SKqRdRnFM4=
X-Google-Smtp-Source: ABdhPJz7vUBxovBoHNivYSsg1DnURA5yXH4PpCEopeWrhuNiRXpR1e7DRz55bLpw69j2h1qkjhcRNQ==
X-Received: by 2002:a17:90a:5215:: with SMTP id v21mr8836068pjh.48.1625129540057;
        Thu, 01 Jul 2021 01:52:20 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i27sm24926973pgl.78.2021.07.01.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:52:19 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drivers/clocksource/timer-of: Remove __init markings
Date:   Thu,  1 Jul 2021 16:51:57 +0800
Message-Id: <20210701085159.208143-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701085159.208143-1-zhang.lyra@gmail.com>
References: <20210701085159.208143-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

This allows timer drivers to be compiled as modules.

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

