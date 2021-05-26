Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D286390EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhEZDNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:13:51 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43735 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhEZDNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:13:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ua7zx7d_1621998736;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ua7zx7d_1621998736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 11:12:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] virtio_ring: Fix kernel-doc
Date:   Wed, 26 May 2021 11:12:11 +0800
Message-Id: <1621998731-17445-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in virtio_ring.c kernel-doc comment
to remove a warning found by clang_w1.

drivers/virtio/virtio_ring.c:1903: warning: expecting prototype for
virtqueue_get_buf(). Prototype was for virtqueue_get_buf_ctx() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit e593bf975156 ("virtio_ring: put split ring fields in a
sub struct")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b5..095a9a3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1875,7 +1875,7 @@ bool virtqueue_kick(struct virtqueue *vq)
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
 /**
- * virtqueue_get_buf - get the next used buffer
+ * virtqueue_get_buf_ctx - get the next used buffer
  * @_vq: the struct virtqueue we're talking about.
  * @len: the length written into the buffer
  * @ctx: extra context for the token
-- 
1.8.3.1

