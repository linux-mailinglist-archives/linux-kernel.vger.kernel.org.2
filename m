Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56AB4150D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhIVUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIVUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:00:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0B1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m3so16733995lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ziLNWDmgY7i1aKqFdBIMncFTg/bHC2p5KHHrB8++sNw=;
        b=uc1a3h+S08yrVTTQnX9QrTLkwpec4GkzsCCF3RoRlb1kPcqg/2DG3+9JSuKn5iwMMZ
         2FGfh3vc8FlPV193jG2MYMRDPeqBSy1p7Ron+G9OIwpl5Ovffbf3XnNeQ5eqfi6Ga5o3
         YYlAdDK2QGYVelmuY56wOBJUbqjwLS0nRqC8XDhPUE8xyIg3hbW/R9gGUG98hXxq8HSf
         jTQ3PBdNsDyvOZBuGGvUAMEC74EB+xJfOvrMZ23nhDk35JgUl7ucLsgqSLuTjnsyi9+z
         r0M8c/6Ek5JDutWTyodZ9kydkatwV471inGpM8pT9qHxbIIsLEL3afWvDn0mb8cCRMp6
         31rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ziLNWDmgY7i1aKqFdBIMncFTg/bHC2p5KHHrB8++sNw=;
        b=lT48RD/ddL97rO0s+Zh3HixWHhIbezxECQW4hTQGrncpmV3q1w5FcFafKukeKnJ3WB
         XFR2f27hycK0cjBf6FsmFvU2DriOF4OcauVyrv30C8CO0bCcl7cF2876uGLSKTZmpecL
         0DPw2EAzTmQjgXdVo6QuG49hrcJuyZNsGfh193W6eLzrmYn3R1ou+g4WJmeP2kbA+vl9
         j8yGin5ZpxCx8j0Ei4g6Vnx+lrUZPVVvCzukf3gGTT+min+Vt6jmgpOXHix6+JHpXe4u
         JZVXqjYUsJyawyUBZ705t7j9j0449+jD4yU6WafgBUW8cCYBuTtaQDn3slCQhaQf7yQY
         MaVQ==
X-Gm-Message-State: AOAM533PfYO8ybDja3LMfit6WfNo3F+LDS+bmsslqYUW1B0awTpaUccU
        //gMzbeVtYqYnPIQwCD2M4MAww==
X-Google-Smtp-Source: ABdhPJy/l6FsVdwCxDPzrA1DwZy6AUNKyhFmLIUUHv20VBPkNgMWLTcdJBeGiSs3BAjKHYtOYp+CiA==
X-Received: by 2002:a2e:5306:: with SMTP id h6mr1134306ljb.271.1632340743243;
        Wed, 22 Sep 2021 12:59:03 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j18sm251514lfg.65.2021.09.22.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:59:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3 v2] clocksource/drivers/fttmr010: Be stricter on IRQs
Date:   Wed, 22 Sep 2021 21:56:54 +0200
Message-Id: <20210922195656.1822268-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
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
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Do not try to detect spurious IRQs on the Aspeed
  2400 and 2500 that miss the IRQ status register.
---
 drivers/clocksource/timer-fttmr010.c | 42 ++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 126fb1f259b2..f47099dda96b 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -253,20 +253,46 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
  */
 static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = dev_id;
+	struct fttmr010 *fttmr010 = dev_id;
+	struct clock_event_device *evt = &fttmr010->clkevt;
+	u32 val;
+
+	if (fttmr010->is_aspeed) {
+		/*
+		 * Aspeed versions do not implement the interrupt
+		 * status register and cannot detect spurious
+		 * interrupts.
+		 */
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
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
 
@@ -384,12 +410,12 @@ static int __init fttmr010_common_init(struct device_node *np,
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

