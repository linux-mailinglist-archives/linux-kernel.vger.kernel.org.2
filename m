Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB02380612
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhENJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhENJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:21:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:20:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lz27so2405545ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oVlIzsgyC0dJxtrYRa2nyFwXTSIbf+GvU9OiEg4J30=;
        b=ao7uaInE5L1Ppno1CZmlqyzXD553mSlHvsskpnwNHtkvUBX9EYTeprO4GgNNSH3Uji
         bvrdUs/4JfwAPgKO15aHM/iy7oIfdU0x95VZxMg6nRc6AlvAmtA1oMjbQw6QFa40d2M4
         OrlwXHnl30DdcfN2I6fsJdIAO+WcSCtGGMEnaK3tuE5VlJT2JyalJfVIT/p5/mAa7vVf
         tVJI3BtGQPBRsZ4EF+D5mZIuKg5nh0jcaoCwHOYMZBlzvshZP+wGzS+Zuf/TgsdiG8/V
         wGNDzyiKZV282kEunh34EvdTIf8jox6RiuBX1w4kIMnx2lxmsAsAUSeQ50yt8gStrQac
         SFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oVlIzsgyC0dJxtrYRa2nyFwXTSIbf+GvU9OiEg4J30=;
        b=a2AErOwMWZBbjI0H8fpc5nTcbE0A+R+mj0KxyK2q+hf9mV0ddfvIIiY6W4Yv9rUc4h
         69vVTqcSAq+bdS/WEUlc6HOn9ULHyymagvu05//CkcYSzvUNDG9HtwDdvNHe99+CLOJt
         /nH+Yrjtq1sH19tZhUH68rnfF4zN0kS5GnLp6iZRHXmYPfM0O8yzppABZrAEfmdPfpPU
         yWr9bQS/NUqTrvH8PrwweDCaF7fxkSzH2Jk2a/qfp/LP7EP5Vu6alzRfvm810eoYQOpP
         Bm0kHbUroqqZOwCO6Fs2fZkWzTfWZS7Gp22HaQBdFBPNH49CMzXsxLGWLzjb0bARrSzg
         0pMA==
X-Gm-Message-State: AOAM533Ew/JS2on6JMfSyMFqbNf+tTGboZz5s/F1Oqt2Aoy8HwA/KLHN
        PdI23awDoo67eEwpdLHuAj9hvsalPGfe8Cvj/Pg=
X-Google-Smtp-Source: ABdhPJw8hWROQjHe9CW4nFmSOlr4ARrNi23X2t+KrG13hniOqUamhI7vXtVjD3fbWXb+J5Y/zYdZ4g==
X-Received: by 2002:a17:907:dab:: with SMTP id go43mr5275772ejc.164.1620984034547;
        Fri, 14 May 2021 02:20:34 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id w21sm4006720edq.82.2021.05.14.02.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:20:34 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        thor.thayer@linux.intel.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-altera-a10sr: remove platform_set_drvdata() + cleanup probe
Date:   Fri, 14 May 2021 12:20:17 +0300
Message-Id: <20210514092017.17922-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call is only useful if we need to retrieve back
the private information.
Since the driver doesn't do that, it's not useful to have it.

If this is removed, we can also just do a direct return on
devm_gpiochip_add_data(). We don't need to print that this call failed as
there are other ways to log/see this during probe.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-altera-a10sr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-altera-a10sr.c b/drivers/gpio/gpio-altera-a10sr.c
index b5917c48e4dc..6af51feda06f 100644
--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -78,7 +78,6 @@ static const struct gpio_chip altr_a10sr_gc = {
 static int altr_a10sr_gpio_probe(struct platform_device *pdev)
 {
 	struct altr_a10sr_gpio *gpio;
-	int ret;
 	struct altr_a10sr *a10sr = dev_get_drvdata(pdev->dev.parent);
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
@@ -91,15 +90,7 @@ static int altr_a10sr_gpio_probe(struct platform_device *pdev)
 	gpio->gp.parent = pdev->dev.parent;
 	gpio->gp.of_node = pdev->dev.of_node;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, gpio);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
 }
 
 static const struct of_device_id altr_a10sr_gpio_of_match[] = {
-- 
2.31.1

