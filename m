Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18230F930
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhBDRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:10:50 -0500
Received: from foss.arm.com ([217.140.110.172]:33868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238295AbhBDRBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:01:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084F711FB;
        Thu,  4 Feb 2021 09:00:24 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477BC3F73B;
        Thu,  4 Feb 2021 09:00:22 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh@kernel.org
Subject: [PATCH v5 1/3] firmware: arm_scmi: support only one single SystemPower device
Date:   Thu,  4 Feb 2021 16:59:11 +0000
Message-Id: <20210204165913.42582-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204165913.42582-1-cristian.marussi@arm.com>
References: <20210204165913.42582-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to minimize SCMI platform fw-side complexity, only one platform
should be in charge of SCMI SystemPower protocol communications with the
OSPM: enforce the existence of one single unique device associated with
SystemPower protocol across any possible number of SCMI platforms, and
warn if a system tries to register different SystemPower devices from
multiple platforms.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 88149a46e6d9..e8542a7e8862 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -19,6 +19,9 @@ static DEFINE_IDA(scmi_bus_id);
 static DEFINE_IDR(scmi_available_protocols);
 static DEFINE_SPINLOCK(protocol_lock);
 
+/* Track globally the creation of SCMI SystemPower related devices */
+static bool scmi_syspower_registered;
+
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 {
@@ -175,6 +178,23 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	int id, retval;
 	struct scmi_device *scmi_dev;
 
+	/*
+	 * Check if any SCMI SystemPower device was already created.
+	 *
+	 * Note that, shared global @scmi_syspower_registered is not protected
+	 * by a mutex since:
+	 *  - scmi_device_create() is not concurrently invoked by the SCMI core
+	 *  - scmi_device_destroy() is effectively called only upon SCMI core
+	 *    unloading/unbinding, so no race is either possible between create
+	 *    and destroy.
+	 */
+	if (protocol == SCMI_PROTOCOL_SYSTEM && scmi_syspower_registered) {
+		dev_warn(parent,
+			 "SCMI SystemPower protocol device must be unique !\n");
+		dump_stack();
+		return NULL;
+	}
+
 	scmi_dev = kzalloc(sizeof(*scmi_dev), GFP_KERNEL);
 	if (!scmi_dev)
 		return NULL;
@@ -204,6 +224,9 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	if (retval)
 		goto put_dev;
 
+	if (protocol == SCMI_PROTOCOL_SYSTEM)
+		scmi_syspower_registered = true;
+
 	return scmi_dev;
 put_dev:
 	kfree_const(scmi_dev->name);
@@ -218,6 +241,8 @@ void scmi_device_destroy(struct scmi_device *scmi_dev)
 	scmi_handle_put(scmi_dev->handle);
 	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
 	device_unregister(&scmi_dev->dev);
+	if (scmi_dev->protocol_id == SCMI_PROTOCOL_SYSTEM)
+		scmi_syspower_registered = false;
 }
 
 void scmi_set_handle(struct scmi_device *scmi_dev)
-- 
2.17.1

