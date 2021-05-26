Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FC391803
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhEZMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:53:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56930 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhEZMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:49:27 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llsx1-00011P-J8
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:47:55 +0000
Received: by mail-vs1-f69.google.com with SMTP id n26-20020a67d61a0000b029023651d629a4so197275vsj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WStmZXvsQ5h7CfTVIuVnQjnA8EJCCjMgEO+OrcP4v9c=;
        b=Y2Aw3f2rfgagh1BTu1O5gHFiSvOeoX3JDtCToVFWVZiJOlXSihJnHA469w/OcOpiax
         Spj/lb3+XiKbWXT7rRuoWSNlJTgZ54wJ3t7af2xSOyfxpNPMhrmJi2SoNUxmXx2EySbZ
         W0FZDKmBpWvXOQAF4Yu/zeRZpxrH/lykkZkwVmB4NNoQEdx7XZmEe3L3Zi+TN4oLgoGd
         m/IAnr1MDynQAC6o/TkYeaByID8FcKTAvR6TFbkaUkvg/V08W/qF7vki/MFXrxHgQ5IE
         qY/VDG4gcj9V3v/FvE0z+xsiBf8t/sogCT1ZSay3tRsuGbw/soP7MhnW8swy8Buw7d92
         Rz8w==
X-Gm-Message-State: AOAM5317iJXJsELhuTLD1VykHEfHtaQVYBTWUatobuHjas/2ujR8kQo0
        p+m+w3oJ0beV/L/YorkXXPsk44V9lnWigFh9tpezFrqNszvUMiLabaLkPMB+F/njqYwfHpPoDQ8
        1yr492ih8dq/zS1Eu/SnPcZeSXkz4nmEiICXqN/EH8w==
X-Received: by 2002:a67:db03:: with SMTP id z3mr26669033vsj.29.1622033270663;
        Wed, 26 May 2021 05:47:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmmhpFUj6CK7bZ7dbqf7I816J0q4PtRcTDGOcM5jZDaT5rNIXCiaQhLvUio7RFOl1bks20HQ==
X-Received: by 2002:a67:db03:: with SMTP id z3mr26668691vsj.29.1622033263826;
        Wed, 26 May 2021 05:47:43 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c126sm875817vkh.47.2021.05.26.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:47:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RESEND PATCH v2 08/13] mfd: sec: Drop support for board files and require devicetree
Date:   Wed, 26 May 2021 08:47:06 -0400
Message-Id: <20210526124711.33223-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
References: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PMIC drivers since long time are used only on devicetree
platforms (Samsung Exynos) and there are no users with board files.

Drop the support for board files entirely and depend on OF for matching.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/Kconfig    |  1 +
 drivers/mfd/sec-core.c | 59 +++++++++++-------------------------------
 2 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5232bc0db8c0..219c09e15452 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1145,6 +1145,7 @@ config MFD_RN5T618
 config MFD_SEC_CORE
 	tristate "Samsung Electronics PMIC Series Support"
 	depends on I2C=y
+	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 15dd4c579937..c61c1fc62165 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -94,7 +94,6 @@ static const struct mfd_cell s2mpu02_devs[] = {
 	{ .name = "s2mpu02-regulator", },
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id sec_dt_match[] = {
 	{
 		.compatible = "samsung,s5m8767-pmic",
@@ -122,7 +121,6 @@ static const struct of_device_id sec_dt_match[] = {
 	},
 };
 MODULE_DEVICE_TABLE(of, sec_dt_match);
-#endif
 
 static bool s2mpa01_volatile(struct device *dev, unsigned int reg)
 {
@@ -282,7 +280,6 @@ static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
 	}
 }
 
-#ifdef CONFIG_OF
 /*
  * Only the common platform data elements for s5m8767 are parsed here from the
  * device tree. Other sub-modules of s5m8767 such as pmic, rtc , charger and
@@ -313,28 +310,12 @@ sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 						"samsung,s2mps11-wrstbi-ground");
 	return pd;
 }
-#else
-static struct sec_platform_data *
-sec_pmic_i2c_parse_dt_pdata(struct device *dev)
-{
-	return NULL;
-}
-#endif
-
-static inline unsigned long sec_i2c_get_driver_data(struct i2c_client *i2c,
-						const struct i2c_device_id *id)
-{
-	if (i2c->dev.of_node)
-		return (unsigned long)of_device_get_match_data(&i2c->dev);
-
-	return id->driver_data;
-}
 
 static int sec_pmic_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct sec_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	const struct regmap_config *regmap;
+	struct sec_platform_data *pdata;
 	const struct mfd_cell *sec_devs;
 	struct sec_pmic_dev *sec_pmic;
 	unsigned long device_type;
@@ -349,22 +330,19 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 	sec_pmic->dev = &i2c->dev;
 	sec_pmic->i2c = i2c;
 	sec_pmic->irq = i2c->irq;
-	device_type = sec_i2c_get_driver_data(i2c, id);
-
-	if (sec_pmic->dev->of_node) {
-		pdata = sec_pmic_i2c_parse_dt_pdata(sec_pmic->dev);
-		if (IS_ERR(pdata)) {
-			ret = PTR_ERR(pdata);
-			return ret;
-		}
-		pdata->device_type = device_type;
-	}
-	if (pdata) {
-		sec_pmic->device_type = pdata->device_type;
-		sec_pmic->irq_base = pdata->irq_base;
-		sec_pmic->wakeup = pdata->wakeup;
-		sec_pmic->pdata = pdata;
+	device_type = (unsigned long)of_device_get_match_data(sec_pmic->dev);
+
+	pdata = sec_pmic_i2c_parse_dt_pdata(sec_pmic->dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		return ret;
 	}
+	pdata->device_type = device_type;
+
+	sec_pmic->device_type = pdata->device_type;
+	sec_pmic->irq_base = pdata->irq_base;
+	sec_pmic->wakeup = pdata->wakeup;
+	sec_pmic->pdata = pdata;
 
 	switch (sec_pmic->device_type) {
 	case S2MPA01:
@@ -404,7 +382,7 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (pdata && pdata->cfg_pmic_irq)
+	if (pdata->cfg_pmic_irq)
 		pdata->cfg_pmic_irq();
 
 	sec_irq_init(sec_pmic);
@@ -529,21 +507,14 @@ static int sec_pmic_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sec_pmic_pm_ops, sec_pmic_suspend, sec_pmic_resume);
 
-static const struct i2c_device_id sec_pmic_id[] = {
-	{ "sec_pmic", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, sec_pmic_id);
-
 static struct i2c_driver sec_pmic_driver = {
 	.driver = {
 		   .name = "sec_pmic",
 		   .pm = &sec_pmic_pm_ops,
-		   .of_match_table = of_match_ptr(sec_dt_match),
+		   .of_match_table = sec_dt_match,
 	},
 	.probe = sec_pmic_probe,
 	.shutdown = sec_pmic_shutdown,
-	.id_table = sec_pmic_id,
 };
 module_i2c_driver(sec_pmic_driver);
 
-- 
2.27.0

