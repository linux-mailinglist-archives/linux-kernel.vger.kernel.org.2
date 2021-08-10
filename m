Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7241C3DEED1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhHCNMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:12:05 -0400
Received: from foss.arm.com ([217.140.110.172]:49772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236292AbhHCNLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:11:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC23811FB;
        Tue,  3 Aug 2021 06:11:40 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D2503F70D;
        Tue,  3 Aug 2021 06:11:37 -0700 (PDT)
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
Subject: [PATCH v7 12/15] firmware: arm_scmi: Add optional link_supplier() transport op
Date:   Tue,  3 Aug 2021 14:10:21 +0100
Message-Id: <20210803131024.40280-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hilber <peter.hilber@opensynergy.com>

Some transports are also effectively registered with other kernel subsystem
in order to be properly probed and initialized; as a consequence such kind
of transports, and their related devices, might still not have been probed
and initialized at the time the main SCMI core driver is probed.

Add an optional .link_supplier() transport operation which can be used by
the core SCMI stack to dynamically check if the transport is ready and
dynamically link its device to the SCMI platform instance device.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
[ Cristian: reworded commit message ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- fixed commit message
v5 --> v6
- reworded commit message
---
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4da6cecc0a1c..024d97fbf97b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -348,6 +348,7 @@ struct scmi_chan_info {
 /**
  * struct scmi_transport_ops - Structure representing a SCMI transport ops
  *
+ * @link_supplier: Optional callback to add link to a supplier device
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
@@ -362,6 +363,7 @@ struct scmi_chan_info {
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
+	int (*link_supplier)(struct device *dev);
 	bool (*chan_available)(struct device *dev, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a907f3fe4c08..7ae4ec8f8d1f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1814,6 +1814,12 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
 
+	if (desc->ops->link_supplier) {
+		ret = desc->ops->link_supplier(dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
 		return ret;
-- 
2.17.1

