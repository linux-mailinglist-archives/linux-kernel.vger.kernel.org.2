Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30E36036E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhDOHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhDOHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Jd0aNYcvoPCuSGEQsik23PhtFa95sAlUM4Kd+9ya+HM=;
        b=SWQ03SlmIeT9I6dqe5kiaJNdNdm9bApuJyZLeQQKRuVtr9bYvnHqn6cp587wD0wumCu7PI
        lbcmTxv5h3dEZV3+hNrftdo/VwhfTQhQu2hAffpsjMDubny7ht0thZMByT/16wpqL2zQ3j
        iWLu2LOIj81FgyMbkJsG8FYfT/LZunw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-sExIEK2UPrGTqn4NSDI7tQ-1; Thu, 15 Apr 2021 03:32:23 -0400
X-MC-Unique: sExIEK2UPrGTqn4NSDI7tQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11F6061243;
        Thu, 15 Apr 2021 07:32:22 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3644860657;
        Thu, 15 Apr 2021 07:32:19 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 6/7] virtio-pci library: report resource address
Date:   Thu, 15 Apr 2021 03:31:46 -0400
Message-Id: <20210415073147.19331-7-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it might be useful to report the capability physical
address. One example is to report the physical address of the doorbell
in order to be mapped by userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c      |  3 ++-
 drivers/virtio/virtio_pci_modern.c     |  2 +-
 drivers/virtio/virtio_pci_modern_dev.c | 24 +++++++++++++++++-------
 include/linux/virtio_pci_modern.h      |  4 +++-
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 2afc90645660..98205e54d089 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -415,7 +415,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	for (i = 0; i < vp_vdpa->queues; i++) {
 		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
-		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
+		vp_vdpa->vring[i].notify =
+			vp_modern_map_vq_notify(mdev, i, NULL);
 		if (!vp_vdpa->vring[i].notify) {
 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
 			goto err;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 29607d9bd95c..722ea44e7579 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -224,7 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	vq->priv = vp_modern_map_vq_notify(mdev, index);
+	vq->priv = vp_modern_map_vq_notify(mdev, index, NULL);
 	if (!vq->priv) {
 		err = -ENOMEM;
 		goto err_map_notify;
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9c241c9bd920..ae87b3fa8858 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -13,13 +13,14 @@
  * @start: start from the capability
  * @size: map size
  * @len: the length that is actually mapped
+ * @pa: physical address of the capability
  *
  * Returns the io address of for the part of the capability
  */
 static void __iomem *
 vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 			 size_t minlen, u32 align, u32 start, u32 size,
-			 size_t *len)
+			 size_t *len, resource_size_t *pa)
 {
 	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
@@ -87,6 +88,9 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 		dev_err(&dev->dev,
 			"virtio_pci: unable to map virtio %u@%u on bar %i\n",
 			length, offset, bar);
+	else if (pa)
+		*pa = pci_resource_start(dev, bar) + offset;
+
 	return p;
 }
 
@@ -273,12 +277,12 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
 				      0, sizeof(struct virtio_pci_common_cfg),
-				      NULL);
+				      NULL, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
 					     0, 1,
-					     NULL);
+					     NULL, NULL);
 	if (!mdev->isr)
 		goto err_map_isr;
 
@@ -306,7 +310,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 		mdev->notify_base = vp_modern_map_capability(mdev, notify,
 							     2, 2,
 							     0, notify_length,
-							     &mdev->notify_len);
+							     &mdev->notify_len,
+							     &mdev->notify_pa);
 		if (!mdev->notify_base)
 			goto err_map_notify;
 	} else {
@@ -319,7 +324,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	if (device) {
 		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
 							0, PAGE_SIZE,
-							&mdev->device_len);
+							&mdev->device_len,
+							NULL);
 		if (!mdev->device)
 			goto err_map_device;
 	}
@@ -595,11 +601,12 @@ static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
  * specific virtqueue
  * @mdev: the modern virtio-pci device
  * @index: the queue index
+ * @pa: the pointer to the physical address of the nofity area
  *
  * Returns the address of the notification area
  */
 void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-			      u16 index)
+			      u16 index, resource_size_t *pa)
 {
 	u16 off = vp_modern_get_queue_notify_off(mdev, index);
 
@@ -614,13 +621,16 @@ void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
 				 index, mdev->notify_len);
 			return NULL;
 		}
+		if (pa)
+			*pa = mdev->notify_pa +
+			      off * mdev->notify_offset_multiplier;
 		return (void __force *)mdev->notify_base +
 			off * mdev->notify_offset_multiplier;
 	} else {
 		return (void __force *)vp_modern_map_capability(mdev,
 				       mdev->notify_map_cap, 2, 2,
 				       off * mdev->notify_offset_multiplier, 2,
-				       NULL);
+				       NULL, pa);
 	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index e6e7072413c1..cdfabbefacdf 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -13,6 +13,8 @@ struct virtio_pci_modern_device {
 	void __iomem *device;
 	/* Base of vq notifications (non-legacy mode). */
 	void __iomem *notify_base;
+	/* Physical base of vq notifications */
+	resource_size_t notify_pa;
 	/* Where to read and clear interrupt */
 	u8 __iomem *isr;
 
@@ -100,7 +102,7 @@ u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
 			     u16 idx);
 u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
 void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
-                              u16 index);
+                              u16 index, resource_size_t *pa);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
 #endif
-- 
2.18.1

