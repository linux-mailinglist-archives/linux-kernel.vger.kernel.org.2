Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F603CF57A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhGTHGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhGTHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:06:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:46:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l26so27301362eda.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fG+TIrBcXjlGO0172HoRoFhmSuH5RlW2FCQ8LPJTxcA=;
        b=E6A58g+Lxxb3C64WKwhiotp6QXgwxqOZiTq0QJWxLpteG83/n68uQukFP+683QRkRD
         fI3dw+hh6jxcsggGwNdq6VTHINik0f7S+0BrHyCFwy1rWofUOj9L29Cwif0rpvtpUsIZ
         qbpUjF2ZWUE/2FNQj6vFVhrba97b5VLIbfn4bnb2In3UbYnOwg6MuiQQ3AMF5+XlJIFA
         gXUndFL/EjcUPmfh9XPRDBu3FTzQixv3i9DVNu/WbcC6SNmMBRRK29WikHKC8R4mExhJ
         RsLFyWt6w+5c5U7HZNcMuTY0HVpus7g2jQPxRaLjUamfqNHZweGsTBj5ozEeO4lXv4Yb
         z1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fG+TIrBcXjlGO0172HoRoFhmSuH5RlW2FCQ8LPJTxcA=;
        b=IjbIROorD9mSUVK2XpkiK0MOHi8Txh6O54stF+ziVuvT7VuEsFzyfgYN3JPCnmFs9n
         Qx91jt6wkoJu10yCz+EFYgQQwbG1RAs+4jH8foiJPvrMOn8iffgLaTdfsP0gbK9Dio1M
         fLImKP6mO5BdA/mGNgH6LSy3WTz7cXM5faLQwTDXLFdURLB9s0SNlMFHWf/9jBexN/dN
         X1nClhwIqGPTDM+hROoTmv8+odxp+rsZK9wDHhHZ0ROqdYIYAMLO5xAgYJtV5P3wK7RV
         rhAjHtvNfiVafrPnVpKphUWCty9OX2MLB6ehvZ406mUxbXiCRAMou+KPOq7o7agbs3YK
         JmVA==
X-Gm-Message-State: AOAM532+Nb1l3dNwNqHRym379pAcIEd5PPSfRMggv7MIG3tDHsGqt/zt
        t6drlZ1CLuEfT95kKgZGkI4XIuCdmIke0yjeiTg=
X-Google-Smtp-Source: ABdhPJwVPGLOWrVCyBdS20griRcddlKUnItVcUPsOMQ5oQFe+y353CEMx0ElGvUVui+8ajQIJ3pR+Q==
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr39333039edt.137.1626767217417;
        Tue, 20 Jul 2021 00:46:57 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id b22sm7530940edj.24.2021.07.20.00.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:46:57 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/4] iio: pressure: st_pressure: use devm_iio_triggered_buffer_setup() for buffer
Date:   Tue, 20 Jul 2021 10:46:39 +0300
Message-Id: <20210720074642.223293-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st_press_allocate_ring() function calls iio_triggered_buffer_setup() to
allocate a triggered buffer.

But the same can be done with devm_iio_triggered_buffer_setup() and then
the st_press_common_remove() no longer needs to manually deallocate it.

We know that the parent of the IIO device is used to manage other instances
of the devm unwind, so it can be used in the st_press_allocate_ring() as
well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/pressure/st_pressure.h        | 5 -----
 drivers/iio/pressure/st_pressure_buffer.c | 9 ++-------
 drivers/iio/pressure/st_pressure_core.c   | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 9417b3bd7513..156e6a72dc5c 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -43,7 +43,6 @@ static __maybe_unused const struct st_sensors_platform_data default_press_pdata
 
 #ifdef CONFIG_IIO_BUFFER
 int st_press_allocate_ring(struct iio_dev *indio_dev);
-void st_press_deallocate_ring(struct iio_dev *indio_dev);
 int st_press_trig_set_state(struct iio_trigger *trig, bool state);
 #define ST_PRESS_TRIGGER_SET_STATE (&st_press_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
@@ -51,10 +50,6 @@ static inline int st_press_allocate_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-
-static inline void st_press_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
 #define ST_PRESS_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index b651e7c31e90..25dbd5476b26 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -41,13 +41,8 @@ static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
 
 int st_press_allocate_ring(struct iio_dev *indio_dev)
 {
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_press_buffer_setup_ops);
-}
-
-void st_press_deallocate_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+		NULL, &st_sensors_trigger_handler, &st_press_buffer_setup_ops);
 }
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 4ff6d40e3670..ab1c17fac807 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -718,7 +718,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 		err = st_sensors_allocate_trigger(indio_dev,
 						  ST_PRESS_TRIGGER_OPS);
 		if (err < 0)
-			goto st_press_probe_trigger_error;
+			return err;
 	}
 
 	err = iio_device_register(indio_dev);
@@ -733,8 +733,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 st_press_device_register_error:
 	if (press_data->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-st_press_probe_trigger_error:
-	st_press_deallocate_ring(indio_dev);
 	return err;
 }
 EXPORT_SYMBOL(st_press_common_probe);
@@ -746,8 +744,6 @@ void st_press_common_remove(struct iio_dev *indio_dev)
 	iio_device_unregister(indio_dev);
 	if (press_data->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_press_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_remove);
 
-- 
2.31.1

