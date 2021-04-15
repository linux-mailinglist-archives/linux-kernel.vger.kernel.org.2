Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8A360368
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhDOHcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhDOHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=x3GwZ1zgb9EqVeYW21l457HIOUZj2XqF5DommpMrgvs=;
        b=Sf0ljs6sqq41ILQc9SAUT3j5CW/jrX1TB2qhwRhLNxbW1xwccw3FNa0kjNygPbs4NuhdyN
        crpA258DolyOJGNjSBIYL6QhrbtbEm12NMA8uT/gAMeyRoKFIwjrmaBHsmnel+1UcmSQmp
        4VwdaMYcfSR3fnFBqvK2RyuD3mQcLrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-_UaDBgr6Nd6y2k-LGK_jwg-1; Thu, 15 Apr 2021 03:32:10 -0400
X-MC-Unique: _UaDBgr6Nd6y2k-LGK_jwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5010107ACCA;
        Thu, 15 Apr 2021 07:32:09 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC3E769FD0;
        Thu, 15 Apr 2021 07:32:01 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 3/7] vp_vdpa: switch to use vp_modern_map_vq_notify()
Date:   Thu, 15 Apr 2021 03:31:43 -0400
Message-Id: <20210415073147.19331-4-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches to use vp_vdpa to use vp_modern_map_notify().

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 1321a2fcd088..2afc90645660 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -369,7 +369,6 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct virtio_pci_modern_device *mdev;
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa;
-	u16 notify_off;
 	int ret, i;
 
 	ret = pcim_enable_device(pdev);
@@ -415,10 +414,12 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	for (i = 0; i < vp_vdpa->queues; i++) {
-		notify_off = vp_modern_get_queue_notify_off(mdev, i);
 		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
-		vp_vdpa->vring[i].notify = mdev->notify_base +
-			notify_off * mdev->notify_offset_multiplier;
+		vp_vdpa->vring[i].notify = vp_modern_map_vq_notify(mdev, i);
+		if (!vp_vdpa->vring[i].notify) {
+			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
+			goto err;
+		}
 	}
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
-- 
2.18.1

