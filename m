Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC13E3A32
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhHHM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 08:28:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31380C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 05:28:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f3so2846765plg.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqtMWSE4X2vIXheda4LMj6aXTtKL9vsZSd9gWgTaTMY=;
        b=AcTLhHqWdA3norqU0pIRWnDxDJ3zDLvz1WYEgEc3boCQAwkIhGV1/uyJ3oEVaRO8wz
         ahzeb90gFMhwmFXEI00QTojCRGZWtjNNx+6e6h2mz++oZFG1uLqw7VkePCRXIno1CUne
         PqhHa+3lpmqaTSHbif2YfploVTmuxccS3PoGB0rdHbTdW6om2QlGhxFuvElj2kfcJ3pD
         ioPoc85hJbZsvyVa3/qxJ7Vy+aXF4epfXcGTd7VsrkDr1fBogOEfa00YPQ69BDw5AXBL
         RCJvAJMfKfo9tWIgHYyBPmPPKpPgUge70D95p7MbTnYaHTz34P2oQQwiARoAjv+ErIMi
         FN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqtMWSE4X2vIXheda4LMj6aXTtKL9vsZSd9gWgTaTMY=;
        b=Ci+2Ujd98zvjuNGtI0u9HPC6sbHaOEEaxCbPNjVGi8VAg7dSu5rV8kFx+aA9dq9jnz
         CIbp8IZa3jaCLzNy/6OSmlad1NiovHu6/vOeDfnAug9gwG4SS+W3yQZI5YpmkhlbHZhq
         lTpy7Aop4HSdTcJ83rNKsNf0jYAfI0+kU2r0LSs5Vqo7SyQ1+SIK7WnIpSXhhYLYOzNh
         BvYWH0WxMAM7b0I8E6xzMJ5hLy5fjZRZLF2HPljBV0xEydwu6cEEAiMf68R7q1SJqBG9
         CdcVekgLnmpvPA1hBPBbmOPn71x7Jkb1gqjaWV7L/4CI2wX+liEeehztw8nSnEehc1fe
         WvUg==
X-Gm-Message-State: AOAM532EBo2lPzyVLIBaaYzV3Mkg6GlkosR2yNhtMvjMcTsnwYe6HbdW
        tcJjIUb0Du7QFAlX1MejVcDjkA==
X-Google-Smtp-Source: ABdhPJz11HFgRkz0O++gm3QZHkSmJjDmtL4JhLflG/0fHxkXR72D5WhZN4EWhkCwTxVruj0crcUr1g==
X-Received: by 2002:a17:90a:3f87:: with SMTP id m7mr19585941pjc.96.1628425715727;
        Sun, 08 Aug 2021 05:28:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:ae81:895b:1959:307d:267f:cefe])
        by smtp.gmail.com with ESMTPSA id d2sm19484766pgv.87.2021.08.08.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 05:28:35 -0700 (PDT)
From:   =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
Subject: [PATCH] iio: pressure: hp03: update device probe to register with devm functions
Date:   Sun,  8 Aug 2021 09:23:36 -0300
Message-Id: <20210808122335.4895-1-theobf@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device probe to register resources with device-managed functions.
Further, get rid of device-specific remove callback which is no longer
needed.

Signed-off-by: Théo Borém Fabris <theobf@usp.br>
---
Could the dev_err() messages be improved? In particular, I don't know if
it is important to express the usage of the device-managed functions.

 drivers/iio/pressure/hp03.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index e40b1d7dc12..78ea95d9f99 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -242,47 +242,27 @@ static int hp03_probe(struct i2c_client *client,
 	 * which has it's dedicated I2C address and contains
 	 * the calibration constants for the sensor.
 	 */
-	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
+	priv->eeprom_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							HP03_EEPROM_ADDR);
 	if (IS_ERR(priv->eeprom_client)) {
 		dev_err(dev, "New EEPROM I2C device failed\n");
 		return PTR_ERR(priv->eeprom_client);
 	}
 
-	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
-					      &hp03_regmap_config);
+	priv->eeprom_regmap = devm_regmap_init_i2c(priv->eeprom_client,
+						   &hp03_regmap_config);
 	if (IS_ERR(priv->eeprom_regmap)) {
 		dev_err(dev, "Failed to allocate EEPROM regmap\n");
 		ret = PTR_ERR(priv->eeprom_regmap);
-		goto err_cleanup_eeprom_client;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to register IIO device\n");
-		goto err_cleanup_eeprom_regmap;
+		return ret;
 	}
 
-	i2c_set_clientdata(client, indio_dev);
-
-	return 0;
-
-err_cleanup_eeprom_regmap:
-	regmap_exit(priv->eeprom_regmap);
-
-err_cleanup_eeprom_client:
-	i2c_unregister_device(priv->eeprom_client);
-	return ret;
-}
-
-static int hp03_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hp03_priv *priv = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regmap_exit(priv->eeprom_regmap);
-	i2c_unregister_device(priv->eeprom_client);
-
 	return 0;
 }
 
@@ -304,7 +284,6 @@ static struct i2c_driver hp03_driver = {
 		.of_match_table = hp03_of_match,
 	},
 	.probe		= hp03_probe,
-	.remove		= hp03_remove,
 	.id_table	= hp03_id,
 };
 module_i2c_driver(hp03_driver);
-- 
2.20.1

