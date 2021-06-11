Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0C3A4748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFKRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:03:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhFKRDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F686D6E;
        Fri, 11 Jun 2021 10:01:04 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12D3B3F719;
        Fri, 11 Jun 2021 10:01:00 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v4 11/16] firmware: arm_scmi: Add is_scmi_protocol_device()
Date:   Fri, 11 Jun 2021 17:59:32 +0100
Message-Id: <20210611165937.701-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hilber <peter.hilber@opensynergy.com>

The scmi-virtio transport driver will need to distinguish SCMI protocol
devices from the SCMI instance device in the chan_setup() and
chan_free() ops. Add this internal helper to be able to distinguish the
two.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/bus.c    | 5 +++++
 drivers/firmware/arm_scmi/common.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 784cf0027da3..06148e972d1a 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -134,6 +134,11 @@ static struct bus_type scmi_bus_type = {
 	.remove = scmi_dev_remove,
 };
 
+bool is_scmi_protocol_device(struct device *dev)
+{
+	return dev->bus == &scmi_bus_type;
+}
+
 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 			 const char *mod_name)
 {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7219970fc5eb..b783ae058c8a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -264,6 +264,8 @@ struct scmi_protocol {
 	const struct scmi_protocol_events	*events;
 };
 
+bool is_scmi_protocol_device(struct device *dev);
+
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
 
-- 
2.17.1

