Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580B03B2A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhFXIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFXIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:21:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:19:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i24so7281689edx.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaNSCMGV5qh1CquvxbjGYHMLSp9S15q2vTJ0o9vKxN0=;
        b=TLyee5ouAerT+C1yZLIoqowVjsiAD5gKsKq5chr0XpfUfnNX9rEcymsL5yVgHGxccp
         qaGcW9AlYF5rN8uL7o2qQALyFPLy0V+h0RC2zzwP48de8tfPqULW94YsYip0NJSTSxWd
         lskXHzb3R9kakbSUCIk4Y6fw/ig+Uuis9FwwG23rx7+SLI8c47AS6xnxsnFkHIi6ZtPi
         NFyzbVcrIz2gy4u0OQCr+kSlT1HJJSoUy/ryDW9vkB2KeCvNjt4Vr2wzloRyq49ExR59
         m4leYGoCzK8EWTg+xHFQ8l3fKLte4Z4McYNcniAwTwiRXomdMHG8g+BKSYw9x8qGrghS
         oygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaNSCMGV5qh1CquvxbjGYHMLSp9S15q2vTJ0o9vKxN0=;
        b=CARN4OED1jqSlydt7GvtFufrztRmcipqo5rMd0dK7cC6fFJC0U2+Kwlh5F/AInOt4p
         3xHazPya1+69Jea8aju+A1nPTvPJk/DE+rr1IZa1i1qS19cXnrCQkqiE7ZzePaF+nHQF
         R+dW6G61561qeLPrMW8d89vKQJt6whEwGFyAvAp8o+5zBNMqqVFh9BiDqLER2pu9y/OJ
         QsX/QxDEctOkkkyJkQSiIowUTgWnEjZg7jLd4O0TH2Qs+N81qbiBg4j07tLV1Lcqj5bj
         Wks3TIAft/0Wza/16vaxNGUCWGCNhHVDgAxtpoDt3p1LFcoVZykakUaCRpw+Ftz8Bs/I
         jsrg==
X-Gm-Message-State: AOAM5329Nww3VQfuqgtkTbT5gGJ1qXn1QCyBQn5gnTiRoZIO+r/V8IBb
        132Ldiy5uAf4gBIDosMC04BxuA==
X-Google-Smtp-Source: ABdhPJzr1GubAJdC6LBzt0jQgZyshEsbRCHypo5AkdW8ZDgu8j0BYpPoybkgWWZNtgpyGMqTij4hvA==
X-Received: by 2002:a05:6402:18f6:: with SMTP id x54mr5689099edy.53.1624522772214;
        Thu, 24 Jun 2021 01:19:32 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id o4sm1374641edc.94.2021.06.24.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:19:31 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, pmeerw@pmeerw.net,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/2] iio: temperature: tmp006: convert probe to device-managed
Date:   Thu, 24 Jun 2021 11:19:23 +0300
Message-Id: <20210624081924.15897-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the driver to register via devm_iio_device_register().
For the tmp006_powerdown() hook, this uses a devm_add_action() hook to put
the device in powerdown mode when it's unregistered.

With these changes, the remove hook can be removed.

The i2c_set_clientdata() call is staying around as the private data is used
in the PM routines.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/temperature/tmp006.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 54976c7dad92..db1ac6029c27 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -193,6 +193,17 @@ static bool tmp006_check_identification(struct i2c_client *client)
 	return mid == TMP006_MANUFACTURER_MAGIC && did == TMP006_DEVICE_MAGIC;
 }
 
+static int tmp006_powerdown(struct tmp006_data *data)
+{
+	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
+		data->config & ~TMP006_CONFIG_MOD_MASK);
+}
+
+static void tmp006_powerdown_cleanup(void *data)
+{
+	tmp006_powerdown(data);
+}
+
 static int tmp006_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -228,23 +239,11 @@ static int tmp006_probe(struct i2c_client *client,
 		return ret;
 	data->config = ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static int tmp006_powerdown(struct tmp006_data *data)
-{
-	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
-		data->config & ~TMP006_CONFIG_MOD_MASK);
-}
-
-static int tmp006_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	tmp006_powerdown(iio_priv(indio_dev));
+	ret = devm_add_action(&client->dev, tmp006_powerdown_cleanup, data);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -277,7 +276,6 @@ static struct i2c_driver tmp006_driver = {
 		.pm	= &tmp006_pm_ops,
 	},
 	.probe = tmp006_probe,
-	.remove = tmp006_remove,
 	.id_table = tmp006_id,
 };
 module_i2c_driver(tmp006_driver);
-- 
2.31.1

