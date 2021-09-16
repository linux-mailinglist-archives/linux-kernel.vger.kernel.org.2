Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6245540D77F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhIPKfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:35:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236569AbhIPKfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:35:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8B8D6D;
        Thu, 16 Sep 2021 03:34:21 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CEE43F5A1;
        Thu, 16 Sep 2021 03:34:18 -0700 (PDT)
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
        Vasyl.Vavrychuk@opensynergy.com, Tryshnivskyy@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] firmware: arm_scmi: Review some virtio log messages
Date:   Thu, 16 Sep 2021 11:33:34 +0100
Message-Id: <20210916103336.7243-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be more verbose avoiding to use _once flavour of dev_info/_err/_notice.
Remove usage of __func_ to identify which vqueue is referred in some error
messages and explicitly name the TX/RX vqueue.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Apply on sudeep/for-next/scmi on top of:

440320fdecdb ("firmware: arm_scmi: Fix virtio transport Kconfig dependency")
---
 drivers/firmware/arm_scmi/virtio.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 224577f86928..9a758d294693 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -94,8 +94,8 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 
 	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
 	if (rc)
-		dev_err_once(vioch->cinfo->dev,
-			     "failed to add to virtqueue (%d)\n", rc);
+		dev_err(vioch->cinfo->dev,
+			"failed to add to RX virtqueue (%d)\n", rc);
 	else
 		virtqueue_kick(vioch->vqueue);
 
@@ -187,8 +187,8 @@ static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
 static int virtio_link_supplier(struct device *dev)
 {
 	if (!scmi_vdev) {
-		dev_notice_once(dev,
-				"Deferring probe after not finding a bound scmi-virtio device\n");
+		dev_notice(dev,
+			   "Deferring probe after not finding a bound scmi-virtio device\n");
 		return -EPROBE_DEFER;
 	}
 
@@ -328,9 +328,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
 	if (rc) {
 		list_add(&msg->list, &vioch->free_list);
-		dev_err_once(vioch->cinfo->dev,
-			     "%s() failed to add to virtqueue (%d)\n", __func__,
-			     rc);
+		dev_err(vioch->cinfo->dev,
+			"failed to add to TX virtqueue (%d)\n", rc);
 	} else {
 		virtqueue_kick(vioch->vqueue);
 	}
@@ -418,10 +417,10 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 			sz /= DESCRIPTORS_PER_TX_MSG;
 
 		if (sz > MSG_TOKEN_MAX) {
-			dev_info_once(dev,
-				      "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
-				      channels[i].is_rx ? "rx" : "tx",
-				      sz, MSG_TOKEN_MAX);
+			dev_info(dev,
+				 "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
+				 channels[i].is_rx ? "rx" : "tx",
+				 sz, MSG_TOKEN_MAX);
 			sz = MSG_TOKEN_MAX;
 		}
 		channels[i].max_msg = sz;
-- 
2.17.1

