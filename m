Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8C399726
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFCAno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:20968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFCAnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:31 -0400
IronPort-SDR: zdngS3Gfqiy37/4RJtO69BGXPSj7zCDA6De5uedM58wgC9wvk0QUKxWf4wMa6qtxAUse73qxRR
 manDaHPiuLZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202075170"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="202075170"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: VL+aXnuQatkvpNkp3FGdeTErR4yDwQpYb+ewFaiTnnSMh3nd3KYOvi3JsGBefEMdCmu0HYu8xI
 bn1hvlf9segA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686682"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 7/8] virtio: Abort IO when descriptor points outside forced swiotlb
Date:   Wed,  2 Jun 2021 17:41:32 -0700
Message-Id: <20210603004133.4079390-8-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a return value for unmapping DMA mappings that
are outside the forced swiotlb, use that to abort the IO operation.

This prevents the host from subverting a read to access some
data in the guest address space, which it might then get access somehow in
another IO operation. It can subvert reads to point to other
reads or other writes, but since it controls IO it can do
that anyways.

This is only done for the split code path, which is the only
one supported with confidential guests.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1e9aa1e95e1b..244a5b62d85c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -365,29 +365,31 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split(const struct vring_virtqueue *vq,
+static int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				  struct vring_desc *desc)
 {
 	u16 flags;
+	int ret;
 
 	if (!vq->use_dma_api)
-		return;
+		return 0;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
+		ret = dma_unmap_single(vring_dma_dev(vq),
 				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
 				 virtio32_to_cpu(vq->vq.vdev, desc->len),
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		dma_unmap_page(vring_dma_dev(vq),
+		ret = dma_unmap_page(vring_dma_dev(vq),
 			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
 			       virtio32_to_cpu(vq->vq.vdev, desc->len),
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
+	return ret;
 }
 
 static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
@@ -609,6 +611,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			break;
 		if (!inside_split_ring(vq, i))
 			break;
+		/*
+		 * Ignore unmapping errors since
+		 * we're aborting anyways.
+		 */
 		vring_unmap_one_split(vq, &desc[i]);
 		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 	}
@@ -671,7 +677,10 @@ static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
+		int ret;
+		ret = vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
+		if (ret)
+			return ret;
 		i = virtio16_to_cpu(vq->vq.vdev, vq->split.vring.desc[i].next);
 		if (!inside_split_ring(vq, i))
 			return -EIO;
@@ -878,6 +887,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
+		/* Ignore unmap errors because there is nothing to abort */
 		detach_buf_split(vq, i, NULL);
 		/* Don't need to check for error because nothing is returned */
 		vq->split.avail_idx_shadow--;
-- 
2.25.4

