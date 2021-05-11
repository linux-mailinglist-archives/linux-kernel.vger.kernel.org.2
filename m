Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108E379B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhEKAa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:26 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:35445 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id B9B33A1A33;
        Tue, 11 May 2021 02:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=qDRth01lvcca
        cQ4leScF8MqXeu+HXFiuV4vdo43NTWA=; b=l3D6+Lg0/yxa6+4wfSVlzgOUMBM9
        Uje/YGgCyD2sbYNUoQDHiiONNgRYhTvEjPbww51bPTUtCaB2BWoua+kMDYe4OYXl
        53v6nOvJME8MkmDRT6WVFTaB5iQ7EJOawBGWlt1TyMqCZO1kswGgHfTuQFB7gJLX
        2SujQGhBfQ8ydb7sMw3TL5MqvwkjCHh/gNxJdMRa59FzXC3IhIxEscOzr0sktI6X
        zKsbGLqad8WkmcwGJc1Ic2TGHDs3sZpdoN6/3FmTMAjSu6PF2SeZ2yl/Q3d/z2qW
        FGwdu8263qq+Yjr/Kh/B1hm0jMIhP9XNEf6K6DEhiATlyogF+Gi3rJxvdw==
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
Subject: [RFC PATCH v3 08/12] firmware: arm_scmi: Add optional drop_message() transport op
Date:   Tue, 11 May 2021 02:20:36 +0200
Message-ID: <20210511002040.802226-9-peter.hilber@opensynergy.com>
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

The virtio transport will need to know when the core has finished using
a message. Add a transport op that indicates this to scmi_rx_callback().
Do not address the polling case for now.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5ab2ea0f7db2..51ee08bdcb0c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -298,6 +298,7 @@ struct scmi_chan_info {
  * @fetch_notification: Callback to fetch notification
  * @clear_channel: Callback to clear a channel
  * @poll_done: Callback to poll transfer status
+ * @drop_message: Optional callback when finished using msg_handle
  */
 struct scmi_transport_ops {
 	int (*link_supplier)(struct device *dev);
@@ -315,6 +316,7 @@ struct scmi_transport_ops {
 				   struct scmi_xfer *xfer, void *msg_handle);
 	void (*clear_channel)(struct scmi_chan_info *cinfo);
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
+	void (*drop_message)(struct scmi_chan_info *cinfo, void *msg_handle);
 };
 
 int scmi_protocol_device_request(const struct scmi_device_id *id_table);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index cc27978b4bea..e04e7c8e6928 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -371,6 +371,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
 {
 	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
 	switch (msg_type) {
 	case MSG_TYPE_NOTIFICATION:
@@ -384,6 +385,9 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
 		break;
 	}
+
+	if (info->desc->ops->drop_message)
+		info->desc->ops->drop_message(cinfo, msg_handle);
 }
 
 /**
-- 
2.25.1


