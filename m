Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD43C2172
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhGIJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhGIJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:23:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC5C0613F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 02:20:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j199so8205572pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7+gpjXiQDl1AFy+yYrtXbpe8Fhb0Q+8EAcrqi2r9tM=;
        b=dJkKOsVnE7piS1AUObD+TdvJMlAEG05imuvqmZRuCb9gZHTugEK6elMQmNAO7QjCt2
         Zrf2twzTOPLiY0e/638grUfJf5cSQgpPJOHBx/fDVm4cp4QIXwh3DQ+m5v6oBsazhfpp
         YJ5YAkkkvMaixJbkwS77osKkOL/bVjlCaNj94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7+gpjXiQDl1AFy+yYrtXbpe8Fhb0Q+8EAcrqi2r9tM=;
        b=cljFAOPhXRuEsKGtbY/TsJbkeotv0AaI6rhspHVD1Z64k/SURTHji1+6dkm3hk4/DC
         7/j7xawjjyRDD4gSOS5Q7u3DhdO2vb5N26DI3rdwF5zOK0ZK/Ayh3ehQT7KesXgUD5PR
         ysx1chqqN3330FLGXoGrTV6BoaRLYidLghoMjinu3u11macWMsIIezDAWCHAezsdvMQZ
         t/KYL56hcUYvn8KsLUayQbuPyvytgzul7JkV7jGUAZbzZjL4w/DdXxisDoe5QB6LnMUX
         I8FbHFgBvxqD/I9jbXfPGdEC9sWRBJK8ZYoic1hI+rG9ryQW/e0gYm3AsT+h5Gk728Xa
         I9Tw==
X-Gm-Message-State: AOAM530KZn3VEhcPu9WiNnhZE862cWNA//N7K8IDkdbZDlJq1VbWqrfY
        xKw5Yezx4kAXq4AdAnpPPvi9aA==
X-Google-Smtp-Source: ABdhPJyoJjAEivftcLuaM99lCohvZ9II2ibQkNXJHXUtuIut5TDrowji7dQCPDJZsZGaRhmx9CaTyg==
X-Received: by 2002:a65:450d:: with SMTP id n13mr36796469pgq.13.1625822455921;
        Fri, 09 Jul 2021 02:20:55 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id e24sm5496539pfn.127.2021.07.09.02.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 02:20:55 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 8/8] videobuf2: handle non-contiguous DMA allocations
Date:   Fri,  9 Jul 2021 18:20:27 +0900
Message-Id: <20210709092027.1050834-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709092027.1050834-1-senozhatsky@chromium.org>
References: <20210709092027.1050834-1-senozhatsky@chromium.org>
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
 .../common/videobuf2/videobuf2-dma-contig.c   | 139 ++++++++++++++----
 1 file changed, 114 insertions(+), 25 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 1e218bc440c6..7408ac9ed60a 100644
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
@@ -139,17 +175,63 @@ static void vb2_dc_put(void *buf_priv)
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
+				       buf->dma_sgt, buf->dma_addr);
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
@@ -159,27 +241,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
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
 
@@ -196,9 +279,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
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
@@ -362,7 +448,7 @@ static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct dma_buf_map *map)
 {
 	struct vb2_dc_buf *buf = dbuf->priv;
 
-	dma_buf_map_set_vaddr(map, buf->vaddr);
+	dma_buf_map_set_vaddr(map, vb2_dc_vaddr(buf->vb, buf));
 
 	return 0;
 }
@@ -390,6 +476,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
 	int ret;
 	struct sg_table *sgt;
 
+	if (!buf->coherent_mem)
+		return buf->dma_sgt;
+
 	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt) {
 		dev_err(buf->dev, "failed to alloc sg table\n");
-- 
2.32.0.93.g670b81a890-goog

