Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B512837EBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381745AbhELTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350798AbhELRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:52:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA5C06134B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:50:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b25so36189938eju.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=g0mM27wtPuRCt6rBjngtsvAOSrPcnf7C/Z7EhpJ0zXwIn23BKQFAUsNFCtqdCY/XTh
         h0TWgja4t+6wQ5d7kytntR6viEA9iO8pTIRjoDk3h463/FyTbtPZgHy+5sPEZMN0A6FY
         0w0cF/J6JarAesGk9Zc8NkfsHL3n1M0b+mWUTIzse6PmegkLdEJ4DDWRrx2C3I7d8NVW
         /65nqrpWdLsmeVEkz0PP2YRClpX4e6VqXtNBHahYNni+rM/ue7Lh9UzD8+Dh/jJfVFj4
         hopnjreFvZdW/vT+VhOCrZNUnobe6WlqZ3b0EenHIcQAkVxP08gFVxsMHp2R6XSggQmm
         xmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc0zdIjPCIp6p3E6v5GazM0pebh4DygGLW4ST5XuVM0=;
        b=IGPs7d5uT5D1LWQxjyEIpF1Z8kKRbEgIvYiOIH5gk0RJ6N0BU+I684/aaiBQO1VZ7j
         r/rlMqL5p3AjKCGwgmS0xq0LWqE2+kcDDjwC21FFoTKb4YaUAc6Pvwm6OnebFj2S6gJX
         UwBav0RRoUfljx8+kgmJaz5f1bIgaTFYbLu3DRd7bjb89INBAzC027WN0J5xlVjQu15x
         aKYElM+gkLYdH3yH3tz6n5hBeO1kx2LU1AIstRJ3vZ4IshF5B/jNoGMGFVfbXLoYczZe
         x+ejFIn+OpDH3qH1eyzoYUXrlqivd104vu3auyZ9A1bhCXuOFlwonL+lhtQlK6FAJDHa
         0bKg==
X-Gm-Message-State: AOAM53038g4Fv3GCNpX1sCeqClEqT1sv5UdOi17AGXzPsOZW8ctFT/rF
        /w1DrXW5o/6lh67TJ6oyPTvcSA==
X-Google-Smtp-Source: ABdhPJxfBub/JbH4fkULgPfA6bjBJQqFm3EveARM0tNtexC6e+Td6lKU1VLpOfABtCh+fADbMukCXA==
X-Received: by 2002:a17:906:82cb:: with SMTP id a11mr39225121ejy.213.1620841804642;
        Wed, 12 May 2021 10:50:04 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:04 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 08/12] iio: adc: ad7780: convert to device-managed functions
Date:   Wed, 12 May 2021 20:49:10 +0300
Message-Id: <20210512174914.10549-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7780 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7780.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index 42e7e8e595d1..42bb952f4738 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -300,6 +300,11 @@ static int ad7780_init_gpios(struct device *dev, struct ad7780_state *st)
 	return 0;
 }
 
+static void ad7780_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_state *st;
@@ -318,8 +323,6 @@ static int ad7780_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
@@ -340,35 +343,15 @@ static int ad7780_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_add_action_or_reset(&spi->dev, ad7780_reg_disable, st->reg);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_buffer_and_trigger;
-
-	return 0;
-
-error_cleanup_buffer_and_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7780_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7780_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7780_id[] = {
@@ -385,7 +368,6 @@ static struct spi_driver ad7780_driver = {
 		.name	= "ad7780",
 	},
 	.probe		= ad7780_probe,
-	.remove		= ad7780_remove,
 	.id_table	= ad7780_id,
 };
 module_spi_driver(ad7780_driver);
-- 
2.31.1

