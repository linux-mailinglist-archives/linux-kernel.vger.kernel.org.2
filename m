Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB13D343B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhGWFCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 01:02:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59488 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233738AbhGWFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:02:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UggRKYB_1627018980;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UggRKYB_1627018980)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Jul 2021 13:43:14 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v2] virtio-balloon: Use virtio_find_vqs() helper
Date:   Fri, 23 Jul 2021 13:42:59 +0800
Message-Id: <20210723054259.2779-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper virtio_find_vqs().

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 47dce91f7..c22ff0117 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
-	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
-					 vqs, callbacks, names, NULL, NULL);
+	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
+			      callbacks, names, NULL);
 	if (err)
 		return err;
 
-- 
2.17.1

