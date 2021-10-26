Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4A43B32D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhJZNdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:33:45 -0400
Received: from smtp2.axis.com ([195.60.68.18]:59299 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236223AbhJZNde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1635255071;
  x=1666791071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gkSOykQ017HN5drBxdrfHBInMC214kQ3rsTxq8LMJzk=;
  b=KUd/1o55q44d825TVjQqiezCth2l+RfOHiDelv6DyoEJHBuOqXxUTMBd
   Rlvg+mxdLbd9rbICZ87QjvOfkUaJlCokkibZckyog0gpZH7fTFsu+hUWf
   6QugZsZ8IQD4JLMG+m9G3+WdDVwSI1+ekWNqc7e4Rvxtp032UObw4Rcbm
   2rnjJABcLVrPGppw77o5am6XXGZ2x/N8jgCqDNecuQKg1ONyM3a5QGI9B
   MlRrH30fA0TDXYJSF09+noViQEzIM5jKkSN9DKiWo4uQRNQ0+zbyQV6wX
   L8Z0tnFUB3C5d6H7P260VpGc6ku3t+jDmYRjVdLLRhlBDpPf/q0CHY9eA
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] virtio-ring: fix DMA metadata flags
Date:   Tue, 26 Oct 2021 15:31:00 +0200
Message-ID: <20211026133100.17541-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags are currently overwritten, leading to the wrong direction
being passed to the DMA unmap functions.

Fixes: 72b5e8958738aaa4 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dd95dfd85e98..3035bb6f5458 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -576,7 +576,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
 	if (!indirect && vq->use_dma_api)
-		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags =
+		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
-- 
2.28.0

