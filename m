Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066941496E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhIVMsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:48:24 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39582 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236042AbhIVMsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:48:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UpEJoj9_1632314798;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UpEJoj9_1632314798)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 20:46:47 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     wuzongyong@linux.alibaba.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v3 5/7] virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
Date:   Wed, 22 Sep 2021 20:46:28 +0800
Message-Id: <e971b011b9224a4da4fcab6e904fcee0b7393ac6.1632313398.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com> <cover.1632313398.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/virtio/virtio_vdpa.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 72eaef2caeb1..8aa4ebe2a2a2 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	unsigned long flags;
-	u32 align, num;
+	u32 align, max_num, min_num = 0;
+	bool may_reduce_num = true;
 	int err;
 
 	if (!name)
@@ -163,22 +164,36 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	num = ops->get_vq_num_max(vdpa);
-	if (num == 0) {
+	max_num = ops->get_vq_num_max(vdpa);
+	if (max_num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
 	}
 
+	if (ops->get_vq_num_min)
+		min_num = ops->get_vq_num_min(vdpa);
+	if (min_num > max_num) {
+		err = -ENOENT;
+		goto error_new_virtqueue;
+	}
+
+	may_reduce_num = (max_num == min_num) ? false : true;
+
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, num, align, vdev,
-				    true, true, ctx,
+	vq = vring_create_virtqueue(index, max_num, align, vdev,
+				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
 	}
 
+	if (virtqueue_get_vring_size(vq) < min_num) {
+		err = -EINVAL;
+		goto err_vq;
+	}
+
 	/* Setup virtqueue callback */
 	cb.callback = virtio_vdpa_virtqueue_cb;
 	cb.private = info;
-- 
2.31.1

