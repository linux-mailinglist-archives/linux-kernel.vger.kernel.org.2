Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1F432EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhJSHGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234464AbhJSHGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634627052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evZyo3/0naAQoa7HSYTH4IiI173n2n8X5vDv9BntqxI=;
        b=CsC5+buBu4RtEQzJqcT7g6kvQ3zX0gshpwW88PXbM0/w1I45BGV7CAVjwB7pu6zQN9DHya
        /h98t8eP/nMe7orLW61yWDZtxBr5R2yTkAeSvstM1I7VcUfiuPetFBtj7F/GVBRaD9g4at
        iXkiYqcp3cRfZISwpNFmXl0QWnrt4jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-NYifhGcuPEC-HtrORkOjsA-1; Tue, 19 Oct 2021 03:04:11 -0400
X-MC-Unique: NYifhGcuPEC-HtrORkOjsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B6880363B;
        Tue, 19 Oct 2021 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C298F7093A;
        Tue, 19 Oct 2021 07:04:07 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V3 07/10] virtio_ring: validate used buffer length
Date:   Tue, 19 Oct 2021 15:01:49 +0800
Message-Id: <20211019070152.8236-8-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch validate the used buffer length provided by the device
before trying to use it. This is done by record the in buffer length
in a new field in desc_state structure during virtqueue_add(), then we
can fail the virtqueue_get_buf() when we find the device is trying to
give us a used buffer length which is greater than the in buffer
length.

Since some drivers have already done the validation by themselves,
this patch tries to makes the core validation optional. For the driver
that doesn't want the validation, it can set the validate_used to be
true (which could be overridden by force_used_validation). To be more
efficient, a dedicate array is used for storing the validate used
length, this helps to eliminate the cache stress if validation is done
by the driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 56 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d2ca0a7365f8..306c86b94480 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -14,6 +14,9 @@
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
+static bool force_used_validation = false;
+module_param(force_used_validation, bool, 0444);
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(_vq, fmt, args...)				\
@@ -182,6 +185,9 @@ struct vring_virtqueue {
 		} packed;
 	};
 
+	/* Per-descriptor in buffer length */
+	u32 *buflen;
+
 	/* How to notify other side. FIXME: commonalize hcalls! */
 	bool (*notify)(struct virtqueue *vq);
 
@@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     indirect);
+			buflen += sg->length;
 		}
 	}
 	/* Last one doesn't continue. */
@@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
+	/* Store in buffer length if necessary */
+	if (vq->buflen)
+		vq->buflen[head] = buflen;
+
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
+	if (vq->buflen && unlikely(*len > vq->buflen[i])) {
+		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
+			*len, vq->buflen[i]);
+		return NULL;
+	}
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
@@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n, err_idx;
 	u16 head, id;
 	dma_addr_t addr;
+	u32 buflen = 0;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1089,6 +1107,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1142,6 +1162,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
 
+	/* Store in buffer length if necessary */
+	if (vq->buflen)
+		vq->buflen[id] = buflen;
+
 	vq->num_added += 1;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -1176,6 +1200,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	unsigned int i, n, c, descs_used, err_idx;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -1250,6 +1275,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 					1 << VRING_PACKED_DESC_F_AVAIL |
 					1 << VRING_PACKED_DESC_F_USED;
 			}
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1269,6 +1296,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
 
+	/* Store in buffer length if necessary */
+	if (vq->buflen)
+		vq->buflen[id] = buflen;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1455,6 +1486,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", id);
 		return NULL;
 	}
+	if (vq->buflen && unlikely(*len > vq->buflen[id])) {
+		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
+			*len, vq->buflen[id]);
+		return NULL;
+	}
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
@@ -1660,6 +1696,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 
@@ -1749,6 +1786,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (!vq->packed.desc_extra)
 		goto err_desc_extra;
 
+	if (!drv->suppress_used_validation || force_used_validation) {
+		vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
+					   GFP_KERNEL);
+		if (!vq->buflen)
+			goto err_buflen;
+	}
+
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
@@ -1761,6 +1805,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
+err_buflen:
+	kfree(vq->packed.desc_extra);
 err_desc_extra:
 	kfree(vq->packed.desc_state);
 err_desc_state:
@@ -2168,6 +2214,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					void (*callback)(struct virtqueue *),
 					const char *name)
 {
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
 	struct vring_virtqueue *vq;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
@@ -2227,6 +2274,13 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq->split.desc_extra)
 		goto err_extra;
 
+	if (!drv->suppress_used_validation || force_used_validation) {
+		vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
+					   GFP_KERNEL);
+		if (!vq->buflen)
+			goto err_buflen;
+	}
+
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 	memset(vq->split.desc_state, 0, vring.num *
@@ -2237,6 +2291,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
+err_buflen:
+	kfree(vq->split.desc_extra);
 err_extra:
 	kfree(vq->split.desc_state);
 err_state:
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 41edbc01ffa4..44d0e09da2d9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @suppress_used_validation: set to not have core validate used length
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
@@ -168,6 +169,7 @@ struct virtio_driver {
 	unsigned int feature_table_size;
 	const unsigned int *feature_table_legacy;
 	unsigned int feature_table_size_legacy;
+	bool suppress_used_validation;
 	int (*validate)(struct virtio_device *dev);
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
-- 
2.25.1

