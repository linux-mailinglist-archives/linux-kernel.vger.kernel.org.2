Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260BD3C5E32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhGLOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:22:21 -0400
Received: from foss.arm.com ([217.140.110.172]:56014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235006AbhGLOWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:22:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D625B31B;
        Mon, 12 Jul 2021 07:19:29 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5FA3F774;
        Mon, 12 Jul 2021 07:19:26 -0700 (PDT)
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
Subject: [PATCH v6 09/17] firmware: arm_scmi: Make .clear_channel optional
Date:   Mon, 12 Jul 2021 15:18:25 +0100
Message-Id: <20210712141833.6628-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
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
index dc14bc63cb43..a952b6527b8a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -593,6 +593,13 @@ static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
 	}
 }
 
+static inline void scmi_clear_channel(struct scmi_info *info,
+				      struct scmi_chan_info *cinfo)
+{
+	if (info->desc->ops->clear_channel)
+		info->desc->ops->clear_channel(cinfo);
+}
+
 static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 				     u32 msg_hdr, void *priv)
 {
@@ -607,7 +614,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		return;
 	}
 
@@ -625,7 +632,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 
 	__scmi_xfer_put(minfo, xfer);
 
-	info->desc->ops->clear_channel(cinfo);
+	scmi_clear_channel(info, cinfo);
 }
 
 static void scmi_handle_response(struct scmi_chan_info *cinfo,
@@ -636,7 +643,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		return;
 	}
 
@@ -655,7 +662,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 			   xfer->hdr.type);
 
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
-		info->desc->ops->clear_channel(cinfo);
+		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
 	} else {
 		complete(&xfer->done);
-- 
2.17.1

