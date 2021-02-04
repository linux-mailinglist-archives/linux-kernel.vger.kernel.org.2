Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAA30CECA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhBBW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:26:19 -0500
Received: from foss.arm.com ([217.140.110.172]:58686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhBBWTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:19:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FC3315A1;
        Tue,  2 Feb 2021 14:17:32 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72BB83F694;
        Tue,  2 Feb 2021 14:17:30 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v6 26/37] firmware: arm_scmi: remove legacy scmi_sensor_ops protocol interface
Date:   Tue,  2 Feb 2021 22:15:44 +0000
Message-Id: <20210202221555.41167-27-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202221555.41167-1-cristian.marussi@arm.com>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the SCMI driver users have been migrated to the new interface
remove the legacy interface and all the transient code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 82 -----------------------------
 include/linux/scmi_protocol.h       | 19 -------
 2 files changed, 101 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 5d2da4f78108..478585f644fa 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -624,17 +624,6 @@ scmi_sensor_trip_point_config(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int
-__scmi_sensor_trip_point_config(const struct scmi_handle *handle,
-				u32 sensor_id, u8 trip_id, u64 trip_value)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_trip_point_config(ph, sensor_id, trip_id,
-					     trip_value);
-}
-
 static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 				  u32 sensor_id, u32 *sensor_config)
 {
@@ -660,15 +649,6 @@ static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_sensor_config_get(const struct scmi_handle *handle,
-				    u32 sensor_id, u32 *sensor_config)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_config_get(ph, sensor_id, sensor_config);
-}
-
 static int scmi_sensor_config_set(const struct scmi_protocol_handle *ph,
 				  u32 sensor_id, u32 sensor_config)
 {
@@ -697,15 +677,6 @@ static int scmi_sensor_config_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_sensor_config_set(const struct scmi_handle *handle,
-				    u32 sensor_id, u32 sensor_config)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_config_set(ph, sensor_id, sensor_config);
-}
-
 /**
  * scmi_sensor_reading_get  - Read scalar sensor value
  * @ph: Protocol handle
@@ -760,15 +731,6 @@ static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_sensor_reading_get(const struct scmi_handle *handle,
-				     u32 sensor_id, u64 *value)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_reading_get(ph, sensor_id, value);
-}
-
 static inline void
 scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
 			   const struct scmi_sensor_reading_resp *in)
@@ -847,18 +809,6 @@ scmi_sensor_reading_get_timestamped(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int
-__scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
-				      u32 sensor_id, u8 count,
-				      struct scmi_sensor_reading *readings)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_reading_get_timestamped(ph, sensor_id, count,
-						   readings);
-}
-
 static const struct scmi_sensor_info *
 scmi_sensor_info_get(const struct scmi_protocol_handle *ph, u32 sensor_id)
 {
@@ -867,15 +817,6 @@ scmi_sensor_info_get(const struct scmi_protocol_handle *ph, u32 sensor_id)
 	return si->sensors + sensor_id;
 }
 
-static const struct scmi_sensor_info *
-__scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_info_get(ph, sensor_id);
-}
-
 static int scmi_sensor_count_get(const struct scmi_protocol_handle *ph)
 {
 	struct sensors_info *si = ph->get_priv(ph);
@@ -883,24 +824,6 @@ static int scmi_sensor_count_get(const struct scmi_protocol_handle *ph)
 	return si->num_sensors;
 }
 
-static int __scmi_sensor_count_get(const struct scmi_handle *handle)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
-
-	return scmi_sensor_count_get(ph);
-}
-
-static const struct scmi_sensor_ops sensor_ops = {
-	.count_get = __scmi_sensor_count_get,
-	.info_get = __scmi_sensor_info_get,
-	.trip_point_config = __scmi_sensor_trip_point_config,
-	.reading_get = __scmi_sensor_reading_get,
-	.reading_get_timestamped = __scmi_sensor_reading_get_timestamped,
-	.config_get = __scmi_sensor_config_get,
-	.config_set = __scmi_sensor_config_set,
-};
-
 static const struct scmi_sensor_proto_ops sensor_proto_ops = {
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
@@ -1040,7 +963,6 @@ static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 	u32 version;
 	int ret;
 	struct sensors_info *sinfo;
-	struct scmi_handle *handle;
 
 	ph->xops->version_get(ph, &version);
 
@@ -1064,10 +986,6 @@ static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->sensor_ops = &sensor_ops;
-
 	return ph->set_priv(ph, sinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 976227a0be01..5a4d3fddfd1d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -463,23 +463,6 @@ struct scmi_sensor_proto_ops {
 			  u32 sensor_id, u32 sensor_config);
 };
 
-struct scmi_sensor_ops {
-	int (*count_get)(const struct scmi_handle *handle);
-	const struct scmi_sensor_info *(*info_get)
-		(const struct scmi_handle *handle, u32 sensor_id);
-	int (*trip_point_config)(const struct scmi_handle *handle,
-				 u32 sensor_id, u8 trip_id, u64 trip_value);
-	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
-			   u64 *value);
-	int (*reading_get_timestamped)(const struct scmi_handle *handle,
-				       u32 sensor_id, u8 count,
-				       struct scmi_sensor_reading *readings);
-	int (*config_get)(const struct scmi_handle *handle,
-			  u32 sensor_id, u32 *sensor_config);
-	int (*config_set)(const struct scmi_handle *handle,
-			  u32 sensor_id, u32 sensor_config);
-};
-
 /**
  * struct scmi_reset_proto_ops - represents the various operations provided
  *	by SCMI Reset Protocol
@@ -619,7 +602,6 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
- * @sensor_ops: pointer to set of sensor protocol operations
  * @voltage_ops: pointer to set of voltage protocol operations
  * @devm_acquire_protocol: devres managed method to get hold of a protocol,
  *			   causing its initialization and related resource
@@ -639,7 +621,6 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_voltage_ops *voltage_ops;
 
 	int __must_check (*devm_acquire_protocol)(struct scmi_device *sdev,
-- 
2.17.1

