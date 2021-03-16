Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8547533D439
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhCPMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233026AbhCPMtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39894139F;
        Tue, 16 Mar 2021 05:49:31 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29B9B3F792;
        Tue, 16 Mar 2021 05:49:29 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 07/38] firmware: arm_scmi: convert events registration to protocol handles
Date:   Tue, 16 Mar 2021 12:48:32 +0000
Message-Id: <20210316124903.35011-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert refactored events registration routines to use protocol handles.

In order to maintain bisectability and to allow protocols and drivers
to be later ported to the new protocol handle interface one by one,
introduce here also some transient code and typing that will be removed
later in order to ease such transition.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
In particular void* argument typing will be reverted later on once all
the protocols have been ported.

v6 --> v7
- reworks to fit into refactored scmi_get_protocol_instance()
---
 drivers/firmware/arm_scmi/base.c    |  4 ++--
 drivers/firmware/arm_scmi/driver.c  |  1 +
 drivers/firmware/arm_scmi/notify.c  | 13 +++++++++----
 drivers/firmware/arm_scmi/notify.h  |  7 ++++---
 drivers/firmware/arm_scmi/perf.c    |  9 +++++----
 drivers/firmware/arm_scmi/power.c   |  9 +++++----
 drivers/firmware/arm_scmi/reset.c   |  9 +++++----
 drivers/firmware/arm_scmi/sensors.c | 12 +++++++-----
 drivers/firmware/arm_scmi/system.c  |  4 ++--
 9 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 34c8a29ede0c..6a5cdef197d0 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -262,7 +262,7 @@ static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
 	return ret;
 }
 
-static int scmi_base_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_base_set_notify_enabled(const void *handle,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -274,7 +274,7 @@ static int scmi_base_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_base_fill_custom_report(const void *handle,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2357b93732ae..568b3f963e15 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -641,6 +641,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	 */
 	if (pi->proto->events) {
 		ret = scmi_register_protocol_events(handle, pi->proto->id,
+						    &pi->ph,
 						    pi->proto->events);
 		if (ret)
 			dev_warn(handle->dev,
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index cbb2b004eb60..023c93deb14b 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -178,7 +178,7 @@
 #define REVT_NOTIFY_SET_STATUS(revt, eid, sid, state)		\
 ({								\
 	typeof(revt) r = revt;					\
-	r->proto->ops->set_notify_enabled(r->proto->ni->handle,	\
+	r->proto->ops->set_notify_enabled(r->proto->ph,		\
 					(eid), (sid), (state));	\
 })
 
@@ -191,7 +191,7 @@
 #define REVT_FILL_REPORT(revt, ...)				\
 ({								\
 	typeof(revt) r = revt;					\
-	r->proto->ops->fill_custom_report(r->proto->ni->handle,	\
+	r->proto->ops->fill_custom_report(r->proto->ph,		\
 					  __VA_ARGS__);		\
 })
 
@@ -279,6 +279,7 @@ struct scmi_registered_event;
  *		       events' descriptors, whose fixed-size is determined at
  *		       compile time.
  * @registered_mtx: A mutex to protect @registered_events_handlers
+ * @ph: SCMI protocol handle reference
  * @registered_events_handlers: An hashtable containing all events' handlers
  *				descriptors registered for this protocol
  *
@@ -303,6 +304,7 @@ struct scmi_registered_events_desc {
 	struct scmi_registered_event	**registered_events;
 	/* mutex to protect registered_events_handlers */
 	struct mutex			registered_mtx;
+	const struct scmi_protocol_handle	*ph;
 	DECLARE_HASHTABLE(registered_events_handlers, SCMI_REGISTERED_HASH_SZ);
 };
 
@@ -735,6 +737,7 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
  * @handle: The handle identifying the platform instance against which the
  *	    protocol's events are registered
  * @proto_id: Protocol ID
+ * @ph: SCMI protocol handle.
  * @ee: A structure describing the events supported by this protocol.
  *
  * Used by SCMI Protocols initialization code to register with the notification
@@ -745,6 +748,7 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
  * Return: 0 on Success
  */
 int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee)
 {
 	int i;
@@ -754,7 +758,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	struct scmi_notify_instance *ni;
 	const struct scmi_event *evt;
 
-	if (!ee || !ee->ops || !ee->evts ||
+	if (!ee || !ee->ops || !ee->evts || !ph ||
 	    (!ee->num_sources && !ee->ops->get_num_sources))
 		return -EINVAL;
 
@@ -768,7 +772,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	if (ee->num_sources) {
 		num_sources = ee->num_sources;
 	} else {
-		int nsrc = ee->ops->get_num_sources(handle);
+		int nsrc = ee->ops->get_num_sources(ph);
 
 		if (nsrc <= 0)
 			return -EINVAL;
@@ -786,6 +790,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	if (IS_ERR(pd))
 		return PTR_ERR(pd);
 
+	pd->ph = ph;
 	for (i = 0; i < ee->num_events; i++, evt++) {
 		struct scmi_registered_event *r_evt;
 
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 03500ca9cf56..97c0e3dd973b 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -50,10 +50,10 @@ struct scmi_protocol_handle;
  *	    process context.
  */
 struct scmi_event_ops {
-	int (*get_num_sources)(const struct scmi_handle *handle);
-	int (*set_notify_enabled)(const struct scmi_handle *handle,
+	int (*get_num_sources)(const void *handle);
+	int (*set_notify_enabled)(const void *handle,
 				  u8 evt_id, u32 src_id, bool enabled);
-	void *(*fill_custom_report)(const struct scmi_handle *handle,
+	void *(*fill_custom_report)(const void *handle,
 				    u8 evt_id, ktime_t timestamp,
 				    const void *payld, size_t payld_sz,
 				    void *report, u32 *src_id);
@@ -82,6 +82,7 @@ void scmi_notification_exit(struct scmi_handle *handle);
 
 struct scmi_protocol_handle;
 int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee);
 void scmi_deregister_protocol_events(const struct scmi_handle *handle,
 				     u8 proto_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 80af823af8ec..6e37a6ebfcd8 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -772,7 +772,7 @@ static const struct scmi_perf_ops perf_ops = {
 	.power_scale_mw_get = scmi_power_scale_mw_get,
 };
 
-static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_perf_set_notify_enabled(const void *handle,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret, cmd_id;
@@ -789,7 +789,7 @@ static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_perf_fill_custom_report(const void *handle,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -837,9 +837,10 @@ static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
 	return rep;
 }
 
-static int scmi_perf_get_num_sources(const struct scmi_handle *handle)
+static int scmi_perf_get_num_sources(const void *handle)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		((const struct scmi_handle *)(handle))->perf_priv;
 
 	if (!pi)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 1cfd10dc18a5..5f43c45ebc13 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -213,7 +213,7 @@ static int scmi_power_request_notify(const struct scmi_handle *handle,
 	return ret;
 }
 
-static int scmi_power_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_power_set_notify_enabled(const void *handle,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -226,7 +226,7 @@ static int scmi_power_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_power_fill_custom_report(const void *handle,
 					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
@@ -246,9 +246,10 @@ static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
-static int scmi_power_get_num_sources(const struct scmi_handle *handle)
+static int scmi_power_get_num_sources(const void *handle)
 {
-	struct scmi_power_info *pinfo = handle->power_priv;
+	struct scmi_power_info *pinfo =
+		((const struct scmi_handle *)(handle))->power_priv;
 
 	if (!pinfo)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 06fecf044153..572dc1fdcede 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -224,7 +224,7 @@ static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
 	return ret;
 }
 
-static int scmi_reset_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_reset_set_notify_enabled(const void *handle,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -237,7 +237,7 @@ static int scmi_reset_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_reset_fill_custom_report(const void *handle,
 					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
@@ -257,9 +257,10 @@ static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
-static int scmi_reset_get_num_sources(const struct scmi_handle *handle)
+static int scmi_reset_get_num_sources(const void *handle)
 {
-	struct scmi_reset_info *pinfo = handle->reset_priv;
+	struct scmi_reset_info *pinfo =
+		((const struct scmi_handle *)(handle))->reset_priv;
 
 	if (!pinfo)
 		return -EINVAL;
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 03b7a274ee80..e40e49869a5d 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -835,7 +835,7 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.config_set = scmi_sensor_config_set,
 };
 
-static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_sensor_set_notify_enabled(const void *handle,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -860,7 +860,7 @@ static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_sensor_fill_custom_report(const void *handle,
 					    u8 evt_id, ktime_t timestamp,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
@@ -890,7 +890,8 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 		struct scmi_sensor_info *s;
 		const struct scmi_sensor_update_notify_payld *p = payld;
 		struct scmi_sensor_update_report *r = report;
-		struct sensors_info *sinfo = handle->sensor_priv;
+		struct sensors_info *sinfo =
+			((const struct scmi_handle *)(handle))->sensor_priv;
 
 		/* payld_sz is variable for this event */
 		r->sensor_id = le32_to_cpu(p->sensor_id);
@@ -920,9 +921,10 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 	return rep;
 }
 
-static int scmi_sensor_get_num_sources(const struct scmi_handle *handle)
+static int scmi_sensor_get_num_sources(const void *handle)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si =
+		((const struct scmi_handle *)(handle))->sensor_priv;
 
 	return si->num_sensors;
 }
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index e1ee6327f761..9d016dff4be5 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -53,7 +53,7 @@ static int scmi_system_request_notify(const struct scmi_handle *handle,
 	return ret;
 }
 
-static int scmi_system_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_system_set_notify_enabled(const void *handle,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
@@ -65,7 +65,7 @@ static int scmi_system_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_system_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_system_fill_custom_report(const void *handle,
 					    u8 evt_id, ktime_t timestamp,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
-- 
2.17.1

