Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72193CF57C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhGTHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhGTHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:06:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3390C061767
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t2so26941085edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WyA9TXdUs//oenEd121gmP7wNOs6Aapjq3zo8t6a0A=;
        b=ccbBxAn67cIsRP+FE8rsrxkIrAcx19Y1IdownOVpm1Si8tbZSAE9oHmBHei5rLp/1i
         +KJjmJAebDZnFgTks5T8INe/EG0RKpjo+bCyiKIvIlKlGg5WIhlf/XcRrxlihP6kc+L1
         FmNSwby2388n0FG+gIuHhC0DmZsVt/BG6ippE6NMWb60UgpJ5n9oVmLcSOBnJdlrXDbD
         Z8lVbQwqX67QMZAibdtmT3A5EeWtVS25Jat+eFjKUTN5ajq4orl0K7i6Cy26vHkQ57Ln
         zfA07z1DxVQYipydRqIq+wqKbS2z7pWO74gPgK8zbBUAcwRtsrp8Q0jM3l9w0yky7cM5
         apcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WyA9TXdUs//oenEd121gmP7wNOs6Aapjq3zo8t6a0A=;
        b=dmavKpdzZIL+cxQt3Z8qLNzUdX7LiTBXfxhiGO+PYQ95vA9Mq+t3YaV+e2c00KUnhv
         YoNpVwsS3VgzmQ+9vYOxe1/Jc9D6yRDdKnzU8kUuoKzF12zJS4ECiZHUDskmmOuVOJV0
         Xmfg7ethFUNZXpX8yKXiYHluPyzensxgxUtMgGTDZ1oFZyXp3zTosViWCWT3/1JPq5mx
         +09GD+tYyHgQIvEkJnbHOZN4bdDjsGlhRD/rNJ5GmA0Cz7KyhV3n8rmdoHXwTA6sY7T9
         uhBstxIFIQpdsF7ytIoWUrPS4tyNs4G4WsEJUiYGShErwL7SZm1YEgwpBu/iehaj9bZV
         8CNQ==
X-Gm-Message-State: AOAM531HeHnWCLsyfURkcpWJW+Bozw5uih1kZvpjjlYhSZTMhEzd4B9z
        elv+A6svCqL6FfOr3m6UFeNgWKKlarUqt/RZIKQ=
X-Google-Smtp-Source: ABdhPJwQ4HryQnpuHExMrnwayhRVr6oKw57439OG0nNncjq+Y5axRgABCOKGEMXpwCq5AbWsFguJ3w==
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr9865569edu.326.1626767219452;
        Tue, 20 Jul 2021 00:46:59 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id b22sm7530940edj.24.2021.07.20.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:46:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 3/4] iio: magn: st_magn: use devm_iio_triggered_buffer_setup() for buffer
Date:   Tue, 20 Jul 2021 10:46:41 +0300
Message-Id: <20210720074642.223293-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720074642.223293-1-aardelean@deviqon.com>
References: <20210720074642.223293-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st_magn_allocate_ring() function calls iio_triggered_buffer_setup() to
allocate a triggered buffer.

But the same can be done with devm_iio_triggered_buffer_setup() and then
the st_magn_common_remove() no longer needs to manually deallocate it.

We know that the parent of the IIO device is used to manage other instances
of the devm unwind, so it can be used in the st_magn_allocate_ring() as
well.

This change also removes some omitted st_magn_{probe,remove}_trigger()
inline hooks.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/magnetometer/st_magn.h        | 12 ------------
 drivers/iio/magnetometer/st_magn_buffer.c |  9 ++-------
 drivers/iio/magnetometer/st_magn_core.c   |  6 +-----
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index fb6c906c4c0c..785b7f7b8b06 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -25,25 +25,13 @@
 
 #ifdef CONFIG_IIO_BUFFER
 int st_magn_allocate_ring(struct iio_dev *indio_dev);
-void st_magn_deallocate_ring(struct iio_dev *indio_dev);
 int st_magn_trig_set_state(struct iio_trigger *trig, bool state);
 #define ST_MAGN_TRIGGER_SET_STATE (&st_magn_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
-static inline int st_magn_probe_trigger(struct iio_dev *indio_dev, int irq)
-{
-	return 0;
-}
-static inline void st_magn_remove_trigger(struct iio_dev *indio_dev, int irq)
-{
-	return;
-}
 static inline int st_magn_allocate_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline void st_magn_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
 #define ST_MAGN_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 68f01714304f..cb43ccda808d 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -41,13 +41,8 @@ static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
 
 int st_magn_allocate_ring(struct iio_dev *indio_dev)
 {
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
-}
-
-void st_magn_deallocate_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+		NULL, &st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
 }
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 2c44a92590fc..9ffd50d796bf 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -647,7 +647,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 		err = st_sensors_allocate_trigger(indio_dev,
 						ST_MAGN_TRIGGER_OPS);
 		if (err < 0)
-			goto st_magn_probe_trigger_error;
+			return err;
 	}
 
 	err = iio_device_register(indio_dev);
@@ -662,8 +662,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 st_magn_device_register_error:
 	if (mdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-st_magn_probe_trigger_error:
-	st_magn_deallocate_ring(indio_dev);
 	return err;
 }
 EXPORT_SYMBOL(st_magn_common_probe);
@@ -675,8 +673,6 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 	iio_device_unregister(indio_dev);
 	if (mdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_magn_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_remove);
 
-- 
2.31.1

