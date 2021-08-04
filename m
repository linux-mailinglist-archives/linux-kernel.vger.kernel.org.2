Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0C3E0A07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhHDVcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhHDVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:32:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67FC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:31:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso5532150pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wx54QOXu07IZylthDG8/13hnCAXGli7P94vLKKXZBkk=;
        b=Zz5fYTs+FGQWlYs47LipWwpRJ/AFZiii3Qmvc/pVC8fmvFMkgTtipCQBl0gYS7H94A
         v52ITZyqy/H0xle9rTWxGVSXZ+Tt6ymU+Vf7OZ11Y7fzQ+zvCu2QuDS9l8My1o2CpH+V
         jeCIhGSUnYpPu9FT9jCmfGHE1hATULIch7mE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wx54QOXu07IZylthDG8/13hnCAXGli7P94vLKKXZBkk=;
        b=QIf+Lxg31i8yP2LAf75q+wi/IfasDFgGZZlCo2NxLOhlFbx6CtTZignLx5jih5O4kV
         Rgysse8Tl5yGn+rte1ZbA7+FIynIX/G5kT2S85JYcP8kqHAcrNCiJF6eRDnnnfqZ72Hz
         a5XJiHHG4S5G5KaSztepvhc0hMGa13yFDW4I8JVbunnuS6Co95UbVzsBMBac3Fp+qfDK
         zfqU7JefO/q8Qgy/CIwL/zViRXxQhrfSngP+dAPyNHjhwB0XacWVdIgxcDRpI1HfaMO8
         7IBga4Ipq9HnXNxUc+xZHUm8wlEP/Ks6RCMzoSBckR/nQGpzL97iuqtIFf8R+1NBUw2+
         k/dw==
X-Gm-Message-State: AOAM53180EYk73WREFoGDy0UAHuYlhT1tyhAyQ9BShlLVOkCkW2u4Zp9
        96TNRtbsXDkcYlf87DcEFxFv7Q==
X-Google-Smtp-Source: ABdhPJzOZ+Lic2jOkb6BfgIqvnUuV7qrK5ctsa52oB24wD9+jtWIo//4s7LLz6znxnj8UDTYgWb8Pg==
X-Received: by 2002:a17:902:e80a:b029:12c:58eb:1c8f with SMTP id u10-20020a170902e80ab029012c58eb1c8fmr1312739plg.59.1628112706360;
        Wed, 04 Aug 2021 14:31:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1bbb:ae51:b1f4:49bc])
        by smtp.gmail.com with UTF8SMTPSA id g1sm4018358pfo.0.2021.08.04.14.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 14:31:46 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dtor@chromium.org, jwerner@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/1] platform/chrome: Poke kb_wake_angle attribute visibility when needed
Date:   Wed,  4 Aug 2021 14:31:39 -0700
Message-Id: <20210804213139.4139492-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210804213139.4139492-1-gwendal@chromium.org>
References: <20210804213139.4139492-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the sensorhub detects 2 accelerometers, kb_wake_angle attribute
in the chromeos EC class device needs to be visible.
When detected, the sensorhub requests the class device to
revisit the visibility of the kb_wake_angle attribute.
Expose the attribute group to alter to close a potiential race between
cros-ec-sensorhub and cros-ec-sysfs (that creates the attribute group
on behalf of the class driver).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_sensorhub.c | 6 +++++-
 drivers/platform/chrome/cros_ec_sysfs.c     | 5 +++--
 include/linux/platform_data/cros_ec_proto.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 9c4af76a9956e..8f24ed90b229c 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -106,8 +106,12 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		sensor_type[sensorhub->resp->info.type]++;
 	}
 
-	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
 		ec->has_kb_wake_angle = true;
+		if (ec->group && sysfs_update_group(&ec->class_dev.kobj,
+						    ec->group))
+			dev_warn(dev, "Unable to update cros-ec-sysfs");
+	}
 
 	if (cros_ec_check_features(ec,
 				   EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f07eabcf9494c..17fe657f3ffd5 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -341,7 +341,8 @@ static int cros_ec_sysfs_probe(struct platform_device *pd)
 	struct device *dev = &pd->dev;
 	int ret;
 
-	ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
+	ec_dev->group = &cros_ec_attr_group;
+	ret = sysfs_create_group(&ec_dev->class_dev.kobj, ec_dev->group);
 	if (ret < 0)
 		dev_err(dev, "failed to create attributes. err=%d\n", ret);
 
@@ -352,7 +353,7 @@ static int cros_ec_sysfs_remove(struct platform_device *pd)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
 
-	sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
+	sysfs_remove_group(&ec_dev->class_dev.kobj, ec_dev->group);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 02599687770c5..c6dca260bbd5d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -191,6 +191,7 @@ struct cros_ec_platform {
 /**
  * struct cros_ec_dev - ChromeOS EC device entry point.
  * @class_dev: Device structure used in sysfs.
+ * @groups: sysfs attributes groups for this EC.
  * @ec_dev: cros_ec_device structure to talk to the physical device.
  * @dev: Pointer to the platform device.
  * @debug_info: cros_ec_debugfs structure for debugging information.
@@ -200,6 +201,7 @@ struct cros_ec_platform {
  */
 struct cros_ec_dev {
 	struct device class_dev;
+	const struct attribute_group *group;
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
-- 
2.32.0.554.ge1b32706d8-goog

