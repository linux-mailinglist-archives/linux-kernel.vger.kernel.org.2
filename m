Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD102399725
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFCAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:55025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhFCAnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:31 -0400
IronPort-SDR: DinTgN8Xgx81EUEfgsisb9AyAuB5fomHfIIL//y7wdwQuW55Yww/72anlkraSGz7lSL6aZVilr
 ZHIq1WZVR2tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200919113"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="200919113"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: 2pFejv7yOdCVkt/FpXsrK39AE0n8XlGFbMG7ggDFwWorVajHKUYwALrKujQ9Giok8owwu3kAMW
 bk1Ny78Bc9jg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686683"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 8/8] virtio: Error out on endless free lists
Date:   Wed,  2 Jun 2021 17:41:33 -0700
Message-Id: <20210603004133.4079390-9-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error out with a warning when the free list loops longer
than the maximum size while freeing descriptors. While technically
we don't care about DOS it is still better to abort it early.

We ran into this problem while fuzzing the virtio interactions
where the fuzzed code would get stuck for a long time.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 244a5b62d85c..96adaa4c5404 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -685,6 +685,11 @@ static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (!inside_split_ring(vq, i))
 			return -EIO;
 		vq->vq.num_free++;
+		if (WARN_ONCE(vq->vq.num_free >
+				vq->split.queue_size_in_bytes /
+					sizeof(struct vring_desc),
+				"Virtio freelist corrupted"))
+			return -EIO;
 	}
 
 	vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
-- 
2.25.4

