Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE73DEECB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhHCNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:11:42 -0400
Received: from foss.arm.com ([217.140.110.172]:49646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236192AbhHCNLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:11:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39D813A1;
        Tue,  3 Aug 2021 06:11:20 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E123F70D;
        Tue,  3 Aug 2021 06:11:17 -0700 (PDT)
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
Subject: [PATCH v7 06/15] firmware: arm_scmi: Make .clear_channel optional
Date:   Tue,  3 Aug 2021 14:10:15 +0100
Message-Id: <20210803131024.40280-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make transport operation .clear_channel optional since some transports
do not need it and so avoid to have them implement dummy callbacks.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bfc35d7c7dbd..6c77fcc1bcb7 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -600,6 +600,13 @@ static inline void scmi_xfer_command_release(struct scmi_info *info,
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
+static inline void scmi_clear_channel(struct scmi_info *info,
+				      struct scmi_chan_info *cinfo)
+{
+	if (info->desc->ops->clear_channel)
+		info->desc->ops->clear_channel(cinfo);
+}
+
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
 	struct scmi_xfer *xfer;
@@ -613,7 +620,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		return;
 	}
 
@@ -629,7 +636,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 
 	__scmi_xfer_put(minfo, xfer);
 
-	info->desc->ops->clear_channel(cinfo);
+	scmi_clear_channel(info, cinfo);
 }
 
 static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
@@ -639,7 +646,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		return;
 	}
 
@@ -654,7 +661,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			   xfer->hdr.type);
 
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
 	} else {
 		complete(&xfer->done);
-- 
2.17.1

