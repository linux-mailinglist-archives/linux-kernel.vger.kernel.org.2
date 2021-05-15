Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5B3816B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhEOIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhEOIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:00:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0DC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:59:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so1898548ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruDxV1+JrGkaktFClfUuq6154xx3fQbfsw7mksEIy9Y=;
        b=JrVcVvCWfvm8b5KZexbt5w3BqB/YLkpXSvMsA3E9+gGxzlIgQ1VVLGdXArS3k1mWxb
         sZ/OPRv1Oliw2pxndFLmhxTnJpGWD80PtZVZSOZ43mPkxyVJf+9RndhvFv5dmlTNUY+V
         YV/Xnu9I94ySl4jX8NI9ZUi3mBdBPsJKq5r0ZqTjCE/wIPQ+JUdXBgeoQpDu8Cgjyz7/
         brEPijUIN9pDhZppJTGtqj/THjZ+PhrbbDmEG1R2gJGx6TkX7LYHPWqQ6sSQczIw2O87
         J3XKibRwPfLy4Reh9a7IJP9tkGHet0Rxsh9VUec6rse5THIlUJqn3+TvTIukZS7OAbDR
         acPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruDxV1+JrGkaktFClfUuq6154xx3fQbfsw7mksEIy9Y=;
        b=GBIHxQhH++m/DROWoikeRkCnKj2QoNxogFJ2kE4FKzMWR5dqp1VjilF1uoLz4y53mf
         TS2htSyYSozzhdXUyCzCMaZNHJjhAPH2BwxhbW2tqbmueahzQ0Jip53b+G43Os+FGJ38
         glKzkGcNByfmbWIdf+ablV6I19p1wJHVJJfZIneEYdh0AQoCwmlWc+hjoLh0S+SR09s/
         wJ3rojnFxw6N42PD4s/0JeeprDGuWyXXojGf2A0x5mQ7/Z/77lxKljQN3q4RUpM/29mD
         BClkrC0l8EaOsj9FsrTW9IuM4X3zg69f+5w0M854sQZh52DN0XA1J5ToknUrGxPkDf5m
         JlCg==
X-Gm-Message-State: AOAM530TH8f/y4O8E+p2S2bpSFuF/OK1RyCGtBm6PfwUbO21N1lFU4dq
        IUxRPgqgQwif+RoOCFKcea3m5Q==
X-Google-Smtp-Source: ABdhPJz+mAdIayNn9GvTEbcAjrn2FCebQe6IE68YmK3rdXeyYhUFWqskChd7cVtIL1EL5M1agqzMjQ==
X-Received: by 2002:a17:906:a403:: with SMTP id l3mr53422894ejz.251.1621065564449;
        Sat, 15 May 2021 00:59:24 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id ch30sm6185520edb.92.2021.05.15.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:59:24 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/2] gpio: gpio-tegra186: remove platform_set_drvdata() + cleanup probe
Date:   Sat, 15 May 2021 10:59:05 +0300
Message-Id: <20210515075905.12150-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515075905.12150-1-aardelean@deviqon.com>
References: <20210515075905.12150-1-aardelean@deviqon.com>
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
 drivers/gpio/gpio-tegra186.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 10d3597e9ac2..f54ae9d4254a 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -741,13 +741,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 		offset += port->pins;
 	}
 
-	platform_set_drvdata(pdev, gpio);
-
-	err = devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &gpio->gpio, gpio);
 }
 
 #define TEGRA186_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.31.1

