Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7067B391801
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhEZMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:53:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56957 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhEZMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:49:35 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llsx9-00013x-GK
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:48:03 +0000
Received: by mail-ua1-f69.google.com with SMTP id 49-20020a9f21b40000b029020ed81a67feso698526uac.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ff7mSFDiPKWIRPLH13ytxRgyCEPx2Ey1Zs19kp0hAg=;
        b=Mnl1z1b7If110afxiMyRIrRSG5gboFk1dwzLPOi0ShZFWhWTrgEamZIWfXqdQSACCv
         tXY4lPqroK6PG7M7lW+Qqa16JsVYmdnZwHPJjJGfZHkZrY0aFCRoKwamAg4tXB9D76Y3
         2bVbOmCE7ahoAoMUYKRc3NMRBQAf57omlGJPXLGyWZ22Wfz1bCGOTSe15vGYAxPX8Y+f
         cZ1x2uQBFex5FK+0Qen1tnLaM8MJsqUrEFWslzI/hbFRu2grvy5HxPVndiOAZxlrxOVQ
         JRa2ijIaMQ3uZIrWg7sGH/VNRUuJV1rBGzMrrkUUmN3uYPaTHZeucTa7GETqFTRYQlVt
         0Okw==
X-Gm-Message-State: AOAM532G6nn9cUowC92Gue8Srm8Ivlix2FU09YX0tzDhQzacT4z37WdJ
        AT/CnIdyfH08DSPC9Q/H5WZjB6CLWLG2BdwpdagdNWMo78eAlYgoUSYUy86o1IAYaX1i3XrXMoQ
        /sqrtPnueeAWLxloP8Q7bdIVbUvYK7k+H19+ITvE+xQ==
X-Received: by 2002:a67:efda:: with SMTP id s26mr30788855vsp.8.1622033282592;
        Wed, 26 May 2021 05:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvzp8HuLrUUCnUNiZlA3le4xYeTGQur5HspC6co1WVkd+XDr3puQBLsVJFCIEz3BujO0hIwg==
X-Received: by 2002:a67:efda:: with SMTP id s26mr30788839vsp.8.1622033282400;
        Wed, 26 May 2021 05:48:02 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c126sm875817vkh.47.2021.05.26.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:47:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [RESEND PATCH v2 12/13] mfd: sec: Enable wakeup from suspend via devicetree property
Date:   Wed, 26 May 2021 08:47:10 -0400
Message-Id: <20210526124711.33223-13-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
References: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set device wakeup capability from devicetree property (done by drivers
core), instead of always setting it to 0 (because value in platform data
is not assigned).

This should not have visible effect on actual resuming from suspend
because the child device - S5M RTC driver - is responsible for waking
up and sets device wakeup unconditionally.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/sec-core.c           | 8 --------
 include/linux/mfd/samsung/core.h | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index a9d4fbc51997..1fb29c45f5cf 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -298,12 +298,6 @@ sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * ToDo: the 'wakeup' member in the platform data is more of a linux
-	 * specfic information. Hence, there is no binding for that yet and
-	 * not parsed here.
-	 */
-
 	pd->manual_poweroff = of_property_read_bool(dev->of_node,
 						"samsung,s2mps11-acokb-ground");
 	pd->disable_wrstbi = of_property_read_bool(dev->of_node,
@@ -337,7 +331,6 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 	}
 
 	sec_pmic->device_type = (unsigned long)of_device_get_match_data(sec_pmic->dev);
-	sec_pmic->wakeup = pdata->wakeup;
 	sec_pmic->pdata = pdata;
 
 	switch (sec_pmic->device_type) {
@@ -429,7 +422,6 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	device_init_wakeup(sec_pmic->dev, sec_pmic->wakeup);
 	sec_pmic_configure(sec_pmic);
 	sec_pmic_dump_rev(sec_pmic);
 
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 9864f13b7814..b0d049a56d16 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -69,8 +69,6 @@ struct sec_pmic_dev {
 	unsigned long device_type;
 	int irq;
 	struct regmap_irq_chip_data *irq_data;
-
-	bool wakeup;
 };
 
 int sec_irq_init(struct sec_pmic_dev *sec_pmic);
@@ -82,7 +80,6 @@ struct sec_platform_data {
 	struct sec_opmode_data		*opmode;
 	int				num_regulators;
 
-	bool				wakeup;
 	bool				buck_voltage_lock;
 
 	int				buck_gpios[3];
-- 
2.27.0

