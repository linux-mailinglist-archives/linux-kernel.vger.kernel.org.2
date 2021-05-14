Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4B3805AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhENI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhENI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:58:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:56:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l7so33943140edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfLV1nYUVE1ZnJSakkYj6xvjl6r5j5i0hj4qr/7M2gA=;
        b=GubL38k3QmfEjpfnVILU1RGDevNxkNmMmsZwDSPavE62Kvk+fNH1QynWxnjBfTDvkr
         70Gbk3NLAMwUWePH88slhpqmE248hN++kRC61Bw8cS1r7y5Qdk2/mKLMfvoWTXzkjlsG
         x2OgsKvwqvODq48M0EydCP6onvJydW0xZxfUTfDpleMXbVkO/qXWC7y0Ql2tuYQ17QfT
         R0pg+I4dWf/7ES/WAGcGXF6yhhgmLxK6gKNOeucW5q3B6b+Ehx9zTAq0A5IsWpoxZH9R
         AqnKIp3mYQq4dZxYECu0PNzd1XDzFsuGvjyWY/3i8jw1PLUbjbMqDzKjkPsWyszFK0Ph
         J43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfLV1nYUVE1ZnJSakkYj6xvjl6r5j5i0hj4qr/7M2gA=;
        b=Gl7mBT60HocTXK/35PT0yatG82ABCZo6HoKsrSHH4WHGd/OpfzvJVqTtS3uCfrqMk8
         lNcflUH0/UDhhmDtfHC5aMsh2kwzlVeoQuK8igmtd4V5W8JnP7CBg46w5hVx+YLX5T4P
         LvAAfrlgASLBzY7tBPtJC6CIYWvUwj/QF6JoNZBjMzFuwhECSthlK47iMxSNI1AKbk4d
         ndDUGj3oZTfRsUxOt2h1MDn2er7s7VxEHfhthynBTT00GWeKEdPUzwZLRKv5X8op6EhY
         V1er66yKlhZnPAG9LvFl6/E8JI8SriJ2HLqvNSWw9S6BzpoNr95OYVhE+39UAIH61d4d
         edTA==
X-Gm-Message-State: AOAM532IUo19xuJZOG31DjN62BNDkXNQJxHr5EAsGDPGkSbBfJZp9ZaT
        27+lfoTsOcEn2RtWiSPXx1InEg==
X-Google-Smtp-Source: ABdhPJzftkaGj2fWO2un3BLJdYuKBtXvDZJSBsWQLiNy9hI8XPgpgg2ibYxTQ78dtqUZTrFV1BzxFA==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr35433389edc.324.1620982612284;
        Fri, 14 May 2021 01:56:52 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id a24sm4102908edr.74.2021.05.14.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:56:51 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        michael.hennerich@analog.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-adp5520: cleanup probe error path + remove platform_set_drvdata()
Date:   Fri, 14 May 2021 11:56:27 +0300
Message-Id: <20210514085627.11230-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call is only useful if we need to retrieve back
the private information.
Since the driver doesn't do that, it's not useful to have it.

This also means that the 'err' label can be removed and all goto statements
replaced with direct returns (with error codes).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-adp5520.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-adp5520.c b/drivers/gpio/gpio-adp5520.c
index 0386ede53f3a..c55e821c63b6 100644
--- a/drivers/gpio/gpio-adp5520.c
+++ b/drivers/gpio/gpio-adp5520.c
@@ -113,10 +113,8 @@ static int adp5520_gpio_probe(struct platform_device *pdev)
 		if (pdata->gpio_en_mask & (1 << i))
 			dev->lut[gpios++] = 1 << i;
 
-	if (gpios < 1) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (gpios < 1)
+		return -EINVAL;
 
 	gc = &dev->gpio_chip;
 	gc->direction_input  = adp5520_gpio_direction_input;
@@ -148,18 +146,10 @@ static int adp5520_gpio_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "failed to write\n");
-		goto err;
+		return ret;
 	}
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &dev->gpio_chip, dev);
-	if (ret)
-		goto err;
-
-	platform_set_drvdata(pdev, dev);
-	return 0;
-
-err:
-	return ret;
+	return devm_gpiochip_add_data(&pdev->dev, &dev->gpio_chip, dev);
 }
 
 static struct platform_driver adp5520_gpio_driver = {
-- 
2.31.1

