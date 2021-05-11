Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6237A0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEKHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhEKHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:19:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60BCC061761
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m12so28262463eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=IbeNYO/ZVaMjfhUYkNzfSaEsrZPxLeTnlbkNUcX0lACa54dq7fJLx5DhRZuDYRAG/l
         wyUHMxs0dgKAc2CguJdtGXVlRJOIa75mRm0ZDnaK75b04CqUFxdrSnswN792MLcxGXQF
         tMYH8pS7bsvMWRfXsemb3P9BTWSlzlKJGIftGn9ummdaPt9j/4KBF+R4NQHEujw6vslj
         k01OKfCvYbNlq5JQIs0P4lT/TbEOBbyDIZrt2rlGt61dVn9vNBZ13JQeRlqGBjjWNf7D
         rhJbQTmiO3zKvo/2WSCBPQqtfa/zcV9+HtEVB2hclkCNExW+CjPxhlQrDylaLKHY0lEs
         qZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=mokpw3HS1PzcCpS1h0VD9H/gm5qGzHu9CkJVetq9/5+3zyVnZPFTgGV4rZuncjtnmT
         sSk9kZTyukJgabjOe0psExNSfgRKWKCeJcf6lwk9r4pm7FHpGFnOFNWGeheA54CVYvkd
         N6rutAdH0NptDeCF1gsYFhXKSF2m/fDokxLE0CXYMmo0JpqOO7tg1JnPue3PdfqDtog4
         D6BZFLZloEHWsEbNeGYZCnz4HdHtWWh//AqHCyeG+SIh9hcAFbhIzkBg1gCSKUDWmQVJ
         qBKzwd91ezrI0SBTgDu8K9KUJpN9IuCkIDTTSJ8Zu8APm/Wz6J7FS0pWoAqZ+K9RRAkW
         T6Sw==
X-Gm-Message-State: AOAM533oUkDH3n4JGyG1KeUS54Lzf5t+mR8S48CNEZNImFkEAVGW2/tV
        GazQU4HpkAG1AVYjNXgKDcWzCQ==
X-Google-Smtp-Source: ABdhPJxO0MjKwg9BHybjx4Vbbd5UhUIy5BNrBduH+WLl+4BiyP4UT+GjfWBVbW9j8O2Uc5aZPAeI7A==
X-Received: by 2002:a17:906:c01a:: with SMTP id e26mr30240339ejz.300.1620717520426;
        Tue, 11 May 2021 00:18:40 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:40 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 05/12] iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
Date:   Tue, 11 May 2021 10:18:24 +0300
Message-Id: <20210511071831.576145-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a version of ad_sd_setup_buffer_and_trigger() with all underlying
functions (that are used) being replaced with their device-managed
variants.

One thing to take care here is with {devm_}iio_trigger_alloc(), where both
functions take a parent-device object as the first parameter.

To make sure nothing quirky is happening, the devm_ad_sd_probe_trigger()
function is checking that the provided 'dev' reference is the same as the
one stored on the 'struct ad_sigma_delta' driver data.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 60 ++++++++++++++++++++++++++
 include/linux/iio/adc/ad_sigma_delta.h |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 69b979331ccd..d5801a47be07 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -513,6 +513,46 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (dev != &sigma_delta->spi->dev) {
+		dev_err(dev, "Trigger parent should be '%s', got '%s'\n",
+			dev_name(dev), dev_name(&sigma_delta->spi->dev));
+		return -EFAULT;
+	}
+
+	sigma_delta->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						   iio_device_id(indio_dev));
+	if (sigma_delta->trig == NULL)
+		return -ENOMEM;
+
+	sigma_delta->trig->ops = &ad_sd_trigger_ops;
+	init_completion(&sigma_delta->completion);
+
+	sigma_delta->irq_dis = true;
+	ret = devm_request_irq(dev, sigma_delta->spi->irq,
+			       ad_sd_data_rdy_trig_poll,
+			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
+			       indio_dev->name,
+			       sigma_delta);
+	if (ret)
+		return ret;
+
+	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
+
+	ret = devm_iio_trigger_register(dev, sigma_delta->trig);
+	if (ret)
+		return ret;
+
+	/* select default trigger */
+	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
+
+	return 0;
+}
+
 static void ad_sd_remove_trigger(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -556,6 +596,26 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
 
+/**
+ * devm_ad_sd_setup_buffer_and_trigger() - Device-managed buffer & trigger setup
+ * @dev: Device object to which to bind the life-time of the resources attached
+ * @indio_dev: The IIO device
+ */
+int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad_sd_trigger_handler,
+					      &ad_sd_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_ad_sd_probe_trigger(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(devm_ad_sd_setup_buffer_and_trigger);
+
 /**
  * ad_sd_init() - Initializes a ad_sigma_delta struct
  * @sigma_delta: The ad_sigma_delta device
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7199280d89ca..be81ad39fb7a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -26,6 +26,7 @@ struct ad_sd_calib_data {
 };
 
 struct ad_sigma_delta;
+struct device;
 struct iio_dev;
 
 /**
@@ -135,6 +136,8 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 int ad_sd_setup_buffer_and_trigger(struct iio_dev *indio_dev);
 void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
 
+int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev);
+
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
 #endif
-- 
2.31.1

