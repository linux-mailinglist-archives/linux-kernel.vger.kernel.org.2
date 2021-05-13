Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFF37F78E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhEMMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhEMMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n25so30707550edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=sDl7yIMm4pEWQCTDiSVISdETV1aBbqNJuPkuYhkGporIoLkGNWG5+OfEvqrd5J7IOJ
         2lMlz6Y4xi6tregmjPhnR90NJ6eKlr+OdGk/JZjQxb9WyJ9fUAaOsOeFpEx/48wmIqTV
         VqIZM2MWY8XrFDgm6uyB8uldiiaffeK2HjQtlwRSsqrOIPxWhZj3l2eNRq24F+IlbSq/
         tcpv9/BOSGfPli+jIwRyADo338UIvr0sx+XfhorJ7xHgQf5Iv+tv76Y1cn2417rVHEFK
         O2RBwhuKxzRF8NQ7wcgfmCh9iqSYTCuMyZVpCXQeSn3Hd8afN6hUldjSgrnyllRjGNat
         X/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=Gsscgf8huFuhVqJWeKlLTA+iReANxe3HSH8nO/Cuf3yrHmKuabaIgeKJdukFnJbdlr
         1vqOti7TOX5whZ/uWsiWoz0VTI0F/fn2jKkV4GCYrbgaxDiPa7avv0TrQvGCBQXYH3/C
         LpaQcNZlVBy9EBhjD0v74CDCl/P8LBkgJqBEUSGJcj6eT+CbWftdHatAOo10Z3LR7NW2
         qoBHIbPVtYy6ZIh0XVImuyK7fJZ8C1L4WkixHYw/x2cCA/n8e5mxSYQqFl9eu34EAkV4
         To5eR7WApEr1UZAj+JerZOmIpwOvn+G6kfeGaYj6jcs+s1xSD6awHA4AYz88+ZoEkbgL
         VF0Q==
X-Gm-Message-State: AOAM532W62Oy11Qqx5e9wT8XWYfA3TQmfjdRwaYsEUMuiP5GGZEnqnC/
        ESQbGuTwacK+53eYbKWHZlyF5Q==
X-Google-Smtp-Source: ABdhPJxXlwbk4geynRS/x1HxuA+bLiCAXit3sXMtZNMNe9uYPyHRcU+H4FrDR+2YMT8G6sVKEQ4w7w==
X-Received: by 2002:a50:f9cc:: with SMTP id a12mr50595743edq.24.1620907686069;
        Thu, 13 May 2021 05:08:06 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:05 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 07/12] iio: adc: ad7791: convert to device-managed functions
Date:   Thu, 13 May 2021 15:07:47 +0300
Message-Id: <20210513120752.90074-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7791 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7791.c | 44 ++++++++++++----------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index d57ad966e17c..cb579aa89f39 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -394,6 +394,11 @@ static int ad7791_setup(struct ad7791_state *st,
 		st->mode);
 }
 
+static void ad7791_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7791_probe(struct spi_device *spi)
 {
 	struct ad7791_platform_data *pdata = spi->dev.platform_data;
@@ -420,11 +425,13 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7791_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
@@ -434,39 +441,15 @@ static int ad7791_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7791_no_filter_info;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = ad7791_setup(st, pdata);
 	if (ret)
-		goto error_remove_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_remove_trigger;
-
-	return 0;
-
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7791_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7791_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7791_spi_ids[] = {
@@ -484,7 +467,6 @@ static struct spi_driver ad7791_driver = {
 		.name	= "ad7791",
 	},
 	.probe		= ad7791_probe,
-	.remove		= ad7791_remove,
 	.id_table	= ad7791_spi_ids,
 };
 module_spi_driver(ad7791_driver);
-- 
2.31.1

