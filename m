Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C45408A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhIMLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbhIMLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:54:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F76C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:53:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z94so7747360ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk43vu3DaZ0x+6xNSgwWNKeuIQVozOPsr0UzZd9OM+o=;
        b=Xo9ZE5tctYbOg+YLyaELtc3SqnplUlV6M/Kj4X8ZB2cF+Pkrt/huGxxiVyBSslmUvR
         gUj+5FjNw+E6akwPSHOPZtUfKuVomWx6F7222HRNwRasxVny9cJXRflDWdk+dQysgEJk
         B+X21GPh0sJ1fLXKZWQ7YAzMIR/0QV71c2hln2WAQhwQBGE1PZV9ph0hS3Uegn3dB6s7
         MK8H4o9isG+RboNwDMFkMqQi9s8c7xUOZQZILQ1OhS4dkqcJaUYaATCN8nkXTWncc6Xq
         ChzK+3f7DRgBjohNn9ktRwnkPEOoJVLS2pQusJupfUe3uUvw0hQJxdo5rbIeDMus6FGu
         DR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk43vu3DaZ0x+6xNSgwWNKeuIQVozOPsr0UzZd9OM+o=;
        b=Bh4Yo+KcAc8ffvIdH4vz0huqiKWDmhJwBm2Brz4pd3hIG4FYRtH7vyjcQzfagK0lD4
         4gZjlX169AOKCfY0BAlArdB32FmQkCIc2CuybmuG3WEwBX/Cmo2YZQSpO3sIqF8Db8Us
         jmMVUfb92NpD8ej5OmylUTlHz5P3+/ercawKYTFE38w/CoaLLV2XCbjIPgIk5/uQUiul
         ZEFYn/U1yZKeLhCVnQICeHjZUyzlKvQS64mP4ivqrwQERKoQE3yHdVGshRTR+KPoKzzI
         dkxYU9fAxSK9TvTQDIaYw/UafyhZFjrtWChdO9Xz0ubHAlwVHFbMMm/IyCE9QiJOjrLC
         +nKQ==
X-Gm-Message-State: AOAM533e+NrBXZphUP4DO656ECvVRj2O6PObHkw7T/5yJfrkLpyKCSae
        O+Jvdhwde3O+GQo58gR9RVFiM1/GfjMEWQ==
X-Google-Smtp-Source: ABdhPJylyJOHufTZedKyIFBiHP1791WeAYIRddqKMbf4UIMmhGLgs6h/SdFHYJ40N6Qnj7h15+h49A==
X-Received: by 2002:a05:6402:54:: with SMTP id f20mr13158827edu.382.1631533993271;
        Mon, 13 Sep 2021 04:53:13 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id m15sm3349014ejx.73.2021.09.13.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:53:12 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: gyro: adis16080: use devm_iio_device_register() in probe
Date:   Mon, 13 Sep 2021 14:53:08 +0300
Message-Id: <20210913115308.301877-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing else that needs to be done for this driver. The remove
hook calls only the iio_device_unregister() hook.

So this driver can use devm_iio_device_register() directly.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/gyro/adis16080.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index e2f4d943e220..acef59d822b1 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -195,8 +195,6 @@ static int adis16080_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	mutex_init(&st->lock);
 
@@ -210,13 +208,7 @@ static int adis16080_probe(struct spi_device *spi)
 	indio_dev->info = &adis16080_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	return iio_device_register(indio_dev);
-}
-
-static int adis16080_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id adis16080_ids[] = {
@@ -231,7 +223,6 @@ static struct spi_driver adis16080_driver = {
 		.name = "adis16080",
 	},
 	.probe = adis16080_probe,
-	.remove = adis16080_remove,
 	.id_table = adis16080_ids,
 };
 module_spi_driver(adis16080_driver);
-- 
2.31.1

