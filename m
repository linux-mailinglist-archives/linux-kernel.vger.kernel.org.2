Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEBE37F78B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhEMMKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhEMMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39374C061763
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g14so30722518edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=rKoxXYq0VLLpeVboxmYLNUUdRpi5VllThnVWF/a1Q2mUx5p/zY0biNpXv4o8RravZj
         vZmeecxIyHFyeKGwlVcSaFWqIHpgy70WVthPsZSA4Vcb/WjD/eW2i+WllBtsZw3TxmFh
         XuunmLCHQsa5of4pBCwRGmeaDgRnO3EVWWknyHUGwIjyPolcKEOUNAnO5IAG38Qi7UGb
         yz/YFbXzNwb34xDMiFQ+psNOvkkBRdgxZZabtkQcbG+pufujjHHNzv4vzjJUthsedMuc
         MAhjtw46noRXQa/pOhM89v2gcjaj3XF+wkDOZiWN/oZOwHWKrrfGIrdF+ffXm+dQjnVU
         Xr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=RqEl9CXMxzFCXkdSfjZ4X3v417NkC4wkMew8EpO3DAbiyhWMHu3odiYteoXYav0eIF
         Yo4xoJzPjsZ1Yqd4B3sLWFVAaE9mNJMgqqIArchqCAe/XcgFkMyWw38RPcqmp5gcREO4
         kj/fouGoSXZI9oONme6xoTHw2blj97/9XrQewZbf67NHUv64ekrPLIhikx4P+HR2x6ob
         h5fX8i2wi66OdHoOlw3cnCVDyvfzgSApCv7yR4b9geHB+vFJjt/Q0XdGl/GB5Tjwbhu2
         RPS1tv5mY2Hp5Bhk5FZCdgYmLFHp7sCV0PtcU4EOABbRmLgPoy9siiHrw6BR/v3DQ4xi
         xGxg==
X-Gm-Message-State: AOAM5329MBCgmAXc2Z6itgMIthmrpy1W8XV+McJIPMwDo+n8wRe3nc63
        O3RmYKFUtky506jaJN64GYG3Y8afVHwpvw==
X-Google-Smtp-Source: ABdhPJzqNELAlWbrqnkEfyaIUB9RVID4ORbQdRCcHursoMRdsbrt5WqvWQEzhK7pzNdA1aJmWnOEAw==
X-Received: by 2002:a50:ccc9:: with SMTP id b9mr49122788edj.316.1620907684016;
        Thu, 13 May 2021 05:08:04 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:03 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 05/12] iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
Date:   Thu, 13 May 2021 15:07:45 +0300
Message-Id: <20210513120752.90074-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

