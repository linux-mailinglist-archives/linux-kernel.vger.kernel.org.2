Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29BC3D53B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhGZGdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhGZGdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:33:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18854C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:14:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go31so1172962ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxCBnIZ5dXssQzzN6VCgXFv518uWR4Tb6f83q4mewwQ=;
        b=Qj7avCSxmgTMPSljW3uUuAK38mXHpjYkMYb7VLWiV1TW0lQjKOOdoo+hPINskds+8l
         8U+XZa4lhiwzZVpt0Q+OKKZ+gxeIONWMbmo1xm6Ew/CVRUKWQWWd1+rBYFh4fKy5i60k
         gN2RaCIgjt0TXIU+2tUKx96QOyhv9Av5DZeY1UUINCyhFh346tNITOUGCaYrYzqMGdyJ
         2yODxUvAA+9JRIpFl45yM1wdlvuWaLZR5NSqzeOTo+QqTjmSvrzUMVrwE3z2Fo6ToN+P
         +6xN2dYNmqLPzXBXGVJ2ngw9I0mm5f5p1mgSWqtrOBVWxfW7wSXX6u78BNrODJTu/ai5
         PHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxCBnIZ5dXssQzzN6VCgXFv518uWR4Tb6f83q4mewwQ=;
        b=DksVnqRpFeIlX2VTLUKgM6whsDw5c+SXxOv61ak7NjyDtML1ejzAjs4nWjzwaoLRiK
         UHsHJVPOJWlE/YEdOxTPvXYc90AUAbVmWnWYzzu4nSacPnxlEz4hDqA2m5KXa8XVEeCB
         xXOkCUpn/qFfv7Pxj4Om6dx3HVbhHVJ+d30LGg9VgHqhg7Si/v/iJG8d8CxbPODnZRMY
         n6w8gv291wba8WR31MUKKo/rVfr3iMqbW/sX4EnfP1IM6+PpAf6kYTQYZnH5QRrvbDK1
         Z18nWQoRR0kQk6IjLK+KXkbE+qIiFhZSXvIClL+jVxQ4IcoIVLgacbEYIbTgJQUP+j3d
         YVvQ==
X-Gm-Message-State: AOAM533V1uHNkfCtwvuAPx/JLT8wUTHCBrDZcDA6F4DA+uzzOCSa69Sm
        Bkes/zwsrTjr8AT9vxtImlYIEw==
X-Google-Smtp-Source: ABdhPJz8JgxfOR79hkFDN7GQeLOQBb7F618/0nX4i37dfhNn9zZAyfrpYVQKq7jUE9MKcTpHA0jDbA==
X-Received: by 2002:a17:906:dc4b:: with SMTP id yz11mr801320ejb.402.1627283648611;
        Mon, 26 Jul 2021 00:14:08 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id v13sm13863772ejh.62.2021.07.26.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 00:14:08 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/4] iio: st_sensors: remove st_sensors_deallocate_trigger() function
Date:   Mon, 26 Jul 2021 10:14:01 +0300
Message-Id: <20210726071404.14529-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726071404.14529-1-aardelean@deviqon.com>
References: <20210726071404.14529-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the st_sensors_allocate_trigger() to use
device-managed functions.

The parent device of the IIO device object is used. This is based on the
assumption that all other devm_ calls in the ST sensors use this reference.

That makes the st_sensors_deallocate_trigger() function un-needed, so it
can be removed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_core.c             | 18 +-------
 .../common/st_sensors/st_sensors_trigger.c    | 45 +++++++------------
 drivers/iio/gyro/st_gyro_core.c               | 18 +-------
 drivers/iio/magnetometer/st_magn_core.c       | 18 +-------
 drivers/iio/pressure/st_pressure_core.c       | 18 +-------
 include/linux/iio/common/st_sensors.h         |  5 ---
 6 files changed, 19 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index f1e6ec380667..a7be1633bff1 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1380,29 +1380,13 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_accel_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered accelerometer %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_accel_device_register_error:
-	if (adata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_probe);
 
 void st_accel_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (adata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 64e0a748a855..d022157b66a2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -119,11 +119,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	unsigned long irq_trig;
 	int err;
 
-	sdata->trig = iio_trigger_alloc(sdata->dev, "%s-trigger",
-					indio_dev->name);
+	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
+					     indio_dev->name);
 	if (sdata->trig == NULL) {
 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
@@ -153,7 +154,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				sdata->sensor_settings->drdy_irq.addr_ihl,
 				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
 			if (err < 0)
-				goto iio_trigger_free;
+				return err;
 			dev_info(&indio_dev->dev,
 				 "interrupts on the falling edge or active low level\n");
 		}
@@ -179,8 +180,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
 			dev_err(&indio_dev->dev,
 				"edge IRQ not supported w/o stat register.\n");
-			err = -EOPNOTSUPP;
-			goto iio_trigger_free;
+			return -EOPNOTSUPP;
 		}
 		sdata->edge_irq = true;
 	} else {
@@ -205,44 +205,29 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	    sdata->sensor_settings->drdy_irq.stat_drdy.addr)
 		irq_trig |= IRQF_SHARED;
 
-	err = request_threaded_irq(sdata->irq,
-				   st_sensors_irq_handler,
-				   st_sensors_irq_thread,
-				   irq_trig,
-				   sdata->trig->name,
-				   sdata->trig);
+	err = devm_request_threaded_irq(parent,
+					sdata->irq,
+					st_sensors_irq_handler,
+					st_sensors_irq_thread,
+					irq_trig,
+					sdata->trig->name,
+					sdata->trig);
 	if (err) {
 		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
-		goto iio_trigger_free;
+		return err;
 	}
 
-	err = iio_trigger_register(sdata->trig);
+	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
 		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
-		goto iio_trigger_register_error;
+		return err;
 	}
 	indio_dev->trig = iio_trigger_get(sdata->trig);
 
 	return 0;
-
-iio_trigger_register_error:
-	free_irq(sdata->irq, sdata->trig);
-iio_trigger_free:
-	iio_trigger_free(sdata->trig);
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_allocate_trigger);
 
-void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *sdata = iio_priv(indio_dev);
-
-	iio_trigger_unregister(sdata->trig);
-	free_irq(sdata->irq, sdata->trig);
-	iio_trigger_free(sdata->trig);
-}
-EXPORT_SYMBOL(st_sensors_deallocate_trigger);
-
 int st_sensors_validate_device(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e8fc8af65143..cb539b47cdf4 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -515,29 +515,13 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_gyro_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered gyroscope %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_gyro_device_register_error:
-	if (gdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
 
 void st_gyro_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (gdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 9ffd50d796bf..5be85e2405a5 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -650,29 +650,13 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_magn_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered magnetometer %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_magn_device_register_error:
-	if (mdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_probe);
 
 void st_magn_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (mdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_remove);
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index ab1c17fac807..17ebb5171d4c 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -721,29 +721,13 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_press_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered pressure sensor %s\n",
-		 indio_dev->name);
-
-	return err;
-
-st_press_device_register_error:
-	if (press_data->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_probe);
 
 void st_press_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (press_data->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_remove);
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 8bdbaf3f3796..e74b55244f35 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -273,7 +273,6 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p);
 int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops);
 
-void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
 int st_sensors_validate_device(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev);
 #else
@@ -282,10 +281,6 @@ static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 {
 	return 0;
 }
-static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
-{
-	return;
-}
 #define st_sensors_validate_device NULL
 #endif
 
-- 
2.31.1

