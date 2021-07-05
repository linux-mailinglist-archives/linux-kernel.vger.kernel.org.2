Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548AD3BB79A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGEHRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:17:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B04C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 00:15:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hc16so27654684ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ykkqmppWnyrslZWxdlWEu20g35sW6pBGKuevoDuJtE=;
        b=UUaCkbZyLKctdNEs96AGfrx0lVlXJ2vW1OfUs4K3VibMRD7JyshiaVi+/gp5ECkqRZ
         R8jES1wRnq9pKAyfQMK7AtUY3QP0gEf0AVDEiS0cXwgQrZ4LUgCv0caFrO26YNeUYIgi
         XHDTkxvDSdrsOvJVxFhAspsYtZVmvTLn9aiiQGUi2676TpQ3ExdDvD5BD8uf+BWN4k0L
         szUGfZOE/oAh10F4K9rQdiSh6f0kbnIqWIQZ3om6NXXkhoOyP5ufrzgCHx0X/XlGVtLD
         5Yrts4dWvA4WeuKcSABOU19BHaUDR+nmSN+wthysbaarHZoTSex9ZUYtAmO5fwhsJQk9
         GF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ykkqmppWnyrslZWxdlWEu20g35sW6pBGKuevoDuJtE=;
        b=KVCD/CGRdKP9wvahtTpGt/dQbAZ8dzdi0+ZQYb9xBT4M5Asw0oqoBBrsAf/IWFVfFK
         oiFbdENMrBQW677t/LjjQOgRTQC2CRssDjOSy3neb3aYX0U2m11i4CvvuoTdZq4fYMP9
         VMChgMHPOlp33ct78lEpzXNE6HRXd+MhddIYRG1963LTPaaKeSmvknmqHozuWrcWNcak
         qFebxw7ehNsrtwRf+XvYlOgMjhrBZrEc+LkC5SOnw8t98BChbxOZP2+6z1XrKJIPySTS
         run2XgO1+2RehYm2atKe+/J8XmXwNBc5j52EcdGVSi822aC3KZndivKAn/Tt+4g1FSHo
         goYQ==
X-Gm-Message-State: AOAM5338rulbvVzNbeZk6/gKCUaoV1v11ESGGrSmjuxeNH68gMH5T/rW
        j3lHK7/no9AK/LwHSWJiz6ra/A==
X-Google-Smtp-Source: ABdhPJxz/16L2ufkgqfkMVdBuWiZ1CyZN9q/L++yakSFkA9g9URIAlBLI7o3S8S4Z6uMpL1PRW0tgg==
X-Received: by 2002:a17:906:36d5:: with SMTP id b21mr11994516ejc.258.1625469308728;
        Mon, 05 Jul 2021 00:15:08 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n22sm3973823eje.3.2021.07.05.00.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:15:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 1/2] iio: light: adjd_s311: move buffer on adjd_s311_data object
Date:   Mon,  5 Jul 2021 10:14:55 +0300
Message-Id: <20210705071456.649659-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change moves the entire buffer on the private adjd_s311_data type.
Since the device has 4 channels, it's not a big waste to just allocate the
maximum possible buffer and use only what's needed.

This is in contrast with free-ing and re-allocating the buffer on the
update_scan_mode hook.

Since the driver pushes buffer data with
iio_push_to_buffers_with_timestamp(), the buffer must also include a
64-bit buffer for the timestamp, for each sample-set.

With this change, the adjd_s311_update_scan_mode() is no longer needed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---

Changelog v1 -> v2:
* https://patchwork.kernel.org/project/linux-iio/patch/20210628135132.73682-1-aardelean@deviqon.com/
* split into 2 patches:
  - first patch move the buffer on the adjd_s311_data object (i.e. this
    patch)
  - second patch to do the conversion to devm_ functions

 drivers/iio/light/adjd_s311.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 17dac8d0e11d..caf852554897 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -54,7 +54,10 @@
 
 struct adjd_s311_data {
 	struct i2c_client *client;
-	u16 *buffer;
+	struct {
+		s16 chans[4];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 enum adjd_s311_channel_idx {
@@ -129,10 +132,10 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->buffer[j++] = ret & ADJD_S311_DATA_MASK;
+		data->scan.chans[j++] = ret & ADJD_S311_DATA_MASK;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer, time_ns);
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -225,23 +228,9 @@ static int adjd_s311_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask)
-{
-	struct adjd_s311_data *data = iio_priv(indio_dev);
-
-	kfree(data->buffer);
-	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (data->buffer == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static const struct iio_info adjd_s311_info = {
 	.read_raw = adjd_s311_read_raw,
 	.write_raw = adjd_s311_write_raw,
-	.update_scan_mode = adjd_s311_update_scan_mode,
 };
 
 static int adjd_s311_probe(struct i2c_client *client,
@@ -286,11 +275,9 @@ static int adjd_s311_probe(struct i2c_client *client,
 static int adjd_s311_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct adjd_s311_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	kfree(data->buffer);
 
 	return 0;
 }
-- 
2.31.1

