Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CE3A4746
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhFKRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:02:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKRCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B92FD6E;
        Fri, 11 Jun 2021 10:00:57 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CACF03F719;
        Fri, 11 Jun 2021 10:00:53 -0700 (PDT)
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
Subject: [PATCH v4 09/16] firmware: arm_scmi: Add optional link_supplier() transport op
Date:   Fri, 11 Jun 2021 17:59:30 +0100
Message-Id: <20210611165937.701-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hilber <peter.hilber@opensynergy.com>

For the scmi-virtio transport, it might not be possible to refer to the
proper virtio device at device tree build time. Therefore, add an op
which will allow scmi-virtio to dynamically link to the proper virtio
device during probe.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6b8d388fcf74..a31194b3000a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -316,6 +316,7 @@ struct scmi_chan_info {
 /**
  * struct scmi_transport_ops - Structure representing a SCMI transport ops
  *
+ * @link_supplier: Optional callback to add link to a supplier device
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
@@ -330,6 +331,7 @@ struct scmi_chan_info {
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
+	int (*link_supplier)(struct device *dev);
 	bool (*chan_available)(struct device *dev, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 041a9e008cbf..69fa97250d98 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1757,6 +1757,12 @@ static int scmi_probe(struct platform_device *pdev)
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

