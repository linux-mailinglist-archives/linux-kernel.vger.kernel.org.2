Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341F7399718
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFCAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:43:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:55025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFCAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:43:30 -0400
IronPort-SDR: p4FHmcKknfBhxyjNIDNM8DVNAP72bZcZitBv6dpBSjvEe/6vZwrXG1xK0gkvrSRTgTrj6tADqe
 XS16pKMQkttQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200919097"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="200919097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:46 -0700
IronPort-SDR: RcO/ziDZiA0zs9KDBzMVcDfkcrCyK0CG+VkWlPWMtZabfLPdUI3KlbztMzBnu5W2HGau7uO170
 UmLD4vf1CVKw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="549686675"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:41:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 1/8] virtio: Force only split mode with protected guest
Date:   Wed,  2 Jun 2021 17:41:26 -0700
Message-Id: <20210603004133.4079390-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running under TDX the virtio host is untrusted. The bulk
of the kernel memory is encrypted and protected, but the virtio
ring is in special shared memory that is shared with the
untrusted host.

This means virtio needs to be hardened against any attacks from
the host through the ring. Of course it's impossible to prevent DOS
(the host can chose at any time to stop doing IO), but there
should be no buffer overruns or similar that might give access to
any private memory in the guest.

virtio has a lot of modes, most are difficult to harden.

The best for hardening seems to be split mode without indirect
descriptors. This also simplifies the hardening job because
it's only a single code path.

Only allow split mode when in a protected guest. Followon
patches harden the split mode code paths, and we don't want
an malicious host to force anything else. Also disallow
indirect mode for similar reasons.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..f35629fa47b1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/dma-mapping.h>
+#include <linux/protected_guest.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -2221,8 +2222,16 @@ void vring_transport_features(struct virtio_device *vdev)
 	unsigned int i;
 
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
+
+		/*
+		 * In protected guest mode disallow packed or indirect
+		 * because they ain't hardened.
+		 */
+
 		switch (i) {
 		case VIRTIO_RING_F_INDIRECT_DESC:
+			if (protected_guest_has(VM_MEM_ENCRYPT))
+				goto clear;
 			break;
 		case VIRTIO_RING_F_EVENT_IDX:
 			break;
@@ -2231,9 +2240,12 @@ void vring_transport_features(struct virtio_device *vdev)
 		case VIRTIO_F_ACCESS_PLATFORM:
 			break;
 		case VIRTIO_F_RING_PACKED:
+			if (protected_guest_has(VM_MEM_ENCRYPT))
+				goto clear;
 			break;
 		case VIRTIO_F_ORDER_PLATFORM:
 			break;
+		clear:
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.25.4

