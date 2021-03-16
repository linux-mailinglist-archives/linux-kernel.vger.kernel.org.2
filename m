Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8933D460
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhCPMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:54:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233419AbhCPMuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A291691;
        Tue, 16 Mar 2021 05:50:39 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAD643F792;
        Tue, 16 Mar 2021 05:50:37 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 36/38] firmware: arm_scmi: rename non devres notify_ops
Date:   Tue, 16 Mar 2021 12:49:01 +0000
Message-Id: <20210316124903.35011-37-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename non devres managed notify_ops to use a naming pattern which exposes
the performed action verb as last token.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
---
 drivers/firmware/arm_scmi/notify.c | 18 +++++++++---------
 include/linux/scmi_protocol.h      |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 9ca019dd0aeb..d860bebd984a 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1307,7 +1307,7 @@ static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
 }
 
 /**
- * scmi_register_notifier()  - Register a notifier_block for an event
+ * scmi_notifier_register()  - Register a notifier_block for an event
  * @handle: The handle identifying the platform instance against which the
  *	    callback is registered
  * @proto_id: Protocol ID
@@ -1339,7 +1339,7 @@ static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
  *
  * Return: 0 on Success
  */
-static int scmi_register_notifier(const struct scmi_handle *handle,
+static int scmi_notifier_register(const struct scmi_handle *handle,
 				  u8 proto_id, u8 evt_id, const u32 *src_id,
 				  struct notifier_block *nb)
 {
@@ -1371,7 +1371,7 @@ static int scmi_register_notifier(const struct scmi_handle *handle,
 }
 
 /**
- * scmi_unregister_notifier()  - Unregister a notifier_block for an event
+ * scmi_notifier_unregister()  - Unregister a notifier_block for an event
  * @handle: The handle identifying the platform instance against which the
  *	    callback is unregistered
  * @proto_id: Protocol ID
@@ -1386,7 +1386,7 @@ static int scmi_register_notifier(const struct scmi_handle *handle,
  *
  * Return: 0 on Success
  */
-static int scmi_unregister_notifier(const struct scmi_handle *handle,
+static int scmi_notifier_unregister(const struct scmi_handle *handle,
 				    u8 proto_id, u8 evt_id, const u32 *src_id,
 				    struct notifier_block *nb)
 {
@@ -1412,7 +1412,7 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	scmi_put_handler(ni, hndl);
 
 	/*
-	 * This balances the initial get issued in @scmi_register_notifier.
+	 * This balances the initial get issued in @scmi_notifier_register.
 	 * If this notifier_block happened to be the last known user callback
 	 * for this event, the handler is here freed and the event's generation
 	 * stopped.
@@ -1440,7 +1440,7 @@ static void scmi_devm_release_notifier(struct device *dev, void *res)
 {
 	struct scmi_notifier_devres *dres = res;
 
-	scmi_unregister_notifier(dres->handle, dres->proto_id, dres->evt_id,
+	scmi_notifier_unregister(dres->handle, dres->proto_id, dres->evt_id,
 				 dres->src_id, dres->nb);
 }
 
@@ -1471,7 +1471,7 @@ static int scmi_devm_notifier_register(struct scmi_device *sdev,
 	if (!dres)
 		return -ENOMEM;
 
-	ret = scmi_register_notifier(sdev->handle, proto_id,
+	ret = scmi_notifier_register(sdev->handle, proto_id,
 				     evt_id, src_id, nb);
 	if (ret) {
 		devres_free(dres);
@@ -1609,8 +1609,8 @@ static void scmi_protocols_late_init(struct work_struct *work)
 static const struct scmi_notify_ops notify_ops = {
 	.devm_event_notifier_register = scmi_devm_notifier_register,
 	.devm_event_notifier_unregister = scmi_devm_notifier_unregister,
-	.register_event_notifier = scmi_register_notifier,
-	.unregister_event_notifier = scmi_unregister_notifier,
+	.event_notifier_register = scmi_notifier_register,
+	.event_notifier_unregister = scmi_notifier_unregister,
 };
 
 /**
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 114890bd7af0..b80496d519f3 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -548,8 +548,8 @@ struct scmi_voltage_proto_ops {
  *				  the requested event
  * @devm_event_notifier_unregister: Managed unregistration of a notifier_block
  *				    for the requested event
- * @register_event_notifier: Register a notifier_block for the requested event
- * @unregister_event_notifier: Unregister a notifier_block for the requested
+ * @event_notifier_register: Register a notifier_block for the requested event
+ * @event_notifier_unregister: Unregister a notifier_block for the requested
  *			       event
  *
  * A user can register/unregister its own notifier_block against the wanted
@@ -590,11 +590,11 @@ struct scmi_notify_ops {
 					      u8 proto_id, u8 evt_id,
 					      const u32 *src_id,
 					      struct notifier_block *nb);
-	int (*register_event_notifier)(const struct scmi_handle *handle,
+	int (*event_notifier_register)(const struct scmi_handle *handle,
 				       u8 proto_id, u8 evt_id,
 				       const u32 *src_id,
 				       struct notifier_block *nb);
-	int (*unregister_event_notifier)(const struct scmi_handle *handle,
+	int (*event_notifier_unregister)(const struct scmi_handle *handle,
 					 u8 proto_id, u8 evt_id,
 					 const u32 *src_id,
 					 struct notifier_block *nb);
-- 
2.17.1

