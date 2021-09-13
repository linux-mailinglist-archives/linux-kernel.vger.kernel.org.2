Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28649408A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhIMLxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbhIMLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:53:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B029C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:52:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g21so13946183edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SJeXbXxW9FZ7gvmVs/J0ouW3ZX3u2oMREwr+4kjkTQ=;
        b=LJsubF1g87brp4BCj2vBcEXxClFcGVfUFDj65GPMLGWcBEAPXQi2s5pCeY+JWfBirK
         0KuQMHUTP3e9al0ipgueHxrxduQiDmr7Se38bx41Av5J+esBZlPL31FQm/3R5vY2bGGw
         dXyHsTtlsFwB1YJrbrrzgO36b4f/K4BbNhZgI73dZxPotV2lyE4RFVlPI6FduemPx2P4
         R3ELJmIp6whCcFE9irWcFml2zRK0z5AlDGrpPUzCQUM4LQtwl5+SvPg0HakEt8DDrbKV
         speb3Sq4dG4C1V1QH22tUttr0kMB7iJNpBs9BC1GK+EObSOEFcipiVFrQTLPqAvAnJeg
         2YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SJeXbXxW9FZ7gvmVs/J0ouW3ZX3u2oMREwr+4kjkTQ=;
        b=ZOBBmQIClHr62DyPsYlx5XypkUpFY1wwqDKmIC/6H8I0vEoH2grxxcuKMbfoInxmi9
         KJnOms0QDlm0d1kPuyU12lN3p7pp+jLJdXKumC48TKqKe/awKMwOYFFHimCVF8P9k3Ud
         otH8y46JsbI6ytiBkJBgFXhhMvvBTTkQlg395I4WxUW9v/3LnSvNkGpvizGK4L8nXMbn
         9G+lbYQVQxAD/orcBnTBwuVw4VCqQZR9iUIZp60/FL5Cy4dhD4S+3L22bIzczeNWN7za
         Z6YNroS044ZSiUKeK0X62Zw3nnwaP9PyMG5w+Wm9lZfNBlYTy8eiTPzyPZq8KvIk7uik
         w87w==
X-Gm-Message-State: AOAM533pZsNChE1rgUxdgznD5jhjZOd+f56VgqCSl/0FibO5tMFjIXTy
        Ier2N647kEBjruZEmXPnMGM3mCIdVNCmQQ==
X-Google-Smtp-Source: ABdhPJzhhRUbmNPfxFgJa7K0/ZFKpwbECHXRIbVikop1KOM9IsNa5nCLPfPgljVCa1eKf5Ih6D5gpw==
X-Received: by 2002:a50:d844:: with SMTP id v4mr12537212edj.73.1631533933758;
        Mon, 13 Sep 2021 04:52:13 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ba29sm2369431edb.5.2021.09.13.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:52:13 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] staging: iio: ad9832: convert probe to device-managed
Date:   Mon, 13 Sep 2021 14:52:09 +0300
Message-Id: <20210913115209.300665-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change does a conversion of the driver to use device-managed init
functions. The 2 regulators and the clock inits are converted to use
devm_add_action_or_reset() callbacks for de-initializing them when the
driver unloads.

And finally the devm_iio_device_register() function can be use to register
the device.

The remove hook can finally be removed and the spi_set_drvdata() call can
also be removed as the private data is no longer used.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/staging/iio/frequency/ad9832.c | 82 +++++++++++---------------
 1 file changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 3f1981e287f5..f43464db618a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -294,6 +294,16 @@ static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
 };
 
+static void ad9832_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static void ad9832_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -310,7 +320,6 @@ static int ad9832_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
@@ -323,27 +332,35 @@ static int ad9832_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
+	if (ret)
+		return ret;
+
 	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd)) {
-		ret = PTR_ERR(st->dvdd);
-		goto error_disable_avdd;
-	}
+	if (IS_ERR(st->dvdd))
+		return PTR_ERR(st->dvdd);
 
 	ret = regulator_enable(st->dvdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
-		goto error_disable_avdd;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
+	if (ret)
+		return ret;
+
 	st->mclk = devm_clk_get(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		goto error_disable_dvdd;
-	}
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret < 0)
-		goto error_disable_dvdd;
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, ad9832_clk_disable, st->mclk);
+	if (ret)
+		return ret;
 
 	st->spi = spi;
 	mutex_init(&st->lock);
@@ -394,60 +411,34 @@ static int ad9832_probe(struct spi_device *spi)
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_unprepare_mclk;
+		return ret;
 	}
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
 	if (ret)
-		goto error_unprepare_mclk;
+		return ret;
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
 	if (ret)
-		goto error_unprepare_mclk;
+		return ret;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
 	if (ret)
-		goto error_unprepare_mclk;
+		return ret;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
 	if (ret)
-		goto error_unprepare_mclk;
+		return ret;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
 	if (ret)
-		goto error_unprepare_mclk;
+		return ret;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
 	if (ret)
-		goto error_unprepare_mclk;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unprepare_mclk;
-
-	return 0;
-
-error_unprepare_mclk:
-	clk_disable_unprepare(st->mclk);
-error_disable_dvdd:
-	regulator_disable(st->dvdd);
-error_disable_avdd:
-	regulator_disable(st->avdd);
-
-	return ret;
-}
-
-static int ad9832_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad9832_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->mclk);
-	regulator_disable(st->dvdd);
-	regulator_disable(st->avdd);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad9832_id[] = {
@@ -462,7 +453,6 @@ static struct spi_driver ad9832_driver = {
 		.name	= "ad9832",
 	},
 	.probe		= ad9832_probe,
-	.remove		= ad9832_remove,
 	.id_table	= ad9832_id,
 };
 module_spi_driver(ad9832_driver);
-- 
2.31.1

