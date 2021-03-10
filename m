Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891B13338F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhCJJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhCJJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:38:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:38:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mm21so37272882ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwRDDrAnor9EGXGbr7Vkv7Yy1evevb3olkhg8PRlgj0=;
        b=B+2JDvg0dfhH0dLyhP9//otvC5a2WfixbsYJOkAbD2InTGEVvultkpyplIcKEeJEoi
         qzzO0b/IZ7rmE+sdEUEn5aYSpqJiwyVSSjLmSj1BaP7d7pTv4PAgUxMmOus7wwAIoNHl
         NymkBOezskzTQXyqHmuKRA3NnNoz2CwVOEo1BjS54Ww9KINu0AOZX/ZmMl1j8TA6FknY
         qZzwsmISw1u1IDmk7hTFdKLaysC4n3pyDH2Ao1rIKEoD957qBfbSkn3wz6SXmlJSw2e4
         T7q9ZQPRtltpgY1S2TMCiitypOCr9pZL1d6eM7Fkw6MOnDvdnSfkxKKBXywL/4fZ+kUt
         E9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwRDDrAnor9EGXGbr7Vkv7Yy1evevb3olkhg8PRlgj0=;
        b=n5auUD8Yazk1XbfSckR+vbM49pV6G465lEALxFtZy3L+432Z2YaOHMXU6tYgFXbI38
         hbsbBHvUDQtlXPFEkmNGqKodHW2t9tpWl/b/j1SNyuCnQ0/ToYjL+CsgzcLnnoPL0dwy
         CG9P7n7UczMLFvsaayAi0c4JyV5v7i1Z5b++xwCFRSEQ4owyPcacDyQKHS4cOBLzEzAD
         1FUv9r8AJZwzy8RsojKpdvc7btuKPf4V/omVLOBBWrFcZuecUmoQ1QbhNI0peuvXsDci
         7J7ETL8veVMDF6xtlEogmUkryC2EpygpHqYUZ1gEOyM4DHOK3UWZcvGb+hMFFplLMlOW
         /sjw==
X-Gm-Message-State: AOAM533l5ohzJ1H0tw5lwefqXUbuh1ctjHSUNY/5FADsekvL/l8HaYEN
        YSdLLL/rnnuhefOYfqH0pcmR73a+FSvy4cKV
X-Google-Smtp-Source: ABdhPJyfo1PZz/sYE//aKz7rSdXtEVrW5HzxMyU8yqUoJlNqozgfcAIigq3S9OV1Rh4JoVGBSJTfJg==
X-Received: by 2002:a17:906:9509:: with SMTP id u9mr1656201ejx.225.1615369096659;
        Wed, 10 Mar 2021 01:38:16 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r19sm5297397ejr.55.2021.03.10.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:38:16 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, manivannanece23@gmail.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: temperature: tmp007: use device-managed functions in probe
Date:   Wed, 10 Mar 2021 11:38:00 +0200
Message-Id: <20210310093800.45822-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the driver to use device-managed functions in the
probe function. The power-down call is handled now via a
devm_add_action_or_reset() hook, and then devm_iio_device_register() can be
used to register the IIO device.

The final aim here would be for IIO to export only the device-managed
functions of it's API. That's a long way to go and this a small step in
that direction.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/temperature/tmp007.c | 36 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index ad2b35c65548..b422371a4674 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -439,6 +439,13 @@ static bool tmp007_identify(struct i2c_client *client)
 	return (manf_id == TMP007_MANUFACTURER_MAGIC && dev_id == TMP007_DEVICE_MAGIC);
 }
 
+static void tmp007_powerdown_action_cb(void *priv)
+{
+	struct tmp007_data *data = priv;
+
+	tmp007_powerdown(data);
+}
+
 static int tmp007_probe(struct i2c_client *client,
 			const struct i2c_device_id *tmp007_id)
 {
@@ -489,6 +496,10 @@ static int tmp007_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&client->dev, tmp007_powerdown_action_cb, data);
+	if (ret)
+		return ret;
+
 	/*
 	 * Only the following flags can activate ALERT pin. Data conversion/validity flags
 	 * flags can still be polled for getting temperature data
@@ -502,7 +513,7 @@ static int tmp007_probe(struct i2c_client *client,
 
 	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
 	if (ret < 0)
-		goto error_powerdown;
+		return ret;
 
 	data->status_mask = ret;
 	data->status_mask |= (TMP007_STATUS_OHF | TMP007_STATUS_OLF
@@ -510,7 +521,7 @@ static int tmp007_probe(struct i2c_client *client,
 
 	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, data->status_mask);
 	if (ret < 0)
-		goto error_powerdown;
+		return ret;
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -519,27 +530,11 @@ static int tmp007_probe(struct i2c_client *client,
 				tmp007_id->name, indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "irq request error %d\n", -ret);
-			goto error_powerdown;
+			return ret;
 		}
 	}
 
-	return iio_device_register(indio_dev);
-
-error_powerdown:
-	tmp007_powerdown(data);
-
-	return ret;
-}
-
-static int tmp007_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct tmp007_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	tmp007_powerdown(data);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -582,7 +577,6 @@ static struct i2c_driver tmp007_driver = {
 		.pm	= &tmp007_pm_ops,
 	},
 	.probe		= tmp007_probe,
-	.remove		= tmp007_remove,
 	.id_table	= tmp007_id,
 };
 module_i2c_driver(tmp007_driver);
-- 
2.29.2

