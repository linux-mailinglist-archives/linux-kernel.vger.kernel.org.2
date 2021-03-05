Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148D432E628
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCEKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCEKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:20:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E06C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:20:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a24so1161549plm.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUACLrL4E5J+zKlEM3mMmLgSh+SjeWlUxfMZEcaS8n0=;
        b=Cu64HLf0HIdq0y7140t5Tlz3UVHd6eyis3sDus6y32di/8IKUdlokhzh9DfUSEVjpP
         SUSElAYITZcFx7+PxUEUS3+h4mipkfxyHKdWIkgJj3v3hGQoo5sTBDrty/vvikqV7rc5
         Pb2TLpAQodcHd7GwqYX/+Y6Gbuni3G9nxKCBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUACLrL4E5J+zKlEM3mMmLgSh+SjeWlUxfMZEcaS8n0=;
        b=IWxLcbVCGwQlfso+KsAiiHldq6jmc0p1V0LUyqbiH1Spjt5RQLzSH29FJBd5WxSi1Z
         l6bcaIe4jn3nNcpBJeOozN2XlHvYkKCOHlaMr7xREBbtvP8m975QWOL8ATx7mhvUctd6
         MmVBOChq73x1ZHyZK6imjLwXE7OjIEh5uWSua8y5OXRl1aKwjo5K/UN7eGy/pjtX58vI
         OMjPuC8mXRuec2D3K843EEj81qvTPw9oqZVn1rtJG17J3yJ4zlb0HuqE20nls9YUJX1Z
         vWPt3V62INRsLGKFeuWQAierR666CeuB+bm6sxLUDh0yX2569A+M8PitW90ad43aNjZz
         NRjQ==
X-Gm-Message-State: AOAM530qlIE37oxkLfAxYLjF00TDd3WCtyBG06ajGNEEGPO+BRO28ah6
        cChDQYOGDqfXg/Pq931KOJcU2g==
X-Google-Smtp-Source: ABdhPJyxjguts9N9hJbIy+WBqBM4VkGt4dYdC45mzBbXhIJhRr6WiT2Rig05kbCicwVUCFTc/FOD0A==
X-Received: by 2002:a17:902:8ec1:b029:dc:8ae1:7a22 with SMTP id x1-20020a1709028ec1b02900dc8ae17a22mr8029087plo.6.1614939608896;
        Fri, 05 Mar 2021 02:20:08 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5da1:da1b:5bcf:2d46])
        by smtp.gmail.com with ESMTPSA id c12sm2402672pfp.17.2021.03.05.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 02:20:08 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] i2c: core: support bus regulator controlling in adapter
Date:   Fri,  5 Mar 2021 18:20:04 +0800
Message-Id: <20210305102004.191209-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bibby Hsieh <bibby.hsieh@mediatek.com>

Although in the most platforms, the bus power of i2c
are alway on, some platforms disable the i2c bus power
in order to meet low power request.

We get and enable bulk regulator in i2c adapter device.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
This patch is squashed from following patch and tested on mt8183 device
which has eeprom at24 client under i2c, so the fix in [2] is also
verified.
[1] https://patchwork.ozlabs.org/project/linux-i2c/cover/20200519072729.7268-1-bibby.hsieh@mediatek.com/
[2] https://patchwork.ozlabs.org/project/linux-i2c/patch/20200522101327.13456-1-m.szyprowski@samsung.com/
---
 drivers/i2c/i2c-core-base.c | 93 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 63ebf722a424..667f4a4de7cc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -439,12 +439,14 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
+	struct i2c_adapter	*adap;
 	struct i2c_driver	*driver;
 	int status;
 
 	if (!client)
 		return 0;
 
+	adap = client->adapter;
 	client->irq = client->init_irq;
 
 	if (!client->irq) {
@@ -510,6 +512,12 @@ static int i2c_device_probe(struct device *dev)
 
 	dev_dbg(dev, "probe\n");
 
+	status = regulator_enable(adap->bus_regulator);
+	if (status < 0) {
+		dev_err(&adap->dev, "Failed to enable power regulator\n");
+		goto err_clear_wakeup_irq;
+	}
+
 	status = of_clk_set_defaults(dev->of_node, false);
 	if (status < 0)
 		goto err_clear_wakeup_irq;
@@ -550,8 +558,10 @@ static int i2c_device_probe(struct device *dev)
 static int i2c_device_remove(struct device *dev)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
+	struct i2c_adapter      *adap;
 	struct i2c_driver	*driver;
 
+	adap = client->adapter;
 	driver = to_i2c_driver(dev->driver);
 	if (driver->remove) {
 		int status;
@@ -564,6 +574,8 @@ static int i2c_device_remove(struct device *dev)
 	}
 
 	dev_pm_domain_detach(&client->dev, true);
+	if (!pm_runtime_status_suspended(&client->dev))
+		regulator_disable(adap->bus_regulator);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -576,6 +588,80 @@ static int i2c_device_remove(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int i2c_resume_early(struct device *dev)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	int err;
+
+	if (!client)
+		return 0;
+
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		err = regulator_enable(client->adapter->bus_regulator);
+		if (err)
+			return err;
+	}
+
+	return pm_generic_resume_early(&client->dev);
+}
+
+static int i2c_suspend_late(struct device *dev)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	int err;
+
+	if (!client)
+		return 0;
+
+	err = pm_generic_suspend_late(&client->dev);
+	if (err)
+		return err;
+
+	if (!pm_runtime_status_suspended(&client->dev))
+		return regulator_disable(client->adapter->bus_regulator);
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int i2c_runtime_resume(struct device *dev)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	int err;
+
+	if (!client)
+		return 0;
+
+	err = regulator_enable(client->adapter->bus_regulator);
+	if (err)
+		return err;
+
+	return pm_generic_runtime_resume(&client->dev);
+}
+
+static int i2c_runtime_suspend(struct device *dev)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	int err;
+
+	if (!client)
+		return 0;
+
+	err = pm_generic_runtime_suspend(&client->dev);
+	if (err)
+		return err;
+
+	return regulator_disable(client->adapter->bus_regulator);
+}
+#endif
+
+static const struct dev_pm_ops i2c_device_pm = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late, i2c_resume_early)
+	SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume, NULL)
+};
+
 static void i2c_device_shutdown(struct device *dev)
 {
 	struct i2c_client *client = i2c_verify_client(dev);
@@ -633,6 +719,7 @@ struct bus_type i2c_bus_type = {
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
 	.shutdown	= i2c_device_shutdown,
+	.pm		= &i2c_device_pm,
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
@@ -1446,6 +1533,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
+	adap->bus_regulator = devm_regulator_get(&adap->dev, "bus");
+	if (IS_ERR(adap->bus_regulator)) {
+		res = PTR_ERR(adap->bus_regulator);
+		goto out_reg;
+	}
+
 	pm_runtime_no_callbacks(&adap->dev);
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 56622658b215..ec87758d9f40 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -15,6 +15,7 @@
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include <linux/rtmutex.h>
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
@@ -721,6 +722,7 @@ struct i2c_adapter {
 	const struct i2c_adapter_quirks *quirks;
 
 	struct irq_domain *host_notify_domain;
+	struct regulator *bus_regulator;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
-- 
2.30.1.766.gb4fecdf3b7-goog

