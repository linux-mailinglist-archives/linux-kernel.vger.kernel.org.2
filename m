Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70133D44E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhCPMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:52:54 -0400
Received: from foss.arm.com ([217.140.110.172]:37946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233215AbhCPMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73B0152D;
        Tue, 16 Mar 2021 05:50:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 804BB3F792;
        Tue, 16 Mar 2021 05:50:12 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v7 25/38] iio/scmi: port driver to the new scmi_sensor_proto_ops interface
Date:   Tue, 16 Mar 2021 12:48:50 +0000
Message-Id: <20210316124903.35011-26-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Sensor interface based on protocol handles
and common devm_get_ops().

Cc: Jyoti Bhayana <jbhayana@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 91 ++++++++++------------
 1 file changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 872d87ca6256..b4bdc3f3a946 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -21,8 +21,10 @@
 
 #define SCMI_IIO_NUM_OF_AXIS 3
 
+static const struct scmi_sensor_proto_ops *sensor_ops;
+
 struct scmi_iio_priv {
-	struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
 	const struct scmi_sensor_info *sensor_info;
 	struct iio_dev *indio_dev;
 	/* adding one additional channel for timestamp */
@@ -82,7 +84,6 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 {
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
-	u32 sensor_id = sensor->sensor_info->id;
 	u32 sensor_config = 0;
 	int err;
 
@@ -92,27 +93,11 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 
 	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
 				    SCMI_SENS_CFG_SENSOR_ENABLE);
-
-	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
-			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
-			&sensor_id, &sensor->sensor_update_nb);
-	if (err) {
-		dev_err(&iio_dev->dev,
-			"Error in registering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, err);
-		return err;
-	}
-
-	err = sensor->handle->sensor_ops->config_set(sensor->handle,
-			sensor->sensor_info->id, sensor_config);
-	if (err) {
-		sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
-				SCMI_PROTOCOL_SENSOR,
-				SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
-				&sensor->sensor_update_nb);
+	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
+				     sensor_config);
+	if (err)
 		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
 			sensor->sensor_info->name, err);
-	}
 
 	return err;
 }
@@ -120,25 +105,13 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
 {
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
-	u32 sensor_id = sensor->sensor_info->id;
 	u32 sensor_config = 0;
 	int err;
 
 	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
 				    SCMI_SENS_CFG_SENSOR_DISABLE);
-
-	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
-			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
-			&sensor_id, &sensor->sensor_update_nb);
-	if (err) {
-		dev_err(&iio_dev->dev,
-			"Error in unregistering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, err);
-		return err;
-	}
-
-	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
-						     sensor_config);
+	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
+				     sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in disabling sensor %s with err %d",
@@ -161,8 +134,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	u32 sensor_config;
 	char buf[32];
 
-	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
-			sensor->sensor_info->id, &sensor_config);
+	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
+					 &sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in getting sensor config for sensor %s err %d",
@@ -208,8 +181,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	sensor_config |=
 		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
 
-	err = sensor->handle->sensor_ops->config_set(sensor->handle,
-			sensor->sensor_info->id, sensor_config);
+	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
+				     sensor_config);
 	if (err)
 		dev_err(&iio_dev->dev,
 			"Error in setting sensor update interval for sensor %s value %u err %d",
@@ -274,8 +247,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	u32 sensor_config;
 	int mult;
 
-	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
-			sensor->sensor_info->id, &sensor_config);
+	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
+					 &sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in getting sensor config for sensor %s err %d",
@@ -542,15 +515,17 @@ static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
 	return 0;
 }
 
-static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
-					 struct scmi_handle *handle,
-					 const struct scmi_sensor_info *sensor_info)
+static struct iio_dev *
+scmi_alloc_iiodev(struct scmi_device *sdev, struct scmi_protocol_handle *ph,
+		  const struct scmi_sensor_info *sensor_info)
 {
 	struct iio_chan_spec *iio_channels;
 	struct scmi_iio_priv *sensor;
 	enum iio_modifier modifier;
 	enum iio_chan_type type;
 	struct iio_dev *iiodev;
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
 	int i, ret;
 
 	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
@@ -560,7 +535,7 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
 	iiodev->modes = INDIO_DIRECT_MODE;
 	iiodev->dev.parent = dev;
 	sensor = iio_priv(iiodev);
-	sensor->handle = handle;
+	sensor->ph = ph;
 	sensor->sensor_info = sensor_info;
 	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
 	sensor->indio_dev = iiodev;
@@ -595,6 +570,17 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
 					  sensor_info->axis[i].id);
 	}
 
+	ret = handle->notify_ops->devm_event_notifier_register(sdev,
+				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+				&sensor->sensor_info->id,
+				&sensor->sensor_update_nb);
+	if (ret) {
+		dev_err(&iiodev->dev,
+			"Error in registering sensor update notifier for sensor %s err %d",
+			sensor->sensor_info->name, ret);
+		return ERR_PTR(ret);
+	}
+
 	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
 	iiodev->channels = iio_channels;
 	return iiodev;
@@ -604,24 +590,29 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 {
 	const struct scmi_sensor_info *sensor_info;
 	struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 	struct device *dev = &sdev->dev;
 	struct iio_dev *scmi_iio_dev;
 	u16 nr_sensors;
 	int err = -ENODEV, i;
 
-	if (!handle || !handle->sensor_ops) {
+	if (!handle)
+		return -ENODEV;
+
+	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
+	if (IS_ERR(sensor_ops)) {
 		dev_err(dev, "SCMI device has no sensor interface\n");
-		return -EINVAL;
+		return PTR_ERR(sensor_ops);
 	}
 
-	nr_sensors = handle->sensor_ops->count_get(handle);
+	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors) {
 		dev_dbg(dev, "0 sensors found via SCMI bus\n");
 		return -ENODEV;
 	}
 
 	for (i = 0; i < nr_sensors; i++) {
-		sensor_info = handle->sensor_ops->info_get(handle, i);
+		sensor_info = sensor_ops->info_get(ph, i);
 		if (!sensor_info) {
 			dev_err(dev, "SCMI sensor %d has missing info\n", i);
 			return -EINVAL;
@@ -636,7 +627,7 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		    sensor_info->axis[0].type != RADIANS_SEC)
 			continue;
 
-		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
+		scmi_iio_dev = scmi_alloc_iiodev(sdev, ph, sensor_info);
 		if (IS_ERR(scmi_iio_dev)) {
 			dev_err(dev,
 				"failed to allocate IIO device for sensor %s: %ld\n",
-- 
2.17.1

