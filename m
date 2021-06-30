Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3C3B81DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhF3MRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhF3MRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:17:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6644C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:15:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id n25so2903403edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaRKJLlIxfNiC/w31k4zL58KaqqFoZh3Zqjg6N3S3Nw=;
        b=HcwNA8t0W9xPEnQyfIEilYhl9SnMv0vg6JVt5EmSdvlg4PUkVpEqYZvbT83F1wsf5C
         hCmT1A4V7TpTupVz7LYnZnyPoTvfEmFV96VM73Z/khD84aNjR3mFsoKlKWucydHv+gRw
         CHK8/O08F1pKayCCSfkN9+qbzq6O/S7ydL+q85Vl0718YyyMdr/ZV79QiKRY9U8/5fdZ
         XQeXuecJwlj3uVlKL5R6D/m4qK5xV0+xwzDhje74tS8NKP3cQrCm5UYW6teA8yQA+1Yu
         /oEOJySvrLNbbypqJWSP77hmwFjM0V/giS0eksp3X0d0XYrZc1aI+CbJDL9P/iT4EgvU
         syPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaRKJLlIxfNiC/w31k4zL58KaqqFoZh3Zqjg6N3S3Nw=;
        b=PJtNrYQagV5mifKZbkN/k2gU+kF+dDIZRCRY1uuuTOy3APE4zJcuHAlv0cg+0UtEPn
         vWR9P7tZisZ06ycO/TvQCBxQG6uu691T1UOT2G8cDZo5dN6ezyTazZACUoe4xlPunUzC
         VAqELRAjtSbKopOPjq6ejTr/HlTdAzpgY6wCYJ//hU6l7XYBkvrP0ZgGXTx4Q5GHmoUp
         Oyswf4dpTCnaQHSqiJcIJr1kCpiPLYYTP3a8guYxAz+z/5vxqElFpGn3le6TzN/uJV89
         bVt5TYR4g37Re4VXs63ci5rqD3g4jaknNNHtBn81eFhqNG++3z1Cl9Ys+88XZToKNGbe
         +kfQ==
X-Gm-Message-State: AOAM530lAKWWrqPFk0Mr1KqZIQCKz77ubHfFsc56cvnu6MozWdiFawkn
        fzGTU+IZAczDHjLnXm0jHXANNg==
X-Google-Smtp-Source: ABdhPJwTmPKe5uvCUHDUQoFQ4VO/9iCSoq6U8UuG2NM/Jjb5rbnUtDpxhZ6AVPZHJXYEKi3/nQvP6Q==
X-Received: by 2002:a05:6402:c91:: with SMTP id cm17mr4314239edb.123.1625055319120;
        Wed, 30 Jun 2021 05:15:19 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n11sm9798879ejg.43.2021.06.30.05.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:15:18 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: accel: dmard10: convert probe to device-managed functions
Date:   Wed, 30 Jun 2021 15:15:09 +0300
Message-Id: <20210630121509.653717-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another simple conversion to device-managed functions, requiring
the use of devm_iio_device_register() and moving the disabling of the
device on a devm_add_action_or_reset() hook.

The i2c_set_clientdata() can be removed, as the PM functions can work with
just the device object, to obtain the i2c_client object.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/dmard10.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index e84bf8db1e89..f9f173eec202 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -170,6 +170,11 @@ static const struct iio_info dmard10_info = {
 	.read_raw	= dmard10_read_raw,
 };
 
+static void dmard10_shutdown_cleanup(void *client)
+{
+	dmard10_shutdown(client);
+}
+
 static int dmard10_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -194,7 +199,6 @@ static int dmard10_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &dmard10_info;
 	indio_dev->name = "dmard10";
@@ -206,22 +210,12 @@ static int dmard10_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		dmard10_shutdown(client);
-	}
-
-	return ret;
-}
-
-static int dmard10_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, dmard10_shutdown_cleanup,
+				       client);
+	if (ret)
+		return ret;
 
-	return dmard10_shutdown(client);
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -250,7 +244,6 @@ static struct i2c_driver dmard10_driver = {
 		.pm = &dmard10_pm_ops,
 	},
 	.probe		= dmard10_probe,
-	.remove		= dmard10_remove,
 	.id_table	= dmard10_i2c_id,
 };
 
-- 
2.31.1

