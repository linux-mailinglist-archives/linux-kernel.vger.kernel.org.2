Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13A43A474F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhFKRDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:03:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhFKRDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0CE4143D;
        Fri, 11 Jun 2021 10:01:24 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DE6D3F719;
        Fri, 11 Jun 2021 10:01:19 -0700 (PDT)
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
Subject: [PATCH v4 16/16] firmware: arm_scmi: Add polling mode to virtio transport
Date:   Fri, 11 Jun 2021 17:59:37 +0100
Message-Id: <20210611165937.701-17-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable polling mode support to virtio transport.

Upon reception of a synchronous command response for a transfer that has
the hdr.poll_completion flag set, virtio transport now simply completes the
same completion which .poll_done() is spinning on.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that as of now in order to test this you have to forcibly
enable hdr.poll_completion in the core and increase SCMI_MAX_POLL_TO_NS.

These workarounds won't be needed anymore once addressed by a distinct
series currently under review.
---
 drivers/firmware/arm_scmi/virtio.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 4412bc590ca7..f77c7f288d4c 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -158,12 +158,12 @@ static void scmi_process_vqueue_input(struct scmi_vio_channel *vioch,
 	/* Drop processed virtio message anyway */
 	scmi_finalize_message(vioch, msg);
 
+	/* Deliver DRESP, NOTIF and non-polled RESP */
 	if (vioch->is_rx || !xfer->hdr.poll_completion)
 		scmi_rx_callback(vioch->cinfo, msg_hdr);
 	else
-		dev_warn(vioch->cinfo->dev,
-			 "Polling mode NOT supported. Dropped hdr:0X%X\n",
-			 msg_hdr);
+		/* poll_done() is busy-waiting on this */
+		complete(&xfer->done);
 
 	scmi_transfer_release(vioch->cinfo, xfer);
 }
@@ -414,10 +414,16 @@ static void dummy_clear_channel(struct scmi_chan_info *cinfo)
 {
 }
 
-static bool dummy_poll_done(struct scmi_chan_info *cinfo,
-			    struct scmi_xfer *xfer)
+static bool virtio_poll_done(struct scmi_chan_info *cinfo,
+			     struct scmi_xfer *xfer)
 {
-	return false;
+	/*
+	 * In polling mode SCMI core does not use xfer->done completion,
+	 * so we can busy-wait on this same completion without adding
+	 * a new flag: this is completed properly upon msg reception in
+	 * scmi_process_vqueue_input().
+	 */
+	return try_wait_for_completion(&xfer->done);
 }
 
 static const struct scmi_transport_ops scmi_virtio_ops = {
@@ -430,7 +436,7 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
 	.fetch_response = virtio_fetch_response,
 	.fetch_notification = virtio_fetch_notification,
 	.clear_channel = dummy_clear_channel,
-	.poll_done = dummy_poll_done,
+	.poll_done = virtio_poll_done,
 };
 
 static int scmi_vio_probe(struct virtio_device *vdev)
-- 
2.17.1

