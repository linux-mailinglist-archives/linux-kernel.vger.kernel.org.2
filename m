Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1BC4039AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbhIHMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:23:13 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56160 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351744AbhIHMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:23:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UnhbUrf_1631103655;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UnhbUrf_1631103655)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 20:21:06 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
Date:   Wed,  8 Sep 2021 20:20:36 +0800
Message-Id: <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new callback is used to indicate whether the vring size can be
change or not. It is useful when we have a legacy virtio pci device as
the vdpa device for there is no way to negotiate the vring num by the
specification.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
 drivers/virtio/virtio_vdpa.c |  5 ++++-
 include/linux/vdpa.h         |  4 ++++
 include/uapi/linux/vhost.h   |  2 ++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9479f7f79217..2204d27d1e5d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
 	return 0;
 }
 
+static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
+						  u32 __user *argp)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	bool unchangeable = false;
+
+	if (ops->get_vq_num_unchangeable)
+		unchangeable = ops->get_vq_num_unchangeable(vdpa);
+
+	if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_GET_IOVA_RANGE:
 		r = vhost_vdpa_get_iova_range(v, argp);
 		break;
+	case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
+		r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 72eaef2caeb1..afb47465307a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct vdpa_vq_state state = {0};
 	unsigned long flags;
 	u32 align, num;
+	bool may_reduce_num = true;
 	int err;
 
 	if (!name)
@@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
+	if (ops->get_vq_num_unchangeable)
+		may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
 	vq = vring_create_virtqueue(index, num, align, vdev,
-				    true, true, ctx,
+				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 35648c11e312..f809b7ada00d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -195,6 +195,9 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				Returns the iova range supported by
  *				the device.
+ * @get_vq_num_unchangeable	Check if size of virtqueue is unchangeable (optional)
+ *				@vdev: vdpa device
+ *				Returns boolean: unchangeable (true) or not (false)
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -262,6 +265,7 @@ struct vdpa_config_ops {
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
+	bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c998860d7bbc..184f1f7f8498 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -150,4 +150,6 @@
 /* Get the valid iova range */
 #define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
 					     struct vhost_vdpa_iova_range)
+/* Check if the vring size can be change */
+#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
 #endif
-- 
2.31.1

