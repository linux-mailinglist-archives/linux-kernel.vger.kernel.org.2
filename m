Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE093D4A82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhGXWGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGXWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 18:06:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD0C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:46:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r26so8489457lfp.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2YDwfyfXMZsvIrwhBC0bDFhpDuSjGAVE8/bmWDh7Hc=;
        b=ZPyVAuxaf1mlV6vSQfR/7Ph3MCesPl98iNVOuPC6S/4jSb8POwvQ0x9D3T9AFqtVWH
         KCafcvDURAACtJCn7LUaNcGRt0k3O4vgPIBx2wKc8oVOQ/M0F756DJCwyJqlzQAvMboP
         0CPFPw/X3Egny8skvNEgkFCSpkfqnkkRDJyyddci1ShMfy2MFeHRnvV4s4s65Et3NajP
         DNjFekMkubOXlzuW2PKuW9FpEh7BsSyEBMBOh7HruMsCCHK2m9WkYYFlsitmHNjMghiQ
         CYzTpvezfxj50sd8L3p6q252FYWToHUnBEG27n7QjPKwr8iX4oZ7hAvhbW2LDqhV0gVp
         j3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2YDwfyfXMZsvIrwhBC0bDFhpDuSjGAVE8/bmWDh7Hc=;
        b=d6MInS5W+FGB3LKazKBuoZDPcP8vZN4IjygRBaIbANN7SKuuKasfasw4giEf9KjDNO
         aTRA66onGiSyABZGx751vVP8fmRzr9pHNkxHHNpSA/fQfM6oUZRqhRqZz00V2fMU+ZFR
         ZTYqLQpNYUcs3+gg8oinX74BMnxZRxaF0aMq3TLPjpLUdtL7FNWY1LXpiD3FdxITPX8D
         LjMThkjxTl/qivzoZ19Zq4xjaFTUraFwPpmUDUQzzLNxDD+aNsGYYR+t0OR+cjCWHLfq
         WDWWj6ztniFL9F5uJIWulCebuCi2DNYCGh4FmPSzeCJ583E80eZY5kmdsN//TA44uYrp
         NEkQ==
X-Gm-Message-State: AOAM533kuFZ9ct5+mbIEoVxueBb1gTsOT27NmTHx8BwaqO8UHxMk5dN1
        9fwJoo8mHBl4zXRxJu05oSxe9A==
X-Google-Smtp-Source: ABdhPJzj/1lC3WK8ARfMrQdsWZzgYYgfRxnKigMi/pcHxRUmH5OsNJMsPbBT/kJD1ktns605w5/nyQ==
X-Received: by 2002:a05:6512:3e13:: with SMTP id i19mr7606162lfv.330.1627166791746;
        Sat, 24 Jul 2021 15:46:31 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id f14sm3778676ljk.42.2021.07.24.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:46:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/2] clocksource/drivers/fttmr010: Pass around less pointers
Date:   Sun, 25 Jul 2021 00:44:23 +0200
Message-Id: <20210724224424.2085404-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just pass bool flags from the different initcalls and use the
flags to set the right pointers. This results in less pointers
passed around in init.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index edb1d5f193f5..126fb1f259b2 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -271,9 +271,7 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
 }
 
 static int __init fttmr010_common_init(struct device_node *np,
-		bool is_aspeed,
-		int (*timer_shutdown)(struct clock_event_device *),
-		irq_handler_t irq_handler)
+				       bool is_aspeed, bool is_ast2600)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -374,8 +372,6 @@ static int __init fttmr010_common_init(struct device_node *np,
 				     fttmr010->tick_rate);
 	}
 
-	fttmr010->timer_shutdown = timer_shutdown;
-
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -383,8 +379,18 @@ static int __init fttmr010_common_init(struct device_node *np,
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret = request_irq(irq, irq_handler, IRQF_TIMER,
-			  "FTTMR010-TIMER1", &fttmr010->clkevt);
+
+	if (is_ast2600) {
+		fttmr010->timer_shutdown = ast2600_timer_shutdown;
+		ret = request_irq(irq, ast2600_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	} else {
+		fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+		ret = request_irq(irq, fttmr010_timer_interrupt,
+				  IRQF_TIMER, "FTTMR010-TIMER1",
+				  &fttmr010->clkevt);
+	}
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
 		goto out_unmap;
@@ -432,23 +438,17 @@ static int __init fttmr010_common_init(struct device_node *np,
 
 static __init int ast2600_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			ast2600_timer_shutdown,
-			ast2600_timer_interrupt);
+	return fttmr010_common_init(np, true, true);
 }
 
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, true, false);
 }
 
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false,
-			fttmr010_timer_shutdown,
-			fttmr010_timer_interrupt);
+	return fttmr010_common_init(np, false, false);
 }
 
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
-- 
2.31.1

