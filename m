Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F323D4A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGXWfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGXWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 18:35:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B388C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 16:15:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a26so8482489lfr.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdnKGE0h9qI+tmxgP9+1tJVm1vnoK/WzHBNxULDN6vA=;
        b=wbal8hLKRcfXaex8SOilcrDsZlgOfdL/apFUPtkM4Qi34BAlhL64+3viHVTn5rqvk6
         rwQxmhudbAEFEJulcpNIHff8u3zXV3kiru9rJar4Tm501ISjxdQNiwHy4y4QgA3zKmXp
         2RQcSwuoU38oNwZnQoeiwzIbbHr0Kq7xRC8GEPagxbcx0sFhF8/rTFlD9Z89ECEuiBvg
         SmO3bdxUJHhtxcmD2JU9bRNcQeOHBmFeuvshv2ri0xmG67mWjGYvOkmeV62kA+x/fS/t
         5Cxth4k3RcRHkPpPGeqBmgw37peni6aDewEOqzOZT/QJ1PVhncU9He6FzEeykiTDiAlH
         /FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdnKGE0h9qI+tmxgP9+1tJVm1vnoK/WzHBNxULDN6vA=;
        b=Y5Y85BQwXGBfVXujM60jc8e2KO+4zrEAQHE1SUdwvUD4FYsJeej02Qq00mHir5BZP4
         4hOsfXqBm0vBuImPv5/YxmJPxGT2c6tL98p6Te4vEcfG1bBx+bHgmhSqSM5zXo7UAsQ8
         y88mR2eCKwye2oyN69lY2jZj7OnGadoidJoBNYFEUNr2STn/zhHf1WujhvaVoLjWeyvx
         PNiZUGENUObJ2qIGfAt4ksRYB6SYx8MwCYx6cVGSR7jaZ2njTwjKFt3CwacnOSp68EWi
         f7sHK/6PJmFOS6svIDDj0oZ7d+05MI9iHithdRr9mT39iu8EKWuKWVWGFKOYqXTiOAot
         2ekQ==
X-Gm-Message-State: AOAM531B3OCVnayXKzzt+7c0e3DTPMBamCVS4NhywxDS4wH5mdlSWGp/
        NKidjvZ2qusoXbG+ar/xQt2ffA==
X-Google-Smtp-Source: ABdhPJxLu44Gu/tOuT5dP6RrIV1x6/qviaS9oNFaJqC2x8QznPnTVt5HHb+NIVntCHV/OcnmeM9rPQ==
X-Received: by 2002:a05:6512:3a8d:: with SMTP id q13mr7467642lfu.401.1627168535752;
        Sat, 24 Jul 2021 16:15:35 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id e7sm4063553ljp.45.2021.07.24.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 16:15:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] clocksource/drivers/fttmr010: Clear also overflow bit on AST2600
Date:   Sun, 25 Jul 2021 01:13:32 +0200
Message-Id: <20210724231332.2129616-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was originally just writing 0x1 into TIMER_INTR_STATE
on the AST2600. But that is just the bit for TIMER_1_INT_MATCH1
so if we're using periodic IRQs we also need to clear
TIMER_1_INT_OVERFLOW.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch goes on top of the other two I just sent.
---
 drivers/clocksource/timer-fttmr010.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index de29d424ec95..24f62698d17f 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -275,7 +275,8 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
 
 	val = readl(fttmr010->base + TIMER_INTR_STATE);
 	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW)) {
-		writel(TIMER_1_INT_MATCH1, fttmr010->base + TIMER_INTR_STATE);
+		writel(TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW,
+		       fttmr010->base + TIMER_INTR_STATE);
 		evt->event_handler(evt);
 	} else {
 		/* Just clear any spurious IRQs from the block */
-- 
2.31.1

