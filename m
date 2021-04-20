Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81094365E16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhDTRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:02:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50088 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhDTRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:02:07 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtkk-0004UI-Ig
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:01:34 +0000
Received: by mail-ed1-f70.google.com with SMTP id n18-20020a0564020612b02903853320059eso4439197edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HCzipZq3msLcuy2WkjGbMNJtslSk5WuayCRwwGv1I8=;
        b=GgxYsTItaeMj3CsTy4Z0L7Fd71CvV4ikUlVylMA/44DjJ5/VgX9dxH4k0hbE+/nArA
         wdB3srQqasKuA9i5Cb9mV8MYikC2UtL3khpybWu/zioP8+QrJ8zfUj++U5LGIYg+T4Pg
         d8a1Sfva78dFRv7IYdQqXCR9Mo4B8FGQTbVuG+rCvN/mu6tFHwWlIYMt3qUHjQf/PatR
         KesqEor2JU+HaT2ARATpu5dmB5Y29ub7D9mO/yTfW1Wi/2hAhph2vngefcDqc+bkz1dr
         m+GpYHSDOFVL5/ecRs15yV69PLupEvlA5pkzZkDmYuoLRrHH2KiOJyEBuFyZ7iUOBzUI
         6NNA==
X-Gm-Message-State: AOAM532dFfW1Gx6YagkNxuJjo7z5jHY+HB9mQMRYNgIPQhfcTvF9JpJU
        KC6tbs3X/38KCYt5nrc3o08xZ4udHHnl2LGxrSxDRv//Cw53VIo8p+jlkY3xhjGQpoCVuUCfnMx
        4IQwNlC/oXbUYHHTotEt0a98WMyOxlwNVxSpb86yO3A==
X-Received: by 2002:a05:6402:485:: with SMTP id k5mr33466130edv.211.1618938094310;
        Tue, 20 Apr 2021 10:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxELCUSPyZrAOwt3tM3D+dUCVIuCF50hufvL6zlHUtYRnZrR2c+i038ZRqkVsJ8Am5+aEE28g==
X-Received: by 2002:a05:6402:485:: with SMTP id k5mr33466108edv.211.1618938094155;
        Tue, 20 Apr 2021 10:01:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id x7sm16334441eds.67.2021.04.20.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:01:33 -0700 (PDT)
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
Subject: [PATCH 3/9] mfd: sec: Remove unused device_type in platform data
Date:   Tue, 20 Apr 2021 19:01:12 +0200
Message-Id: <20210420170118.12788-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
References: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'device_type' field of platform data structure is not used and can
be safely dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/sec-core.c           | 5 +----
 include/linux/mfd/samsung/core.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 653d02b98d53..4c4db3171ce6 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -318,7 +318,6 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 	struct sec_platform_data *pdata;
 	const struct mfd_cell *sec_devs;
 	struct sec_pmic_dev *sec_pmic;
-	unsigned long device_type;
 	int ret, num_sec_devs;
 
 	sec_pmic = devm_kzalloc(&i2c->dev, sizeof(struct sec_pmic_dev),
@@ -330,16 +329,14 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 	sec_pmic->dev = &i2c->dev;
 	sec_pmic->i2c = i2c;
 	sec_pmic->irq = i2c->irq;
-	device_type = (unsigned long)of_device_get_match_data(sec_pmic->dev);
 
 	pdata = sec_pmic_i2c_parse_dt_pdata(sec_pmic->dev);
 	if (IS_ERR(pdata)) {
 		ret = PTR_ERR(pdata);
 		return ret;
 	}
-	pdata->device_type = device_type;
 
-	sec_pmic->device_type = pdata->device_type;
+	sec_pmic->device_type = (unsigned long)of_device_get_match_data(sec_pmic->dev);
 	sec_pmic->irq_base = pdata->irq_base;
 	sec_pmic->wakeup = pdata->wakeup;
 	sec_pmic->pdata = pdata;
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 68afc2b97a41..bfde1b7c6303 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -81,7 +81,6 @@ int sec_irq_resume(struct sec_pmic_dev *sec_pmic);
 struct sec_platform_data {
 	struct sec_regulator_data	*regulators;
 	struct sec_opmode_data		*opmode;
-	int				device_type;
 	int				num_regulators;
 
 	int				irq_base;
-- 
2.25.1

