Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828E238CD01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhEUSPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhEUSPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:15:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:14:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z12so30334865ejw.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxSWMfTKV0DnrGthCk2mW907OE06qEE2VFa75NVRydc=;
        b=LCGiZkjsO9XXyvZkKrVWxXAX+RrHYsenY2uyMBTwo6hSFG5HeWx7I1UVVJDSXOGK+x
         u+vKph+AFQs9PQWmo4p7hw5aToK4VZ5QYOWBv7BxcP4uQwWC388TCzd8ti5RaUA1GlJH
         fsgW21AgVeenlTttTO+laAAP5XVwqJFnCx+S6ooi4WtpcSXlvXoqvR3lmKbsfbDcWewS
         w8nm27xO1kHoZjNXqfAD/a0zUdohuMeHxmcV+0OaFaNmvtkCVhPMPIFmxaUaL8ggGkHH
         2UwuUJouMhhkDAqwCKHJcJsiA1+G0lZyjzaJoEYdiJ1S5M1Y58ELAbDkUkrHFwi/K6SB
         kfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NxSWMfTKV0DnrGthCk2mW907OE06qEE2VFa75NVRydc=;
        b=KcO3v/U14COyuViVWl/UZE/waejAxg79OredXRDLetcNVn4kKasIXxcdwI4+dSzqQb
         +4Mv3pMyfJhk0LQjn3bZWqvxrGSlyR4a7t0jWx9w7Awr6xWE111GqHqRVcwsYRLo2jKj
         dMm1eaC9T53cmnAUR+2XJll1+bWuSI5TWUW8Ab879oMEbe2UT15zhZzvhcET8Yw200Y8
         muRQGZni3jE40iEob5O+xe8vhfUbRXvF7ZGCTKIGwRdcymTb0tLIVrDNwigij3CPjjCD
         6XagYexCFS3fEJE+bNCRsyiJczxIWFbrJUniRPKXYv5Gz/ssZaMRM2OIBZ61pu1N0YOQ
         RVJA==
X-Gm-Message-State: AOAM533UEUIt7hPCNjuz9utp4/miUtb4bymkQkAjPW571UjP0o9xqXFy
        5kVe7RwfU9omxYygpKxcn1EoN/11N58kwWS8GcE=
X-Google-Smtp-Source: ABdhPJxciuAn1gGquNnTkrxCMmb+2cC3zK/XW5cKG7SX4MgiECCx4lwlpd8Qv8qpKdZ8MskzPHpQiQ==
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr11914838ejy.460.1621620863380;
        Fri, 21 May 2021 11:14:23 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id d15sm4566617edu.86.2021.05.21.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:14:23 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        support.opensource@diasemi.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-da9052: remove platform_set_drvdata() + cleanup probe
Date:   Fri, 21 May 2021 21:13:55 +0300
Message-Id: <20210521181355.9983-1-aardelean@deviqon.com>
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
there are other ways to log/see this during probe

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-da9052.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-da9052.c b/drivers/gpio/gpio-da9052.c
index 9aa59afdcbbf..559188d80c2b 100644
--- a/drivers/gpio/gpio-da9052.c
+++ b/drivers/gpio/gpio-da9052.c
@@ -196,7 +196,6 @@ static int da9052_gpio_probe(struct platform_device *pdev)
 {
 	struct da9052_gpio *gpio;
 	struct da9052_pdata *pdata;
-	int ret;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
@@ -209,15 +208,7 @@ static int da9052_gpio_probe(struct platform_device *pdev)
 	if (pdata && pdata->gpio_base)
 		gpio->gp.base = pdata->gpio_base;
 
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
 
 static struct platform_driver da9052_gpio_driver = {
-- 
2.31.1

