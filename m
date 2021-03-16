Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFA33D438
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhCPMui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:38 -0400
Received: from foss.arm.com ([217.140.110.172]:37692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhCPMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:49:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E41151396;
        Tue, 16 Mar 2021 05:49:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E10303F792;
        Tue, 16 Mar 2021 05:49:26 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 06/38] firmware: arm_scmi: refactor events registration
Date:   Tue, 16 Mar 2021 12:48:31 +0000
Message-Id: <20210316124903.35011-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new refactored protocol events registration helper and invoke it
from the centralized initialization process triggered by get_ops() and
friends.

Add a .get_num_sources as a new optional callback amongst protocol events
operations; finally remove events registration call-sites from within the
legacy protocol init routines.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- reworks to fit into refactored scmi_get_protocol_instance()
- check, warn and ignore scmi_register_protocol_events errors
- fixed Copyright
---
 drivers/firmware/arm_scmi/base.c    | 15 +++--
 drivers/firmware/arm_scmi/common.h  |  2 +
 drivers/firmware/arm_scmi/driver.c  | 16 ++++++
 drivers/firmware/arm_scmi/notify.c  | 88 ++++++++++++++++++-----------
 drivers/firmware/arm_scmi/notify.h  | 35 ++++++++++--
 drivers/firmware/arm_scmi/perf.c    | 25 ++++++--
 drivers/firmware/arm_scmi/power.c   | 25 ++++++--
 drivers/firmware/arm_scmi/reset.c   | 25 ++++++--
 drivers/firmware/arm_scmi/sensors.c | 22 ++++++--
 drivers/firmware/arm_scmi/system.c  | 16 +++---
 10 files changed, 194 insertions(+), 75 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index b0e16bea614a..34c8a29ede0c 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -318,6 +318,14 @@ static const struct scmi_event_ops base_event_ops = {
 	.fill_custom_report = scmi_base_fill_custom_report,
 };
 
+static const struct scmi_protocol_events base_protocol_events = {
+	.queue_sz = 4 * SCMI_PROTO_QUEUE_SZ,
+	.ops = &base_event_ops,
+	.evts = base_events,
+	.num_events = ARRAY_SIZE(base_events),
+	.num_sources = SCMI_BASE_NUM_SOURCES,
+};
+
 int scmi_base_protocol_init(struct scmi_handle *h)
 {
 	int id, ret;
@@ -352,12 +360,6 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 	dev_dbg(dev, "Found %d protocol(s) %d agent(s)\n", rev->num_protocols,
 		rev->num_agents);
 
-	scmi_register_protocol_events(handle, SCMI_PROTOCOL_BASE,
-				      (4 * SCMI_PROTO_QUEUE_SZ),
-				      &base_event_ops, base_events,
-				      ARRAY_SIZE(base_events),
-				      SCMI_BASE_NUM_SOURCES);
-
 	for (id = 0; id < rev->num_agents; id++) {
 		scmi_base_discover_agent_get(handle, id, name);
 		dev_dbg(dev, "Agent %d: %s\n", id, name);
@@ -370,6 +372,7 @@ static const struct scmi_protocol scmi_base = {
 	.id = SCMI_PROTOCOL_BASE,
 	.init = &scmi_base_protocol_init,
 	.ops = NULL,
+	.events = &base_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index e90ab458b08e..9478b8240589 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -226,6 +226,7 @@ typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
  * @instance_deinit: Optional protocol de-initialization function.
  * @ops: Optional reference to the operations provided by the protocol and
  *	 exposed in scmi_protocol.h.
+ * @events: An optional reference to the events supported by this protocol.
  */
 struct scmi_protocol {
 	const u8				id;
@@ -233,6 +234,7 @@ struct scmi_protocol {
 	const scmi_prot_init_fn_t		instance_init;
 	const scmi_prot_init_fn_t		instance_deinit;
 	const void				*ops;
+	const struct scmi_protocol_events	*events;
 };
 
 int __init scmi_bus_init(void);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5a960a7fd973..2357b93732ae 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -635,6 +635,19 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	if (ret != proto->id)
 		goto clean;
 
+	/*
+	 * Warn but ignore events registration errors since we do not want
+	 * to skip whole protocols if their notifications are messed up.
+	 */
+	if (pi->proto->events) {
+		ret = scmi_register_protocol_events(handle, pi->proto->id,
+						    pi->proto->events);
+		if (ret)
+			dev_warn(handle->dev,
+				 "Protocol:%X - Events Registration Failed - err:%d\n",
+				 pi->proto->id, ret);
+	}
+
 	devres_close_group(handle->dev, pi->gid);
 	dev_dbg(handle->dev, "Initialized protocol: 0x%X\n", pi->proto->id);
 
@@ -719,6 +732,9 @@ void scmi_protocol_release(struct scmi_handle *handle, u8 protocol_id)
 	if (refcount_dec_and_test(&pi->users)) {
 		void *gid = pi->gid;
 
+		if (pi->proto->events)
+			scmi_deregister_protocol_events(handle, protocol_id);
+
 		if (pi->proto->instance_deinit)
 			pi->proto->instance_deinit(handle);
 
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 9dd729ac9fe2..cbb2b004eb60 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Notification support
  *
- * Copyright (C) 2020 ARM Ltd.
+ * Copyright (C) 2020-2021 ARM Ltd.
  */
 /**
  * DOC: Theory of operation
@@ -733,14 +733,9 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
 /**
  * scmi_register_protocol_events()  - Register Protocol Events with the core
  * @handle: The handle identifying the platform instance against which the
- *	    the protocol's events are registered
+ *	    protocol's events are registered
  * @proto_id: Protocol ID
- * @queue_sz: Size in bytes of the associated queue to be allocated
- * @ops: Protocol specific event-related operations
- * @evt: Event descriptor array
- * @num_events: Number of events in @evt array
- * @num_sources: Number of possible sources for this protocol on this
- *		 platform.
+ * @ee: A structure describing the events supported by this protocol.
  *
  * Used by SCMI Protocols initialization code to register with the notification
  * core the list of supported events and their descriptors: takes care to
@@ -749,18 +744,18 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
  *
  * Return: 0 on Success
  */
-int scmi_register_protocol_events(const struct scmi_handle *handle,
-				  u8 proto_id, size_t queue_sz,
-				  const struct scmi_event_ops *ops,
-				  const struct scmi_event *evt, int num_events,
-				  int num_sources)
+int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_events *ee)
 {
 	int i;
+	unsigned int num_sources;
 	size_t payld_sz = 0;
 	struct scmi_registered_events_desc *pd;
 	struct scmi_notify_instance *ni;
+	const struct scmi_event *evt;
 
-	if (!ops || !evt)
+	if (!ee || !ee->ops || !ee->evts ||
+	    (!ee->num_sources && !ee->ops->get_num_sources))
 		return -EINVAL;
 
 	/* Ensure notify_priv is updated */
@@ -769,40 +764,49 @@ int scmi_register_protocol_events(const struct scmi_handle *handle,
 		return -ENOMEM;
 	ni = handle->notify_priv;
 
-	/* Attach to the notification main devres group */
-	if (!devres_open_group(ni->handle->dev, ni->gid, GFP_KERNEL))
-		return -ENOMEM;
+	/* num_sources cannot be <= 0 */
+	if (ee->num_sources) {
+		num_sources = ee->num_sources;
+	} else {
+		int nsrc = ee->ops->get_num_sources(handle);
+
+		if (nsrc <= 0)
+			return -EINVAL;
+		num_sources = nsrc;
+	}
 
-	for (i = 0; i < num_events; i++)
+	evt = ee->evts;
+	for (i = 0; i < ee->num_events; i++)
 		payld_sz = max_t(size_t, payld_sz, evt[i].max_payld_sz);
 	payld_sz += sizeof(struct scmi_event_header);
 
-	pd = scmi_allocate_registered_events_desc(ni, proto_id, queue_sz,
-						  payld_sz, num_events, ops);
+	pd = scmi_allocate_registered_events_desc(ni, proto_id, ee->queue_sz,
+						  payld_sz, ee->num_events,
+						  ee->ops);
 	if (IS_ERR(pd))
-		goto err;
+		return PTR_ERR(pd);
 
-	for (i = 0; i < num_events; i++, evt++) {
+	for (i = 0; i < ee->num_events; i++, evt++) {
 		struct scmi_registered_event *r_evt;
 
 		r_evt = devm_kzalloc(ni->handle->dev, sizeof(*r_evt),
 				     GFP_KERNEL);
 		if (!r_evt)
-			goto err;
+			return -ENOMEM;
 		r_evt->proto = pd;
 		r_evt->evt = evt;
 
 		r_evt->sources = devm_kcalloc(ni->handle->dev, num_sources,
 					      sizeof(refcount_t), GFP_KERNEL);
 		if (!r_evt->sources)
-			goto err;
+			return -ENOMEM;
 		r_evt->num_sources = num_sources;
 		mutex_init(&r_evt->sources_mtx);
 
 		r_evt->report = devm_kzalloc(ni->handle->dev,
 					     evt->max_report_sz, GFP_KERNEL);
 		if (!r_evt->report)
-			goto err;
+			return -ENOMEM;
 
 		pd->registered_events[i] = r_evt;
 		/* Ensure events are updated */
@@ -816,8 +820,6 @@ int scmi_register_protocol_events(const struct scmi_handle *handle,
 	/* Ensure protocols are updated */
 	smp_wmb();
 
-	devres_close_group(ni->handle->dev, ni->gid);
-
 	/*
 	 * Finalize any pending events' handler which could have been waiting
 	 * for this protocol's events registration.
@@ -825,13 +827,35 @@ int scmi_register_protocol_events(const struct scmi_handle *handle,
 	schedule_work(&ni->init_work);
 
 	return 0;
+}
 
-err:
-	dev_warn(handle->dev, "Proto:%X - Registration Failed !\n", proto_id);
-	/* A failing protocol registration does not trigger full failure */
-	devres_close_group(ni->handle->dev, ni->gid);
+/**
+ * scmi_deregister_protocol_events  - Deregister protocol events with the core
+ * @handle: The handle identifying the platform instance against which the
+ *	    protocol's events are registered
+ * @proto_id: Protocol ID
+ */
+void scmi_deregister_protocol_events(const struct scmi_handle *handle,
+				     u8 proto_id)
+{
+	struct scmi_notify_instance *ni;
+	struct scmi_registered_events_desc *pd;
 
-	return -ENOMEM;
+	/* Ensure notify_priv is updated */
+	smp_rmb();
+	if (!handle->notify_priv)
+		return;
+
+	ni = handle->notify_priv;
+	pd = ni->registered_protocols[proto_id];
+	if (!pd)
+		return;
+
+	ni->registered_protocols[proto_id] = NULL;
+	/* Ensure protocols are updated */
+	smp_wmb();
+
+	cancel_work_sync(&pd->equeue.notify_work);
 }
 
 /**
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 3485f20fa70e..03500ca9cf56 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -4,7 +4,7 @@
  * notification header file containing some definitions, structures
  * and function prototypes related to SCMI Notification handling.
  *
- * Copyright (C) 2020 ARM Ltd.
+ * Copyright (C) 2020-2021 ARM Ltd.
  */
 #ifndef _SCMI_NOTIFY_H
 #define _SCMI_NOTIFY_H
@@ -31,8 +31,12 @@ struct scmi_event {
 	size_t	max_report_sz;
 };
 
+struct scmi_protocol_handle;
+
 /**
  * struct scmi_event_ops  - Protocol helpers called by the notification core.
+ * @get_num_sources: Returns the number of possible events' sources for this
+ *		     protocol
  * @set_notify_enabled: Enable/disable the required evt_id/src_id notifications
  *			using the proper custom protocol commands.
  *			Return 0 on Success
@@ -46,6 +50,7 @@ struct scmi_event {
  *	    process context.
  */
 struct scmi_event_ops {
+	int (*get_num_sources)(const struct scmi_handle *handle);
 	int (*set_notify_enabled)(const struct scmi_handle *handle,
 				  u8 evt_id, u32 src_id, bool enabled);
 	void *(*fill_custom_report)(const struct scmi_handle *handle,
@@ -54,14 +59,32 @@ struct scmi_event_ops {
 				    void *report, u32 *src_id);
 };
 
+/**
+ * struct scmi_protocol_events  - Per-protocol description of available events
+ * @queue_sz: Size in bytes of the per-protocol queue to use.
+ * @ops: Array of protocol-specific events operations.
+ * @evts: Array of supported protocol's events.
+ * @num_events: Number of supported protocol's events described in @evts.
+ * @num_sources: Number of protocol's sources, should be greater than 0; if not
+ *		 available at compile time, it will be provided at run-time via
+ *		 @get_num_sources.
+ */
+struct scmi_protocol_events {
+	size_t				queue_sz;
+	const struct scmi_event_ops	*ops;
+	const struct scmi_event		*evts;
+	unsigned int			num_events;
+	unsigned int			num_sources;
+};
+
 int scmi_notification_init(struct scmi_handle *handle);
 void scmi_notification_exit(struct scmi_handle *handle);
 
-int scmi_register_protocol_events(const struct scmi_handle *handle,
-				  u8 proto_id, size_t queue_sz,
-				  const struct scmi_event_ops *ops,
-				  const struct scmi_event *evt, int num_events,
-				  int num_sources);
+struct scmi_protocol_handle;
+int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_events *ee);
+void scmi_deregister_protocol_events(const struct scmi_handle *handle,
+				     u8 proto_id);
 int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 		const void *buf, size_t len, ktime_t ts);
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 4630dcae3d21..80af823af8ec 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -837,6 +837,16 @@ static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
 	return rep;
 }
 
+static int scmi_perf_get_num_sources(const struct scmi_handle *handle)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+
+	if (!pi)
+		return -EINVAL;
+
+	return pi->num_domains;
+}
+
 static const struct scmi_event perf_events[] = {
 	{
 		.id = SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
@@ -851,10 +861,18 @@ static const struct scmi_event perf_events[] = {
 };
 
 static const struct scmi_event_ops perf_event_ops = {
+	.get_num_sources = scmi_perf_get_num_sources,
 	.set_notify_enabled = scmi_perf_set_notify_enabled,
 	.fill_custom_report = scmi_perf_fill_custom_report,
 };
 
+static const struct scmi_protocol_events perf_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &perf_event_ops,
+	.evts = perf_events,
+	.num_events = ARRAY_SIZE(perf_events),
+};
+
 static int scmi_perf_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
@@ -887,12 +905,6 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
 	}
 
-	scmi_register_protocol_events(handle,
-				      SCMI_PROTOCOL_PERF, SCMI_PROTO_QUEUE_SZ,
-				      &perf_event_ops, perf_events,
-				      ARRAY_SIZE(perf_events),
-				      pinfo->num_domains);
-
 	pinfo->version = version;
 	handle->perf_ops = &perf_ops;
 	handle->perf_priv = pinfo;
@@ -904,6 +916,7 @@ static const struct scmi_protocol scmi_perf = {
 	.id = SCMI_PROTOCOL_PERF,
 	.init = &scmi_perf_protocol_init,
 	.ops = &perf_ops,
+	.events = &perf_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(perf, scmi_perf)
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index a5e5e22913b5..1cfd10dc18a5 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -246,6 +246,16 @@ static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
+static int scmi_power_get_num_sources(const struct scmi_handle *handle)
+{
+	struct scmi_power_info *pinfo = handle->power_priv;
+
+	if (!pinfo)
+		return -EINVAL;
+
+	return pinfo->num_domains;
+}
+
 static const struct scmi_event power_events[] = {
 	{
 		.id = SCMI_EVENT_POWER_STATE_CHANGED,
@@ -256,10 +266,18 @@ static const struct scmi_event power_events[] = {
 };
 
 static const struct scmi_event_ops power_event_ops = {
+	.get_num_sources = scmi_power_get_num_sources,
 	.set_notify_enabled = scmi_power_set_notify_enabled,
 	.fill_custom_report = scmi_power_fill_custom_report,
 };
 
+static const struct scmi_protocol_events power_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &power_event_ops,
+	.evts = power_events,
+	.num_events = ARRAY_SIZE(power_events),
+};
+
 static int scmi_power_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
@@ -288,12 +306,6 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}
 
-	scmi_register_protocol_events(handle,
-				      SCMI_PROTOCOL_POWER, SCMI_PROTO_QUEUE_SZ,
-				      &power_event_ops, power_events,
-				      ARRAY_SIZE(power_events),
-				      pinfo->num_domains);
-
 	pinfo->version = version;
 	handle->power_ops = &power_ops;
 	handle->power_priv = pinfo;
@@ -305,6 +317,7 @@ static const struct scmi_protocol scmi_power = {
 	.id = SCMI_PROTOCOL_POWER,
 	.init = &scmi_power_protocol_init,
 	.ops = &power_ops,
+	.events = &power_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(power, scmi_power)
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index ef9d80cafb56..06fecf044153 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -257,6 +257,16 @@ static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
+static int scmi_reset_get_num_sources(const struct scmi_handle *handle)
+{
+	struct scmi_reset_info *pinfo = handle->reset_priv;
+
+	if (!pinfo)
+		return -EINVAL;
+
+	return pinfo->num_domains;
+}
+
 static const struct scmi_event reset_events[] = {
 	{
 		.id = SCMI_EVENT_RESET_ISSUED,
@@ -266,10 +276,18 @@ static const struct scmi_event reset_events[] = {
 };
 
 static const struct scmi_event_ops reset_event_ops = {
+	.get_num_sources = scmi_reset_get_num_sources,
 	.set_notify_enabled = scmi_reset_set_notify_enabled,
 	.fill_custom_report = scmi_reset_fill_custom_report,
 };
 
+static const struct scmi_protocol_events reset_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &reset_event_ops,
+	.evts = reset_events,
+	.num_events = ARRAY_SIZE(reset_events),
+};
+
 static int scmi_reset_protocol_init(struct scmi_handle *handle)
 {
 	int domain;
@@ -298,12 +316,6 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 		scmi_reset_domain_attributes_get(handle, domain, dom);
 	}
 
-	scmi_register_protocol_events(handle,
-				      SCMI_PROTOCOL_RESET, SCMI_PROTO_QUEUE_SZ,
-				      &reset_event_ops, reset_events,
-				      ARRAY_SIZE(reset_events),
-				      pinfo->num_domains);
-
 	pinfo->version = version;
 	handle->reset_ops = &reset_ops;
 	handle->reset_priv = pinfo;
@@ -315,6 +327,7 @@ static const struct scmi_protocol scmi_reset = {
 	.id = SCMI_PROTOCOL_RESET,
 	.init = &scmi_reset_protocol_init,
 	.ops = &reset_ops,
+	.events = &reset_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(reset, scmi_reset)
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 1eb8a36abf64..03b7a274ee80 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -920,6 +920,13 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 	return rep;
 }
 
+static int scmi_sensor_get_num_sources(const struct scmi_handle *handle)
+{
+	struct sensors_info *si = handle->sensor_priv;
+
+	return si->num_sensors;
+}
+
 static const struct scmi_event sensor_events[] = {
 	{
 		.id = SCMI_EVENT_SENSOR_TRIP_POINT_EVENT,
@@ -939,10 +946,18 @@ static const struct scmi_event sensor_events[] = {
 };
 
 static const struct scmi_event_ops sensor_event_ops = {
+	.get_num_sources = scmi_sensor_get_num_sources,
 	.set_notify_enabled = scmi_sensor_set_notify_enabled,
 	.fill_custom_report = scmi_sensor_fill_custom_report,
 };
 
+static const struct scmi_protocol_events sensor_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &sensor_event_ops,
+	.evts = sensor_events,
+	.num_events = ARRAY_SIZE(sensor_events),
+};
+
 static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 {
 	u32 version;
@@ -971,12 +986,6 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 	if (ret)
 		return ret;
 
-	scmi_register_protocol_events(handle,
-				      SCMI_PROTOCOL_SENSOR, SCMI_PROTO_QUEUE_SZ,
-				      &sensor_event_ops, sensor_events,
-				      ARRAY_SIZE(sensor_events),
-				      sinfo->num_sensors);
-
 	handle->sensor_priv = sinfo;
 	handle->sensor_ops = &sensor_ops;
 
@@ -987,6 +996,7 @@ static const struct scmi_protocol scmi_sensors = {
 	.id = SCMI_PROTOCOL_SENSOR,
 	.init = &scmi_sensors_protocol_init,
 	.ops = &sensor_ops,
+	.events = &sensor_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(sensors, scmi_sensors)
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index d6d7400449fc..e1ee6327f761 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -101,6 +101,14 @@ static const struct scmi_event_ops system_event_ops = {
 	.fill_custom_report = scmi_system_fill_custom_report,
 };
 
+static const struct scmi_protocol_events system_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &system_event_ops,
+	.evts = system_events,
+	.num_events = ARRAY_SIZE(system_events),
+	.num_sources = SCMI_SYSTEM_NUM_SOURCES,
+};
+
 static int scmi_system_protocol_init(struct scmi_handle *handle)
 {
 	u32 version;
@@ -115,13 +123,6 @@ static int scmi_system_protocol_init(struct scmi_handle *handle)
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_register_protocol_events(handle,
-				      SCMI_PROTOCOL_SYSTEM, SCMI_PROTO_QUEUE_SZ,
-				      &system_event_ops,
-				      system_events,
-				      ARRAY_SIZE(system_events),
-				      SCMI_SYSTEM_NUM_SOURCES);
-
 	pinfo->version = version;
 	handle->system_priv = pinfo;
 
@@ -132,6 +133,7 @@ static const struct scmi_protocol scmi_system = {
 	.id = SCMI_PROTOCOL_SYSTEM,
 	.init = &scmi_system_protocol_init,
 	.ops = NULL,
+	.events = &system_protocol_events,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(system, scmi_system)
-- 
2.17.1

