Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8096A43F997
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhJ2JSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:18:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43514 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhJ2JRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:17:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uu7wNNx_1635498896;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uu7wNNx_1635498896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:15:04 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com
Subject: [PATCH v7 6/9] virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
Date:   Fri, 29 Oct 2021 17:14:47 +0800
Message-Id: <bc0551cec6c3f3dd9424b678b7c22d882aebab3a.1635493219.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com> <cover.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the devices which implement the get_vq_num_min callback, the driver
should not negotiate with virtqueue size with the backend vdpa device if
the value returned by get_vq_num_min equals to the value returned by
get_vq_num_max.
This is useful for vdpa devices based on legacy virtio specfication.

Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/virtio/virtio_vdpa.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 72eaef2caeb1..6b62aaf08cc5 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
 	unsigned long flags;
-	u32 align, num;
+	u32 align, max_num, min_num = 1;
+	bool may_reduce_num = true;
 	int err;
 
 	if (!name)
@@ -163,16 +164,21 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
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
-- 
2.31.1

