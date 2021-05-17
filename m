Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAA382B30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhEQLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhEQLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:37:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45329C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:36:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b25so8709127eju.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcGpt5wEDtLrk+3qFVLpoBXykB2bKeqmmLwp+4JjPkI=;
        b=hts47UB0XM6AOcqV/LviB/gWfvERufgRTDuGVN9j62F/YZLXmRh+2H0qBsWeYsuwmA
         m4ow7P70AuciBQzi8X95xn7fV6SRs2/M6iwc12H/5SLNlqoazp9dV84i0WTYn7p5xV2A
         6Mds/B9+1hB4jHrhGhgyFYDC3hmGRPv0soTyQJiqNffB8+OfWoXAv/Z8JDbaW3qkGshE
         +wHf6oSbYcNVUa+86ITzVWQ4Ih7+g1Y3KBgyQlvbbvenyQrnYThMibgckWZdP34PML85
         bF89QfGYaAqFE7Msyeras4UVmV4DBTHGnU0OZrB6yhG/7+4/rMqhABqZxye8f/J2qxpx
         u/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcGpt5wEDtLrk+3qFVLpoBXykB2bKeqmmLwp+4JjPkI=;
        b=FUhgG/jAzHTu1fZkVIiFdg91ecrnMiixejThiFnoIVWYCaEt7iiR/HsCM6ANk0nSvb
         VxlSZ5vFkNHQqLDzz/QhsuQb9zOcqUyf1eh9V/M9OqNydE+iNR9HF4SEnFjJK9tCSyvN
         E/cdUixgK/ooKQ+dsFwJmYcmFJdZ3oznNI21sytSm3IjcE9me0MwIBLWE/s28Md05c62
         uUy52AaN2h1aUqz0iuOW/suGNOfWKvMxlku0yU27jEHtcPlEx/TaVv26JL+HJc2mxEvO
         JFvWOkL3vCihLfl4Jlw6sd2ATaMHIEUQIFjNaF637ZrYQKwKod9jZXyqXG2QDOrumQlB
         U6vQ==
X-Gm-Message-State: AOAM532imotF5oDlMHVKelPuQp3n+J1x/OU6CiXoTKaRIT1HuR6Jcdx4
        L0p/NcidBl2A6lU4pD4JGuZx5bj4+p3Fhul7dkE=
X-Google-Smtp-Source: ABdhPJwPKYk3uJ3oyv7F8e1AJaekAuEiddr//uyl/5NGsUR0Th3h8MG9EQ4bb3BCMwyndvQvv2tdIA==
X-Received: by 2002:a17:907:98a9:: with SMTP id ju9mr11736205ejc.257.1621251365062;
        Mon, 17 May 2021 04:36:05 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id v24sm2903703eds.19.2021.05.17.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:36:04 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-wm8350: remove platform_set_drvdata() + cleanup probe
Date:   Mon, 17 May 2021 14:35:39 +0300
Message-Id: <20210517113540.237495-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517113540.237495-1-aardelean@deviqon.com>
References: <20210517113540.237495-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-wm8350.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-wm8350.c b/drivers/gpio/gpio-wm8350.c
index 460f0a4b04bd..b1b131fb9804 100644
--- a/drivers/gpio/gpio-wm8350.c
+++ b/drivers/gpio/gpio-wm8350.c
@@ -105,7 +105,6 @@ static int wm8350_gpio_probe(struct platform_device *pdev)
 	struct wm8350 *wm8350 = dev_get_drvdata(pdev->dev.parent);
 	struct wm8350_platform_data *pdata = dev_get_platdata(wm8350->dev);
 	struct wm8350_gpio_data *wm8350_gpio;
-	int ret;
 
 	wm8350_gpio = devm_kzalloc(&pdev->dev, sizeof(*wm8350_gpio),
 				   GFP_KERNEL);
@@ -121,16 +120,7 @@ static int wm8350_gpio_probe(struct platform_device *pdev)
 	else
 		wm8350_gpio->gpio_chip.base = -1;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &wm8350_gpio->gpio_chip,
-				     wm8350_gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, wm8350_gpio);
-
-	return ret;
+	return devm_gpiochip_add_data(&pdev->dev, &wm8350_gpio->gpio_chip, wm8350_gpio);
 }
 
 static struct platform_driver wm8350_gpio_driver = {
-- 
2.31.1

