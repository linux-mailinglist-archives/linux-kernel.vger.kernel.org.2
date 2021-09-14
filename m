Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008B040AD85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhINM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:26:51 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53887 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232571AbhINM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:26:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoNt7PD_1631622314;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoNt7PD_1631622314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Sep 2021 20:25:25 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v2 4/5] vdpa: add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1
Date:   Tue, 14 Sep 2021 20:24:51 +0800
Message-Id: <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com> <cover.1631621507.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new attribute advertises whether the vdpa device is legacy or not.
Users can pick right virtqueue size if the vdpa device is legacy which
doesn't support to change virtqueue size.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/vdpa.c          | 6 ++++++
 drivers/virtio/virtio_vdpa.c | 7 ++++++-
 include/uapi/linux/vdpa.h    | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1dc121a07a93..533d7f589eee 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/vdpa.h>
 #include <uapi/linux/vdpa.h>
+#include <uapi/linux/virtio_config.h>
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
 
@@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 	u16 max_vq_size;
 	u32 device_id;
 	u32 vendor_id;
+	u64 features;
 	void *hdr;
 	int err;
 
@@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 	device_id = vdev->config->get_device_id(vdev);
 	vendor_id = vdev->config->get_vendor_id(vdev);
 	max_vq_size = vdev->config->get_vq_num_max(vdev);
+	features = vdev->config->get_features(vdev);
 
 	err = -EMSGSIZE;
 	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
@@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 		goto msg_err;
 	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
 		goto msg_err;
+	if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
+	    nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
+		goto msg_err;
 
 	genlmsg_end(msg, hdr);
 	return 0;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 72eaef2caeb1..1cba957c4cdc 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include "linux/virtio_config.h"
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	unsigned long flags;
+	bool may_reduce_num = false;
 	u32 align, num;
 	int err;
 
@@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		goto error_new_virtqueue;
 	}
 
+	if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
+		may_reduce_num = true;
+
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
 	vq = vring_create_virtqueue(index, num, align, vdev,
-				    true, true, ctx,
+				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 66a41e4ec163..ce0b74276a5b 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -32,6 +32,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
 	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
 	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
+	VDPA_ATTR_DEV_VERSION_1,		/* flag */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.31.1

