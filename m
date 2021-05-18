Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216E7387102
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbhERFAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:00:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2960 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhERFAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:00:03 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FkkGk5tnbzCtbv;
        Tue, 18 May 2021 12:55:58 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 12:58:42 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:58:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <jasowang@redhat.com>, <mst@redhat.com>
Subject: [PATCH -next] virtio_ring: Correct function name virtqueue_get_buf_ctx()
Date:   Tue, 18 May 2021 13:00:57 +0800
Message-ID: <20210518050057.614081-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 kernel build warning:

  drivers/virtio/virtio_ring.c:1903: warning: expecting prototype for virtqueue_get_buf(). Prototype was for virtqueue_get_buf_ctx() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 88f0b16b11b8..992cb1cbec93 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1882,7 +1882,7 @@ bool virtqueue_kick(struct virtqueue *vq)
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
 /**
- * virtqueue_get_buf - get the next used buffer
+ * virtqueue_get_buf_ctx - get the next used buffer
  * @_vq: the struct virtqueue we're talking about.
  * @len: the length written into the buffer
  * @ctx: extra context for the token
-- 
2.25.1

