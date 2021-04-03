Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7321B3532D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhDCGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhDCGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 02:20:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FEC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 23:20:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s11so4844282pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P82zFEPVLjloJCBghkyeqygNmf39QVfUBEQdyGRPBwQ=;
        b=IHVkZtJ9LjWvFjwbnsT2SVG/T1svuk11ngGUdj1RZnys5mMea2cS792kHddRjHHitg
         lOu6vw3XM+32udOCuXloBx2FKbXvwW7SLAmokDBZPsVSJw7npup6qrLHAE78i4Tx/48M
         ASmXIcJQ779N62Brc+K22l6MK59BUaHmuxJ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P82zFEPVLjloJCBghkyeqygNmf39QVfUBEQdyGRPBwQ=;
        b=U0a/MnQNqtJxcgWugWYq4fnLSZDTAwsusms/Mi3nH/MGdrj2Fixgynf0lU9TwT+rPb
         GyejNUH7FHbQVSVew4nrzgtKaKpQ9s24JoMAhWfkZYGaNYpYwkrVzFy4yzMdD0nxvvQS
         Tpr4ZMkuOix3PvU6ER4h3eGt0OZ06dRUWoayZZ7GBp04Pt8lE6OlJfjLr/Qd9anZMkvY
         AZR5cSFMpPji/cKznFiHskQOj9th+Z9phxTOSVTnMppRP8l9e8ywlaa0jo8iEJfQ4KQm
         z26zD5kMAfHW3l2QrchMd8wOPiScfKO7cfcdxuJXVh/Ez0rM2S2qg7iBAZvZsi9sNQfL
         kusQ==
X-Gm-Message-State: AOAM531J5h6pbNx9pQJjQgjtAyAMqJkOhl/H/WRy6pzU15zZGf7GRK5/
        Mu5UScvqy2cQO/42QrUc5P5XIw==
X-Google-Smtp-Source: ABdhPJyf0QS+29adjYl0uILALc4Emw0cZu9QrzyGoKebLa83rZeosHM1suZLSn9K2T9A85AGoIYeDw==
X-Received: by 2002:a62:7a09:0:b029:1f1:5cf4:3fd7 with SMTP id v9-20020a627a090000b02901f15cf43fd7mr14771041pfc.66.1617430836279;
        Fri, 02 Apr 2021 23:20:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:298f:23e5:11f:e743])
        by smtp.gmail.com with UTF8SMTPSA id d5sm9300387pjo.12.2021.04.02.23.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 23:20:35 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        stable@vger.kernel.org
Subject: [PATCH] platform/chrome: Update cros_ec sysfs attributes on sensors discovery
Date:   Fri,  2 Apr 2021 23:20:31 -0700
Message-Id: <20210403062031.1820582-1-gwendal@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cros_ec_sysfs probe is called before cros_ec_sensorhub probe
routine, the |kb_wake_angle| attribute will not be displayed, even if
there are two accelerometers in the chromebook.

Call sysfs_update_group() when accelerometers are enumerated if the
cros_ec sysfs attributes group has already been created.

Fixes: d60ac88a62df ("mfd / platform / iio: cros_ec: Register sensor through sensorhub")
Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/platform/chrome/cros_ec_sensorhub.c | 5 ++++-
 drivers/platform/chrome/cros_ec_sysfs.c     | 2 ++
 include/linux/platform_data/cros_ec_proto.h | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 9c4af76a9956e..78085ad362ca8 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -106,8 +106,11 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		sensor_type[sensorhub->resp->info.type]++;
 	}
 
-	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
 		ec->has_kb_wake_angle = true;
+		if (ec->group)
+			sysfs_update_group(&ec->class_dev.kobj, ec->group);
+	}
 
 	if (cros_ec_check_features(ec,
 				   EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f07eabcf9494c..3838d5f51aadc 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -344,6 +344,8 @@ static int cros_ec_sysfs_probe(struct platform_device *pd)
 	ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
 	if (ret < 0)
 		dev_err(dev, "failed to create attributes. err=%d\n", ret);
+	else
+		ec_dev->group = &cros_ec_attr_group;
 
 	return ret;
 }
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 02599687770c5..4cd06f68bc536 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -191,6 +191,7 @@ struct cros_ec_platform {
 /**
  * struct cros_ec_dev - ChromeOS EC device entry point.
  * @class_dev: Device structure used in sysfs.
+ * @group: sysfs attributes group for this EC.
  * @ec_dev: cros_ec_device structure to talk to the physical device.
  * @dev: Pointer to the platform device.
  * @debug_info: cros_ec_debugfs structure for debugging information.
@@ -200,6 +201,7 @@ struct cros_ec_platform {
  */
 struct cros_ec_dev {
 	struct device class_dev;
+	struct attribute_group *group;
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
-- 
2.31.0.208.g409f899ff0-goog

