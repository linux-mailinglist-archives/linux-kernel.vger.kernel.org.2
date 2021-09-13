Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53059408435
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhIMF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237273AbhIMF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vR9iCzVCROKUiEXD2CzM4Pn1CySsVc/uXehQ5Tcbo98=;
        b=JXo4erVYeqstPOm+MN9JjSrKtF31uGkW0+hFxrfi5Uvsqve09cRi7iLozCwFjr6EfbqYJN
        X3bRtB1SuSY8UGEWcZUSGmkJI2SrrTnGt1UEMS1zZphgJVHyjefzObOILSXM5jdi8r7gvu
        ONQFdKv7Th+Vmenhbry0/FOcUjWPNf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Ks-V8_G1NDe43t47inVZlQ-1; Mon, 13 Sep 2021 01:54:56 -0400
X-MC-Unique: Ks-V8_G1NDe43t47inVZlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740E6362F8;
        Mon, 13 Sep 2021 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0F1C17258;
        Mon, 13 Sep 2021 05:54:48 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH 7/9] virtio-pci: harden INTX interrupts
Date:   Mon, 13 Sep 2021 13:53:51 +0800
Message-Id: <20210913055353.35219-8-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to make sure the virtio interrupt handler for INTX
won't be called after a reset and before virtio_device_ready(). We
can't use IRQF_NO_AUTOEN since we're using shared interrupt
(IRQF_SHARED). So this patch tracks the INTX enabling status in a new
intx_soft_enabled variable and toggle it during in
vp_disable/enable_vectors(). The INTX interrupt handler will check
intx_soft_enabled before processing the actual interrupt.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 0b9523e6dd39..835197151dc1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		vp_dev->intx_soft_enabled = false;
+		/* ensure the vp_interrupt see this intx_soft_enabled value */
+		smp_wmb();
 		synchronize_irq(vp_dev->pci_dev->irq);
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		vp_dev->intx_soft_enabled = true;
+		/* ensure the vp_interrupt see this intx_soft_enabled value */
+		smp_wmb();
 		return;
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	struct virtio_pci_device *vp_dev = opaque;
 	u8 isr;
 
+	if (!vp_dev->intx_soft_enabled)
+		return IRQ_NONE;
+
+	/* read intx_soft_enabled before read others */
+	smp_rmb();
+
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
 	isr = ioread8(vp_dev->isr);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index a235ce9ff6a5..3c06e0f92ee4 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -64,6 +64,7 @@ struct virtio_pci_device {
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
+	bool intx_soft_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
-- 
2.25.1

