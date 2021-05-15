Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04563816A5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhEOHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhEOHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:53:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88541C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:52:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c20so1900795ejm.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZk+7UgQ/ev3klOu/zQXroC2fr8BBS83ryBvlIT0lSQ=;
        b=btBYIMJsb2Qc8kUu+BwOzOm0bnembBDeEEMcNwO3rZ8qJl6mPDVKh4e8qHfgiGnzPC
         xnowC/5vzGnTfe1wXi6lseO+Yu9NvNbWjX9LHvPuES1VCgvKtSxw8VAXdJ7CFV7N1Xt2
         Hnb1hOyg2aH9hcm+rIu7BwuaY72D64La3wxF5oLBoleJpgThljTSSHuUrKCwLmuPCdFI
         G6Ix17XOn9G5HduDq1E2r8si1105Zf+Y1hvg16SH/nOQqy21QPDZFVIr4alhANs1gmn6
         QLizj0Y4hiHZCBnVxpeesjJ44EorJ0W/8s0xxX+VBtGRfn6kHW2ZSJ2syIy+1RXNGSEx
         b0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZk+7UgQ/ev3klOu/zQXroC2fr8BBS83ryBvlIT0lSQ=;
        b=CElemCySJ7UWILJkkk9weUGtoLuW95/YWemx2Dp6jPAa8RQPpbkxkVO8IOrp3HgPVH
         VyXUfd1SIpGTyDNgxycLyJ+k3KEDsDAagZgJupH6wdYdbfAYYt+mniArl9hGffvdgQej
         ziQC9GDc61l6UvqyVMC7NLBTb5cGHVGlPRSj3OulNn8dYjc8f/Tac8bIEUZgrEENkXGc
         WyvLj+/ZW4GjK0p96ITbZxBNg8ETNjxAiSB4GZ4+DGMG57fYZHbx9lo7eGE4WYZzC8jH
         VD1geJPmxQIEe4exzKbhEHnRRjemRLltMmNT+RgoRau3gs6zgRwu77Z8GH8/N6C957Ut
         dNrg==
X-Gm-Message-State: AOAM5303mZKrFU+UI97ISbvoolI51nWJjmvwJKzigi5pFB9atrb+/302
        Z0OC707eOCA2C8J0e/3fmRPLBA==
X-Google-Smtp-Source: ABdhPJydKnPJ1GBx+K3tFJkfHdqem6TY2f81reDMs79XknWZXNikrNvVcrJowXyeYpPTPdiq5+cIlg==
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr53659347ejc.316.1621065162220;
        Sat, 15 May 2021 00:52:42 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id d25sm4868426ejd.59.2021.05.15.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:52:41 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-tps6586x: remove platform_set_drvdata() + cleanup probe
Date:   Sat, 15 May 2021 10:52:33 +0300
Message-Id: <20210515075233.7594-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-tps6586x.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-tps6586x.c b/drivers/gpio/gpio-tps6586x.c
index 9b6cc74f47c8..20c4f96f42f0 100644
--- a/drivers/gpio/gpio-tps6586x.c
+++ b/drivers/gpio/gpio-tps6586x.c
@@ -76,7 +76,6 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 {
 	struct tps6586x_platform_data *pdata;
 	struct tps6586x_gpio *tps6586x_gpio;
-	int ret;
 
 	pdata = dev_get_platdata(pdev->dev.parent);
 	tps6586x_gpio = devm_kzalloc(&pdev->dev,
@@ -106,16 +105,7 @@ static int tps6586x_gpio_probe(struct platform_device *pdev)
 	else
 		tps6586x_gpio->gpio_chip.base = -1;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &tps6586x_gpio->gpio_chip,
-				     tps6586x_gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, tps6586x_gpio);
-
-	return ret;
+	return devm_gpiochip_add_data(&pdev->dev, &tps6586x_gpio->gpio_chip, tps6586x_gpio);
 }
 
 static struct platform_driver tps6586x_gpio_driver = {
-- 
2.31.1

