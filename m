Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AF379B85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhEKAaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:00 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:58514 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhEKA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:44 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id C6EF7A1A28;
        Tue, 11 May 2021 02:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=u2R/F8gzBLp/
        QsX1CQem5LuI8ZQQb+bW1B2JAci57oY=; b=nhH8Ojjk7BDWo/aNGYA5vxOI3ePd
        gKDHty8/N/wAP6zmG8gU7lFLot0XE6PvT+kDl+/3+fcPqjRzcxpvYutlafycI7Qm
        afj4d017ZmK6IZrIYEaPdn6QQlsfJBv+rfImvs6ZrgfRzKhSULAU0GNpU5rr1zSu
        LDULKHxiZh+G6txpVg2MQ2m72Noygpwg2jE4hTJMRy2o6zVMai7FJBXdaCtGOsli
        ttWSLGJI39K2EFzRGSDCrvD8CWaEt4V9RHxhIu/cSn0NhEPlQHp9JO+fEGry8gXh
        /CMGKcLRwX7xFUL8wpdPugZUN8+pcfqrpoJw0OdZndxCAdnW8hpDKxOJzQ==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 04/12] firmware: arm_scmi: Add optional link_supplier() transport op
Date:   Tue, 11 May 2021 02:20:32 +0200
Message-ID: <20210511002040.802226-5-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 13be8dedcd6b..d60e3c26821d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -283,6 +283,7 @@ struct scmi_chan_info {
 /**
  * struct scmi_transport_ops - Structure representing a SCMI transport ops
  *
+ * @link_supplier: Optional callback to add link to a supplier device
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
@@ -297,6 +298,7 @@ struct scmi_chan_info {
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
+	int (*link_supplier)(struct device *dev);
 	bool (*chan_available)(struct device *dev, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b7271f8fd1c7..df526ff37c6d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1434,6 +1434,12 @@ static int scmi_probe(struct platform_device *pdev)
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
2.25.1


