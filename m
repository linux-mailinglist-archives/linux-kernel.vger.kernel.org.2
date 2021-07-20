Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5218D3CF580
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhGTHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhGTHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:06:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE09BC0613DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:47:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ca14so27366647edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yws7s4TXHWQe2pKmn33RrpTgITzoOEmoytMF72afsZA=;
        b=iA11nX9aO55Ub5rAjlydHf16P+FeqYzwVKEDAuGGA7+AIj4Cx86fbhFwd44ItAZx3o
         ppQv6xbyPdtE1wwiDsTWI3nKs3A43twiYuzErrhS7O5GFrRP+qyX+d0gSChBrJKA2kpI
         JUt13Z4U4jIGhPfop/9RxmHzPnyasyXX4nDdV76uyIZHXsM5JaJkyeIFjBRJS1qn+hsi
         mY3yhYgCatuJLm+VSNuYvx3mcUE796FOFJljyhlXcFdaHERCefVklw/0zVcFjn4dtQrL
         X50PMD72lIwFyqvtb0Fjd7irYTgP84j7HKGU188uOzmBaFAfbNadzdnqj7+S+L7ea3Si
         gUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yws7s4TXHWQe2pKmn33RrpTgITzoOEmoytMF72afsZA=;
        b=T6BIpTcbWqfdom6mNWRGjsTNT27rjkgafKIIuhvWE5YXqng4NhzFSPsjpJ41ZtL7f8
         q15TP1mkXAJzUg6F+lmeFZvTbkJitSZvDpNLu3uJ0bTc4V+f8rwtaR4hpRJrUhuHdLiw
         GhvGk4u5AkmC13ujg0LZX9bJuLkkLdSr08cQIM0tLw2YeCpWEa4A/TZXkPnBFkVP5cgx
         twWVH7TAxmw4aMQDl6Ay7kp9bub9TABgU/vtncc0UX81x9vAldj3mEzoJkbdVve1sghA
         ZzjoQx+7t734qWYX2fWEGTzkCvImStqynD0LKwBAzM6KVVujtqUqiYAk40xl97Z7Cq72
         trpg==
X-Gm-Message-State: AOAM532qvEhGm4MXyKrLbPF2gjOHqQRfxhOidj3ysWZSUa6C3UrZtkIL
        YTIugzGo5ncXkg0/8xcpmppPjg==
X-Google-Smtp-Source: ABdhPJwr+3oKQ9L+qo0jwHjaqZ3HD1KElQ5R2NnqVAyyw96iK0WZ6Ubs+sq2EHVMFAhrph6zcC+P0w==
X-Received: by 2002:a05:6402:29a:: with SMTP id l26mr39209861edv.207.1626767220356;
        Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id b22sm7530940edj.24.2021.07.20.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:47:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 4/4] iio: gyro: st_gyro: use devm_iio_triggered_buffer_setup() for buffer
Date:   Tue, 20 Jul 2021 10:46:42 +0300
Message-Id: <20210720074642.223293-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720074642.223293-1-aardelean@deviqon.com>
References: <20210720074642.223293-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st_gyro_allocate_ring() function calls iio_triggered_buffer_setup() to
allocate a triggered buffer.

But the same can be done with devm_iio_triggered_buffer_setup() and then
the st_gyro_common_remove() no longer needs to manually deallocate it.

We know that the parent of the IIO device is used to manage other instances
of the devm unwind, so it can be used in the st_gyro_allocate_ring() as
well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/gyro/st_gyro.h        | 4 ----
 drivers/iio/gyro/st_gyro_buffer.c | 9 ++-------
 drivers/iio/gyro/st_gyro_core.c   | 6 +-----
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 6537f5cb8320..f5332b6a02bc 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -26,7 +26,6 @@
 
 #ifdef CONFIG_IIO_BUFFER
 int st_gyro_allocate_ring(struct iio_dev *indio_dev);
-void st_gyro_deallocate_ring(struct iio_dev *indio_dev);
 int st_gyro_trig_set_state(struct iio_trigger *trig, bool state);
 #define ST_GYRO_TRIGGER_SET_STATE (&st_gyro_trig_set_state)
 #else /* CONFIG_IIO_BUFFER */
@@ -34,9 +33,6 @@ static inline int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 {
 	return 0;
 }
-static inline void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
-{
-}
 #define ST_GYRO_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 02b5562b6585..4ae33ef25b9c 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -61,13 +61,8 @@ static const struct iio_buffer_setup_ops st_gyro_buffer_setup_ops = {
 
 int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 {
-	return iio_triggered_buffer_setup(indio_dev, NULL,
-		&st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
-}
-
-void st_gyro_deallocate_ring(struct iio_dev *indio_dev)
-{
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+		NULL, &st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
 }
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index fe227ad400f0..e8fc8af65143 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -512,7 +512,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 		err = st_sensors_allocate_trigger(indio_dev,
 						  ST_GYRO_TRIGGER_OPS);
 		if (err < 0)
-			goto st_gyro_probe_trigger_error;
+			return err;
 	}
 
 	err = iio_device_register(indio_dev);
@@ -527,8 +527,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 st_gyro_device_register_error:
 	if (gdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-st_gyro_probe_trigger_error:
-	st_gyro_deallocate_ring(indio_dev);
 	return err;
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
@@ -540,8 +538,6 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 	iio_device_unregister(indio_dev);
 	if (gdata->irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-
-	st_gyro_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
-- 
2.31.1

