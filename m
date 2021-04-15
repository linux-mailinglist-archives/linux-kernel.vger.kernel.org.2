Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73F360363
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDOHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231358AbhDOHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=SakyL2xDOEGFzy/jZi6mME+ezuJj78cuYX6cQVP57+M=;
        b=UH4JjzvbHvUN32CU+d0CyvXHbmnLvH8pwYXl4FXKEcSZlt2inETLV+lQ6RJBB+rOVsmx/z
        RxB3Cpsv0crWnenWxok8XMlnH7FUJ298T0Nj/PMB0Cvz5P02xbuzw4qFsWd/4ePAAZkjMo
        XJT8ap5HJ2btZm8B4quIXjWNIaXOvHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-pY5_qzDwNoSR44FbqT7Rrw-1; Thu, 15 Apr 2021 03:31:59 -0400
X-MC-Unique: pY5_qzDwNoSR44FbqT7Rrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B83591883522;
        Thu, 15 Apr 2021 07:31:58 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD0DF69FD0;
        Thu, 15 Apr 2021 07:31:56 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 1/7] virtio_pci_modern: introduce helper to map vq notify area
Date:   Thu, 15 Apr 2021 03:31:41 -0400
Message-Id: <20210415073147.19331-2-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch factors out the logic of vq notify area mapping. Following
patches will switch to use this common helpers for both virtio_pci
library and virtio-pci vDPA driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 35 ++++++++++++++++++++++++++
 include/linux/virtio_pci_modern.h      |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index cbd667496bb1..28cb5847fafa 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -593,6 +593,41 @@ u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
 
+/*
+ * vp_modern_map_vq_notify - map notification area for a
+ * specific virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the address of the notification area
+ */
+void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+			      u16 index)
+{
+	u16 off = vp_modern_get_queue_notify_off(mdev, index);
+
+	if (mdev->notify_base) {
+		/* offset should not wrap */
+		if ((u64)off * mdev->notify_offset_multiplier + 2
+			> mdev->notify_len) {
+			dev_warn(&mdev->pci_dev->dev,
+				 "bad notification offset %u (x %u) "
+				 "for queue %u > %zd",
+				 off, mdev->notify_offset_multiplier,
+				 index, mdev->notify_len);
+			return NULL;
+		}
+		return (void __force *)mdev->notify_base +
+			off * mdev->notify_offset_multiplier;
+	} else {
+		return (void __force *)vp_modern_map_capability(mdev,
+				       mdev->notify_map_cap, 2, 2,
+				       off * mdev->notify_offset_multiplier, 2,
+				       NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
+
 MODULE_VERSION("0.1");
 MODULE_DESCRIPTION("Modern Virtio PCI Device");
 MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index f26acbeec965..1b95d39b00fc 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -106,6 +106,8 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
 				       u32 align,
 				       u32 start, u32 size,
 				       size_t *len);
+void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+                              u16 index);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
 #endif
-- 
2.18.1

