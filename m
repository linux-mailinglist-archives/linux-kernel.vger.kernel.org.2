Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E503C993B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhGOG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbhGOG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:58:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6248C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y17so5015234pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaS99ik3gmjreFZM9BN5U2VBxMsMMHz4ezTOIrMIRdU=;
        b=itdp1Mh3SCi4Zq45gJ7TOs6JDZKrY00ft+gZnzhmlnIwrsMSTdqBFlEnljI+6CasZn
         YNGpDnG4JpW1ZGuPD2ZmDEToeqv7MghbZfqPfDZyU2ACq36yAcLge/Mo7Io2gcaQU3bN
         DapKQQduDzzlJ564DLur60DWr3j66cpN+s9ptRdn7qSKDSky6cqsXnUyeZcbbAGm/64L
         JC6ncs0DIszshWSmrrjBOYB20NIQZKodljL2w2jZwNlTnMQxXZloLwfM0C6zsSl6kNPt
         AfUjC83lxmI/1CRtHe9YGJcCbGG0fXRBTR8prGEQnU8WCEIDqSIsGL60LCw5PG7BjmUm
         egng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaS99ik3gmjreFZM9BN5U2VBxMsMMHz4ezTOIrMIRdU=;
        b=jAg3mItJZlO6x77Ad8y7Tmeht7Q5X0v2+a1YdgmQHANCMCM5rkfwiStxDif9edKHz+
         I3ezkQVgG2SSzG64CKvJzHfs+x8FHBv/EnSp5Xx2FLhZF44/SkkxX7X1muI21rZjma3c
         4nadKM5ZA8+87LtdLDCS+2CKWTh/X7kDhWUWrDHkF3S+fo0VSLPtfudnRRBKL6HjZr9x
         UVvKDwmNmpSkasTfVlDUCx47u0RLccjQ5aGIyUgle092pSmzTyLeCv+V1IjYbsQmPYWs
         yEi315JxG9W8X3oz4r44Tdg2jbsqVv2bkhM11PJ9RAUAcmxKSpO1N+8nK8tT4Q2Fo4FK
         N7bA==
X-Gm-Message-State: AOAM532l/1Pcsovl1ky+EWUeMciRaPsvuoBq6XpRGFS9gY/3yiGrDnd7
        g5sVOmc7QF0C3JldOpCtBpE=
X-Google-Smtp-Source: ABdhPJxPCD5IMDSUCrz9XgZvujmdcr6fRGWWTru+mCIBmNUplaBn+hcsgg9FEVfKTnExYzltXdQ6+w==
X-Received: by 2002:a05:6a00:1488:b029:332:5e67:1198 with SMTP id v8-20020a056a001488b02903325e671198mr2868333pfu.9.1626332114232;
        Wed, 14 Jul 2021 23:55:14 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm5032689pfc.203.2021.07.14.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 23:55:13 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init markings
Date:   Thu, 15 Jul 2021 14:54:53 +0800
Message-Id: <20210715065455.392923-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715065455.392923-1-zhang.lyra@gmail.com>
References: <20210715065455.392923-1-zhang.lyra@gmail.com>
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

