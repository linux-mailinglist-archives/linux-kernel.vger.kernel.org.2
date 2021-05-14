Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5038061E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhENJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhENJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:24:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:23:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t4so43831596ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmlUFVkQ6uD6pUb8XfWfoeJo9HT3302ShZH0nB1le0I=;
        b=KmgSKURBJx/Vc2rhXTYKGXTtIterSj4KTcg1FcgtQ5x984hBMLS2XqBtX3s9u4Eegh
         qfjjT0NcE+L3r8/e/b4eCZX+uFQS16+cMdJLO4n8IL6XJHVDk1OrZWHxA2CVz4cegpPj
         JUHjecTd0VKxF4UIdPssGWpvs3TqIz6i06s+NWUHEUPycSw7Lacay3LU4lZ3700xZIKB
         tndi7UVe4z/cSgC9dzGCKAtnPV8ibgDeJfFO44Cx7+GUb37Qa1yUIRQll9UNtl7hMDMl
         9bIZ6t1eegwdWnCfjwGXyNuDtV1O30OGtJWNOb911vNkogq4/5HXv/ZIG9xrOgKD1dBD
         GnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmlUFVkQ6uD6pUb8XfWfoeJo9HT3302ShZH0nB1le0I=;
        b=EUCJTprByyA50agtNF9NrcvVn3QoBbmCf72ELqy8UAcn2y+dVIhMTMIN8H8BQf2adB
         pO7xqKnp739JD94/nB8sZucBsc0kjwe5rtvP2sgz3Vs4R077OqnY4ZmCbjLJTiEsgfjD
         +0cRaNSTy38KbWbL3POOFPyKfYDNZfGzcFdBihDnjGS3EmWwH36bXM4zHS/Mi03Y3+P2
         D+B1m20HTv7lQAtALqf1ByBLmfSAz/p/kjdt0R03MjYDYGxI9G0xKUQeWayg6c8W7sj+
         2p7VgTP/mJ01cEuY/6m6uXETquL3BDhnt//AHv5Q+4WdZP2LJ3ffeim6UBVHRtOi04br
         VhkQ==
X-Gm-Message-State: AOAM531QPDUkE6PLHsMeeUgpnLnRlLk+oKm63ts6XGzglvqYaBhJmG65
        ZAX4hL9NnwxS/e5QAS7eP165fw==
X-Google-Smtp-Source: ABdhPJxm204+NKwNwHBbo83HCeUN5nr7NJj9e+yftkEfM2nkUwYN8vMR34iiNYtaUeYjDQ6HpHgAPA==
X-Received: by 2002:a17:906:8299:: with SMTP id h25mr3619511ejx.81.1620984216327;
        Fri, 14 May 2021 02:23:36 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c3sm4264226edn.16.2021.05.14.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:23:36 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        support.opensource@diasemi.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-da9055: remove platform_set_drvdata() + cleanup probe
Date:   Fri, 14 May 2021 12:23:32 +0300
Message-Id: <20210514092332.19966-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-da9055.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-da9055.c b/drivers/gpio/gpio-da9055.c
index 6ad0c37b862e..49446a030f10 100644
--- a/drivers/gpio/gpio-da9055.c
+++ b/drivers/gpio/gpio-da9055.c
@@ -133,7 +133,6 @@ static int da9055_gpio_probe(struct platform_device *pdev)
 {
 	struct da9055_gpio *gpio;
 	struct da9055_pdata *pdata;
-	int ret;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
@@ -146,15 +145,7 @@ static int da9055_gpio_probe(struct platform_device *pdev)
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
 
 static struct platform_driver da9055_gpio_driver = {
-- 
2.31.1

