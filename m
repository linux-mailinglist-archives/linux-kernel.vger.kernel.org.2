Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB289408434
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbhIMF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237165AbhIMF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J289FhGEIVLXNYP/g9ScWAC9TdBI3SjEeFEwrPpHTIg=;
        b=N7qfCo/Mby2jGVhL8A1sfc4JZJt7tvneVGAV8H+RYNn5xpj5rU1Ry8u8gUXYpl/bJQhf40
        vMfE5Wi8GOmpmsRf56fGqY3iRpkLDSeE7CsQG3lCfddqoTCm0NgIPdXDI5CPGjlUU3FkIj
        evJgYhjIh4A9bYEVgx1VzFSzSFjN4LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-uX4mrOuINzO6t4LbmldzyA-1; Mon, 13 Sep 2021 01:54:49 -0400
X-MC-Unique: uX4mrOuINzO6t4LbmldzyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2837380196C;
        Mon, 13 Sep 2021 05:54:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA5A15C23A;
        Mon, 13 Sep 2021 05:54:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Date:   Mon, 13 Sep 2021 13:53:50 +0800
Message-Id: <20210913055353.35219-7-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to synchronize pending MSI-X irq handlers via
synchronize_irq(), this may not work for the untrusted device which
may keep sending interrupts after reset which may lead unexpected
results. Similarly, we should not enable MSI-X interrupt until the
device is ready. So this patch fixes those two issues by:

1) switching to use disable_irq() to prevent the virtio interrupt
   handlers to be called after the device is reset.
2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()

This can make sure the virtio interrupt handler won't be called before
virtio_device_ready() and after reset.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  6 ++++--
 drivers/virtio/virtio_pci_legacy.c |  5 +++--
 drivers/virtio/virtio_pci_modern.c |  6 ++++--
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b35bb2d57f62..0b9523e6dd39 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
-/* wait for pending irq handlers */
-void vp_synchronize_vectors(struct virtio_device *vdev)
+/* disable irq handlers */
+void vp_disable_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
@@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(vp_dev->pci_dev->irq);
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
+		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
+}
+
+/* enable irq handlers */
+void vp_enable_vectors(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	if (vp_dev->intx_enabled)
+		return;
+
+	for (i = 0; i < vp_dev->msix_vectors; ++i)
+		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
 /* the notify function used when creating a virt queue */
@@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
 	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, 0, vp_dev->msix_names[v],
+			  vp_config_changed, IRQF_NO_AUTOEN,
+			  vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
 		goto error;
@@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
+				  vp_vring_interrupt, IRQF_NO_AUTOEN,
+				  vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
 			goto error;
@@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			 "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
+				  vring_interrupt, IRQF_NO_AUTOEN,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
 		if (err)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index beec047a8f8d..a235ce9ff6a5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_pci_device, vdev);
 }
 
-/* wait for pending irq handlers */
-void vp_synchronize_vectors(struct virtio_device *vdev);
+/* disable irq handlers */
+void vp_disable_vectors(struct virtio_device *vdev);
+/* enable irq handlers */
+void vp_enable_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d62e9835aeec..bdf6bc667ab5 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
+	/* Disable VQ/configuration callbacks. */
+	vp_disable_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= vp_get,
 	.set		= vp_set,
 	.get_status	= vp_get_status,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 30654d3a0b41..acf0f6b6381d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
 	 */
 	while (vp_modern_get_status(mdev))
 		msleep(1);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
+	/* Disable VQ/configuration callbacks. */
+	vp_disable_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= NULL,
 	.set		= NULL,
 	.generation	= vp_generation,
@@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= vp_get,
 	.set		= vp_set,
 	.generation	= vp_generation,
-- 
2.25.1

