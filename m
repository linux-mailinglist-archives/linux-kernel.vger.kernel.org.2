Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47623827F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhEQJQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhEQJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:13:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34EC06138F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:10:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g18so2842984pfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVHgxECPh+4aMC+d/yesfoBU3H23LPf0jPkdCj0P02w=;
        b=I8eQYEb1yktkAQXJ3AUhNfBuUqT+BbPazOAchvlHC7TL6rCKl4kSXjqDy0N8HnugQb
         /FPblapbzxYdETJGMVGgQos0wlB7o4Wwf7AE788ESlp2YNBYMQ4oCi/EtdKFDZLrZF8K
         Fm6omXt5zg5t1OC2s7jI59EQQSGptQoD2k2IpkMheyoSZyzqtkBG6sB2nxEK0zPSMm5O
         336VejUzc9Vq15GhI8a+jhWlE2xT5UX8S/+ZAlSm9aN2Ytj7ULnAtGQHeLI9W+QT0lYn
         UoQSh58XscnRJ+wueAq/D497qUZt6utOBi27FfUgtxe6b3UWvQNHn9tSSn0H7oByCo5w
         zjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVHgxECPh+4aMC+d/yesfoBU3H23LPf0jPkdCj0P02w=;
        b=D0z3GQhnU+853nJSHg223/lNbVLPLOaf5TCQEtwVmMRCXIididW9/AYv2my1g/p3bu
         vGDQIIITdbo8LYPBafz9bsiDDHOqutoDIOFlJ4xS1rkk4XJXu3b8oqOH+pGpoTAZ6R0n
         DHUmX5idHTlWPDz4gMPe6xFx54QvwMhGcE97hLqTrm4gc0u7b38uckRWf/j3M/wIGgs2
         NDDGQa8wE5/Gp7bgCPPyO3qoOAL3PTDSKN/gaqZjO0BTY+LBYv1UE9mv+sENv/S/RW9g
         O8BnZ9weI16Wvzdf+Xhh8Y05FNtHpY8VOWSKSe6tQyBp1mbKfOXuyMsfZax8Vf8iphgw
         hIAg==
X-Gm-Message-State: AOAM533QYEOqWh5zH7Frhbe9eR0J++dpW0w2uguM6P6BLyEfY0BUzOCh
        ECV46anvZO4sjkKBBfFPd0Pl
X-Google-Smtp-Source: ABdhPJy4S7NE8hxnMRmZPiZ4CNJjvpKD+LAREoOPkXT6Jc/AsLrBkhbI5PPwLiuYrcMIiRFLzNBceA==
X-Received: by 2002:a63:581c:: with SMTP id m28mr23923882pgb.353.1621242603187;
        Mon, 17 May 2021 02:10:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t141sm6669741pfc.3.2021.05.17.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:10:02 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/17] virtio_ring: Add validation for used length
Date:   Mon, 17 May 2021 17:08:36 +0800
Message-Id: <20210517090836.533-18-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds validation for used length (might come
from an untrusted device) when it will be used by
virtio device driver.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d999a1d6d271..7d4845d06f21 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -68,11 +68,13 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	u32 in_len;			/* Total length of writable buffer */
 };
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	u32 in_len;			/* Total length of writable buffer */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -486,7 +488,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, avail, descs_used, prev, err_idx, in_len = 0;
 	int head;
 	bool indirect;
 
@@ -570,6 +572,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     indirect);
+			in_len += sg->length;
 		}
 	}
 	/* Last one doesn't continue. */
@@ -604,6 +607,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].in_len = in_len;
 	if (indirect)
 		vq->split.desc_state[head].indir_desc = desc;
 	else
@@ -784,6 +788,10 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
+	if (unlikely(len && vq->split.desc_state[i].in_len < *len)) {
+		BAD_RING(vq, "id %u has invalid length: %u!\n", i, *len);
+		return NULL;
+	}
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
@@ -1059,7 +1067,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, err_idx;
+	unsigned int i, n, err_idx, in_len = 0;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1084,6 +1092,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
+			in_len += (n < out_sgs) ? 0 : sg->length;
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
 						0 : VRING_DESC_F_WRITE);
 			desc[i].addr = cpu_to_le64(addr);
@@ -1141,6 +1150,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].in_len = in_len;
 
 	vq->num_added += 1;
 
@@ -1173,7 +1183,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
+	unsigned int i, n, c, descs_used, err_idx, in_len = 0;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
 
@@ -1223,6 +1233,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
+			in_len += (n < out_sgs) ? 0 : sg->length;
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
 				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
 				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
@@ -1268,6 +1279,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
+	vq->packed.desc_state[id].in_len = in_len;
 
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
@@ -1456,6 +1468,10 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", id);
 		return NULL;
 	}
+	if (unlikely(len && vq->packed.desc_state[id].in_len < *len)) {
+		BAD_RING(vq, "id %u has invalid length: %u!\n", id, *len);
+		return NULL;
+	}
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
-- 
2.11.0

