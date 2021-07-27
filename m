Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66D63D6FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhG0HGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhG0HF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:05:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D9C061765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso3596214pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kwt45LLVSdGoGJYvlKtnH+LSyc3Czgk6CzlT7PGOa4M=;
        b=K1Cc9t3vS646icaUtsnyurmJaJQ4KbP90fg5pmVIqIhfSMeZT9KuUU2o4qCG3T8WjD
         3eIK70R0EEm66Y//L1Nq7qopqQsHEKDmKbmIjFlWfbQibdXGAncJARmx5W+YZZwgL4YQ
         6M32zF9SPF+q5fvLC2TMqpqHsJJZELNGFUfQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kwt45LLVSdGoGJYvlKtnH+LSyc3Czgk6CzlT7PGOa4M=;
        b=Dh0oj63KswtXiKTHujsPSSTA0buRi0o0KPuExNrc/jN4PPpO43XpVuFmFc98ipPRrX
         3eVnNomeyhX5ApOQE355oo2SNHj34N3zSKQ6H62YzOpdN1XmCS7O83hblcYeLaYOteoI
         sM23iell1SpCcLVSPtRCNHndkgOlR1Qvf01bpQV+XK3Js0s5irpJXDOnjKBhaQsqJGi+
         47FkXg3r+KzONxTePGhpIyt5mSvVDlvhhbagoLtdZ+DY83teX2bR7q5iFFENi3Q4Wecz
         R98gQ5DRmQqnzXRKJTTRycbqRHsj4uGnluFryf3niwARu58EWXIXDyVN1HkUMQO49VR4
         KH+g==
X-Gm-Message-State: AOAM530RCOoj2vKt5P099C3cnWHZL3uLvYErD9mAulhyl3AbC0GOj4nI
        3U8urrdzoVACVkJPRmQ8IumvtQ==
X-Google-Smtp-Source: ABdhPJzrXqplxKCb2MygGa9zmJnj9itFK/NS4KHu9rk5hRKfH52uq+yXw7JemuZkLLnMju2/rz8RWw==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr2909796pjg.218.1627369559115;
        Tue, 27 Jul 2021 00:05:59 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id 30sm2343447pgq.31.2021.07.27.00.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:05:58 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 8/8] videobuf2: handle non-contiguous DMA allocations
Date:   Tue, 27 Jul 2021 16:05:17 +0900
Message-Id: <20210727070517.443167-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727070517.443167-1-senozhatsky@chromium.org>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for new noncontiguous DMA API, which
requires allocators to have two execution branches: one
for the current API, and one for the new one.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Christoph Hellwig <hch@lst.de>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 142 +++++++++++++++---
 1 file changed, 117 insertions(+), 25 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 1e218bc440c6..10f73e27d694 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/highmem.h>
 
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
@@ -42,6 +43,7 @@ struct vb2_dc_buf {
 	struct dma_buf_attachment	*db_attach;
 
 	struct vb2_buffer		*vb;
+	bool				coherent_mem;
 };
 
 /*********************************************/
@@ -78,14 +80,22 @@ static void *vb2_dc_cookie(struct vb2_buffer *vb, void *buf_priv)
 static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
 {
 	struct vb2_dc_buf *buf = buf_priv;
-	struct dma_buf_map map;
-	int ret;
 
-	if (!buf->vaddr && buf->db_attach) {
-		ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
-		buf->vaddr = ret ? NULL : map.vaddr;
+	if (buf->vaddr)
+		return buf->vaddr;
+
+	if (buf->db_attach) {
+		struct dma_buf_map map;
+
+		if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
+			buf->vaddr = map.vaddr;
+
+		return buf->vaddr;
 	}
 
+	if (!buf->coherent_mem)
+		buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size,
+						    buf->dma_sgt);
 	return buf->vaddr;
 }
 
@@ -101,13 +111,26 @@ static void vb2_dc_prepare(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
+	/* This takes care of DMABUF and user-enforced cache sync hint */
 	if (buf->vb->skip_cache_sync_on_prepare)
 		return;
 
+	/*
+	 * Coherent MMAP buffers do not need to be synced, unlike USERPTR
+	 * and non-coherent MMAP buffers.
+	 */
+	if (buf->vb->memory == V4L2_MEMORY_MMAP && buf->coherent_mem)
+		return;
+
 	if (!sgt)
 		return;
 
+	/* For both USERPTR and non-coherent MMAP */
 	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
+
+	/* Non-coherent MMAP only */
+	if (!buf->coherent_mem && buf->vaddr)
+		flush_kernel_vmap_range(buf->vaddr, buf->size);
 }
 
 static void vb2_dc_finish(void *buf_priv)
@@ -115,13 +138,26 @@ static void vb2_dc_finish(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
+	/* This takes care of DMABUF and user-enforced cache sync hint */
 	if (buf->vb->skip_cache_sync_on_finish)
 		return;
 
+	/*
+	 * Coherent MMAP buffers do not need to be synced, unlike USERPTR
+	 * and non-coherent MMAP buffers.
+	 */
+	if (buf->vb->memory == V4L2_MEMORY_MMAP && buf->coherent_mem)
+		return;
+
 	if (!sgt)
 		return;
 
+	/* For both USERPTR and non-coherent MMAP */
 	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
+
+	/* Non-coherent MMAP only */
+	if (!buf->coherent_mem && buf->vaddr)
+		invalidate_kernel_vmap_range(buf->vaddr, buf->size);
 }
 
 /*********************************************/
@@ -139,17 +175,66 @@ static void vb2_dc_put(void *buf_priv)
 		sg_free_table(buf->sgt_base);
 		kfree(buf->sgt_base);
 	}
-	dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
-		       buf->attrs);
+
+	if (buf->coherent_mem) {
+		dma_free_attrs(buf->dev, buf->size, buf->cookie,
+			       buf->dma_addr, buf->attrs);
+	} else {
+		if (buf->vaddr)
+			dma_vunmap_noncontiguous(buf->dev, buf->vaddr);
+		dma_free_noncontiguous(buf->dev, buf->size,
+				       buf->dma_sgt, buf->dma_dir);
+	}
 	put_device(buf->dev);
 	kfree(buf);
 }
 
+static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
+{
+	struct vb2_queue *q = buf->vb->vb2_queue;
+
+	buf->cookie = dma_alloc_attrs(buf->dev,
+				      buf->size,
+				      &buf->dma_addr,
+				      GFP_KERNEL | q->gfp_flags,
+				      buf->attrs);
+	if (!buf->cookie)
+		return -ENOMEM;
+
+	if (q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return 0;
+
+	buf->vaddr = buf->cookie;
+	return 0;
+}
+
+static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
+{
+	struct vb2_queue *q = buf->vb->vb2_queue;
+
+	buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
+					       buf->size,
+					       buf->dma_dir,
+					       GFP_KERNEL | q->gfp_flags,
+					       buf->attrs);
+	if (!buf->dma_sgt)
+		return -ENOMEM;
+
+	buf->dma_addr = sg_dma_address(buf->dma_sgt->sgl);
+
+	/*
+	 * For requests that need kernel mapping (DMA_ATTR_NO_KERNEL_MAPPING
+	 * bit is cleared) we perform dma_vmap_noncontiguous() in vb2_dc_vadd().
+	 */
+	return 0;
+}
+
 static void *vb2_dc_alloc(struct vb2_buffer *vb,
 			  struct device *dev,
 			  unsigned long size)
 {
 	struct vb2_dc_buf *buf;
+	int ret;
 
 	if (WARN_ON(!dev))
 		return ERR_PTR(-EINVAL);
@@ -159,27 +244,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
 		return ERR_PTR(-ENOMEM);
 
 	buf->attrs = vb->vb2_queue->dma_attrs;
-	buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
-				      GFP_KERNEL | vb->vb2_queue->gfp_flags,
-				      buf->attrs);
-	if (!buf->cookie) {
-		dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
-		kfree(buf);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
-		buf->vaddr = buf->cookie;
+	buf->dma_dir = vb->vb2_queue->dma_dir;
+	buf->vb = vb;
+	buf->coherent_mem = vb->vb2_queue->coherent_mem;
 
+	buf->size = size;
 	/* Prevent the device from being released while the buffer is used */
 	buf->dev = get_device(dev);
-	buf->size = size;
-	buf->dma_dir = vb->vb2_queue->dma_dir;
+
+	if (buf->coherent_mem)
+		ret = vb2_dc_alloc_coherent(buf);
+	else
+		ret = vb2_dc_alloc_non_coherent(buf);
+
+	if (ret) {
+		dev_err(dev, "dma alloc of size %ld failed\n", size);
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	buf->handler.refcount = &buf->refcount;
 	buf->handler.put = vb2_dc_put;
 	buf->handler.arg = buf;
-	buf->vb = vb;
 
 	refcount_set(&buf->refcount, 1);
 
@@ -196,9 +282,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
-		buf->dma_addr, buf->size, buf->attrs);
-
+	if (buf->coherent_mem)
+		ret = dma_mmap_attrs(buf->dev, vma, buf->cookie, buf->dma_addr,
+				     buf->size, buf->attrs);
+	else
+		ret = dma_mmap_noncontiguous(buf->dev, vma, buf->size,
+					     buf->dma_sgt);
 	if (ret) {
 		pr_err("Remapping memory failed, error: %d\n", ret);
 		return ret;
@@ -362,7 +451,7 @@ static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
 {
 	struct vb2_dc_buf *buf = dbuf->priv;
 
-	dma_buf_map_set_vaddr(map, buf->vaddr);
+	dma_buf_map_set_vaddr(map, vb2_dc_vaddr(buf->vb, buf));
 
 	return 0;
 }
@@ -390,6 +479,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
 	int ret;
 	struct sg_table *sgt;
 
+	if (!buf->coherent_mem)
+		return buf->dma_sgt;
+
 	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt) {
 		dev_err(buf->dev, "failed to alloc sg table\n");
-- 
2.32.0.432.gabb21c7263-goog

