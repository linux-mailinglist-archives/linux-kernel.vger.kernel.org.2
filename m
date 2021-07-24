Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB13D4A83
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGXWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGXWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 18:06:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9CC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:46:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z2so8537085lft.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9sp8Mw1cIZ8d9sTrYKOXOu5gXXKVmjWk9v6nJqz7iA=;
        b=zRrzIE75OF0+177d6Cg2PQneLapWUCalel6rm4msxKnKSheDmMx+8eUnxWa3tVmbL9
         BcABsWSsvCt/8Q82SI85A7ap+4Ro6iPhQYWdwhS8h4vX2yOOvSvU8NW0H5I4EWu1Qna4
         1iohV1D4ZMX2+t6rqsXkEH1eQogwSuqqVWS7rv6jH8J/NIedBXt0g26naQ0PB9c/BF9b
         IHb9L8UHrBsN1qSOOJRYJ97ySkfWIEm3ktNiJfg7ntIITaLh12BT994qQiElIcdpjB9A
         XfISY1pMjh238oZ242zMhrUe+d7khQUs/xu4PxMhIhhdx5Kc14ee/HFEPFFR14oDEZYg
         Ybdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9sp8Mw1cIZ8d9sTrYKOXOu5gXXKVmjWk9v6nJqz7iA=;
        b=SkmQORrSc91IEgy3UdIRU2J1O8pvJkO8ozHmhOFm7p1dMWdg9XCcgZegOwHmR2UNo8
         qHpn51pUE1Xgvv2aLjqjmxNeJFiBbpg/kVpvWoAAlOB66Z8p9CAeVII/44jbYlVLgJ1V
         rBtUwYVjngWRd0FuUhnxwzQpQnXHm1Bf988NVaku1jvsiAzQPSqG/84sxA5q8O19kmBr
         cM4hFZML0wPQFNa4YSPV8sH35hUbOptph744UTC8FaBcKm6a2743Z37iKUoG5cYN6Wca
         EHilE8+cbE2iUbjjw4JzBmdqqoAZUvYE1znd0DXonqnS/e1syMRUohOW0H9Q5ISnpnvD
         TRlA==
X-Gm-Message-State: AOAM5327DazleGJfeyFdTziMzGz6jyGv0tx/N27vUxKAr9qJf1PYrjlN
        FS5DnFm4T9Ciq3OH/tsnD8sA5g==
X-Google-Smtp-Source: ABdhPJxL/Df/aCyVpp85Yt8NY2bxuYkNLeL0fIiPXZJOIMsFtPuegSwSPJFxpE6HwICPrev5loFtpQ==
X-Received: by 2002:ac2:58d6:: with SMTP id u22mr7666662lfo.186.1627166794070;
        Sat, 24 Jul 2021 15:46:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id f14sm3778676ljk.42.2021.07.24.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:46:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
Date:   Sun, 25 Jul 2021 00:44:24 +0200
Message-Id: <20210724224424.2085404-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724224424.2085404-1-linus.walleij@linaro.org>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we check that the right interrupt occurred before
calling the event handler for timer 1. Report spurious IRQs
as IRQ_NONE.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 32 +++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 126fb1f259b2..de29d424ec95 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -253,20 +253,36 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
  */
 static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = dev_id;
+	struct fttmr010 *fttmr010 = dev_id;
+	struct clock_event_device *evt = &fttmr010->clkevt;
+	u32 val;
+
+	val = readl(fttmr010->base + TIMER_INTR_STATE);
+	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW))
+		evt->event_handler(evt);
+	else
+		/* Spurious IRQ */
+		return IRQ_NONE;
 
-	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = dev_id;
-	struct fttmr010 *fttmr010 = to_fttmr010(evt);
+	struct fttmr010 *fttmr010 = dev_id;
+	struct clock_event_device *evt = &fttmr010->clkevt;
+	u32 val;
 
-	writel(0x1, fttmr010->base + TIMER_INTR_STATE);
+	val = readl(fttmr010->base + TIMER_INTR_STATE);
+	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW)) {
+		writel(TIMER_1_INT_MATCH1, fttmr010->base + TIMER_INTR_STATE);
+		evt->event_handler(evt);
+	} else {
+		/* Just clear any spurious IRQs from the block */
+		writel(val, fttmr010->base + TIMER_INTR_STATE);
+		return IRQ_NONE;
+	}
 
-	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -384,12 +400,12 @@ static int __init fttmr010_common_init(struct device_node *np,
 		fttmr010->timer_shutdown = ast2600_timer_shutdown;
 		ret = request_irq(irq, ast2600_timer_interrupt,
 				  IRQF_TIMER, "FTTMR010-TIMER1",
-				  &fttmr010->clkevt);
+				  fttmr010);
 	} else {
 		fttmr010->timer_shutdown = fttmr010_timer_shutdown;
 		ret = request_irq(irq, fttmr010_timer_interrupt,
 				  IRQF_TIMER, "FTTMR010-TIMER1",
-				  &fttmr010->clkevt);
+				  fttmr010);
 	}
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
-- 
2.31.1

