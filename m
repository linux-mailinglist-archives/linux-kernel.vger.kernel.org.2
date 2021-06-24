Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947793B29DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhFXIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhFXIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:09:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D9AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:06:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s6so7194653edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4nA73tTn4BEbsExo9rREISfJYQH8bIha0KgZwwYk0U=;
        b=gqFYvfIiExTkr0Wh6JaJzaLvhcoFitp2BuZafaKV3a5/j/cHyXbJfII9T+NRhZpCZB
         QSVcdnVjQ9QZ0s0irS6RbkDNmPDV5KunLc30362xlLluuLr6ZmZhfdqFjcgd7k1I8gsz
         R7LvQzHX4C3rbHGRKpGXtvjTiF0+LGmVpDocRuEDSrlGML98Yei0D3bZB3/da9Tn7V0/
         xTK2SaY1kkpfDc+VZwHSmbsU8LRfRGoHix1t8y2ncU6GVH/SeznTO54NvZKwH2hx2PK6
         7JB/Zd6lc84XiMGDO5B6vIjZEMuC3o6wMpwWRANN8mEN0vZPDLAr/lKkCAPzOtyj9a6c
         mGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4nA73tTn4BEbsExo9rREISfJYQH8bIha0KgZwwYk0U=;
        b=WuY9IxKzIs+s49ElbqyBwNPInwibgWolUFHwYoJK/zufE11FS6RDnNkoASewJtShq8
         MLsXaySF0q7lzbsi0pOjHtDta05cDFQO2OvtAaIA1kf26R4LtGe9RKSWgqC6O/yk2zI2
         GL4lJdUIy6dwlpECVExMxAJB7FIOp8FXvYClpoI6Yfk49qx4ozKZT2D13sur9byx+PjD
         KoKS+hpJhP30raMctSKh9nU1HruF02KwN+FL+BI2oXBoBRZK+uVMraNbiOvywrXs8ic5
         qr0LdD4glylLXu3lxqCi+qE4jvmuu19P9xSDy/6VH00j9ezTfWzErupJdhw5XDVdaWQj
         rygw==
X-Gm-Message-State: AOAM531PZLzvpFG1iYdiH4BOQ+HM/cZVNQf3xGMrjjKnhel62DuzFNvZ
        34gVLD/mgG8n0bJh2+uy5eoR5Q==
X-Google-Smtp-Source: ABdhPJzMpliokcDsWHyd2dx274CTFrJ/Yt1GGC9oim3kUcuRKQlnG+0ssdEZQEqZq7fCxumFcdzPlw==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr5457088edt.121.1624522017126;
        Thu, 24 Jun 2021 01:06:57 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n15sm1392785eds.28.2021.06.24.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:06:56 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: potentiometer: max5481: convert probe to device-managed
Date:   Thu, 24 Jun 2021 11:06:41 +0300
Message-Id: <20210624080641.9953-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change converts the probe function to use the
devm_iio_device_register() function.

Before calling that, we need to register an action to store the wiper back
to non-volatile memory when the device is de-registered.

We don't need to do this if the probe fails, because the only place where
the probe can fail now is devm_iio_device_register() and that shouldn't
create an IIO device (for userspace to poke at) if it fails.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/potentiometer/max5481.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 6e22b538091f..098d144a8fdd 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -125,6 +125,11 @@ static const struct of_device_id max5481_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max5481_match);
 
+static void max5481_wiper_save(void *data)
+{
+	max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
+}
+
 static int max5481_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -136,7 +141,6 @@ static int max5481_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
 	data = iio_priv(indio_dev);
 
 	data->spi = spi;
@@ -158,18 +162,11 @@ static int max5481_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static int max5481_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct max5481_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
+	ret = devm_add_action(&spi->dev, max5481_wiper_save, data);
+	if (ret < 0)
+		return ret;
 
-	/* save wiper reg to NV reg */
-	return max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id max5481_id_table[] = {
@@ -187,7 +184,6 @@ static struct spi_driver max5481_driver = {
 		.of_match_table = max5481_match,
 	},
 	.probe = max5481_probe,
-	.remove = max5481_remove,
 	.id_table = max5481_id_table,
 };
 
-- 
2.31.1

