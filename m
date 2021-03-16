Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9222333D463
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhCPMyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:54:53 -0400
Received: from foss.arm.com ([217.140.110.172]:38096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhCPMuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63DC91682;
        Tue, 16 Mar 2021 05:50:35 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1343F792;
        Tue, 16 Mar 2021 05:50:33 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 34/38] firmware: arm_scmi: cleanup events registration transient code
Date:   Tue, 16 Mar 2021 12:48:59 +0000
Message-Id: <20210316124903.35011-35-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all the events registration code used to ease the transition to the
new interface based on protocol handles..

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  4 ++--
 drivers/firmware/arm_scmi/notify.h  |  6 +++---
 drivers/firmware/arm_scmi/perf.c    |  9 ++++-----
 drivers/firmware/arm_scmi/power.c   | 16 ++++++++--------
 drivers/firmware/arm_scmi/reset.c   | 16 ++++++++--------
 drivers/firmware/arm_scmi/sensors.c | 19 +++++++++----------
 drivers/firmware/arm_scmi/system.c  | 11 ++++++-----
 7 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index b5b6bd08132e..0d28f0f825b6 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -264,7 +264,7 @@ static int scmi_base_error_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_base_set_notify_enabled(const void *ph,
+static int scmi_base_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -276,7 +276,7 @@ static int scmi_base_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_base_fill_custom_report(const void *ph,
+static void *scmi_base_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 97c0e3dd973b..ce0324be6c71 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -50,10 +50,10 @@ struct scmi_protocol_handle;
  *	    process context.
  */
 struct scmi_event_ops {
-	int (*get_num_sources)(const void *handle);
-	int (*set_notify_enabled)(const void *handle,
+	int (*get_num_sources)(const struct scmi_protocol_handle *ph);
+	int (*set_notify_enabled)(const struct scmi_protocol_handle *ph,
 				  u8 evt_id, u32 src_id, bool enabled);
-	void *(*fill_custom_report)(const void *handle,
+	void *(*fill_custom_report)(const struct scmi_protocol_handle *ph,
 				    u8 evt_id, ktime_t timestamp,
 				    const void *payld, size_t payld_sz,
 				    void *report, u32 *src_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9770821c4819..059d6214f93b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -769,7 +769,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.power_scale_mw_get = scmi_power_scale_mw_get,
 };
 
-static int scmi_perf_set_notify_enabled(const void *ph,
+static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret, cmd_id;
@@ -786,7 +786,7 @@ static int scmi_perf_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_perf_fill_custom_report(const void *ph,
+static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -834,10 +834,9 @@ static void *scmi_perf_fill_custom_report(const void *ph,
 	return rep;
 }
 
-static int scmi_perf_get_num_sources(const void *ph)
+static int scmi_perf_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_perf_info *pi =
-		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	if (!pi)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index ecdf49abd981..e0987f0a8fb2 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -211,7 +211,7 @@ static int scmi_power_request_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_power_set_notify_enabled(const void *ph,
+static int scmi_power_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -224,10 +224,11 @@ static int scmi_power_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_power_fill_custom_report(const void *ph,
-					   u8 evt_id, ktime_t timestamp,
-					   const void *payld, size_t payld_sz,
-					   void *report, u32 *src_id)
+static void *
+scmi_power_fill_custom_report(const struct scmi_protocol_handle *ph,
+			      u8 evt_id, ktime_t timestamp,
+			      const void *payld, size_t payld_sz,
+			      void *report, u32 *src_id)
 {
 	const struct scmi_power_state_notify_payld *p = payld;
 	struct scmi_power_state_changed_report *r = report;
@@ -244,10 +245,9 @@ static void *scmi_power_fill_custom_report(const void *ph,
 	return r;
 }
 
-static int scmi_power_get_num_sources(const void *ph)
+static int scmi_power_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_power_info *pinfo =
-		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
+	struct scmi_power_info *pinfo = ph->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 7ea1286bfed6..48b487302db8 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -225,7 +225,7 @@ static int scmi_reset_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_reset_set_notify_enabled(const void *ph,
+static int scmi_reset_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -238,10 +238,11 @@ static int scmi_reset_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_reset_fill_custom_report(const void *ph,
-					   u8 evt_id, ktime_t timestamp,
-					   const void *payld, size_t payld_sz,
-					   void *report, u32 *src_id)
+static void *
+scmi_reset_fill_custom_report(const struct scmi_protocol_handle *ph,
+			      u8 evt_id, ktime_t timestamp,
+			      const void *payld, size_t payld_sz,
+			      void *report, u32 *src_id)
 {
 	const struct scmi_reset_issued_notify_payld *p = payld;
 	struct scmi_reset_issued_report *r = report;
@@ -258,10 +259,9 @@ static void *scmi_reset_fill_custom_report(const void *ph,
 	return r;
 }
 
-static int scmi_reset_get_num_sources(const void *ph)
+static int scmi_reset_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_reset_info *pinfo =
-		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
+	struct scmi_reset_info *pinfo = ph->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 2f5b06135468..935c4b08829d 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -834,7 +834,7 @@ static const struct scmi_sensor_proto_ops sensor_proto_ops = {
 	.config_set = scmi_sensor_config_set,
 };
 
-static int scmi_sensor_set_notify_enabled(const void *ph,
+static int scmi_sensor_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -858,10 +858,11 @@ static int scmi_sensor_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_sensor_fill_custom_report(const void *ph,
-					    u8 evt_id, ktime_t timestamp,
-					    const void *payld, size_t payld_sz,
-					    void *report, u32 *src_id)
+static void *
+scmi_sensor_fill_custom_report(const struct scmi_protocol_handle *ph,
+			       u8 evt_id, ktime_t timestamp,
+			       const void *payld, size_t payld_sz,
+			       void *report, u32 *src_id)
 {
 	void *rep = NULL;
 
@@ -888,8 +889,7 @@ static void *scmi_sensor_fill_custom_report(const void *ph,
 		struct scmi_sensor_info *s;
 		const struct scmi_sensor_update_notify_payld *p = payld;
 		struct scmi_sensor_update_report *r = report;
-		struct sensors_info *sinfo =
-			((const struct scmi_protocol_handle *)ph)->get_priv(ph);
+		struct sensors_info *sinfo = ph->get_priv(ph);
 
 		/* payld_sz is variable for this event */
 		r->sensor_id = le32_to_cpu(p->sensor_id);
@@ -919,10 +919,9 @@ static void *scmi_sensor_fill_custom_report(const void *ph,
 	return rep;
 }
 
-static int scmi_sensor_get_num_sources(const void *ph)
+static int scmi_sensor_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct sensors_info *si =
-		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->num_sensors;
 }
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index ca6fb4698963..3631a9f94d27 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -53,7 +53,7 @@ static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_system_set_notify_enabled(const void *ph,
+static int scmi_system_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -65,10 +65,11 @@ static int scmi_system_set_notify_enabled(const void *ph,
 	return ret;
 }
 
-static void *scmi_system_fill_custom_report(const void *ph,
-					    u8 evt_id, ktime_t timestamp,
-					    const void *payld, size_t payld_sz,
-					    void *report, u32 *src_id)
+static void *
+scmi_system_fill_custom_report(const struct scmi_protocol_handle *ph,
+			       u8 evt_id, ktime_t timestamp,
+			       const void *payld, size_t payld_sz,
+			       void *report, u32 *src_id)
 {
 	const struct scmi_system_power_state_notifier_payld *p = payld;
 	struct scmi_system_power_state_notifier_report *r = report;
-- 
2.17.1

