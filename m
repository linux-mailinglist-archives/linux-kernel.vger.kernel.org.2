Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57838CCFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhEUSMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEUSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:12:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37295C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:10:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lz27so31746367ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4OX4sQ2wD2GJuD9PR45HkX778XiGO0vWKrBeEd5TQpo=;
        b=u5eOXzVHMUt/n+nmw2DDsQ92ykwe/K8H/fEKEHaIMXeeQqGCZDYsEzpxelNF2DLSSj
         i0fRaYfHM+0oOtsl3pQt6awxe8wK0HEBGI29f8kvSA/xCeATYjD6yOkclCBCQivyfN6n
         B29/K84JnNpN9pU7KcBkw1v7b6ESgqBguVF5E3iAybhGRF5XiJeup/Z1cY+rpV93viRR
         eLlTCsAIMR4wVMC40Zr+qYDCpsa+dkjTk/GzXhgdFgGplPNWcDWWvgwJ4F3BHgG9YwwT
         ZfNgHg3RMvSC6sEZOBnoOgZOC5DcfLr6rERh2p3bikJxZQdPzNTM5Flkn9yY3QQQovGv
         wV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4OX4sQ2wD2GJuD9PR45HkX778XiGO0vWKrBeEd5TQpo=;
        b=d8ejvVJgT3eDCU2yx8tJ69AapeCmspYXx6pGwkJ6x49EKIgv/4fQK5OXQBTd25Ebao
         xW3wiElORxd77JcKqf7WK26tqbaa5VmZb5I1x0XvYH9i2pUUdpG6zv8pBH/YsA+/ira1
         d/wEqQhhELhLAilSSf9abc+R9xBQ2GQyQRFcl3AeH1zhDgdqT/DcQ0mFEYU0IMkiv2Kv
         qvcKd68F/nlpVp0l9j6I6GPb769r/7B4VwQN+MovSlDw8gD1qwz6gbeYgooiaIEKwmje
         V7Rl/fFvwtKsPVh/MTZuJHFPZMiv6Sz+U4KsFFg1EbbQdqdr8540lN5xyiBHpoHx1OgF
         OivQ==
X-Gm-Message-State: AOAM5309cwTQyta8KuckFUN2HhpVli/ZsAJJ6rjNmWHTkWPy6Iq+7C4a
        kNysv+fVHBcLLe0OUKof7ZE8sexVL/E4tEWCXig=
X-Google-Smtp-Source: ABdhPJwN8gVmnUJ9+so0L8+KhZLH4ULKra6RZ+x51a04/nqj42wSK4n/aoq6Lk4UlorgcSQD1jk6wA==
X-Received: by 2002:a17:906:d0d4:: with SMTP id bq20mr11812090ejb.541.1621620648732;
        Fri, 21 May 2021 11:10:48 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id h16sm4477962edq.82.2021.05.21.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:10:48 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-xgene: simplify probe, return devm_gpiochip_add_data() directly
Date:   Fri, 21 May 2021 21:10:42 +0300
Message-Id: <20210521181042.7726-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of the return value from devm_gpiochip_add_data() is a bit
redundant. It prints messages on error and success cases.
While the success message may be useful, it is more in the area of log
spam, and these can be printed with other forms of kernel logging.

This change does a direct return with devm_gpiochip_add_data() in the probe
function.

The platform_set_drvdata() is needed, as this driver uses the stored
private date in the PM suspend/resume routines.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-xgene.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index 532b0df8a1f2..fb4b0c67aeef 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -159,7 +159,6 @@ static SIMPLE_DEV_PM_OPS(xgene_gpio_pm, xgene_gpio_suspend, xgene_gpio_resume);
 static int xgene_gpio_probe(struct platform_device *pdev)
 {
 	struct xgene_gpio *gpio;
-	int err = 0;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
@@ -183,15 +182,7 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio);
 
-	err = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
-	if (err) {
-		dev_err(&pdev->dev,
-			"failed to register gpiochip.\n");
-		return err;
-	}
-
-	dev_info(&pdev->dev, "X-Gene GPIO driver registered.\n");
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 }
 
 static const struct of_device_id xgene_gpio_of_match[] = {
-- 
2.31.1

