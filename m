Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC87365E26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhDTRD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:03:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhDTRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:03:25 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtm0-0004dC-68
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:02:52 +0000
Received: by mail-ed1-f71.google.com with SMTP id w14-20020aa7da4e0000b02903834aeed684so11713419eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZHnNFNaMNa8a85SBpXammff3rvFDkP+H98gsBQ8d3o=;
        b=gFiGwLEj4SZAEL4m1X/kGKdOtHT4BmeXnpoiLfJ4y4HoNwkv82vpVLjVwNG8CqtZGV
         MBmswBT2b6Wh6yhSXMlbEC3ihojH6lLKx/MRTJEVR9j/KYmxZixliYNkIBwArP/V37d0
         NDjpaHmudbFLYUM+39N0lWr3S1gMuiyAgynfBew+ZAQCgmONndGUUodICQuZIMdY2LgE
         NXmJVwZig2SNFL2JhmDZdRO516yq4PXALofPbtJzFVe2Nc8FcPiuI02IVpGIHWNSSzeJ
         Ki2fRxNiHVK/LpzzDv5ShNQYcJO8pLxxn1A7fLOowQXn0SjsLFYRp11MPcqN2IJ0uQHQ
         SuqA==
X-Gm-Message-State: AOAM532crMmdvmtZaHcfn9DR43euRqup1/17xIFfvJONENWL9dI/mxXq
        gMClUXhtPEjL5hiEk2UiOW3+XIHA2tGwTHR1ovzkfIYYlbfo/oOjdkRFS/P8t7GgQ7S/rVZgh13
        gyBaCn01SdZitLSCg8p7MVRnARycRbxPsKxcHvsRIZQ==
X-Received: by 2002:a17:906:4913:: with SMTP id b19mr28867172ejq.439.1618938170533;
        Tue, 20 Apr 2021 10:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOLsxZKglCAv77mKXcTh7j9A7OdejF9kWYftWrwmpV/d4re5KZPtRxzK5D7Kz9pjhQCLFxOg==
X-Received: by 2002:a17:906:4913:: with SMTP id b19mr28867163ejq.439.1618938170410;
        Tue, 20 Apr 2021 10:02:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id s20sm16590714edu.93.2021.04.20.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:02:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 7/9] rtc: s5m: Remove reference to parent's device pdata
Date:   Tue, 20 Apr 2021 19:02:42 +0200
Message-Id: <20210420170244.13467-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
References: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
 <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S5M RTC driver does not use parent's device (sec-core PMIC driver)
platform data so there is no need to check for it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rtc/rtc-s5m.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 80b66f16db89..038269a6b08c 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -713,16 +713,10 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
 static int s5m_rtc_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *s5m87xx = dev_get_drvdata(pdev->dev.parent);
-	struct sec_platform_data *pdata = s5m87xx->pdata;
 	struct s5m_rtc_info *info;
 	const struct regmap_config *regmap_cfg;
 	int ret, alarm_irq;
 
-	if (!pdata) {
-		dev_err(pdev->dev.parent, "Platform data not supplied\n");
-		return -ENODEV;
-	}
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.25.1

