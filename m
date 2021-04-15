Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96918360367
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhDOHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhDOHc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tvo70H+X8MJ1qdI3suLeJqKhXV9PcO3VeOoRKkGDd0o=;
        b=K7sxg9bc1yIMD6JtbaAF2ttN8qNADYq37bAQ3DWYevULbaAKGicgrkFfb7+dOLph5yn2DA
        Sv8myHfFoM6ZvYENtfQBLFdx/Wzqb3o8D1UIN+n0JB0FftOjD5+tr+TYpGSrQs/KNoRefp
        0Prry2mQ7GzKDiTQ9SICto5RYc1xx6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-Z79qqh5WMNW6TWg-RZy2nA-1; Thu, 15 Apr 2021 03:32:02 -0400
X-MC-Unique: Z79qqh5WMNW6TWg-RZy2nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD6D1883520;
        Thu, 15 Apr 2021 07:32:01 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41EB960657;
        Thu, 15 Apr 2021 07:31:59 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 2/7] virtio-pci library: switch to use vp_modern_map_vq_notify()
Date:   Thu, 15 Apr 2021 03:31:42 -0400
Message-Id: <20210415073147.19331-3-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switch to use vp_modern_map_notify() for virtio-pci
library.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index fbd4ebc00eb6..29607d9bd95c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -192,7 +192,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtqueue *vq;
-	u16 num, off;
+	u16 num;
 	int err;
 
 	if (index >= vp_modern_get_num_queues(mdev))
@@ -208,9 +208,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/* get offset of notification word for this vq */
-	off = vp_modern_get_queue_notify_off(mdev, index);
-
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
@@ -227,27 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	if (mdev->notify_base) {
-		/* offset should not wrap */
-		if ((u64)off * mdev->notify_offset_multiplier + 2
-		    > mdev->notify_len) {
-			dev_warn(&mdev->pci_dev->dev,
-				 "bad notification offset %u (x %u) "
-				 "for queue %u > %zd",
-				 off, mdev->notify_offset_multiplier,
-				 index, mdev->notify_len);
-			err = -EINVAL;
-			goto err_map_notify;
-		}
-		vq->priv = (void __force *)mdev->notify_base +
-			off * mdev->notify_offset_multiplier;
-	} else {
-		vq->priv = (void __force *)vp_modern_map_capability(mdev,
-							  mdev->notify_map_cap, 2, 2,
-							  off * mdev->notify_offset_multiplier, 2,
-							  NULL);
-	}
-
+	vq->priv = vp_modern_map_vq_notify(mdev, index);
 	if (!vq->priv) {
 		err = -ENOMEM;
 		goto err_map_notify;
-- 
2.18.1

