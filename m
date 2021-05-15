Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65888381822
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhEOLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhEOLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 07:05:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED0C061756
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 03:58:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s6so1350745edu.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UIcZhVTZNdr19HjFjUOTgszjkrybyrCDOni+/NopqI=;
        b=o4m+VlMtdqgj8eq6Tva5ZoGJU89nY9hAXeB4PWOwzbSGzzlxPFMfoA6ub7N6gOc80x
         Ot4SkkGbxmPrKQ8j5um5EiQFFaWfyUfFk3xh3i47YWFC+tKYHFThoAo8P5Gr4yJrNRGu
         uraVIy/4kTCmc+p82Wxq7lYkahZZ69AEMsDhvscP8+g1P0+VGrHElXsrZr8wsJwNZLv/
         mWEHPyQf0m2CaionSQvShp9Y+pk7Y03OJUgHPQhxcma4jy+YZp0rlootYnuG456xi/Tw
         sCeVj8DyNTsOloqQT5AbJUagFSoVwe7R85d+VGSHLWkVJ4ROqhsZMJeQZ4DgtE1DIn2M
         WCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UIcZhVTZNdr19HjFjUOTgszjkrybyrCDOni+/NopqI=;
        b=ouPhbGtr9Z3mTpMA+8mZR2oaQ0pDPWjdbbkB0lfCGzhZeOITYVKoG8y+RGeYJIpBlI
         V7Qf2QUwfYsPOC86U072VUPYa7E7O3kDj+qwz6TWTI+6b5WF4/NMxOgLZ5kQ3QcdV+NE
         cSp4kHgJUCuBU/qNEuGQ2xcVFHBpHjnINqE5pTna5z45OULs+f7dXZaHHcHepHnjaW2G
         Gy7waIdKTw9bF5xKEOzGqiFi1HyCIQvEN/klo++Y3KCslMDWuzwXA3HHOrqPT+SEHNwh
         PnxodLCN1GBjv2IfDG1klGch1ysKGi4ezURRid7V4K3oz7AQCIrYeFKygvwOHd5FCW6A
         RYqA==
X-Gm-Message-State: AOAM5311733ydbYUQoQdJCUYBxreK1OOIO1vdq0EBYxgFw55iFktyMtQ
        /hgsD4/l2UBKMFC+e1sj1zGPvw==
X-Google-Smtp-Source: ABdhPJz5MXyR0avcV9T7mZWH0Uj0PD9k/Kxh4jnw0fdDXpasVY0k9S9bp/AzD4+vi0vR+dX5ChlcrQ==
X-Received: by 2002:a05:6402:5106:: with SMTP id m6mr61248341edd.212.1621076315727;
        Sat, 15 May 2021 03:58:35 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id gz2sm5085276ejb.76.2021.05.15.03.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 03:58:35 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-tc3589x: emove platform_set_drvdata() + cleanup probe
Date:   Sat, 15 May 2021 13:58:31 +0300
Message-Id: <20210515105831.9439-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-tc3589x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 55b8dbd13d11..8d158492488f 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -357,16 +357,7 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &tc3589x_gpio->chip,
-				     tc3589x_gpio);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, tc3589x_gpio);
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &tc3589x_gpio->chip, tc3589x_gpio);
 }
 
 static struct platform_driver tc3589x_gpio_driver = {
-- 
2.31.1

