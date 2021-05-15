Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1853816AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhEOH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhEOH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:56:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F433C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:55:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b25so1882467eju.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3vLwW+VzRaxjESKCqXUtPcyQh1X0uzwp7Rpbs5RV5U=;
        b=VtdMewbitiV1KF4LGZiKuYoOrGK5e6TmWfRfHQkdoU3FnoAGXgQ+hTTgx0lvSlnSaA
         n4592UsITYm0/vCXB4f5cqP7YLlCsWowyipJFsepFyrFdWY2Rnd994Z+BkZ7FZwO708Y
         SkRmcYBkZRb0+LL7kJD/z9IgQ9PqT1uNDocIEreQKpAl25OsuVeYW0Z7lQaGw+atpHZr
         ppv4uuVvmKMlvg82uAh1Kk8zZQQ0zuvMYLarBY9pRmPnM5IagrMjPoc3PowT7ltYjT7K
         gCQpk4Fi0DnJqrPf2OlN63Zsk7/YPp4qOwJpQTqZm56NlOUvxnd+WzXqjBB3akYVX3dE
         Nm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3vLwW+VzRaxjESKCqXUtPcyQh1X0uzwp7Rpbs5RV5U=;
        b=KHFL4atlANN3SWNfz8SBUXAf5ruWLv3ltmg9Ip/GXp8BJ7MlwBilRhsMO7IS6rpgK8
         rHgbiiPsu+PgnYhwVykox+gX0UuYU+disThCISczMWHUyR4gx7K0cSy3Z5QP47xFSyHw
         YmGOiwDHyXJ7HwChuNsImJ4kHJgehWkQza6LePoVFV2t3pCPSb1+jf/mRou3nojqKE/U
         NDENYgJSZpQTsUguGcdwxIb8RND7oqFvm37hLvFOTmLEkUGtcCBG8miO8qSNvll58Vba
         85HT/WB0KJsCRzoCgERjmzYhPjPoWDMYG7i9GqEKS2KzAqfIs9FqxBuvunwd9n0yOz0J
         Snsg==
X-Gm-Message-State: AOAM533gFBHGR16jzVr7Z8xHgH5SnAFQZdZu60zTolOOkGfKfGSq+ug9
        rN7VOksJQ8yBltCji1f1g/PUiw==
X-Google-Smtp-Source: ABdhPJxkx3f8TGV6oKOgiHV4JzUhvMYSvanBfTJn72/CwIK812lJLfh+3Jdsrm00DW1/yKWfYlT20w==
X-Received: by 2002:a17:906:84d:: with SMTP id f13mr9182085ejd.451.1621065301903;
        Sat, 15 May 2021 00:55:01 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id q18sm6182629edd.3.2021.05.15.00.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:55:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-tps65218: remove platform_set_drvdata() + cleanup probe
Date:   Sat, 15 May 2021 10:54:44 +0300
Message-Id: <20210515075444.9210-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-tps65218.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 43a1150055ce..66461ed192d7 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -187,7 +187,6 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
 {
 	struct tps65218 *tps65218 = dev_get_drvdata(pdev->dev.parent);
 	struct tps65218_gpio *tps65218_gpio;
-	int ret;
 
 	tps65218_gpio = devm_kzalloc(&pdev->dev, sizeof(*tps65218_gpio),
 				     GFP_KERNEL);
@@ -201,16 +200,7 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
 	tps65218_gpio->gpio_chip.of_node = pdev->dev.of_node;
 #endif
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &tps65218_gpio->gpio_chip,
-				     tps65218_gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, tps65218_gpio);
-
-	return ret;
+	return devm_gpiochip_add_data(&pdev->dev, &tps65218_gpio->gpio_chip, tps65218_gpio);
 }
 
 static const struct of_device_id tps65218_dt_match[] = {
-- 
2.31.1

