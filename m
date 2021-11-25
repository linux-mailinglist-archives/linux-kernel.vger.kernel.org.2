Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62A45D4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbhKYGfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345135AbhKYGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637821841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2/MroL6oE5BBVYn3KMhwEVkq/8JZw+Q6u+jWrdIUJT8=;
        b=h2XdapUCAGgpN/Gn5G325Phea8clEmEejxqHeFJcKEbSzE/yEr5AIx9u/kBvoWbMU02gF1
        e2OpMHJd7Kt4NVpTjdfUg8lF1ZjpAexYgh4Vwy/ywW7zMmCucK2efkUVKwnmhhnbkj08jl
        UpvjFXFGtj64ZtDfdPxqzj7d+yyYHOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-qBrVQiU3P3yZvxS14D-HYw-1; Thu, 25 Nov 2021 01:30:39 -0500
X-MC-Unique: qBrVQiU3P3yZvxS14D-HYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B21831927800;
        Thu, 25 Nov 2021 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1C745D9C0;
        Thu, 25 Nov 2021 06:30:36 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-mmio: harden interrupt
Date:   Thu, 25 Nov 2021 14:30:34 +0800
Message-Id: <20211125063034.12347-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to make sure the virtio interrupt handler for MMIO
won't be called after a reset and before virtio_device_ready(). We
can't use IRQF_NO_AUTOEN since we're using shared interrupt
(IRQF_SHARED). So this patch tracks the interrupt enabling status in a
new intr_soft_enabled variable and toggle it during in
vm_disable/enable_interrupts(). The MMIO interrupt handler will check
intr_soft_enabled before processing the actual interrupt.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..796f0c789b09 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -90,6 +90,7 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+	bool intr_soft_enabled;
 };
 
 struct virtio_mmio_vq_info {
@@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
 	struct list_head node;
 };
 
+/* disable irq handlers */
+void vm_disable_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 
+	/*
+	 * The below synchronize() guarantees that any
+	 * interrupt for this line arriving after
+	 * synchronize_irq() has completed is guaranteed to see
+	 * intx_soft_enabled == false.
+	 */
+	WRITE_ONCE(vm_dev->intr_soft_enabled, false);
+	synchronize_irq(irq);
+}
+
+/* enable irq handlers */
+void vm_enable_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
+
+	disable_irq(irq);
+	/*
+	 * The above disable_irq() provides TSO ordering and
+	 * as such promotes the below store to store-release.
+	 */
+	WRITE_ONCE(vm_dev->intr_soft_enabled, true);
+	enable_irq(irq);
+	return;
+}
 
 /* Configuration interface */
 
@@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	/* Disable VQ/configuration callbacks. */
+	vm_disable_cbs(vdev);
 }
 
 
@@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	if (!READ_ONCE(vm_dev->intr_soft_enabled))
+		return IRQ_NONE;
+
 	/* Read and acknowledge interrupts */
 	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
 	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
@@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 }
 
 static const struct virtio_config_ops virtio_mmio_config_ops = {
+	.enable_cbs     = vm_enable_cbs,
 	.get		= vm_get,
 	.set		= vm_set,
 	.generation	= vm_generation,
-- 
2.25.1

