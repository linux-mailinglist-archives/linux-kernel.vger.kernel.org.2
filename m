Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11D14037DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348883AbhIHKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:30:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15251 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhIHKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:30:05 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H4JHm2JMhz1DGpG;
        Wed,  8 Sep 2021 18:28:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeml765-chm.china.huawei.com
 (10.1.199.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 18:28:55 +0800
From:   Liu Yuntao <liuyuntao10@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <kirill.shutemov@linux.intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wuxu.wu@huawei.com>, <liusirui@huawei.com>,
        <windspectator@gmail.com>
Subject: [PATCH] virtio-gpu: fix possible memory allocation failure
Date:   Wed, 8 Sep 2021 18:26:47 +0800
Message-ID: <20210908102648.2326917-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml765-chm.china.huawei.com (10.1.199.175)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_zalloc in virtio_gpu_get_vbuf fails, it will return
an error code. But none of its callers checks this error code, and
a core dump will take place.

Considering many of its callers can't handle such error, I add
a __GFP_NOFAIL flag when calling kmem_cache_zalloc to make sure
it won't fail, and delete those unused error handlings.

Fixes: dc5698e80cf724 ("Add virtio gpu driver.")
Signed-off-by: Yuntao Liu <liuyuntao10@huawei.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index cf84d382dd41..5286cf110208 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -91,9 +91,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL);
-	if (!vbuf)
-		return ERR_PTR(-ENOMEM);
+	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
@@ -147,10 +145,6 @@ static void *virtio_gpu_alloc_cmd_resp(struct virtio_gpu_device *vgdev,
 
 	vbuf = virtio_gpu_get_vbuf(vgdev, cmd_size,
 				   resp_size, resp_buf, cb);
-	if (IS_ERR(vbuf)) {
-		*vbuffer_p = NULL;
-		return ERR_CAST(vbuf);
-	}
 	*vbuffer_p = vbuf;
 	return (struct virtio_gpu_command *)vbuf->buf;
 }
-- 
2.23.0

