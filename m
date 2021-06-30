Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B503B82C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhF3NUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhF3NUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:20:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3DC061767
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:17:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l24so4112711ejq.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XH4RKf95uj0XGgjr7ofqfjtHRyfEBIs1/NXlXnVrwYI=;
        b=ax2et6Fq3SGMp+nmQS31Tgr4Z7CKWxguDv2PSQ03cdoudNQkw3+6hYf4ABbioe94/5
         ykmaOBtoqURlgq3vRWFLbjr9r+YYCfuCG7wKxmQI7+1PV/6cFJW9OYDnobz4fUj0IqYF
         gURDBI970v7SoJPEXTAeVpm7aXwVZIY1Wp+cNetyzch9aBb5qfr4N5NAN6zPK4TlqpyM
         AdN0Mbsg2P0ex+Mbt3zTdj6PLGqlxZyBz6Dqqhm8S8+1eROIQ1aaA4B2xEhGRotz/vBb
         z14RF+79DIPx4uTAZ/l9ZQpFQI52HVxxqNQTazelQhbj9lpGRzLE8Qj2pfIPCHN4gqnu
         lFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XH4RKf95uj0XGgjr7ofqfjtHRyfEBIs1/NXlXnVrwYI=;
        b=c6qIEDbA0oJnsqlf8lKonbmEk2upqnjU76Nd+2XZj0pUJlLPbOAMbWh06mb+YCVGlc
         N22h9v9ruIsyQbZnSGy1B1Y8DVi2jggU0+/0Rp0yR8pFwKpmbPd9vEoyLBQyVwe9CBeB
         EEkS620eOID+d18X7Ih7hPDG1m1tcAiYIwFcsd4WJDMFRqI3PmNeGjWx3OIzOPvI7MvN
         6YBmqMMyWh3eEb8Ub1s5mIRHDm8Dh0jckPWcBh7hMfwmLo5GCzSSHnAq8ZmZ6cothqWv
         tgGFZokJlMCf+9CeoaJmDYR+sheprv4kl1Axo+Vrl7WnPYP1ZI6lQCi509Tt+qlMkL6a
         HYGg==
X-Gm-Message-State: AOAM531n5MBjLf/fKi5ewrebuDHbwv+WTeO9bpG9/AS1pDFJp0W43azP
        8QsqpdUtQ3UHZawdPOJau40a9g==
X-Google-Smtp-Source: ABdhPJyGQ0J8ACUJhNNJ8MLetWxk0lXprsnPX+MhLU9yn8pn9wm9bA4xIV972M6LjqIPKrMrWHgPdw==
X-Received: by 2002:a17:907:2da6:: with SMTP id gt38mr34186045ejc.528.1625059050398;
        Wed, 30 Jun 2021 06:17:30 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id md14sm39511ejb.125.2021.06.30.06.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 06:17:30 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/2] iio: proximity: rfd77402: convert probe to device-managed functions
Date:   Wed, 30 Jun 2021 16:16:36 +0300
Message-Id: <20210630131636.1563148-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630131636.1563148-1-aardelean@deviqon.com>
References: <20210630131636.1563148-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the probe hook to register the IIO device with
devm_iio_device_register() and register a hook with
devm_add_action_or_reset() to put the device in powerdown when the driver
gets unloaded.

Since the PM suspend/resume functions need only a reference to the
i2c_client object (which can be obtained from the base device object), the
i2c_set_clientdata() call can be removed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/proximity/rfd77402.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index f349526421f3..8c06d02139b6 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -252,6 +252,11 @@ static int rfd77402_powerdown(struct i2c_client *client)
 				  RFD77402_STATUS_STANDBY);
 }
 
+static void rfd77402_disable(void *client)
+{
+	rfd77402_powerdown(client);
+}
+
 static int rfd77402_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -270,7 +275,6 @@ static int rfd77402_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
 
@@ -284,25 +288,11 @@ static int rfd77402_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, rfd77402_disable, client);
 	if (ret)
-		goto err_powerdown;
-
-	return 0;
-
-err_powerdown:
-	rfd77402_powerdown(client);
-	return ret;
-}
-
-static int rfd77402_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	rfd77402_powerdown(client);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -331,7 +321,6 @@ static struct i2c_driver rfd77402_driver = {
 		.pm     = &rfd77402_pm_ops,
 	},
 	.probe  = rfd77402_probe,
-	.remove = rfd77402_remove,
 	.id_table = rfd77402_id,
 };
 
-- 
2.31.1

