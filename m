Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E443816B5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhEOIAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhEOIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:00:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3314C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:59:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l7so1105297edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8BjOD14/zfrRT9J2IBjHxA1EstqGY6nrbX9XG/Uqgw=;
        b=Q/ehuhlO06rEtD0RVIMgwXJe67yhu6Fz46cpD/Ye6XiyQnAV6R+srVKCqlVhfPM3jP
         45xUAQnK0YJGk/25MIGqW4qNEmAUIkgK/v6dGejdo2lCiaCfxUUD1dRFi4LgFBmadDwv
         G4vYwJDu8opTGhesnOItmD82eRQTy8CKQq6/gDHr7qgV/45DlR4kl07n/gcLGyyoQgE/
         d9NlkuBtPJHDnzxal8JtfQJ+drCK/MdFQeZtWh3s6bDSccfu/x9YZW9Te3myFn/TZu12
         RihZo7CpZnDgtFF8l0bwz8ohCkMqS8f59cxOfgGe3LJp90WYtcKf83GuF6woGTYm9WhJ
         p6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8BjOD14/zfrRT9J2IBjHxA1EstqGY6nrbX9XG/Uqgw=;
        b=iQ+n7Zx7PxH6isrgyo5+nVsyjbt/yglZnc4/kgReiURpR11pqmh9zxBl/p+cWS5v9G
         kcQuYQvG49+srsopWBTN4KOsjsVrACRplyDBS0SOmOCNOnpKyZ9zQvIKYmQvSEw8CbsZ
         idnu1Kz3P8HdEEfAKJBrzwlFjC4Ka3LHfFKF8QO9r23c8k+2uoqukTnX7NwLLkBTjADt
         wjB8+w+pQpTMrn4AuM3aSxRtCNoOlI/XkgOWK0MNN/oNy5Oojqx2OzsCTDwZczvkGj9m
         Ui/iC+6sF0M5VtXxOGzGIYLfTejAFWHXGQQ839wsP6fY0Tc7u7zxwnsP0IWmEHtrI2mw
         j6MA==
X-Gm-Message-State: AOAM5310zD4TNppbdQKoNAi/fO42iRNZGAkNr8QvjQIr+PtwmqqijBgt
        cpZxV1GmM0IycWCSqySp3FvnBw==
X-Google-Smtp-Source: ABdhPJzEMypq/3EyajT0dRbWrPY8bLNymglDBOtSpgmLaFZdgFURQuip3b5LhNIDHb7dwKy0Mj8qDg==
X-Received: by 2002:a05:6402:204b:: with SMTP id bc11mr60780971edb.40.1621065563457;
        Sat, 15 May 2021 00:59:23 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id ch30sm6185520edb.92.2021.05.15.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 00:59:23 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/2] gpio: gpio-tegra186: remove empty remove hook
Date:   Sat, 15 May 2021 10:59:04 +0300
Message-Id: <20210515075905.12150-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra186_gpio_remove hook simply does a return 0.
Not defining it yields pretty much the same result.
So, this can be removed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-tegra186.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 1bd9e44df718..10d3597e9ac2 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -750,11 +750,6 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra186_gpio_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 #define TEGRA186_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
 	[TEGRA186_MAIN_GPIO_PORT_##_name] = {			\
 		.name = #_name,					\
@@ -924,7 +919,6 @@ static struct platform_driver tegra186_gpio_driver = {
 		.of_match_table = tegra186_gpio_of_match,
 	},
 	.probe = tegra186_gpio_probe,
-	.remove = tegra186_gpio_remove,
 };
 module_platform_driver(tegra186_gpio_driver);
 
-- 
2.31.1

