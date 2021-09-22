Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F84150DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhIVUBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbhIVUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:00:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA580C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b20so16723729lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kirSNZC3LGy8tRHg461vHsiEZgK8q2yo81KgBYR6tws=;
        b=ba4bNRMHOxY32D9ZN9dQDNgJT71yLqjg/+0RUSgkWVpajglt+dKQGEEpaKwBBmESLN
         miUObi6XdAuFACtag9FJ0cBaldL5tqrqwlgMW0TAz31buc1rVycT98BxM/nmOfg732+h
         TN85r2m9jX7ycrzRu6KsS7zMbDSU2Dn9gjenVYGvB6vez+Z76d5ZVonj5r2I0TnA0JpU
         NIsLogUgN3fmJ7gTSeg5kRnA3zpAdRD6VCvvDhAK6fhnHBJK8OglhAR7/zfSOV5PXm8r
         XmmGoDCUxE3SO6QYJcKVMo+wztxOHHj0Ij6PHfMtWl1t0L3W1i1v4masunP7cKQk/BNK
         Do2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kirSNZC3LGy8tRHg461vHsiEZgK8q2yo81KgBYR6tws=;
        b=l98VWksWhf7F98WJ36P4T4DkPiNZ2eQNPYJRo1sAtL/DB6XA2eS3QUdoDFm9VizbrJ
         KxQ4vHvklKSmGZqBNNGqgMXb010g3ZHS/XfcFwMK4GiRDkb+4VeYJFeckqD/ZAUU00MC
         6wxTxZXIvBlO/CYj8Bagih24gAKvX58zhpGElFr4rLrI+HujPd1PVfgrXXjsROvz/Dn4
         P+ahUxqfxRivpJw6/jiMmIfrZXAHBNhuI21b8a35hV5NyA937W0tWKZMhRl2Jk8eUZ6C
         jC1M5G7vuwNGMPcvGlhEQzA+P4MaE2JmkNXq2VsyQvTs0vUQtxngmqFMd436SE7GPEKT
         1CAQ==
X-Gm-Message-State: AOAM5335pSh7OPeumDnOkyAWQcEj0swiWCkHlxQ5zz/rwRDG2UDzbzJW
        paB4GW6/RAB3D5BcbDr6R2AYAQ==
X-Google-Smtp-Source: ABdhPJxwNgF40iMJefxXhynJvy5AV9N1NOqW/96Vd00nTZb31ykmYwEL3ugOkneFCjTy1uihb5sgUw==
X-Received: by 2002:a2e:85cb:: with SMTP id h11mr1190045ljj.111.1632340765201;
        Wed, 22 Sep 2021 12:59:25 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j18sm251514lfg.65.2021.09.22.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:59:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3 v2] clocksource/drivers/fttmr010: Just count down
Date:   Wed, 22 Sep 2021 21:56:56 +0200
Message-Id: <20210922195656.1822268-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922195656.1822268-1-linus.walleij@linaro.org>
References: <20210922195656.1822268-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All timers can handled just counting down so what about just
doing that instead of special-casing the counting down mode.

This has the upside that overflow cannot occur so we can
remove some handling of that interrupt as well.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch.
---
 drivers/clocksource/timer-fttmr010.c | 97 +++++-----------------------
 1 file changed, 16 insertions(+), 81 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 5af8ea388cc4..f72ec84884e2 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -119,21 +119,11 @@ static inline struct fttmr010 *to_fttmr010(struct clock_event_device *evt)
 	return container_of(evt, struct fttmr010, clkevt);
 }
 
-static unsigned long fttmr010_read_current_timer_up(void)
-{
-	return readl(local_fttmr->base + TIMER2_COUNT);
-}
-
 static unsigned long fttmr010_read_current_timer_down(void)
 {
 	return ~readl(local_fttmr->base + TIMER2_COUNT);
 }
 
-static u64 notrace fttmr010_read_sched_clock_up(void)
-{
-	return fttmr010_read_current_timer_up();
-}
-
 static u64 notrace fttmr010_read_sched_clock_down(void)
 {
 	return fttmr010_read_current_timer_down();
@@ -148,17 +138,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	/* Stop */
 	fttmr010->timer_shutdown(evt);
 
-	if (fttmr010->is_aspeed) {
-		/*
-		 * ASPEED Timer Controller will load TIMER1_LOAD register
-		 * into TIMER1_COUNT register when the timer is re-enabled.
-		 */
-		writel(cycles, fttmr010->base + TIMER1_LOAD);
-	} else {
-		/* Setup the match register forward in time */
-		cr = readl(fttmr010->base + TIMER1_COUNT);
-		writel(cr + cycles, fttmr010->base + TIMER1_MATCH1);
-	}
+	writel(cycles, fttmr010->base + TIMER1_LOAD);
 
 	/* Start */
 	cr = readl(fttmr010->base + TIMER_CR);
@@ -194,24 +174,11 @@ static int fttmr010_timer_shutdown(struct clock_event_device *evt)
 static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 {
 	struct fttmr010 *fttmr010 = to_fttmr010(evt);
-	u32 cr;
 
 	/* Stop */
 	fttmr010->timer_shutdown(evt);
-
-	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
-	if (fttmr010->is_aspeed) {
-		writel(~0, fttmr010->base + TIMER1_LOAD);
-	} else {
-		writel(0, fttmr010->base + TIMER1_LOAD);
-
-		/* Enable interrupt */
-		cr = readl(fttmr010->base + TIMER_INTR_MASK);
-		cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
-		cr |= TIMER_1_INT_MATCH1;
-		writel(cr, fttmr010->base + TIMER_INTR_MASK);
-	}
+	writel(~0, fttmr010->base + TIMER1_LOAD);
 
 	return 0;
 }
@@ -226,19 +193,7 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	fttmr010->timer_shutdown(evt);
 
 	/* Setup timer to fire at 1/HZ intervals. */
-	if (fttmr010->is_aspeed) {
-		writel(period, fttmr010->base + TIMER1_LOAD);
-	} else {
-		cr = 0xffffffff - (period - 1);
-		writel(cr, fttmr010->base + TIMER1_COUNT);
-		writel(cr, fttmr010->base + TIMER1_LOAD);
-
-		/* Enable interrupt on overflow */
-		cr = readl(fttmr010->base + TIMER_INTR_MASK);
-		cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
-		cr |= TIMER_1_INT_OVERFLOW;
-		writel(cr, fttmr010->base + TIMER_INTR_MASK);
-	}
+	writel(period, fttmr010->base + TIMER1_LOAD);
 
 	/* Start the timer */
 	cr = readl(fttmr010->base + TIMER_CR);
@@ -268,7 +223,7 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	}
 
 	val = readl(fttmr010->base + TIMER_INTR_STATE);
-	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW))
+	if (val & TIMER_1_INT_MATCH1)
 		evt->event_handler(evt);
 	else
 		/* Spurious IRQ */
@@ -284,9 +239,8 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
 	u32 val;
 
 	val = readl(fttmr010->base + TIMER_INTR_STATE);
-	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW)) {
-		writel(TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW,
-		       fttmr010->base + TIMER_INTR_STATE);
+	if (val & TIMER_1_INT_MATCH1) {
+		writel(TIMER_1_INT_MATCH1, fttmr010->base + TIMER_INTR_STATE);
 		evt->event_handler(evt);
 	} else {
 		/* Just clear any spurious IRQs from the block */
@@ -360,15 +314,10 @@ static int __init fttmr010_common_init(struct device_node *np,
 		writel(0, fttmr010->base + TIMER_INTR_STATE);
 	}
 
-	/*
-	 * Enable timer 1 count up, timer 2 count up, except on Aspeed,
-	 * where everything just counts down.
-	 */
 	if (is_aspeed)
 		val = TIMER_2_CR_ASPEED_ENABLE;
 	else {
-		val = TIMER_2_CR_ENABLE | TIMER_1_CR_UPDOWN |
-			TIMER_2_CR_UPDOWN;
+		val = TIMER_2_CR_ENABLE;
 	}
 	writel(val, fttmr010->base + TIMER_CR);
 
@@ -381,23 +330,13 @@ static int __init fttmr010_common_init(struct device_node *np,
 	writel(0, fttmr010->base + TIMER2_MATCH1);
 	writel(0, fttmr010->base + TIMER2_MATCH2);
 
-	if (fttmr010->is_aspeed) {
-		writel(~0, fttmr010->base + TIMER2_LOAD);
-		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
-				      "FTTMR010-TIMER2",
-				      fttmr010->tick_rate,
-				      300, 32, clocksource_mmio_readl_down);
-		sched_clock_register(fttmr010_read_sched_clock_down, 32,
-				     fttmr010->tick_rate);
-	} else {
-		writel(0, fttmr010->base + TIMER2_LOAD);
-		clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
-				      "FTTMR010-TIMER2",
-				      fttmr010->tick_rate,
-				      300, 32, clocksource_mmio_readl_up);
-		sched_clock_register(fttmr010_read_sched_clock_up, 32,
-				     fttmr010->tick_rate);
-	}
+	writel(~0, fttmr010->base + TIMER2_LOAD);
+	clocksource_mmio_init(fttmr010->base + TIMER2_COUNT,
+			      "FTTMR010-TIMER2",
+			      fttmr010->tick_rate,
+			      300, 32, clocksource_mmio_readl_down);
+	sched_clock_register(fttmr010_read_sched_clock_down, 32,
+			     fttmr010->tick_rate);
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
@@ -441,12 +380,8 @@ static int __init fttmr010_common_init(struct device_node *np,
 
 #ifdef CONFIG_ARM
 	/* Also use this timer for delays */
-	if (fttmr010->is_aspeed)
-		fttmr010->delay_timer.read_current_timer =
-			fttmr010_read_current_timer_down;
-	else
-		fttmr010->delay_timer.read_current_timer =
-			fttmr010_read_current_timer_up;
+	fttmr010->delay_timer.read_current_timer =
+		fttmr010_read_current_timer_down;
 	fttmr010->delay_timer.freq = fttmr010->tick_rate;
 	register_current_timer_delay(&fttmr010->delay_timer);
 #endif
-- 
2.31.1

