Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7CB33D44D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCPMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:52:47 -0400
Received: from foss.arm.com ([217.140.110.172]:37928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233167AbhCPMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0CC51529;
        Tue, 16 Mar 2021 05:50:11 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5BC53F792;
        Tue, 16 Mar 2021 05:50:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v7 24/38] hwmon: (scmi) port driver to the new scmi_sensor_proto_ops interface
Date:   Tue, 16 Mar 2021 12:48:49 +0000
Message-Id: <20210316124903.35011-25-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Sensor interface based on protocol handles
and common devm_get_ops().

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 -> v7
- fixed Copyright
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
v4 --> v5
- using renamed devm_get/put_protocol
---
 drivers/hwmon/scmi-hwmon.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 17d064e58938..b1329a58ce40 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface(SCMI) based hwmon sensor driver
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2021 ARM Ltd.
  * Sudeep Holla <sudeep.holla@arm.com>
  */
 
@@ -13,8 +13,10 @@
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
 
+static const struct scmi_sensor_proto_ops *sensor_ops;
+
 struct scmi_sensors {
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
@@ -69,10 +71,9 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	u64 value;
 	const struct scmi_sensor_info *sensor;
 	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
-	const struct scmi_handle *h = scmi_sensors->handle;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
+	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
 	if (ret)
 		return ret;
 
@@ -169,11 +170,16 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	struct hwmon_channel_info *scmi_hwmon_chan;
 	const struct hwmon_channel_info **ptr_scmi_ci;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->sensor_ops)
+	if (!handle)
 		return -ENODEV;
 
-	nr_sensors = handle->sensor_ops->count_get(handle);
+	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
+	if (IS_ERR(sensor_ops))
+		return PTR_ERR(sensor_ops);
+
+	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors)
 		return -EIO;
 
@@ -181,10 +187,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	if (!scmi_sensors)
 		return -ENOMEM;
 
-	scmi_sensors->handle = handle;
+	scmi_sensors->ph = ph;
 
 	for (i = 0; i < nr_sensors; i++) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(ph, i);
 		if (!sensor)
 			return -EINVAL;
 
@@ -236,7 +242,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	}
 
 	for (i = nr_sensors - 1; i >= 0 ; i--) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(ph, i);
 		if (!sensor)
 			continue;
 
-- 
2.17.1

