Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D873CC13F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhGQFAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhGQE7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:59:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFFC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso10049652pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLDUaTCh3VK5lI9Kvmqz2LtxGRfdlTFuw6ZvgFybPpU=;
        b=qXnMdlmNRiHXn4gEatb5R2QPYD7u68zHYAV2t0+R9+sqFlxeNlUJKIIJOZCbzfUqS1
         Uao6y0bjdBAJyQ17u19nr2Q/ZQUh6yGMYCFkZiE4l1PyrOHNOHPRNSxnjK7ikv1ocsoV
         jTjHfcpf1JBJbYeJFtQxH1ezS37Xz8XvfsRww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLDUaTCh3VK5lI9Kvmqz2LtxGRfdlTFuw6ZvgFybPpU=;
        b=YyMCrl9814cCujjWwf9C0RVPJO5r89yv9pkn69UIYPsir3uff0VVsW6nPpR71fqD95
         dZNHCm6bkdkfi52dKAs0axCV6jZ8PuQ/GUpx+4x9PzUToXgzxOVLNkBVXnElnEkIgwUH
         xFAM7tD56jBT8Z++OcpfzwbcKakSTqp8VaEexGzHPr26pggyAbwD39bjX49UzzhLpgqP
         i0iu+TlJCSwtkncwnA667leOAPm11Hhnba5f+5/bYJZ3mhkndyEuHtji6dx9WuMK3795
         oon1HofGBWmZREXUj4Yj7BkzhUKXIwNF8CvW6zhuOTCbF0QeiuEZ5zq4HObK1T/zhdKh
         6m3Q==
X-Gm-Message-State: AOAM533Wxr4XWJQjgJJ19KNc2x1HtnLrkCyFgkKUuVLv6V1MmJmW9Gzl
        OzVCa0szJ6ons1NTjP7rGSYdeg==
X-Google-Smtp-Source: ABdhPJxKYUOqP3DW/70zYd5fRMGwvv2i7eB31THLOGZFrdnFDAouv5BkHoNr7Q58CcKQKpTRtkZ0Pw==
X-Received: by 2002:a17:90b:2382:: with SMTP id mr2mr18779595pjb.169.1626497809011;
        Fri, 16 Jul 2021 21:56:49 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:56:48 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 03/10] gpio: msc313: Code clean ups
Date:   Sat, 17 Jul 2021 13:56:20 +0900
Message-Id: <20210717045627.1739959-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove the unneeded assignment of ret before returning it.
- Remove an unneeded blank line

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpio/gpio-msc313.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index da31a5ff7a2b..a894bafbd4c3 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -344,7 +344,6 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	struct irq_domain *parent_domain;
 	struct device_node *parent_node;
 	struct device *dev = &pdev->dev;
-	int ret;
 
 	match_data = of_device_get_match_data(dev);
 	if (!match_data)
@@ -399,8 +398,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	gpioirqchip->handler = handle_bad_irq;
 	gpioirqchip->default_type = IRQ_TYPE_NONE;
 
-	ret = devm_gpiochip_add_data(dev, gpiochip, gpio);
-	return ret;
+	return devm_gpiochip_add_data(dev, gpiochip, gpio);
 }
 
 static int msc313_gpio_remove(struct platform_device *pdev)
@@ -456,5 +454,4 @@ static struct platform_driver msc313_gpio_driver = {
 	.probe = msc313_gpio_probe,
 	.remove = msc313_gpio_remove,
 };
-
 builtin_platform_driver(msc313_gpio_driver);
-- 
2.32.0

