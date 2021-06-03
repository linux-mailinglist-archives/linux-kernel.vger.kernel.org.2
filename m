Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24C39971B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFCAne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:55025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhFCAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:30 -0400
IronPort-SDR: wp+pbXlWeh5ws+amw/RxKH2brBNAbQ/KqGpWXhs6tCqkCIWYppUx5CP48OIovCPiM9QX4Q7Trb
 53Ucql502h8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200919108"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="200919108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: rlyoqNWWeXyvXoVbNuuUK3XZ1Fd5UUASA5LehE5YNWmgGQqO1lOphbl/vq+xhP/7KFutiwdzVk
 eB9TI4QJcAnw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686677"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 3/8] virtio: Harden split buffer detachment
Date:   Wed,  2 Jun 2021 17:41:28 -0700
Message-Id: <20210603004133.4079390-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harden the split buffer detachment path by adding boundary checking. Note
that when this fails we may fail to unmap some swiotlb mapping, which could
result in a leak and a DOS. But that's acceptable because an malicious host
can DOS us anyways.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d37ff5a0ff58..1e9aa1e95e1b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -651,12 +651,19 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			    void **ctx)
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
+	/* We'll leak DMA mappings when this happens, but nothing
+	 * can be done about that. In the worst case the host
+	 * could DOS us, but it can of course do that anyways.
+	 */
+	if (!inside_split_ring(vq, head))
+		return -EIO;
+
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
 
@@ -666,6 +673,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	while (vq->split.vring.desc[i].flags & nextflag) {
 		vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
 		i = virtio16_to_cpu(vq->vq.vdev, vq->split.vring.desc[i].next);
+		if (!inside_split_ring(vq, i))
+			return -EIO;
 		vq->vq.num_free++;
 	}
 
@@ -684,7 +693,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
-			return;
+			return 0;
 
 		len = virtio32_to_cpu(vq->vq.vdev,
 				vq->split.vring.desc[head].len);
@@ -701,6 +710,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	} else if (ctx) {
 		*ctx = vq->split.desc_state[head].indir_desc;
 	}
+	return 0;
 }
 
 static inline bool more_used_split(const struct vring_virtqueue *vq)
@@ -717,6 +727,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	void *ret;
 	unsigned int i;
 	u16 last_used;
+	int err;
 
 	START_USE(vq);
 
@@ -751,7 +762,12 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
-	detach_buf_split(vq, i, ctx);
+	err = detach_buf_split(vq, i, ctx);
+	if (err) {
+		END_USE(vq);
+		return NULL;
+	}
+
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -863,6 +879,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
 		detach_buf_split(vq, i, NULL);
+		/* Don't need to check for error because nothing is returned */
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 				vq->split.avail_idx_shadow);
-- 
2.25.4

