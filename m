Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01D234A4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:54:02 -0400
Received: from out28-3.mail.aliyun.com ([115.124.28.3]:50455 "EHLO
        out28-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhCZJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:53:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2060481|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0887221-0.00131808-0.90996;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.JqaqMtq_1616752409;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.JqaqMtq_1616752409)
          by smtp.aliyun-inc.com(10.194.99.21);
          Fri, 26 Mar 2021 17:53:30 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     mst@redhat.com
Cc:     david@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        liuxiang1999@gmail.com, Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] virtio-balloon: move release_pages_balloon() outside of mutex_unlock(&vb->balloon_lock)
Date:   Fri, 26 Mar 2021 17:53:26 +0800
Message-Id: <20210326095326.13221-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pages have been deflated to a local list,
there is no race between fill and leak.

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8985fc2ce..7da25b87f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -303,8 +303,8 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	 */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->deflate_vq);
-	release_pages_balloon(vb, &pages);
 	mutex_unlock(&vb->balloon_lock);
+	release_pages_balloon(vb, &pages);
 	return num_freed_pages;
 }
 
-- 
2.17.1

