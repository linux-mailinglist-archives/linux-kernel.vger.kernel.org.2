Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702F38CD10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhEUSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhEUSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:18:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F5FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:17:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t15so24311538edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMwmJaZ5GB+lc9fDld1NHW1/GpWNomISU7CUFQvXptE=;
        b=ud67qYNHNNv6PvX4CkVUTYjRaZZ1DebaBV69n/s50r2RJRzy8pFK8e5gqafc/l5O6E
         XcDPz1ZAEMM451j3sLjHEd6ZDOTSy1JSSnAOhH9pkUcBjdzjZ10mRLDA9SHLMcRAKYLe
         vMuUJCmgP48jPy9n9Fa3l6zAeXOPTh9BCtmSl1OjDfkZjdlI21iyV3jVK7+7kiQ+vfbq
         CNrbsOh+rOgUKlffBojLWvDv3foG4dNI1gSUS//KzSB1endfmw6rg0LdaIhBZW+7bp9R
         Nx13ojLVFsm3A2GCXlpTz56grFWtHuTBhHxdDKA08WcvR+8a827TQmqS7zBmF57XhXyq
         Ci8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMwmJaZ5GB+lc9fDld1NHW1/GpWNomISU7CUFQvXptE=;
        b=RpRevq+rEOssUbR6Q8HEY+64USs8CRLUaVJ599BzLtJLFrL8eJQPAbX67lWYdBGz0n
         55FLIVMiXlIz4rEiUn0c0cLwuIREaAf195T1i2dTYgi8VYLHFfR+w0VyhPljfpPn81gB
         6M079dx4lAw4czuGhRsrafVtSMmO5lFNOKoMrn739vr6Qs89k16ReGOv/SzruFqDnNoR
         uf1pA1WpRJVsNxMBI71V/LBcktQA4Q4WVit6A00Sa8/6D1m1H3InXNLwKP8Xz+fYNc+F
         HpJcIv1zymXdVC+sTLyQ3RQrQ03x/IEP/yWzRW+J75aflhr9hO38PHqKWVYuCOekFezl
         c1ig==
X-Gm-Message-State: AOAM530KBASas5owigAI25gqZgM5FU7rVKfb7q7T0HDeZ4bzGoUh7e2Q
        IlcVbrAFoqRhWBK5BYXhrvJbwQ==
X-Google-Smtp-Source: ABdhPJy/tnF3pLUYaUV6v59n/IifAXvOM0FdLnANaTYmbxBvSUkPNx+kbpX4k12ivW7Bcz86ie9Uaw==
X-Received: by 2002:aa7:c845:: with SMTP id g5mr12775506edt.219.1621621040973;
        Fri, 21 May 2021 11:17:20 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id h9sm4503438edr.10.2021.05.21.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:17:20 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-tps65910: remove platform_set_drvdata() + cleanup probe
Date:   Fri, 21 May 2021 21:17:08 +0300
Message-Id: <20210521181708.11524-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-tps65910.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index 0c0b445c75c0..7fa8c841081f 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -165,16 +165,8 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	}
 
 skip_init:
-	ret = devm_gpiochip_add_data(&pdev->dev, &tps65910_gpio->gpio_chip,
-				     tps65910_gpio);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, tps65910_gpio);
-
-	return ret;
+	return devm_gpiochip_add_data(&pdev->dev, &tps65910_gpio->gpio_chip,
+				      tps65910_gpio);
 }
 
 static struct platform_driver tps65910_gpio_driver = {
-- 
2.31.1

