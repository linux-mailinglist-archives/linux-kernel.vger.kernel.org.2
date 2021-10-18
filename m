Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0A432515
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhJRReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhJRReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:34:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39BC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:32:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y30so1589527edi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcXTMSle67F0iHj+mrkZMW1lH8e/zEdbzDB64MF3Hvs=;
        b=BcVd61Rq2NCn1GxP94JH5rzt+AoQTkkFGmeW2+2+kB5BdxHQWQhk8jgkdZACBlX80Z
         hsQV+dyxwly5rGw+mlzWvn+jSYY8F4tnMfXvcDF0r/D9j4BzHX+8mEh0dPF4nhQOIWZc
         GStKXraJtspGVDzioSG5ffyRhB3Kyt8UQxXPrpCLfQPB1X2FFKZ8KOBiDLFr3b1mMotY
         dRsA2DSasWR/FI/TtfXdgu8ouMht07sF612sGQA5teORLVfVNe5jznmU3TPIwRxugyXx
         QpnTqGi/j0sw8C9mXF65w1ypJPjloAo6655lcAZRsyvPVyfxof0LDnF5hHLftbCt4Bb0
         wnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcXTMSle67F0iHj+mrkZMW1lH8e/zEdbzDB64MF3Hvs=;
        b=CJsghXaRsH9nEWFXjgWi1Yy12UwzhcQ0qWmGajEUK6HTr/Rblw30uOqK0eCZnXCl/W
         QV4vQDUKqrp6473XFZ5GgXFjxX5PPjMvGeH5O8SceOUUwP7EvSxwVmXqCrfmGjmQBUnH
         SoV8Ylp5xS6zXjymKd2HE2vc1orhGGuYgGjsrFfFLftUvNTUJduiGwlihd4doDJtcv2p
         xILjDzd/8CtjqkhlUS5whwPJpNqGaZ/ZWT2uBnd3ofhlcPmeLWR1yAD5MWt8A8cw3HZE
         G2J99ea2hEKRCnyvQr2b1xSKMLKbbVWAh3nlPz/Xo09Hvlhgy27uaaHANG3p66DXD2aX
         eqOw==
X-Gm-Message-State: AOAM5320cdFN182QnaQWcBPS5WWUPE8nfgOGWFhb1mq9hX5NS9ePpkui
        c38u3w+8W0w+Wd7Cl9aH4F0soIEHTCKaNqXW
X-Google-Smtp-Source: ABdhPJzrkfb8ujNn/nq10hWyW0cvZvpMkMTTpEmtgWG+N17RxIsfLFDczErL+gitqi6RrdEPrHUgqQ==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr46571650ede.394.1634578323076;
        Mon, 18 Oct 2021 10:32:03 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m3sm1244049edc.11.2021.10.18.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:32:02 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: s3c: Remove usage of devm_rtc_device_register()
Date:   Mon, 18 Oct 2021 20:32:01 +0300
Message-Id: <20211018173201.2166-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_rtc_device_register() is deprecated. Use devm_rtc_allocate_device()
and devm_rtc_register_device() API instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/rtc/rtc-s3c.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index e57d3ca70a78..10e591794276 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -447,15 +447,18 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	/* register RTC and exit */
-	info->rtc = devm_rtc_device_register(&pdev->dev, "s3c", &s3c_rtcops,
-					     THIS_MODULE);
+	info->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(info->rtc)) {
-		dev_err(&pdev->dev, "cannot attach rtc\n");
 		ret = PTR_ERR(info->rtc);
 		goto err_nortc;
 	}
 
+	info->rtc->ops = &s3c_rtcops;
+
+	ret = devm_rtc_register_device(info->rtc);
+	if (ret)
+		goto err_nortc;
+
 	ret = devm_request_irq(&pdev->dev, info->irq_alarm, s3c_rtc_alarmirq,
 			       0, "s3c2410-rtc alarm", info);
 	if (ret) {
-- 
2.30.2

