Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598D7447BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhKHIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234561AbhKHIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636359212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nN5+aIj4d2XOGFghF3/VOZbdSEePgdIyyJhpvcoo8+g=;
        b=bJPY63++AhJtrozEHwOsQpeQF9qXVAOFzR3aRlxaFS+8/za43t1lUSZu9lQwm35OXL1CBw
        DqrUaOc09Dv5FWuc597n/4n9p12gAkLDo5zzHScfnUafaYwE5GS6gd5y8Q89/XoMb4QluG
        m5eEExye9FQknOXIyVYuOOmxM6bIC1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-NWEKaI_jNa6gkvVWB9jm7Q-1; Mon, 08 Nov 2021 03:13:29 -0500
X-MC-Unique: NWEKaI_jNa6gkvVWB9jm7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B964CBBEE0;
        Mon,  8 Nov 2021 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-20.pek2.redhat.com [10.72.14.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1D811017E37;
        Mon,  8 Nov 2021 08:13:26 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Date:   Mon,  8 Nov 2021 16:13:24 +0800
Message-Id: <20211108081324.14204-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
for split virtqueue") tries to make it possible for the driver to not
read from the descriptor ring to prevent the device from corrupting
the descriptor ring. But it still read the descriptor flag from the
descriptor ring during buffer detach.

This patch fixes by always store the descriptor flag no matter whether
DMA API is used and then we can avoid reading descriptor flag from the
descriptor ring. This eliminates the possibly of unexpected next
descriptor caused by the wrong flag (e.g the next flag).

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 00f64f2f8b72..28734f4e57d3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vq->use_dma_api)
+	if (!indirect)
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
@@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
+	while (vq->split.desc_extra[i].flags & nextflag) {
 		vring_unmap_one_split(vq, i);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
-- 
2.25.1

