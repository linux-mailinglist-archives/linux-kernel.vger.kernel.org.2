Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A05347918
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhCXM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhCXM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0302C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w18so27553668edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ruo6fYyWvyeJFaVWRfRo7oSi7ED8tQGcfoAxMCBCouU=;
        b=pToGEiEfgiNyZfl5C5BwyI33D499QdsgN5d4sYrAyvneIIsK/sYBAGjJZrICh9FW3g
         ltW9Mx8eY0dcmwNGjyTEPcdR9Dx0lfN3skiPB61+AvuKuVXuIB1vG5gF6N0PVrbK+V2d
         DdrBpkOc5Oc3lAazjRDt8f0l4wKevp/U8+82KBYfgfV8JRJnfBIwkV8w4n2qHGLT/qqw
         m635iR/BBo/0bSiWsebp3FGP9+gM7BAhr9HXzP7tXV/O3XnnfzLp1O49EzdO4pkb9+Bw
         AJ5q+u8K7rnnwi+Dl1NA3M0i5lZvPul7SbJbu9QuQOfjKteIHLWGMpLvFxkxWLBVTXgr
         5/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ruo6fYyWvyeJFaVWRfRo7oSi7ED8tQGcfoAxMCBCouU=;
        b=Sgb4qz/VC6n9IRAv/F+4TQh+Pp0ZlDNl8O1OoLLJgsBQ8zUFK6bGH4nFlJ9p/SYdSG
         hPV3hpfdK/zULX5H9HKYiUubOxEbpJDJycP8zZgKHdKb3hg7HVoAyXzxRJ25JOS8ZXMi
         AZtH2uPP8iMpPz0LIC0QO/wP9JUH9ZG9xyZcIFrqgOkzoE51Ie95gDkpkQNpAI2xsW5A
         aGTYWcFAa/vAvxP2a6WlnYREIbOIYdJqkuTL93dvPcyIpzRLIipHdb5itMvaxxHrYxS7
         R/vH3DptJB7eRFQbVkeMw9u6L0esb4tvVF28nbkgeGhluxTEGNheLxfYOgu/Bv1cv1G3
         kZQg==
X-Gm-Message-State: AOAM530Q8JRBbx9LaqXMvd4DlG3rYNgxzTpvyq+WZAbay+CmJ1nThbFH
        gJedFYi/ewKAni/ZUEkWxOJVCQ==
X-Google-Smtp-Source: ABdhPJxJui6LdwmCfMr51Xk8gBZNOfiV50TbD4aKH9VG4B65APB61qzksR3QKrC4/mmIV44+rkV7og==
X-Received: by 2002:a05:6402:142:: with SMTP id s2mr3307510edu.2.1616590567384;
        Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id fi11sm880282ejb.73.2021.03.24.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:56:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     coproscefalo@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 07/10] platform/x86: toshiba_acpi: use device-managed functions for accelerometer
Date:   Wed, 24 Mar 2021 14:55:45 +0200
Message-Id: <20210324125548.45983-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324125548.45983-1-aardelean@deviqon.com>
References: <20210324125548.45983-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the IIO registration to use devm_iio_device_alloc()
and devm_iio_device_register().
With this change we can remove the manual deregistrations an freeing of the
IIO data.

This also makes the deregistration symmetrical with the registration.

One side-effect (that is undesired), is that if devm_iio_device_register()
fails, then the IIO object will not be free'd and will stick around until
the parent object is free'd. This is because there is no
devm_iio_device_free() function anymore in IIO.
However, this is a pretty bad corner-case that should not happen under
normal operation.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/platform/x86/toshiba_acpi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index e787c140eec2..12860ef60e4d 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2992,11 +2992,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 
 	remove_toshiba_proc_entries(dev);
 
-	if (dev->accelerometer_supported && dev->indio_dev) {
-		iio_device_unregister(dev->indio_dev);
-		iio_device_free(dev->indio_dev);
-	}
-
 	if (dev->sysfs_created)
 		sysfs_remove_group(&dev->acpi_dev->dev.kobj,
 				   &toshiba_attr_group);
@@ -3149,7 +3144,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 	toshiba_accelerometer_available(dev);
 	if (dev->accelerometer_supported) {
-		dev->indio_dev = iio_device_alloc(&acpi_dev->dev, sizeof(*dev));
+		dev->indio_dev = devm_iio_device_alloc(parent, sizeof(*dev));
 		if (!dev->indio_dev) {
 			pr_err("Unable to allocate iio device\n");
 			goto iio_error;
@@ -3164,10 +3159,10 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 		dev->indio_dev->num_channels =
 					ARRAY_SIZE(toshiba_iio_accel_channels);
 
-		ret = iio_device_register(dev->indio_dev);
+		ret = devm_iio_device_register(parent, dev->indio_dev);
 		if (ret < 0) {
 			pr_err("Unable to register iio device\n");
-			iio_device_free(dev->indio_dev);
+			dev->indio_dev = NULL;
 		}
 	}
 iio_error:
-- 
2.30.2

