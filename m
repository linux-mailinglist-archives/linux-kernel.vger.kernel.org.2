Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44CB375C37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhEFUaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:30:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49223 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhEFUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:30:38 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lekcs-0001ci-Rt
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 20:29:38 +0000
Received: by mail-qk1-f199.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so4332087qkj.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3wg2XN420azu/evG4iGtlbTYfEz7jreR3UbeD+i/T0=;
        b=k8WBmCJjgBYruJilNZ4ct7eaGTfqJMuQtSWEYd0iq2T2cT7aZBYBti7wylUUAt7za3
         +XK9dn1tQqEhTgywMSTGGzo5MYMNBk1L4QbEerRRtWT7/2Ii5xZAjBxhWyli0fvFCY+w
         0N+UvsXSi3LP1I34/KgbT573U8aeyboWw8jdF9D1vboLY9PuvZ5bTG2hITKbNjk+M69F
         oBHOL2DFpIMGNO6pKLIwukiUlgvl1Y5aK6JKc0oHnsmOoVUfznpe1aLpeiEhkJLuHTPo
         gdnr8uhp6ANsB1a+9M8Q/57jGRnf7EBNnTGf7JmQ7FxJi1+bBbUFMVIOKqJcfJyb+d8a
         EglQ==
X-Gm-Message-State: AOAM530AlZqAyzIPx6b1nV1qgUItrfFe1X3dKKFJRNqQX6abdUekEmsO
        tOB/QhTeeeci5JupYN7pnaCCnMxBKZqareRJeTYeegdaJ+SDlW1yQf+rERjpnnQbXgjzEfp6WG0
        LIgG5/8V5sNqQ+UHkrM4VDjSmcQpydTk2X2s4kvnoEQ==
X-Received: by 2002:ac8:5dce:: with SMTP id e14mr6047042qtx.385.1620332978030;
        Thu, 06 May 2021 13:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr/teC4fU26p0xkpWZj5KkZrm5frwONB63LY6ImAr+V1yN3mfqGPo04XbzbC5xzeeBkOr5Tg==
X-Received: by 2002:ac8:5dce:: with SMTP id e14mr6047029qtx.385.1620332977866;
        Thu, 06 May 2021 13:29:37 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.6])
        by smtp.gmail.com with ESMTPSA id r9sm3151363qtf.62.2021.05.06.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:29:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/5] clocksource/drivers/samsung_pwm: Cleanup on init error
Date:   Thu,  6 May 2021 16:27:27 -0400
Message-Id: <20210506202729.157260-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure of timer initialization is likely to be fatal for the system, so
cleanup in such case is not strictly necessary.  However the code might
be refactored or reused, so better not to rely on such assumption that
system won't continue init failure.

Unmap the IO memory and put the clock on initialization failures from
devicetree.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Not marking as cc-stable and not adding Fixes tag, as this is not really
a bug.
---
 drivers/clocksource/samsung_pwm_timer.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index bfad61b509f9..55e2f9fa2a15 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -421,7 +421,7 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 	struct property *prop;
 	const __be32 *cur;
 	u32 val;
-	int i;
+	int i, ret;
 
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
 	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
@@ -444,10 +444,24 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 	pwm.timerclk = of_clk_get_by_name(np, "timers");
 	if (IS_ERR(pwm.timerclk)) {
 		pr_crit("failed to get timers clock for timer\n");
-		return PTR_ERR(pwm.timerclk);
+		ret = PTR_ERR(pwm.timerclk);
+		goto err_clk;
 	}
 
-	return _samsung_pwm_clocksource_init();
+	ret = _samsung_pwm_clocksource_init();
+	if (ret)
+		goto err_clocksource;
+
+	return 0;
+
+err_clocksource:
+	clk_put(pwm.timerclk);
+	pwm.timerclk = NULL;
+err_clk:
+	iounmap(pwm.base);
+	pwm.base = NULL;
+
+	return ret;
 }
 
 static const struct samsung_pwm_variant s3c24xx_variant = {
-- 
2.25.1

