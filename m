Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BF45F5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhKZU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhKZU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F62C061756;
        Fri, 26 Nov 2021 12:22:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so20966971wrn.6;
        Fri, 26 Nov 2021 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbmBZ5Zwv5zLpsOoPrsOue7z4XHagT3TOh60X5iwSAY=;
        b=drj5uZa5q5DgnCUAYwUWDMNBfKgYAJC5XXnMNyelrkFc7Y071PxiTy8eJPB5sjsNF4
         nbHxkqh2wJK5X5jU5GoWqNmcNr9iZOvcSYbMkB5AxVfGF5XMN+tbs0CHHNJeqgKGr4yJ
         28caOB0kyD/NVg212LmGgQAhzYtG9v+gSrPklh9t7ud3QP6ynJ7xW8wcngPk9AvTRvZa
         FdazuNlDJaQnysRTNnQJUq1KLW5r78Q/RqpU5rfYkwKu1abZfA54fmkqz9mSXh6DALow
         1a1rzvj4L1LRcT121UEyskz+E6Ko3IIR3sphaTvfTqKCKPYLZecFQYZEYQhthJe7rWP4
         P6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbmBZ5Zwv5zLpsOoPrsOue7z4XHagT3TOh60X5iwSAY=;
        b=uGXlbxRe9lQn77bJP43NGvdkr7mr0GrCEW+fqBLDTep/qM37AMaSCjdfLt/m3C01iu
         ouXsf8QNt7sui21I6aQHuVQURkOxYuI1XHeUhrkyOsKtvv8GfbXrr9FiOOhL10MEipQI
         hSFuMBS4d2Dh7q/bNKInsuQIINRamWt+y+JLl73RByJEA0d7nZYY42TD4nWqPtCBoIyE
         ByBU56TDmBy6NhPrClS1MPGPtWDZ5Dp9V0CAHzrXSGJITDnc+wTWuakb2is7h/nltN7m
         XWPnQTmM210bbamEDFpm81KpgGgwP91LVkABgFgob9nc5/F/1HEORZk9xJ5cXHppSSCE
         IHYA==
X-Gm-Message-State: AOAM5305fLZwW1hzRIuPLAVKknZZOHEBzUHW1Zw3u3dVogjkli65rCL4
        5MQq/3ujDg9zNGDdee4gHMngQy4aBqg=
X-Google-Smtp-Source: ABdhPJyNo6PUm297QU/qS4l22fTFGh7a3sXWQsg0TWfokPhfQd0RtcysQcp4G0owRIMqMWEixgI7mQ==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr15689606wra.557.1637958123544;
        Fri, 26 Nov 2021 12:22:03 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id bg34sm10864180wmb.47.2021.11.26.12.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:03 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] clocksource: msc313e: Add support for ssd20xd-based platforms
Date:   Fri, 26 Nov 2021 21:21:41 +0100
Message-Id: <20211126202144.72936-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSD20X family SoCs have an oscillator running at ~432Mhz for timer1 and
timer2, while timer0 is running at 12Mhz. There are no ways to reduce or
divide these clocks in the clktree. However, SSD20X SoCs provide an
internal "timer_divide" register that can act on this input oscillator.
This commit adds support for this register, as timer1 and timer2 are
used as clockevents these will run at 48Mhz.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/clocksource/timer-msc313e.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
index 81f161744349..6e7a0ece6601 100644
--- a/drivers/clocksource/timer-msc313e.c
+++ b/drivers/clocksource/timer-msc313e.c
@@ -30,7 +30,9 @@
 #define MSC313E_REG_TIMER_MAX_HIGH	0x0c
 #define MSC313E_REG_COUNTER_LOW		0x10
 #define MSC313E_REG_COUNTER_HIGH	0x14
+#define MSC313E_REG_TIMER_DIVIDE	0x18
 
+#define MSC313E_CLK_DIVIDER		9
 #define TIMER_SYNC_TICKS		3
 
 struct msc313e_delay {
@@ -165,6 +167,12 @@ static int __init msc313e_clkevt_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	if (of_device_is_compatible(np, "mstar,ssd20xd-timer")) {
+		to->of_clk.rate = clk_get_rate(to->of_clk.clk) / MSC313E_CLK_DIVIDER;
+		to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
+		writew(MSC313E_CLK_DIVIDER - 1, timer_of_base(to) + MSC313E_REG_TIMER_DIVIDE);
+	}
+
 	msc313e_clkevt.cpumask = cpu_possible_mask;
 	msc313e_clkevt.irq = to->of_irq.irq;
 	to->clkevt = msc313e_clkevt;
@@ -226,3 +234,4 @@ static int __init msc313e_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
+TIMER_OF_DECLARE(ssd20xd, "mstar,ssd20xd-timer", msc313e_timer_init);
-- 
2.33.0

