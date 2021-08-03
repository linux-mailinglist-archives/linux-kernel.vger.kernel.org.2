Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26AA3DEEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhHCNLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:11:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236138AbhHCNLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:11:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F470143B;
        Tue,  3 Aug 2021 06:11:07 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384B23F70D;
        Tue,  3 Aug 2021 06:11:04 -0700 (PDT)
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
Subject: [PATCH v7 02/15] firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
Date:   Tue,  3 Aug 2021 14:10:11 +0100
Message-Id: <20210803131024.40280-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being a while that we have SCMI trace events in the SCMI stack, remove
this debug helper and its call sites.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a7a789c5d101..bd7f81b2b46b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -172,19 +172,6 @@ static inline int scmi_to_linux_errno(int errno)
 	return -EIO;
 }
 
-/**
- * scmi_dump_header_dbg() - Helper to dump a message header.
- *
- * @dev: Device pointer corresponding to the SCMI entity
- * @hdr: pointer to header.
- */
-static inline void scmi_dump_header_dbg(struct device *dev,
-					struct scmi_msg_hdr *hdr)
-{
-	dev_dbg(dev, "Message ID: %x Sequence ID: %x Protocol: %x\n",
-		hdr->id, hdr->seq, hdr->protocol_id);
-}
-
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv)
 {
@@ -288,7 +275,6 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
-	scmi_dump_header_dbg(dev, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -339,8 +325,6 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (msg_type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
 
-	scmi_dump_header_dbg(dev, &xfer->hdr);
-
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
-- 
2.17.1

