Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C18429E20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhJLGzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233398AbhJLGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDTeTbCYxQCFpuTbeU5yfrZZ8qTDnqfbGCjQYjVC3Gw=;
        b=GcyHxUP+jJXUWMSUoYHIZ0rQeGSGj+Roe+1V49N3KQQLvCSSqZC+k+wdwyd45vG5oJq2gR
        53o3tP80qJWu8CawXCvOfWe4JAzhH8UAsZGQ8u+A+QKCNH4Utj66bdeW1K+ZbPAk8QpOTx
        0eKFTkoxA31Q3gNS3883ebhGy9FuiAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-33Cm2TyEPS6qMeTCYtHiVg-1; Tue, 12 Oct 2021 02:53:23 -0400
X-MC-Unique: 33Cm2TyEPS6qMeTCYtHiVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53FEF19251CA;
        Tue, 12 Oct 2021 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53185F4E0;
        Tue, 12 Oct 2021 06:52:54 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Date:   Tue, 12 Oct 2021 14:52:22 +0800
Message-Id: <20211012065227.9953-8-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 0b9523e6dd39..5ae6a2a4eb77 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		/*
+		 * The below synchronize() guarantees that any
+		 * interrupt for this line arriving after
+		 * synchronize_irq() has completed is guaranteed to see
+		 * intx_soft_enabled == false.
+		 */
+		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
 		synchronize_irq(vp_dev->pci_dev->irq);
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		disable_irq(vp_dev->pci_dev->irq);
+		/*
+		 * The above disable_irq() provides TSO ordering and
+		 * as such promotes the below store to store-release.
+		 */
+		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
+		enable_irq(vp_dev->pci_dev->irq);
 		return;
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	struct virtio_pci_device *vp_dev = opaque;
 	u8 isr;
 
+	/* read intx_soft_enabled before read others */
+	if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
+		return IRQ_NONE;
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

